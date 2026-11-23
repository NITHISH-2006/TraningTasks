USE day9_retail_fulfilment;

-- P3: row-by-row cursor with a NOT FOUND handler.
DELIMITER //

DROP PROCEDURE IF EXISTS sp_pending_order_followups //

CREATE PROCEDURE sp_pending_order_followups(OUT p_followups_created INT)
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_order_id BIGINT;
    DECLARE v_count INT DEFAULT 0;
    DECLARE cur_pending CURSOR FOR
        SELECT o.id
        FROM orders o
        WHERE o.status = 'PENDING'
          AND o.order_date < DATE_SUB(NOW(), INTERVAL 3 DAY)
        ORDER BY o.id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;

    SET p_followups_created = 0;
    OPEN cur_pending;

    read_loop: LOOP
        FETCH cur_pending INTO v_order_id;
        IF v_done THEN
            LEAVE read_loop;
        END IF;

        INSERT IGNORE INTO order_followups (order_id, reason)
        VALUES (v_order_id, 'Pending more than 3 days');

        IF ROW_COUNT() > 0 THEN
            SET v_count = v_count + 1;
        END IF;
    END LOOP;

    CLOSE cur_pending;
    SET p_followups_created = v_count;
END //

DELIMITER ;

CALL sp_pending_order_followups(@cursor_followups);
SELECT @cursor_followups AS cursor_followups_created;
SELECT * FROM order_followups ORDER BY id;

-- Set-based rewrite: one INSERT ... SELECT replaces the entire cursor loop.
INSERT IGNORE INTO order_followups (order_id, reason)
SELECT o.id, 'Pending more than 3 days'
FROM orders o
WHERE o.status = 'PENDING'
  AND o.order_date < DATE_SUB(NOW(), INTERVAL 3 DAY);

SELECT ROW_COUNT() AS set_based_new_rows;
