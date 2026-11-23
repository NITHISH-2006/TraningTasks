USE day9_insurance_premium;

DELIMITER //

-- F1: reusable no-claim discount calculation.
DROP FUNCTION IF EXISTS fn_premium_with_no_claim_discount //

CREATE FUNCTION fn_premium_with_no_claim_discount(
    p_premium DECIMAL(12,2),
    p_pending_claims INT
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    IF p_pending_claims = 0 THEN
        RETURN ROUND(p_premium * 0.90, 2);
    END IF;
    RETURN p_premium;
END //

-- P1: renew one policy; INOUT carries the running processed count back to the caller.
DROP PROCEDURE IF EXISTS sp_renew_policy //

CREATE PROCEDURE sp_renew_policy(
    IN p_policy_id BIGINT,
    INOUT p_processed_count INT
)
BEGIN
    DECLARE v_status VARCHAR(20) DEFAULT NULL;
    DECLARE v_old_premium DECIMAL(12,2);
    DECLARE v_sum_assured DECIMAL(14,2);
    DECLARE v_new_premium DECIMAL(12,2);
    DECLARE v_pending_claims INT DEFAULT 0;
    DECLARE v_end_date DATE;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF p_processed_count IS NULL THEN
        SET p_processed_count = 0;
    END IF;

    START TRANSACTION;

    SELECT status, premium_amount, sum_assured, end_date
    INTO v_status, v_old_premium, v_sum_assured, v_end_date
    FROM policies WHERE id = p_policy_id FOR UPDATE;

    IF v_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Policy does not exist';
    END IF;

    IF v_status NOT IN ('ACTIVE', 'PENDING_RENEWAL') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only ACTIVE or PENDING_RENEWAL policies can be renewed';
    END IF;

    SELECT COUNT(*) INTO v_pending_claims
    FROM claims WHERE policy_id = p_policy_id AND status = 'PENDING';

    IF v_pending_claims > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Renewal blocked: policy has a pending claim';
    END IF;

    SET v_new_premium = fn_premium_with_no_claim_discount(
        ROUND(v_sum_assured * 0.02, 2), 0
    );

    UPDATE policies
    SET status = 'ACTIVE',
        premium_amount = v_new_premium,
        end_date = DATE_ADD(v_end_date, INTERVAL 1 YEAR)
    WHERE id = p_policy_id;

    INSERT INTO premium_audit (policy_id, old_premium, new_premium, note)
    VALUES (p_policy_id, v_old_premium, v_new_premium, 'Renewal with no-claim discount');

    SET p_processed_count = p_processed_count + 1;

    COMMIT;
END //

DELIMITER ;

-- Calls: policy 1 succeeds; policy 2 is rejected because it has a pending claim.
SET @processed = 0;
CALL sp_renew_policy(1, @processed);
SELECT @processed AS processed_after_first;

DELIMITER //

DROP PROCEDURE IF EXISTS sp_demo_pending_claim_block //

CREATE PROCEDURE sp_demo_pending_claim_block()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'RENEWAL_BLOCKED_BY_PENDING_CLAIM' AS outcome;
    END;

    CALL sp_renew_policy(2, @processed);
    SELECT 'UNEXPECTEDLY_RENEWED' AS outcome;
END //

DELIMITER ;

CALL sp_demo_pending_claim_block();
SELECT @processed AS processed_after_second;

-- Report using the stored function.
SELECT p.policy_no,
       p.premium_amount AS current_premium,
       fn_premium_with_no_claim_discount(p.premium_amount, 0) AS renewal_premium_if_no_claim
FROM policies p
ORDER BY p.policy_no;
