USE day8_bank_transfer;

-- Monthly statement CTE: every transaction is numbered per account and paired with
-- the previous balance_after. LAG's default handles the first row of each partition.
WITH ordered_statement AS (
    SELECT t.id,
           t.account_id,
           t.txn_date,
           t.txn_type,
           t.description,
           CASE WHEN t.txn_type = 'CREDIT' THEN t.amount ELSE -t.amount END AS signed_amount,
           t.balance_after,
           ROW_NUMBER() OVER (
               PARTITION BY t.account_id ORDER BY t.txn_date, t.id
           ) AS statement_row,
           LAG(t.balance_after, 1,
               t.balance_after - CASE WHEN t.txn_type = 'CREDIT' THEN t.amount ELSE -t.amount END
           ) OVER (
               PARTITION BY t.account_id ORDER BY t.txn_date, t.id
           ) AS previous_balance
    FROM account_transactions t
)
SELECT a.account_no,
       s.statement_row,
       s.txn_date,
       s.txn_type,
       s.description,
       s.signed_amount,
       s.previous_balance,
       s.balance_after,
       s.balance_after - s.previous_balance AS movement
FROM ordered_statement s
JOIN accounts a ON a.id = s.account_id
ORDER BY a.account_no, s.statement_row;
