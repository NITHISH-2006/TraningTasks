# Day 8 Set 2 - Airline Seat Booking

**Scenario:** Two customers may try to reserve the same seat. InnoDB row locking plus a transaction guarantees that only one booking succeeds.

## Deliverables

- [`booking_transaction.sql`](booking_transaction.sql) - `SELECT ... FOR UPDATE` booking procedure and two-session locking simulation.
- [`ranking_report.sql`](ranking_report.sql) - `RANK`, `DENSE_RANK`, CTE running total and correlated above-average-fare query.
- [`locking_note.md`](locking_note.md) - observed locking behaviour with tied fares explained.
- [`schema.sql`](schema.sql) / [`seed_data.sql`](seed_data.sql) - self-contained InnoDB setup.
- [`notes/Notes.md`](notes/Notes.md) - implementation rationale.

## Run

```sql
SOURCE Day8/Set2_AirlineBooking/schema.sql;
SOURCE Day8/Set2_AirlineBooking/seed_data.sql;
SOURCE Day8/Set2_AirlineBooking/booking_transaction.sql;
SOURCE Day8/Set2_AirlineBooking/ranking_report.sql;
```
