# Day 5 - Databases, Normalisation and Data Definition (MySQL 8.4 LTS)

Structure per assignment spec. Each set contains `schema.sql`, `seed_data.sql`, notes, and output/evidence.

- **Set1_RetailInventory**: 3NF retail inventory, constraints/failing inserts, supplier correction & discontinued SKU removal, `information_schema` exploration.
- **Set2_BankBranch**: 3NF/BCNF bank accounts, data type justification, DROP/TRUNCATE/DELETE comparison, queries and ALTER TABLE exercises.
- **Set3_HospitalRecords**: 3NF decomposition (Patient/Doctor/Department/Visit/Billing), DB/table DDL lifecycle, sample queries, SQL vs NoSQL comparison.

Run with MySQL 8.4:
```sql
SOURCE Day5_Databases/Set1_RetailInventory/schema.sql;
SOURCE Day5_Databases/Set1_RetailInventory/seed_data.sql;
```
