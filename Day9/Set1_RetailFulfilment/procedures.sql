USE day9_retail_fulfilment;

DELIMITER //

-- P1: place an order atomically. IN = customer/items, OUT = generated order id.
DROP PROCEDURE IF EXISTS sp_place_order //

CREATE PROCEDURE sp_place_order(
    IN p_customer_id BIGINT,
    IN p_items JSON,
    OUT p_order_id BIGINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_order_id = NULL;
        RESIGNAL;
    END;

    SET p_order_id = NULL;

    IF p_customer_id IS NULL OR p_items IS NULL OR JSON_LENGTH(p_items) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer and at least one line are required';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM customers WHERE id = p_customer_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer does not exist';
    END IF;

    DROP TEMPORARY TABLE IF EXISTS tmp_order_lines;
    CREATE TEMPORARY TABLE tmp_order_lines (
        product_id BIGINT PRIMARY KEY,
        qty INT NOT NULL,
        unit_price DECIMAL(10,2) NOT NULL
    ) ENGINE=InnoDB;

    INSERT INTO tmp_order_lines (product_id, qty, unit_price)
    SELECT ji.product_id, SUM(ji.qty), MAX(ji.unit_price)
    FROM JSON_TABLE(p_items, '$[*]' COLUMNS (
            product_id BIGINT PATH '$.product_id',
            qty INT PATH '$.qty',
            unit_price DECIMAL(10,2) PATH '$.unit_price'
         )) AS ji
    GROUP BY ji.product_id;

    IF EXISTS (SELECT 1 FROM tmp_order_lines WHERE qty IS NULL OR qty <= 0 OR unit_price IS NULL OR unit_price <= 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Line quantity and price must be positive';
    END IF;

    IF EXISTS (
        SELECT 1 FROM tmp_order_lines t LEFT JOIN products p ON p.id = t.product_id
        WHERE p.id IS NULL
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'One or more products do not exist';
    END IF;

    START TRANSACTION;

    IF EXISTS (
        SELECT 1 FROM products p JOIN tmp_order_lines t ON t.product_id = p.id
        WHERE p.qty_in_stock < t.qty
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for order';
    END IF;

    INSERT INTO orders (order_no, customer_id, status)
    VALUES (CONCAT('ORD-', UUID_SHORT()), p_customer_id, 'PROCESSING');
    SET p_order_id = LAST_INSERT_ID();

    INSERT INTO order_items (order_id, product_id, qty, unit_price)
    SELECT p_order_id, t.product_id, t.qty, t.unit_price FROM tmp_order_lines t;

    UPDATE orders o
    SET o.total_amount = (SELECT SUM(oi.qty * oi.unit_price) FROM order_items oi WHERE oi.order_id = o.id)
    WHERE o.id = p_order_id;

    UPDATE products p JOIN tmp_order_lines t ON t.product_id = p.id
    SET p.qty_in_stock = p.qty_in_stock - t.qty;

    COMMIT;
    DROP TEMPORARY TABLE IF EXISTS tmp_order_lines;
END //

-- F1: deterministic function usable inside SELECT.
DROP FUNCTION IF EXISTS fn_order_total_with_tax //

CREATE FUNCTION fn_order_total_with_tax(
    p_subtotal DECIMAL(12,2),
    p_tax_rate DECIMAL(5,4)
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    RETURN ROUND(p_subtotal * (1 + p_tax_rate), 2);
END //

-- P2: raises a business error visible to the caller.
DROP PROCEDURE IF EXISTS sp_reject_cancelled_order //

CREATE PROCEDURE sp_reject_cancelled_order(IN p_order_id BIGINT)
BEGIN
    IF EXISTS (SELECT 1 FROM orders WHERE id = p_order_id AND status = 'CANCELLED') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cancelled orders cannot be processed';
    END IF;
    SELECT 'ORDER_IS_PROCESSABLE' AS result;
END //

DELIMITER ;

-- Calls / reports.
CALL sp_place_order(
    2,
    '[{"product_id":1,"qty":2,"unit_price":799.00},{"product_id":3,"qty":1,"unit_price":1299.00}]',
    @placed_order_id
);
SELECT @placed_order_id AS placed_order_id;

SELECT o.order_no,
       o.total_amount AS subtotal,
       fn_order_total_with_tax(o.total_amount, 0.1800) AS total_with_18pct_tax
FROM orders o
ORDER BY o.id;

UPDATE orders SET status = 'CANCELLED' WHERE id = 3;

DELIMITER //

DROP PROCEDURE IF EXISTS sp_demo_cancelled_error //

CREATE PROCEDURE sp_demo_cancelled_error()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'SIGNAL_CAUGHT_CANCELLED_ORDER_REJECTED' AS outcome;
    END;

    CALL sp_reject_cancelled_order(3);
    SELECT 'UNEXPECTEDLY_PROCESSED' AS outcome;
END //

DELIMITER ;

CALL sp_demo_cancelled_error();
