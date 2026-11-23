# Day 10 Set 2 - Bank Account Balance Guard

**Scenario:** Every account transaction change must be audited, savings balances must never go negative, and `accounts.last_txn_date` must stay current.

## Deliverables

- [`triggers.sql`](triggers.sql) - AFTER INSERT/UPDATE/DELETE audit, BEFORE UPDATE savings guard and derived-date maintenance trigger.
- [`test_evidence.sql`](test_evidence.sql) - batch update, audit and derived-column evidence.
- [`limitations_note.md`](limitations_note.md) - why MySQL has no `INSTEAD OF` trigger and when to use `CHECK`/procedures.
- [`schema.sql`](schema.sql) / [`seed_data.sql`](seed_data.sql) - self-contained InnoDB setup.

## Run

```sql
SOURCE Day10/Set2_BankBalanceGuard/schema.sql;
SOURCE Day10/Set2_BankBalanceGuard/seed_data.sql;
SOURCE Day10/Set2_BankBalanceGuard/triggers.sql;
SOURCE Day10/Set2_BankBalanceGuard/test_evidence.sql;
```
