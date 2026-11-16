# Day 5 Set 2 - Bank Branch Accounts

## Scenario
Normalize a de-normalised bank branch sheet to 3NF/BCNF and implement with appropriate MySQL data types and constraints.

## Deliverables
- `schema.sql` - schema with AUTO_INCREMENT keys, UNIQUE account numbers, CHECK constraints (balance/type), DECIMAL for money
- `seed_data.sql` - sample data (>=10 rows per table)
- `notes/Normalisation.md` - anomalies, keys and decomposition
- `notes/ER_Diagram.md` - ER diagram and data type justification
- `output/console_output.txt` - DROP/TRUNCATE/DELETE comparison (incl. AUTO_INCREMENT/rollback), filtered queries, ALTER TABLE effects
