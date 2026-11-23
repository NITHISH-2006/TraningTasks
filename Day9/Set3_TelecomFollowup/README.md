# Day 9 Set 3 - Telecom Low-Balance Follow-up

**Scenario:** Prepaid recharges must update balances and history atomically, while low-balance subscribers are notified through either a cursor job or one set-based statement.

## Deliverables

- [`views.sql`](views.sql) - `vw_prepaid_subscribers` (hides postpaid/sensitive data) and `vw_recharge_summary`.
- [`procedures.sql`](procedures.sql) - `sp_recharge` with `OUT` balance, `fn_validity_days_left`, `SQLEXCEPTION` handler and `SIGNAL` demo.
- [`cursor.sql`](cursor.sql) - low-balance cursor with `NOT FOUND` handler and set-based rewrite with timing.
- [`timing_comparison.md`](timing_comparison.md) - timing comparison notes.
- [`schema.sql`](schema.sql) / [`seed_data.sql`](seed_data.sql) - self-contained InnoDB setup.

## Run

```sql
SOURCE Day9/Set3_TelecomFollowup/schema.sql;
SOURCE Day9/Set3_TelecomFollowup/seed_data.sql;
SOURCE Day9/Set3_TelecomFollowup/views.sql;
SOURCE Day9/Set3_TelecomFollowup/procedures.sql;
SOURCE Day9/Set3_TelecomFollowup/cursor.sql;
```
