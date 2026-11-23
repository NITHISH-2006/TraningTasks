# Day 9 - Views, Stored Procedures, Functions and Cursors (MySQL 8.4 LTS)

Topics: security/simplification views, updatable views with `WITH CHECK OPTION`, transactional stored procedures, `IN`/`OUT`/`INOUT` parameters, stored functions, cursors with `NOT FOUND` handlers, `SIGNAL` and set-based rewrites.

Each set ships its own `schema.sql` and `seed_data.sql`; run them before the views/procedures/cursor scripts.

| Set | Folder | Focus | Key Deliverables |
|---|---|---|---|
| 1 | `Set1_RetailFulfilment/` | Order placement, tax function, pending-order follow-ups | `views.sql`, `procedures.sql`, `cursor.sql`, `cursor_vs_setbased.md` |
| 2 | `Set2_InsurancePremium/` | Policy renewal, discount function, lapse processing | `views.sql`, `procedures.sql`, `cursor.sql`, `comparison.md` |
| 3 | `Set3_TelecomFollowup/` | Recharge, validity function, low-balance notifications | `views.sql`, `procedures.sql`, `cursor.sql`, `timing_comparison.md` |

Run, from the repository root (MySQL 8.4):

```sql
SOURCE Day9/Set1_RetailFulfilment/schema.sql;
SOURCE Day9/Set1_RetailFulfilment/seed_data.sql;
SOURCE Day9/Set1_RetailFulfilment/views.sql;
SOURCE Day9/Set1_RetailFulfilment/procedures.sql;
SOURCE Day9/Set1_RetailFulfilment/cursor.sql;
```
