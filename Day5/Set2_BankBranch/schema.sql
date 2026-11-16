-- Bank Branch Accounts - Schema (MySQL 8.4, InnoDB)
DROP DATABASE IF EXISTS bank_branch;
CREATE DATABASE bank_branch;
USE bank_branch;

CREATE TABLE branches (
    branch_id   INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL UNIQUE,
    city        VARCHAR(60) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE relationship_managers (
    rm_id   INT AUTO_INCREMENT PRIMARY KEY,
    rm_name VARCHAR(100) NOT NULL,
    branch_id INT NOT NULL,
    CONSTRAINT fk_rm_branch FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(120) NOT NULL,
    address     VARCHAR(200) NOT NULL,
    phone       VARCHAR(20) NOT NULL,
    rm_id       INT NULL,
    CONSTRAINT fk_cust_rm FOREIGN KEY (rm_id)
        REFERENCES relationship_managers(rm_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE accounts (
    account_id     INT AUTO_INCREMENT PRIMARY KEY,
    account_number VARCHAR(20) NOT NULL,
    customer_id    INT NOT NULL,
    branch_id      INT NOT NULL,
    account_type   VARCHAR(20) NOT NULL,
    balance        DECIMAL(14,2) NOT NULL DEFAULT 0.00,
    opened_date    DATE NOT NULL,
    CONSTRAINT uq_account_number UNIQUE (account_number),
    CONSTRAINT chk_balance_nonneg CHECK (balance >= 0),
    CONSTRAINT chk_account_type CHECK (account_type IN ('SAVINGS','CURRENT','SALARY','FD')),
    CONSTRAINT fk_acct_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_acct_branch FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
