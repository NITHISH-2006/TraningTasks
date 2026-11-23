USE day10_bank_balance_guard;

DELIMITER //

-- T1: AFTER INSERT audit.
DROP TRIGGER IF EXISTS trg_account_transaction_after_insert_audit //

CREATE TRIGGER trg_account_transaction_after_insert_audit
AFTER INSERT ON account_transaction
FOR EACH ROW
BEGIN
    INSERT INTO account_audit
        (action_type, txn_id, account_id, old_amount, new_amount,
         old_description, new_description, changed_at, changed_by)
    VALUES
        ('INSERT', NEW.id, NEW.account_id, NULL, NEW.amount,
         NULL, NEW.description, NOW(), USER());
END //

-- T2: AFTER UPDATE audit with OLD and NEW values.
DROP TRIGGER IF EXISTS trg_account_transaction_after_update_audit //

CREATE TRIGGER trg_account_transaction_after_update_audit
AFTER UPDATE ON account_transaction
FOR EACH ROW
BEGIN
    INSERT INTO account_audit
        (action_type, txn_id, account_id, old_amount, new_amount,
         old_description, new_description, changed_at, changed_by)
    VALUES
        ('UPDATE', NEW.id, NEW.account_id, OLD.amount, NEW.amount,
         OLD.description, NEW.description, NOW(), USER());
END //

-- T3: AFTER DELETE audit; NEW does not exist for DELETE.
DROP TRIGGER IF EXISTS trg_account_transaction_after_delete_audit //

CREATE TRIGGER trg_account_transaction_after_delete_audit
AFTER DELETE ON account_transaction
FOR EACH ROW
BEGIN
    INSERT INTO account_audit
        (action_type, txn_id, account_id, old_amount, new_amount,
         old_description, new_description, changed_at, changed_by)
    VALUES
        ('DELETE', OLD.id, OLD.account_id, OLD.amount, NULL,
         OLD.description, NULL, NOW(), USER());
END //

-- T4: derived-column maintenance - keep accounts.last_txn_date current.
DROP TRIGGER IF EXISTS trg_account_transaction_after_insert_last_txn //

CREATE TRIGGER trg_account_transaction_after_insert_last_txn
AFTER INSERT ON account_transaction
FOR EACH ROW
BEGIN
    UPDATE accounts
    SET last_txn_date = GREATEST(COALESCE(last_txn_date, NEW.txn_date), NEW.txn_date)
    WHERE id = NEW.account_id;
END //

-- T5: BEFORE UPDATE guard - a savings balance may never become negative.
DROP TRIGGER IF EXISTS trg_accounts_before_update_savings_guard //

CREATE TRIGGER trg_accounts_before_update_savings_guard
BEFORE UPDATE ON accounts
FOR EACH ROW
BEGIN
    IF NEW.account_type = 'SAVINGS' AND NEW.balance < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Savings account balance cannot be negative';
    END IF;
END //

DELIMITER ;
