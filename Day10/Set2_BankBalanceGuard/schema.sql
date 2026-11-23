DROP DATABASE IF EXISTS day10_bank_balance_guard;
CREATE DATABASE day10_bank_balance_guard;
USE day10_bank_balance_guard;

CREATE TABLE accounts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    account_no VARCHAR(20) NOT NULL UNIQUE,
    holder_name VARCHAR(100) NOT NULL,
    account_type ENUM('SAVINGS', 'CURRENT') NOT NULL,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    last_txn_date DATETIME NULL,
    CONSTRAINT chk_accounts_balance_nonnegative CHECK (balance >= 0.00)
) ENGINE=InnoDB;

CREATE TABLE account_transaction (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    account_id BIGINT NOT NULL,
    txn_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(12,2) NOT NULL,
    description VARCHAR(150) NOT NULL,
    CONSTRAINT fk_txn_account FOREIGN KEY (account_id) REFERENCES accounts(id)
) ENGINE=InnoDB;

CREATE TABLE account_audit (
    audit_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    action_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    txn_id BIGINT NOT NULL,
    account_id BIGINT NOT NULL,
    old_amount DECIMAL(12,2) NULL,
    new_amount DECIMAL(12,2) NULL,
    old_description VARCHAR(150) NULL,
    new_description VARCHAR(150) NULL,
    changed_at DATETIME NOT NULL,
    changed_by VARCHAR(100) NOT NULL
) ENGINE=InnoDB;
