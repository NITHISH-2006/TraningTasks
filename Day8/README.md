# Day 8 - CTEs, Window Functions and Transactions (MySQL 8.4 LTS)

Topics: ACID transactions, `START TRANSACTION`/`COMMIT`/`ROLLBACK`, savepoints, autocommit, isolation levels, locking reads, CTEs, correlated subqueries and window functions.

Each set includes its own `schema.sql` and `seed_data.sql` so the transaction and reporting scripts can be executed independently.

| Set | Folder | Focus | Key Deliverables |
|---|---|---|---|
| 1 | `Set1_BankTransfer/` | Atomic funds transfer, rollback evidence, statement CTE | `transfer.sql`, `statement_cte.sql`, `isolation_level_note.md` |
| 2 | `Set2_AirlineBooking/` | Seat reservation with `FOR UPDATE`, ranked fares, running revenue | `booking_transaction.sql`, `ranking_report.sql`, `locking_note.md` |
| 3 | `Set3_RetailReservation/` | Stock reservation, rollback, category ranking, MoM sales | `reservation.sql`, `rank_report.sql`, `acid_explanation.md` |

Run, from the repository root (MySQL 8.4):

```sql
SOURCE Day8/Set1_BankTransfer/schema.sql;
SOURCE Day8/Set1_BankTransfer/seed_data.sql;
SOURCE Day8/Set1_BankTransfer/transfer.sql;
SOURCE Day8/Set1_BankTransfer/statement_cte.sql;
```
