DROP DATABASE IF EXISTS day9_telecom_followup;
CREATE DATABASE day9_telecom_followup;
USE day9_telecom_followup;

CREATE TABLE plans (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(80) NOT NULL UNIQUE,
    monthly_fee DECIMAL(10,2) NOT NULL,
    validity_days INT NOT NULL,
    plan_type ENUM('PREPAID', 'POSTPAID') NOT NULL,
    CONSTRAINT chk_validity_positive CHECK (validity_days > 0)
) ENGINE=InnoDB;

CREATE TABLE subscribers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    subscriber_no VARCHAR(20) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL,
    plan_id BIGINT NOT NULL,
    connection_type ENUM('PREPAID', 'POSTPAID') NOT NULL,
    balance DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    last_recharge_date DATE NULL,
    status ENUM('ACTIVE', 'SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT chk_balance_nonnegative CHECK (balance >= 0.00),
    CONSTRAINT fk_subscriber_plan FOREIGN KEY (plan_id) REFERENCES plans(id)
) ENGINE=InnoDB;

CREATE TABLE recharges (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    subscriber_id BIGINT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    recharge_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    recharge_mode ENUM('ONLINE', 'OFFLINE', 'USSD') NOT NULL DEFAULT 'ONLINE',
    CONSTRAINT chk_recharge_amount_positive CHECK (amount > 0.00),
    CONSTRAINT fk_recharge_subscriber FOREIGN KEY (subscriber_id) REFERENCES subscribers(id)
) ENGINE=InnoDB;

CREATE TABLE notifications (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    subscriber_id BIGINT NOT NULL,
    message VARCHAR(200) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_notification_subscriber FOREIGN KEY (subscriber_id) REFERENCES subscribers(id)
) ENGINE=InnoDB;
