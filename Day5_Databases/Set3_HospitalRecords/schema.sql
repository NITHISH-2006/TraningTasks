-- Hospital Patient Records - Schema (MySQL 8.4, InnoDB)
DROP DATABASE IF EXISTS hospital_records;
CREATE DATABASE hospital_records;
USE hospital_records;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name     VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE doctors (
    doctor_id     INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name   VARCHAR(120) NOT NULL,
    department_id INT NOT NULL,
    phone         VARCHAR(20),
    CONSTRAINT fk_doctor_dept FOREIGN KEY (department_id)
        REFERENCES departments(department_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name  VARCHAR(120) NOT NULL,
    address    VARCHAR(200) NOT NULL,
    phone      VARCHAR(20),
    dob        DATE
) ENGINE=InnoDB;

CREATE TABLE visits (
    visit_id    INT AUTO_INCREMENT PRIMARY KEY,
    patient_id  INT NOT NULL,
    doctor_id   INT NOT NULL,
    visit_date  DATE NOT NULL,
    diagnosis   VARCHAR(255) NOT NULL,
    prescription VARCHAR(255),
    CONSTRAINT chk_visit_date CHECK (visit_date >= '2000-01-01' AND visit_date <= '2030-12-31'),
    CONSTRAINT fk_visit_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_visit_doctor FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE billing (
    bill_id    INT AUTO_INCREMENT PRIMARY KEY,
    visit_id   INT NOT NULL UNIQUE,
    bill_amount DECIMAL(10,2) NOT NULL,
    bill_status VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    CONSTRAINT chk_bill_nonneg CHECK (bill_amount >= 0),
    CONSTRAINT chk_bill_status CHECK (bill_status IN ('OPEN','PAID','CANCELLED')),
    CONSTRAINT fk_bill_visit FOREIGN KEY (visit_id)
        REFERENCES visits(visit_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
