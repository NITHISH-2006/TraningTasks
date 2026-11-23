# Rollback / Savepoint Evidence (Day 8 Set 1)

Run the three `CALL` statements in `transfer.sql`, then execute:

```sql
SELECT id, account_no, balance FROM accounts ORDER BY id;
SELECT id, account_id, txn_type, amount, description, balance_after
FROM account_transactions ORDER BY id;
```

Expected state from the seeded balances (`2500`, `1800`, `900`):

| Check | Expected result |
|---|---|
| After successful transfer of `250.00` from account 1 to 2 | balances `2250.00`, `2050.00`, `900.00`; one `DEBIT` and one `CREDIT` row for `Shared expense settlement` |
| After deliberate failure of `100.00` from account 1 to 2 | balances remain `2250.00`, `2050.00`, `900.00`; no `Failed transfer demo` row survives |
| After savepoint transfer of `100.00` plus `15.00` fee | balances `2150.00`, `2150.00`, `900.00`; one new `DEBIT`/`CREDIT` pair; no surviving `FEE` row |
| Handler output | `TRANSFER_COMMITTED`, `ROLLED_BACK_AFTER_DEBIT`, `TRANSFER_COMMITTED_FEE_REVERSED` |

`ROW_COUNT()` can also be checked immediately after each `UPDATE`, and `SHOW ENGINE INNODB STATUS;` can be used to inspect the most recent deadlock/lock information if the isolation experiment is extended.
