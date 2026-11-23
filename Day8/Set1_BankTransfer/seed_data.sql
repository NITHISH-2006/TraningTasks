USE day8_bank_transfer;

INSERT INTO accounts (id, account_no, holder_name, balance, status) VALUES
    (1, 'SB-1001', 'Asha Rao',     2500.00, 'ACTIVE'),
    (2, 'SB-1002', 'Vijay Kumar',  1800.00, 'ACTIVE'),
    (3, 'SB-1003', 'Meera Nair',    900.00, 'ACTIVE');

INSERT INTO account_transactions
    (id, account_id, txn_type, amount, counterparty_account_id, description, balance_after, txn_date) VALUES
    (1, 1, 'CREDIT', 3000.00, NULL, 'Salary credit',        3000.00, '2026-10-01 09:00:00'),
    (2, 1, 'DEBIT',   500.00, NULL, 'Rent payment',         2500.00, '2026-10-02 09:00:00'),
    (3, 2, 'CREDIT', 2000.00, NULL, 'Salary credit',        2000.00, '2026-10-01 09:05:00'),
    (4, 2, 'DEBIT',   200.00, NULL, 'Utility bill',         1800.00, '2026-10-03 09:00:00'),
    (5, 3, 'CREDIT', 1000.00, NULL, 'Opening deposit',      1000.00, '2026-10-01 10:00:00'),
    (6, 3, 'DEBIT',   100.00, NULL, 'Mobile recharge',       900.00, '2026-10-04 10:00:00');
