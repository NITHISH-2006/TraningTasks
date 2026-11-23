USE day10_retail_price_audit;

-- T1: single-row valid update -> one audit row.
UPDATE product_price SET selling_price = 120.00 WHERE id = 1;
SELECT id, product_name, cost_price, selling_price FROM product_price ORDER BY id;
SELECT audit_id, product_id, old_price, new_price, changed_by, changed_at
FROM price_audit ORDER BY audit_id;

-- T3: multi-row update. One row would become invalid (90 < 100), so the whole
-- statement fails and the valid change to product 2 is also rolled back.
DELIMITER //

DROP PROCEDURE IF EXISTS sp_test_invalid_batch //

CREATE PROCEDURE sp_test_invalid_batch()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'BATCH_REJECTED_BY_TRIGGER' AS outcome;
    END;

    START TRANSACTION;
    UPDATE product_price
    SET selling_price = CASE id WHEN 1 THEN 90.00 WHEN 2 THEN 260.00 ELSE selling_price END
    WHERE id IN (1, 2);
    COMMIT;
    SELECT 'BATCH_UNEXPECTEDLY_COMMITTED' AS outcome;
END //

DELIMITER ;

CALL sp_test_invalid_batch();

SELECT id, product_name, cost_price, selling_price FROM product_price ORDER BY id;
SELECT COUNT(*) AS audit_rows_after_failed_batch FROM price_audit;

-- T5: catalog lookup.
SELECT TRIGGER_NAME, EVENT_MANIPULATION, ACTION_TIMING, ACTION_STATEMENT
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'day10_retail_price_audit'
ORDER BY EVENT_MANIPULATION, ACTION_TIMING;
