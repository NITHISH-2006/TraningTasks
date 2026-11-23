USE day9_insurance_premium;

-- P2: row-by-row lapse processing with NOT FOUND handler.
DELIMITER //

DROP PROCEDURE IF EXISTS sp_lapse_premiums //

CREATE PROCEDURE sp_lapse_premiums(INOUT p_processed_count INT)
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_policy_id BIGINT;
    DECLARE cur_lapse CURSOR FOR
        SELECT policy_id FROM policy_lapse_queue ORDER BY policy_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;

    IF p_processed_count IS NULL THEN
        SET p_processed_count = 0;
    END IF;

    DELETE FROM policy_lapse_queue;
    INSERT INTO policy_lapse_queue (policy_id)
    SELECT id FROM policies WHERE status = 'ACTIVE' AND end_date < CURDATE();

    OPEN cur_lapse;

    read_loop: LOOP
        FETCH cur_lapse INTO v_policy_id;
        IF v_done THEN
            LEAVE read_loop;
        END IF;

        UPDATE policies SET status = 'LAPSED' WHERE id = v_policy_id;

        INSERT INTO premium_audit (policy_id, old_premium, new_premium, note)
        SELECT id, premium_amount, premium_amount, 'Lapsed by cursor'
        FROM policies WHERE id = v_policy_id;

        SET p_processed_count = p_processed_count + 1;
    END LOOP;

    CLOSE cur_lapse;
END //

DELIMITER ;

SET @lapsed = 0;
CALL sp_lapse_premiums(@lapsed);
SELECT @lapsed AS cursor_lapsed_count;

-- Set-based rewrite of the same job. Reset policy 3 so the rewrite has work to do.
UPDATE policies SET status = 'ACTIVE' WHERE id = 3;

INSERT INTO premium_audit (policy_id, old_premium, new_premium, note)
SELECT id, premium_amount, premium_amount, 'Lapsed by set-based statement'
FROM policies
WHERE status = 'ACTIVE' AND end_date < CURDATE();

UPDATE policies SET status = 'LAPSED'
WHERE status = 'ACTIVE' AND end_date < CURDATE();

SELECT ROW_COUNT() AS set_based_lapsed_count;
SELECT p.id, p.policy_no, p.status, a.note
FROM policies p LEFT JOIN premium_audit a ON a.policy_id = p.id
ORDER BY p.id, a.id DESC;
