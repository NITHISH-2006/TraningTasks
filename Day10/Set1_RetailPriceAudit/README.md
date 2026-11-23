# Day 10 Set 1 - Retail Price Change Audit

**Scenario:** Every selling-price change must be logged with the old value, new value, user and time. Prices below cost must be rejected before the row changes.

## Deliverables

- [`triggers.sql`](triggers.sql) - `AFTER UPDATE` audit trigger and `BEFORE UPDATE` below-cost guard.
- [`test_evidence.sql`](test_evidence.sql) - single-row, multi-row, failure and `information_schema` evidence.
- [`pitfalls_note.md`](pitfalls_note.md) - hidden logic, cascading effects and better-fit alternatives.
- [`schema.sql`](schema.sql) / [`seed_data.sql`](seed_data.sql) - self-contained InnoDB setup.

## Run

```sql
SOURCE Day10/Set1_RetailPriceAudit/schema.sql;
SOURCE Day10/Set1_RetailPriceAudit/seed_data.sql;
SOURCE Day10/Set1_RetailPriceAudit/triggers.sql;
SOURCE Day10/Set1_RetailPriceAudit/test_evidence.sql;
```
