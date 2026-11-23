USE day10_hospital_capacity;

DELIMITER //

-- T1: BEFORE INSERT blocks an admission to a full ward.
DROP TRIGGER IF EXISTS trg_admissions_before_insert_capacity //

CREATE TRIGGER trg_admissions_before_insert_capacity
BEFORE INSERT ON admissions
FOR EACH ROW
BEGIN
    DECLARE v_capacity INT;
    DECLARE v_occupied INT;

    IF NEW.status = 'ADMITTED' THEN
        SELECT capacity, occupied INTO v_capacity, v_occupied
        FROM wards WHERE id = NEW.ward_id;

        IF v_occupied >= v_capacity THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Admission rejected: ward is at full capacity';
        END IF;
    END IF;
END //

-- T1b: BEFORE UPDATE blocks discharge-to-admitted or ward changes into a full ward.
DROP TRIGGER IF EXISTS trg_admissions_before_update_capacity //

CREATE TRIGGER trg_admissions_before_update_capacity
BEFORE UPDATE ON admissions
FOR EACH ROW
BEGIN
    DECLARE v_capacity INT;
    DECLARE v_occupied INT;

    IF NEW.status = 'ADMITTED'
       AND (OLD.status <> 'ADMITTED' OR NEW.ward_id <> OLD.ward_id) THEN
        SELECT capacity, occupied INTO v_capacity, v_occupied
        FROM wards WHERE id = NEW.ward_id;

        IF v_occupied >= v_capacity THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Admission update rejected: target ward is full';
        END IF;
    END IF;
END //

-- T2a: AFTER INSERT audits and increments occupied.
DROP TRIGGER IF EXISTS trg_admissions_after_insert //

CREATE TRIGGER trg_admissions_after_insert
AFTER INSERT ON admissions
FOR EACH ROW
BEGIN
    INSERT INTO admission_audit
        (action_type, admission_id, old_patient_name, new_patient_name,
         old_ward_id, new_ward_id, old_status, new_status, changed_at, changed_by)
    VALUES
        ('INSERT', NEW.id, NULL, NEW.patient_name,
         NULL, NEW.ward_id, NULL, NEW.status, NOW(), USER());

    IF NEW.status = 'ADMITTED' THEN
        UPDATE wards SET occupied = occupied + 1 WHERE id = NEW.ward_id;
    END IF;
END //

-- T2b: AFTER UPDATE audits and moves the occupied count when needed.
DROP TRIGGER IF EXISTS trg_admissions_after_update //

CREATE TRIGGER trg_admissions_after_update
AFTER UPDATE ON admissions
FOR EACH ROW
BEGIN
    INSERT INTO admission_audit
        (action_type, admission_id, old_patient_name, new_patient_name,
         old_ward_id, new_ward_id, old_status, new_status, changed_at, changed_by)
    VALUES
        ('UPDATE', NEW.id, OLD.patient_name, NEW.patient_name,
         OLD.ward_id, NEW.ward_id, OLD.status, NEW.status, NOW(), USER());

    IF OLD.status = 'ADMITTED' THEN
        UPDATE wards SET occupied = occupied - 1 WHERE id = OLD.ward_id;
    END IF;
    IF NEW.status = 'ADMITTED' THEN
        UPDATE wards SET occupied = occupied + 1 WHERE id = NEW.ward_id;
    END IF;
END //

-- T2c: AFTER DELETE audits and frees a bed.
DROP TRIGGER IF EXISTS trg_admissions_after_delete //

CREATE TRIGGER trg_admissions_after_delete
AFTER DELETE ON admissions
FOR EACH ROW
BEGIN
    INSERT INTO admission_audit
        (action_type, admission_id, old_patient_name, new_patient_name,
         old_ward_id, new_ward_id, old_status, new_status, changed_at, changed_by)
    VALUES
        ('DELETE', OLD.id, OLD.patient_name, NULL,
         OLD.ward_id, NULL, OLD.status, NULL, NOW(), USER());

    IF OLD.status = 'ADMITTED' THEN
        UPDATE wards SET occupied = occupied - 1 WHERE id = OLD.ward_id;
    END IF;
END //

DELIMITER ;
