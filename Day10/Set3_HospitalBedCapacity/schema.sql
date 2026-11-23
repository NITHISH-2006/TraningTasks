DROP DATABASE IF EXISTS day10_hospital_capacity;
CREATE DATABASE day10_hospital_capacity;
USE day10_hospital_capacity;

CREATE TABLE wards (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ward_name VARCHAR(80) NOT NULL UNIQUE,
    capacity INT NOT NULL,
    occupied INT NOT NULL DEFAULT 0,
    CONSTRAINT chk_capacity_positive CHECK (capacity > 0),
    CONSTRAINT chk_occupied_bounds CHECK (occupied >= 0 AND occupied <= capacity)
) ENGINE=InnoDB;

CREATE TABLE admissions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    ward_id BIGINT NOT NULL,
    admitted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    discharged_at DATETIME NULL,
    status ENUM('ADMITTED', 'DISCHARGED') NOT NULL DEFAULT 'ADMITTED',
    CONSTRAINT fk_admission_ward FOREIGN KEY (ward_id) REFERENCES wards(id)
) ENGINE=InnoDB;

CREATE TABLE admission_audit (
    audit_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    action_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    admission_id BIGINT NOT NULL,
    old_patient_name VARCHAR(100) NULL,
    new_patient_name VARCHAR(100) NULL,
    old_ward_id BIGINT NULL,
    new_ward_id BIGINT NULL,
    old_status ENUM('ADMITTED', 'DISCHARGED') NULL,
    new_status ENUM('ADMITTED', 'DISCHARGED') NULL,
    changed_at DATETIME NOT NULL,
    changed_by VARCHAR(100) NOT NULL
) ENGINE=InnoDB;
