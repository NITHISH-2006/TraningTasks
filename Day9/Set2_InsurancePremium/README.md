# Day 9 Set 2 - Insurance Premium Processing

**Scenario:** Monthly renewals must use one premium formula, validate policy/claim state, audit changes and handle lapsed premiums.

## Deliverables

- [`views.sql`](views.sql) - `vw_policy_due` without sensitive customer columns.
- [`procedures.sql`](procedures.sql) - `sp_renew_policy` with `INOUT` count, `fn_premium_with_no_claim_discount`, transactional audit and handlers.
- [`cursor.sql`](cursor.sql) - lapse cursor with `NOT FOUND` handler plus set-based rewrite.
- [`comparison.md`](comparison.md) - cursor vs set-based comparison.
- [`schema.sql`](schema.sql) / [`seed_data.sql`](seed_data.sql) - self-contained InnoDB setup.

## Run

```sql
SOURCE Day9/Set2_InsurancePremium/schema.sql;
SOURCE Day9/Set2_InsurancePremium/seed_data.sql;
SOURCE Day9/Set2_InsurancePremium/views.sql;
SOURCE Day9/Set2_InsurancePremium/procedures.sql;
SOURCE Day9/Set2_InsurancePremium/cursor.sql;
```
