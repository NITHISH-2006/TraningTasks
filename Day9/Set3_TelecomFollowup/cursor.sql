USE day9_telecom_followup;

-- P3: one notification per low-balance prepaid subscriber, row by row.
DELIMITER //

DROP PROCEDURE IF EXISTS sp_low_balance_notifications //

CREATE PROCEDURE sp_low_balance_notifications(OUT p_notified INT)
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_subscriber_id BIGINT;
    DECLARE cur_low_balance CURSOR FOR
        SELECT s.id
        FROM subscribers s
        WHERE s.connection_type = 'PREPAID' AND s.balance < 50
        ORDER BY s.id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;

    SET p_notified = 0;

    OPEN cur_low_balance;

    read_loop: LOOP
        FETCH cur_low_balance INTO v_subscriber_id;
        IF v_done THEN
            LEAVE read_loop;
        END IF;

        INSERT INTO notifications (subscriber_id, message)
        SELECT s.id, CONCAT('Low balance warning: ', s.balance, ' units remaining')
        FROM subscribers s
        WHERE s.id = v_subscriber_id
          AND NOT EXISTS (
              SELECT 1 FROM notifications n
              WHERE n.subscriber_id = s.id AND DATE(n.created_at) = CURDATE()
          );

        SET p_notified = p_notified + ROW_COUNT();
    END LOOP;

    CLOSE cur_low_balance;
END //

DELIMITER ;

-- Cursor run with timing.
DELETE FROM notifications;
SET @cursor_start = NOW(6);
CALL sp_low_balance_notifications(@cursor_notified);
SELECT @cursor_notified AS cursor_notifications,
       TIMESTAMPDIFF(MICROSECOND, @cursor_start, NOW(6)) AS cursor_elapsed_microseconds;

-- Set-based rewrite with timing.
DELETE FROM notifications;
SET @set_start = NOW(6);

INSERT INTO notifications (subscriber_id, message)
SELECT s.id, CONCAT('Low balance warning: ', s.balance, ' units remaining')
FROM subscribers s
WHERE s.connection_type = 'PREPAID'
  AND s.balance < 50
  AND NOT EXISTS (
      SELECT 1 FROM notifications n
      WHERE n.subscriber_id = s.id AND DATE(n.created_at) = CURDATE()
  );

SELECT ROW_COUNT() AS set_based_notifications,
       TIMESTAMPDIFF(MICROSECOND, @set_start, NOW(6)) AS set_based_elapsed_microseconds;

SELECT * FROM notifications ORDER BY id;
