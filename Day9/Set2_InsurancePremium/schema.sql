DROP DATABASE IF EXISTS day9_insurance_premium;
CREATE DATABASE day9_insurance_premium;
USE day9_insurance_premium;

CREATE TABLE customers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    pan_number VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE policies (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    policy_no VARCHAR(30) NOT NULL UNIQUE,
    customer_id BIGINT NOT NULL,
    policy_type VARCHAR(40) NOT NULL,
    status ENUM('ACTIVE', 'PENDING_RENEWAL', 'LAPSED', 'CANCELLED') NOT NULL DEFAULT 'ACTIVE',
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    premium_amount DECIMAL(12,2) NOT NULL,
    sum_assured DECIMAL(14,2) NOT NULL,
    CONSTRAINT fk_policy_customer FOREIGN KEY (customer_id) REFERENCES customers(id)
) ENGINE=InnoDB;

CREATE TABLE claims (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    claim_no VARCHAR(30) NOT NULL UNIQUE,
    policy_id BIGINT NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
    amount DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_claim_policy FOREIGN KEY (policy_id) REFERENCES policies(id)
) ENGINE=InnoDB;

CREATE TABLE premium_audit (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    policy_id BIGINT NOT NULL,
    old_premium DECIMAL(12,2) NOT NULL,
    new_premium DECIMAL(12,2) NOT NULL,
    changed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    note VARCHAR(120) NOT NULL,
    CONSTRAINT fk_audit_policy FOREIGN KEY (policy_id) REFERENCES policies(id)
) ENGINE=InnoDB;

CREATE TABLE policy_lapse_queue (
    policy_id BIGINT PRIMARY KEY,
    CONSTRAINT fk_queue_policy FOREIGN KEY (policy_id) REFERENCES policies(id)
) ENGINE=InnoDB;
