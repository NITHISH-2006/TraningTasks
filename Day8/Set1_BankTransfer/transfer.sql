USE day8_bank_transfer;

-- Q1: Atomic transfer. Both rows are locked in primary-key order to avoid deadlocks.
DELIMITER //

DROP PROCEDURE IF EXISTS sp_transfer_funds //

CREATE PROCEDURE sp_transfer_funds(
    IN p_from_account_id BIGINT,
    IN p_to_account_id BIGINT,
    IN p_amount DECIMAL(12,2),
    IN p_description VARCHAR(150)
)
BEGIN
    DECLARE v_from_balance DECIMAL(12,2);
    DECLARE v_from_status VARCHAR(10) DEFAULT NULL;
    DECLARE v_to_status VARCHAR(10) DEFAULT NULL;
    DECLARE v_first_id BIGINT;
    DECLARE v_second_id BIGINT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF p_amount IS NULL OR p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transfer amount must be positive';
    END IF;

    IF p_from_account_id = p_to_account_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Source and target accounts must differ';
    END IF;

    SET v_first_id = LEAST(p_from_account_id, p_to_account_id);
    SET v_second_id = GREATEST(p_from_account_id, p_to_account_id);

    START TRANSACTION;

    SELECT status, balance INTO v_from_status, v_from_balance
    FROM accounts WHERE id = v_first_id FOR UPDATE;

    SELECT status INTO v_to_status
    FROM accounts WHERE id = v_second_id FOR UPDATE;

    SELECT status, balance INTO v_from_status, v_from_balance
    FROM accounts WHERE id = p_from_account_id FOR UPDATE;

    IF v_from_status IS NULL OR v_to_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'One or both accounts do not exist';
    END IF;

    IF v_from_status <> 'ACTIVE' OR v_to_status <> 'ACTIVE' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Both accounts must be ACTIVE';
    END IF;

    IF v_from_balance < p_amount THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient balance for transfer';
    END IF;

    UPDATE accounts
    SET balance = balance - p_amount
    WHERE id = p_from_account_id;

    INSERT INTO account_transactions
        (account_id, txn_type, amount, counterparty_account_id, description, balance_after)
    VALUES
        (p_from_account_id, 'DEBIT', p_amount, p_to_account_id, p_description, v_from_balance - p_amount);

    UPDATE accounts
    SET balance = balance + p_amount
    WHERE id = p_to_account_id;

    INSERT INTO account_transactions
        (account_id, txn_type, amount, counterparty_account_id, description, balance_after)
    SELECT p_to_account_id, 'CREDIT', p_amount, p_from_account_id, p_description, balance
    FROM accounts WHERE id = p_to_account_id;

    COMMIT;

    SELECT 'TRANSFER_COMMITTED' AS outcome,
           p_from_account_id AS from_account_id,
           p_to_account_id AS to_account_id,
           p_amount AS amount;
END //

-- Q2: Deliberate failure after the debit. The handler proves ROLLBACK restores both balances.
DROP PROCEDURE IF EXISTS sp_failed_transfer_rollback_demo //

CREATE PROCEDURE sp_failed_transfer_rollback_demo(
    IN p_from_account_id BIGINT,
    IN p_to_account_id BIGINT,
    IN p_amount DECIMAL(12,2)
)
BEGIN
    DECLARE v_balance DECIMAL(12,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'ROLLED_BACK_AFTER_DEBIT' AS outcome;
    END;

    START TRANSACTION;

    SELECT balance INTO v_balance
    FROM accounts WHERE id = p_from_account_id FOR UPDATE;

    UPDATE accounts SET balance = balance - p_amount WHERE id = p_from_account_id;

    INSERT INTO account_transactions
        (account_id, txn_type, amount, counterparty_account_id, description, balance_after)
    VALUES
        (p_from_account_id, 'DEBIT', p_amount, p_to_account_id, 'Failed transfer demo', v_balance - p_amount);

    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deliberate failure after debit';

    COMMIT;
END //

-- Q3: SAVEPOINT reverses only the fee posting; the debit and credit remain.
DROP PROCEDURE IF EXISTS sp_transfer_with_fee_savepoint //

CREATE PROCEDURE sp_transfer_with_fee_savepoint(
    IN p_from_account_id BIGINT,
    IN p_to_account_id BIGINT,
    IN p_amount DECIMAL(12,2),
    IN p_fee DECIMAL(12,2),
    IN p_description VARCHAR(150)
)
BEGIN
    DECLARE v_from_balance DECIMAL(12,2);
    DECLARE v_to_balance DECIMAL(12,2);
    DECLARE v_status VARCHAR(10) DEFAULT NULL;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF p_amount <= 0 OR p_fee < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid amount or fee';
    END IF;

    START TRANSACTION;

    SELECT balance, status INTO v_from_balance, v_status
    FROM accounts WHERE id = p_from_account_id FOR UPDATE;
    IF v_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Source account does not exist';
    END IF;

    SELECT balance, status INTO v_to_balance, v_status
    FROM accounts WHERE id = p_to_account_id FOR UPDATE;
    IF v_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Target account does not exist';
    END IF;

    IF v_from_balance < p_amount + p_fee THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient balance for transfer and fee';
    END IF;

    UPDATE accounts SET balance = balance - p_amount WHERE id = p_from_account_id;
    UPDATE accounts SET balance = balance + p_amount WHERE id = p_to_account_id;

    INSERT INTO account_transactions
        (account_id, txn_type, amount, counterparty_account_id, description, balance_after)
    VALUES
        (p_from_account_id, 'DEBIT', p_amount, p_to_account_id, p_description, v_from_balance - p_amount),
        (p_to_account_id, 'CREDIT', p_amount, p_from_account_id, p_description, v_to_balance + p_amount);

    SAVEPOINT fee_posting;

    UPDATE accounts SET balance = balance - p_fee WHERE id = p_from_account_id;
    INSERT INTO account_transactions
        (account_id, txn_type, amount, counterparty_account_id, description, balance_after)
    VALUES
        (p_from_account_id, 'FEE', p_fee, NULL, 'Transfer fee - reversed by savepoint', v_from_balance - p_amount - p_fee);

    ROLLBACK TO SAVEPOINT fee_posting;
    RELEASE SAVEPOINT fee_posting;

    COMMIT;

    SELECT 'TRANSFER_COMMITTED_FEE_REVERSED' AS outcome,
           v_from_balance - p_amount AS from_balance,
           v_to_balance + p_amount AS to_balance;
END //

DELIMITER ;

-- Q1 call: successful transfer.
CALL sp_transfer_funds(1, 2, 250.00, 'Shared expense settlement');

-- Q2 call: balance must be unchanged after the handler reports rollback.
CALL sp_failed_transfer_rollback_demo(1, 2, 100.00);

-- Q3 call: 100.00 transfer stays, 15.00 fee is undone by ROLLBACK TO SAVEPOINT.
CALL sp_transfer_with_fee_savepoint(1, 2, 100.00, 15.00, 'Transfer with reversible fee');
