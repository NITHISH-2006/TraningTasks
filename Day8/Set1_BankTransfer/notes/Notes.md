# Notes - Day 8 Set 1

- All money columns use `DECIMAL`, never floating point.
- `sp_transfer_funds` uses `START TRANSACTION`, two `FOR UPDATE` reads, validation with `SIGNAL SQLSTATE '45000'`, paired ledger inserts, and `COMMIT`. An `EXIT HANDLER` issues `ROLLBACK` and re-signals so the caller sees the real error.
- Rows are locked in ascending account id order to keep a global lock order and avoid deadlocks.
- `sp_failed_transfer_rollback_demo` deliberately raises an error after the debit and its handler rolls back; the account balance and transaction count are restored.
- `sp_transfer_with_fee_savepoint` commits the transfer but rolls back only the fee posting via `SAVEPOINT` / `ROLLBACK TO SAVEPOINT`.
- `statement_cte.sql` uses `ROW_NUMBER()` for deterministic statement ordering and `LAG(balance_after)` to derive the balance before each transaction.
- The ACID behaviour depends on InnoDB; MyISAM would silently discard the rollback demonstration.
