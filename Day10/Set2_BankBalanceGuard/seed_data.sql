USE day10_bank_balance_guard;

INSERT INTO accounts (id, account_no, holder_name, account_type, balance, last_txn_date) VALUES
    (1, 'CA-2001', 'Ajay Sharma', 'CURRENT', 1000.00, NULL),
    (2, 'CA-2002', 'Bina Patel',  'CURRENT', 1000.00, NULL),
    (3, 'SB-2003', 'Chitra Nair', 'SAVINGS',  100.00, NULL),
    (4, 'CA-2004', 'Deepak Roy',  'CURRENT', 1000.00, NULL),
    (5, 'CA-2005', 'Esha Menon',  'CURRENT', 1000.00, NULL);
