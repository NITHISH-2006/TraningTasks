# Notes - Day 8 Set 2

- `sp_book_seat` validates and mutates the seat in one transaction; the `EXIT HANDLER` rolls back and re-signals on any SQL error.
- `FOR UPDATE` is a current/locking read, so it is not affected by the repeatable-read snapshot and prevents the classic check-then-insert race.
- `UUID_SHORT()` supplies a unique booking reference; a real system would use a longer, collision-safe generator.
- The ranking report demonstrates `RANK`, `DENSE_RANK`, a CTE chain, a framed `SUM() OVER (...)`, and a correlated above-average-fare subquery.
- Querying `information_schema.INNODB_TRX` and `performance_schema.data_locks` while session A holds the lock shows the waiting transaction and the explicit row lock.
