# Day 10 Set 3 - Hospital Bed Capacity Control

**Scenario:** An admission cannot be created when its ward is full. All admission changes are audited, including the bed-count side effect.

## Deliverables

- [`triggers.sql`](triggers.sql) - BEFORE INSERT/UPDATE capacity guards and AFTER INSERT/UPDATE/DELETE audit plus bed-count maintenance.
- [`test_evidence.sql`](test_evidence.sql) - multi-row insert where one row exceeds capacity and InnoDB statement rollback evidence.
- [`justification_note.md`](justification_note.md) - when a `CHECK`/procedure is preferable and how to test from JDBC.
- [`schema.sql`](schema.sql) / [`seed_data.sql`](seed_data.sql) - self-contained InnoDB setup.

## Run

```sql
SOURCE Day10/Set3_HospitalBedCapacity/schema.sql;
SOURCE Day10/Set3_HospitalBedCapacity/seed_data.sql;
SOURCE Day10/Set3_HospitalBedCapacity/triggers.sql;
SOURCE Day10/Set3_HospitalBedCapacity/test_evidence.sql;
```
