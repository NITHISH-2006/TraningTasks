USE day10_bank_balance_guard;

-- T1/T4: insert, update, delete a transaction and inspect audit + derived date.
INSERT INTO account_transaction (id, account_id, txn_date, amount, description)
VALUES (1, 1, '2026-11-20 10:00:00', 250.00, 'Cash deposit');

UPDATE account_transaction SET amount = 300.00, description = 'Cash deposit corrected' WHERE id = 1;
DELETE FROM account_transaction WHERE id = 1;

SELECT audit_id, action_type, txn_id, account_id, old_amount, new_amount,
       old_description, new_description, changed_at
FROM account_audit ORDER BY audit_id;

SELECT id, account_no, account_type, balance, last_txn_date FROM accounts ORDER BY id;

-- T5: batch update of five accounts; account 3 would become -100.00.
-- InnoDB aborts the entire statement; the other four rows are not changed.
DELIMITER //

DROP PROCEDURE IF EXISTS sp_test_batch_guard //

CREATE PROCEDURE sp_test_batch_guard()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'BATCH_REJECTED_BY_TRIGGER' AS outcome;
    END;

    START TRANSACTION;
    UPDATE accounts SET balance = balance - 200.00 WHERE id BETWEEN 1 AND 5;
    COMMIT;
    SELECT 'BATCH_UNEXPECTEDLY_COMMITTED' AS outcome;
END //

DELIMITER ;

CALL sp_test_batch_guard();

SELECT id, account_type, balance FROM accounts ORDER BY id;

SELECT TRIGGER_NAME, EVENT_MANIPULATION, ACTION_TIMING
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'day10_bank_balance_guard'
ORDER BY EVENT_OBJECT_TABLE, EVENT_MANIPULATION, ACTION_TIMING;
