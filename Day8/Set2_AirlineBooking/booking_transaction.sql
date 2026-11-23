USE day8_airline_booking;

-- Q1: Atomic seat reservation. FOR UPDATE serialises concurrent check + insert + update.
DELIMITER //

DROP PROCEDURE IF EXISTS sp_book_seat //

CREATE PROCEDURE sp_book_seat(
    IN p_flight_id BIGINT,
    IN p_seat_id BIGINT,
    IN p_passenger_id BIGINT,
    OUT p_booking_id BIGINT
)
BEGIN
    DECLARE v_seat_status VARCHAR(10) DEFAULT NULL;
    DECLARE v_fare DECIMAL(10,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_booking_id = NULL;
        RESIGNAL;
    END;

    SET p_booking_id = NULL;
    START TRANSACTION;

    SELECT status, fare INTO v_seat_status, v_fare
    FROM seats
    WHERE id = p_seat_id AND flight_id = p_flight_id
    FOR UPDATE;

    IF v_seat_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Seat does not exist on this flight';
    END IF;

    IF v_seat_status <> 'AVAILABLE' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Seat is no longer available';
    END IF;

    INSERT INTO bookings (booking_ref, flight_id, seat_id, passenger_id, fare, status)
    VALUES (CONCAT('BK-', UUID_SHORT()), p_flight_id, p_seat_id, p_passenger_id, v_fare, 'CONFIRMED');

    SET p_booking_id = LAST_INSERT_ID();

    UPDATE seats SET status = 'BOOKED' WHERE id = p_seat_id;

    COMMIT;
END //

DELIMITER ;

-- Q1 call.
CALL sp_book_seat(1, 1, 1, @booking_id);
SELECT @booking_id AS new_booking_id;

-- Q2: Two-session locking simulation (run statements in the order shown, in two connections).
-- Session A:
--   START TRANSACTION;
--   SELECT id, status FROM seats WHERE id = 2 FOR UPDATE;
-- Session B (second connection):
--   START TRANSACTION;
--   SELECT id, status FROM seats WHERE id = 2 FOR UPDATE;   -- blocks until A commits/rolls back
-- Session A:
--   UPDATE seats SET status = 'BOOKED' WHERE id = 2;
--   INSERT INTO bookings (booking_ref, flight_id, seat_id, passenger_id, fare)
--   VALUES ('BK-LOCK-DEMO', 1, 2, 2, 9500.00);
--   COMMIT;
-- Session B now unblocks, sees status = 'BOOKED' and must abort instead of booking.
--   ROLLBACK;

-- Verify the outcome of the calls/simulation.
SELECT s.id, s.seat_no, s.status, b.booking_ref, p.full_name
FROM seats s
LEFT JOIN bookings b ON b.seat_id = s.id
LEFT JOIN passengers p ON p.id = b.passenger_id
ORDER BY s.id;
