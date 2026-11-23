# Day 10 - Triggers (MySQL 8.4 LTS)

Topics: `BEFORE`/`AFTER` triggers, `OLD`/`NEW` references, `SIGNAL SQLSTATE '45000'`, row-level execution, multi-row statement behaviour, trigger discovery through `information_schema`, pitfalls and alternatives.

Each set includes a self-contained `schema.sql` and `seed_data.sql`.

| Set | Folder | Focus | Key Deliverables |
|---|---|---|---|
| 1 | `Set1_RetailPriceAudit/` | Price-change audit and below-cost guard | `triggers.sql`, `test_evidence.sql`, `pitfalls_note.md` |
| 2 | `Set2_BankBalanceGuard/` | Transaction audit, savings overdraft guard, derived date | `triggers.sql`, `test_evidence.sql`, `limitations_note.md` |
| 3 | `Set3_HospitalBedCapacity/` | Ward capacity guard, admission audit, JDBC testing | `triggers.sql`, `test_evidence.sql`, `justification_note.md` |

Run, from the repository root (MySQL 8.4):

```sql
SOURCE Day10/Set1_RetailPriceAudit/schema.sql;
SOURCE Day10/Set1_RetailPriceAudit/seed_data.sql;
SOURCE Day10/Set1_RetailPriceAudit/triggers.sql;
SOURCE Day10/Set1_RetailPriceAudit/test_evidence.sql;
```
