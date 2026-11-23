USE day9_retail_fulfilment;

-- V1: hides cost_price, supplier_id and supplier contact details.
CREATE OR REPLACE VIEW vw_order_summary AS
SELECT o.id AS order_id,
       o.order_no,
       o.order_date,
       o.status,
       c.name AS customer_name,
       p.name AS product_name,
       oi.qty,
       oi.unit_price,
       ROUND(oi.qty * oi.unit_price, 2) AS line_total,
       o.total_amount
FROM orders o
JOIN customers c ON c.id = o.customer_id
JOIN order_items oi ON oi.order_id = o.id
JOIN products p ON p.id = oi.product_id;

-- V2: simple single-table view, therefore updatable; CHECK OPTION keeps rows in the view.
CREATE OR REPLACE VIEW vw_low_stock AS
SELECT id AS product_id, name, qty_in_stock, reorder_level
FROM products
WHERE qty_in_stock <= reorder_level
WITH CHECK OPTION;

-- Demonstration: the first update stays inside the view; the second is rejected.
DELIMITER //

DROP PROCEDURE IF EXISTS sp_demo_check_option //

CREATE PROCEDURE sp_demo_check_option()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'CHECK_OPTION_REJECTED_OUTSIDE_VIEW' AS outcome;
    END;

    START TRANSACTION;
    UPDATE vw_low_stock SET qty_in_stock = 2 WHERE product_id = 2;
    SELECT 'CHECK_OPTION_ACCEPTED_INSIDE_VIEW' AS outcome;

    UPDATE vw_low_stock SET qty_in_stock = 50 WHERE product_id = 2;
    COMMIT;
END //

DELIMITER ;

CALL sp_demo_check_option();
SELECT * FROM vw_low_stock ORDER BY product_id;
SELECT * FROM vw_order_summary ORDER BY order_id, product_name;
