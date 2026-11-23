# Day 8 Set 1 - Bank Funds Transfer

**Scenario:** A bank moves money between two accounts. The debit and credit must either both commit or both roll back; fees can be reversed independently with a savepoint.

## Deliverables

- [`transfer.sql`](transfer.sql) - transactional transfer, deliberate post-debit failure with rollback, and savepoint-based fee reversal.
- [`statement_cte.sql`](statement_cte.sql) - CTE statement with `ROW_NUMBER()` and `LAG()`.
- [`isolation_level_note.md`](isolation_level_note.md) - autocommit and two-session `READ COMMITTED` vs `REPEATABLE READ` experiment.
- [`schema.sql`](schema.sql) / [`seed_data.sql`](seed_data.sql) - self-contained InnoDB setup.
- [`output/rollback_evidence.md`](output/rollback_evidence.md) - verification queries and expected state changes.
- [`notes/Notes.md`](notes/Notes.md) - implementation rationale.

## Run

```sql
SOURCE Day8/Set1_BankTransfer/schema.sql;
SOURCE Day8/Set1_BankTransfer/seed_data.sql;
SOURCE Day8/Set1_BankTransfer/transfer.sql;
SOURCE Day8/Set1_BankTransfer/statement_cte.sql;
```
