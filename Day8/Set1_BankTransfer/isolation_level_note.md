# Isolation Level and Autocommit Note (Day 8 Set 1)

## Autocommit

```sql
SELECT @@autocommit;          -- 1 by default: each statement is its own transaction
SET autocommit = 0;           -- statements stay in one transaction until COMMIT/ROLLBACK
```

When autocommit is `0`, always finish an explicit unit of work with `COMMIT` or `ROLLBACK`; otherwise the connection retains locks and an open transaction. `START TRANSACTION` suspends autocommit for one transaction even when `@@autocommit = 1`.

## Two-session experiment: READ COMMITTED vs REPEATABLE READ

Use two MySQL connections (A and B) on the seeded database.

| Step | Session A | Session B |
|---|---|---|
| 1 | `SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED; START TRANSACTION; SELECT balance FROM accounts WHERE id=1;` -> `2500.00` | |
| 2 | | `UPDATE accounts SET balance = 2000.00 WHERE id=1; COMMIT;` |
| 3 | `SELECT balance FROM accounts WHERE id=1;` -> `2000.00` | |
| 4 | `COMMIT;` | |

The second read sees the newly committed value: `READ COMMITTED` permits a **non-repeatable read**.

Repeat with `SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;` in session A before step 1. Step 3 still returns `2500.00`, because InnoDB creates a consistent read snapshot at the first plain `SELECT`. Only `COMMIT`/`ROLLBACK` ends that snapshot.

## Locking reads

`SELECT ... FOR UPDATE` is a **locking/current read**; it reads the latest committed version and takes an exclusive next-key lock on InnoDB. It is not satisfied from the repeatable-read snapshot. That is why all transfer validation in `transfer.sql` uses `FOR UPDATE`: two sessions cannot simultaneously validate the same balance and both overdraw the account.

## Practical conclusion

- `READ COMMITTED`: each statement gets a fresh snapshot; good when fresh values matter more than repeatability.
- `REPEATABLE READ` (InnoDB default): consistent results for the same transaction; use `FOR UPDATE` for reads that gate a write.
- Keep transactions short and lock rows in a consistent order (this solution locks the lower account id first) to reduce deadlock risk.
