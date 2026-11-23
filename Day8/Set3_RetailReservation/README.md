# Day 8 Set 3 - Retail Inventory Reservation

**Scenario:** Placing an order must reserve stock atomically. If any line has insufficient stock, the order, lines and stock changes all roll back.

## Deliverables

- [`reservation.sql`](reservation.sql) - transactional order reservation with JSON line items and insufficient-stock rollback.
- [`rank_report.sql`](rank_report.sql) - correlated below-average stock query, CTE top-three ranking, `LEAD`/`LAG` sales trend.
- [`acid_explanation.md`](acid_explanation.md) - ACID properties mapped to this scenario plus a non-transactional counter-example.
- [`schema.sql`](schema.sql) / [`seed_data.sql`](seed_data.sql) - self-contained InnoDB setup.
- [`notes/Notes.md`](notes/Notes.md) - implementation rationale.

## Run

```sql
SOURCE Day8/Set3_RetailReservation/schema.sql;
SOURCE Day8/Set3_RetailReservation/seed_data.sql;
SOURCE Day8/Set3_RetailReservation/reservation.sql;
SOURCE Day8/Set3_RetailReservation/rank_report.sql;
```
