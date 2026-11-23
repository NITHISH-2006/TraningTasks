USE day8_retail_reservation;

-- Q1: Reserve stock, create the order and its lines in one transaction.
-- Line items are supplied as JSON, e.g.
-- '[{"product_id":1,"qty":1,"unit_price":58000.00},{"product_id":2,"qty":2,"unit_price":4500.00}]'
DELIMITER //

DROP PROCEDURE IF EXISTS sp_reserve_order //

CREATE PROCEDURE sp_reserve_order(
    IN p_order_no VARCHAR(30),
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

    IF p_order_no IS NULL OR p_items IS NULL OR JSON_LENGTH(p_items) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order number and at least one line are required';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM JSON_TABLE(p_items, '$[*]' COLUMNS (
                product_id BIGINT PATH '$.product_id',
                qty INT PATH '$.qty',
                unit_price DECIMAL(10,2) PATH '$.unit_price'
             )) AS ji
        LEFT JOIN products p ON p.id = ji.product_id
        WHERE p.id IS NULL OR ji.qty IS NULL OR ji.qty <= 0
           OR ji.unit_price IS NULL OR ji.unit_price <= 0
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid line item: unknown product or non-positive qty/price';
    END IF;

    DROP TEMPORARY TABLE IF EXISTS tmp_reservation_lines;
    CREATE TEMPORARY TABLE tmp_reservation_lines (
        product_id BIGINT NOT NULL,
        qty INT NOT NULL,
        unit_price DECIMAL(10,2) NOT NULL
    ) ENGINE=InnoDB;

    INSERT INTO tmp_reservation_lines (product_id, qty, unit_price)
    SELECT ji.product_id, ji.qty, ji.unit_price
    FROM JSON_TABLE(p_items, '$[*]' COLUMNS (
            product_id BIGINT PATH '$.product_id',
            qty INT PATH '$.qty',
            unit_price DECIMAL(10,2) PATH '$.unit_price'
         )) AS ji;

    START TRANSACTION;

    SET @v_short_product_id = NULL;

    SELECT p.id INTO @v_short_product_id
    FROM products p
    WHERE EXISTS (
        SELECT 1 FROM tmp_reservation_lines ji
        WHERE ji.product_id = p.id AND p.qty_in_stock < ji.qty
    )
    LIMIT 1 FOR UPDATE;

    IF @v_short_product_id IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for at least one line';
    END IF;

    INSERT INTO orders (order_no, status) VALUES (p_order_no, 'CONFIRMED');
    SET p_order_id = LAST_INSERT_ID();

    INSERT INTO order_lines (order_id, product_id, qty, unit_price)
    SELECT p_order_id, ji.product_id, ji.qty, ji.unit_price
    FROM tmp_reservation_lines ji;

    UPDATE orders o
    SET o.total_amount = (SELECT SUM(ol.qty * ol.unit_price) FROM order_lines ol WHERE ol.order_id = o.id)
    WHERE o.id = p_order_id;

    UPDATE products p
    JOIN tmp_reservation_lines ji ON ji.product_id = p.id
    SET p.qty_in_stock = p.qty_in_stock - ji.qty;

    COMMIT;

    DROP TEMPORARY TABLE IF EXISTS tmp_reservation_lines;
END //

DELIMITER ;

-- Q1 success case.
CALL sp_reserve_order(
    'ORD-2026-1001',
    '[{"product_id":1,"qty":1,"unit_price":58000.00},{"product_id":2,"qty":2,"unit_price":4500.00}]',
    @ok_order_id
);
SELECT @ok_order_id AS reserved_order_id;

-- Q1 rollback evidence: product 3 has only 20 units, so asking for 999 fails and
-- the EXIT HANDLER rolls back the whole transaction (no order/lines are left behind).
DELIMITER //

DROP PROCEDURE IF EXISTS sp_demo_insufficient_stock //

CREATE PROCEDURE sp_demo_insufficient_stock()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'INSUFFICIENT_STOCK_ROLLED_BACK' AS outcome;
    END;

    CALL sp_reserve_order(
        'ORD-2026-1002',
        '[{"product_id":3,"qty":999,"unit_price":3200.00}]',
        @failed_order_id
    );
    SELECT 'UNEXPECTEDLY_RESERVED' AS outcome;
END //

DELIMITER ;

CALL sp_demo_insufficient_stock();
SELECT @failed_order_id AS rolled_back_order_id;

SELECT id, name, qty_in_stock FROM products ORDER BY id;
SELECT id, order_no, status, total_amount FROM orders ORDER BY id;
SELECT order_id, product_id, qty, unit_price FROM order_lines ORDER BY id;
