USE day10_hospital_capacity;

-- T3: ICU starts with occupied = 1, capacity = 2. The first row would fit, the
-- second would exceed capacity. InnoDB rolls back the whole statement.
DELIMITER //

DROP PROCEDURE IF EXISTS sp_test_full_ward_batch //

CREATE PROCEDURE sp_test_full_ward_batch()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'BATCH_REJECTED_BY_TRIGGER' AS outcome;
    END;

    START TRANSACTION;
    INSERT INTO admissions (patient_name, ward_id, status) VALUES
        ('Patient G', 1, 'ADMITTED'),
        ('Patient H', 1, 'ADMITTED');
    COMMIT;
    SELECT 'BATCH_UNEXPECTEDLY_COMMITTED' AS outcome;
END //

DELIMITER ;

CALL sp_test_full_ward_batch();

SELECT id, ward_name, capacity, occupied FROM wards ORDER BY id;
SELECT id, patient_name, ward_id, status FROM admissions ORDER BY id;
SELECT action_type, admission_id, new_patient_name, new_ward_id, new_status
FROM admission_audit ORDER BY audit_id;

-- Valid single admission to General (2 of 5 occupied -> 3 of 5).
INSERT INTO admissions (patient_name, ward_id, status)
VALUES ('Patient I', 2, 'ADMITTED');

SELECT id, ward_name, capacity, occupied FROM wards ORDER BY id;

-- Discharge frees a bed; audit still records the change.
UPDATE admissions SET status = 'DISCHARGED', discharged_at = NOW() WHERE id = 2;
SELECT id, ward_name, capacity, occupied FROM wards ORDER BY id;
SELECT action_type, admission_id, old_status, new_status FROM admission_audit ORDER BY audit_id;

SELECT TRIGGER_NAME, EVENT_MANIPULATION, ACTION_TIMING
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'day10_hospital_capacity'
ORDER BY EVENT_MANIPULATION, ACTION_TIMING;
