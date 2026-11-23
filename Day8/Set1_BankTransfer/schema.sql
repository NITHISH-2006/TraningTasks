DROP DATABASE IF EXISTS day8_bank_transfer;
CREATE DATABASE day8_bank_transfer;
USE day8_bank_transfer;

CREATE TABLE accounts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    account_no VARCHAR(20) NOT NULL UNIQUE,
    holder_name VARCHAR(100) NOT NULL,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    status ENUM('ACTIVE', 'FROZEN', 'CLOSED') NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT chk_accounts_balance_nonnegative CHECK (balance >= 0.00)
) ENGINE=InnoDB;

CREATE TABLE account_transactions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    account_id BIGINT NOT NULL,
    txn_type ENUM('DEBIT', 'CREDIT', 'FEE', 'FEE_REVERSAL') NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    counterparty_account_id BIGINT NULL,
    description VARCHAR(150) NOT NULL,
    balance_after DECIMAL(12,2) NOT NULL,
    txn_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_txn_amount_positive CHECK (amount > 0.00),
    CONSTRAINT fk_txn_account FOREIGN KEY (account_id) REFERENCES accounts(id),
    CONSTRAINT fk_txn_counterparty FOREIGN KEY (counterparty_account_id) REFERENCES accounts(id)
) ENGINE=InnoDB;

CREATE INDEX idx_txn_account_date ON account_transactions(account_id, txn_date, id);
