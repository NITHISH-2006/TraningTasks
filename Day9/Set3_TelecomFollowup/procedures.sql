USE day9_telecom_followup;

DELIMITER //

-- P1: recharge with IN amount and OUT new balance.
DROP PROCEDURE IF EXISTS sp_recharge //

CREATE PROCEDURE sp_recharge(
    IN p_subscriber_id BIGINT,
    IN p_amount DECIMAL(10,2),
    OUT p_new_balance DECIMAL(10,2)
)
BEGIN
    DECLARE v_balance DECIMAL(10,2);
    DECLARE v_plan_type VARCHAR(10) DEFAULT NULL;
    DECLARE v_connection_type VARCHAR(10) DEFAULT NULL;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_new_balance = NULL;
        RESIGNAL;
    END;

    SET p_new_balance = NULL;

    IF p_amount IS NULL OR p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Recharge amount must be positive';
    END IF;

    START TRANSACTION;

    SELECT s.balance, s.connection_type, pl.plan_type
    INTO v_balance, v_connection_type, v_plan_type
    FROM subscribers s JOIN plans pl ON pl.id = s.plan_id
    WHERE s.id = p_subscriber_id FOR UPDATE;

    IF v_balance IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subscriber does not exist';
    END IF;

    IF v_connection_type <> 'PREPAID' OR v_plan_type <> 'PREPAID' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Recharges are valid only for prepaid plans';
    END IF;

    UPDATE subscribers
    SET balance = balance + p_amount, last_recharge_date = CURDATE()
    WHERE id = p_subscriber_id;

    INSERT INTO recharges (subscriber_id, amount, recharge_mode)
    VALUES (p_subscriber_id, p_amount, 'ONLINE');

    SET p_new_balance = v_balance + p_amount;

    COMMIT;
END //

-- F1: validity remaining after the last recharge.
DROP FUNCTION IF EXISTS fn_validity_days_left //

CREATE FUNCTION fn_validity_days_left(
    p_last_recharge_date DATE,
    p_validity_days INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    IF p_last_recharge_date IS NULL THEN
        RETURN 0;
    END IF;
    RETURN GREATEST(DATEDIFF(p_last_recharge_date, CURDATE()) + p_validity_days, 0);
END //

-- P2: shows how a caller can handle a SQLEXCEPTION raised by SIGNAL.
DROP PROCEDURE IF EXISTS sp_recharge_error_demo //

CREATE PROCEDURE sp_recharge_error_demo(IN p_amount DECIMAL(10,2))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'SQLEXCEPTION_HANDLED_INVALID_RECHARGE' AS outcome;
    END;

    CALL sp_recharge(1, p_amount, @demo_balance);
    SELECT 'NO_ERROR' AS outcome;
END //

DELIMITER ;

-- Calls and reports.
CALL sp_recharge(1, 100.00, @new_balance);
SELECT @new_balance AS new_balance;

CALL sp_recharge_error_demo(-5.00);

SELECT s.subscriber_no,
       s.full_name,
       s.balance,
       fn_validity_days_left(s.last_recharge_date, pl.validity_days) AS validity_days_left
FROM subscribers s JOIN plans pl ON pl.id = s.plan_id
ORDER BY s.subscriber_no;
