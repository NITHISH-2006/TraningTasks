# Day 9 Set 1 - Retail Order Fulfilment

**Scenario:** Fulfilment rules live in the database so every application uses the same validation, pricing and follow-up logic.

## Deliverables

- [`views.sql`](views.sql) - `vw_order_summary`, `vw_low_stock`, updatable view with `WITH CHECK OPTION`.
- [`procedures.sql`](procedures.sql) - `sp_place_order`, `fn_order_total_with_tax`, `SIGNAL` error demo, procedure/function comparison in [`notes/Notes.md`](notes/Notes.md).
- [`cursor.sql`](cursor.sql) - cursor with `NOT FOUND` handler plus the set-based rewrite.
- [`cursor_vs_setbased.md`](cursor_vs_setbased.md) - comparison of the two implementations.
- [`schema.sql`](schema.sql) / [`seed_data.sql`](seed_data.sql) - self-contained InnoDB setup.

## Run

```sql
SOURCE Day9/Set1_RetailFulfilment/schema.sql;
SOURCE Day9/Set1_RetailFulfilment/seed_data.sql;
SOURCE Day9/Set1_RetailFulfilment/views.sql;
SOURCE Day9/Set1_RetailFulfilment/procedures.sql;
SOURCE Day9/Set1_RetailFulfilment/cursor.sql;
```
