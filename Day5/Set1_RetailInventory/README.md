# Day 5 Set 1 - Retail Inventory

## Scenario
Normalize a de-normalised retail stock spreadsheet into 3NF and implement the schema in MySQL 8.4.

## Deliverables
- `schema.sql` - database and InnoDB tables with PK/FK/UNIQUE/CHECK/DEFAULT and referential actions
- `seed_data.sql` - sample data (>=10 rows per table)
- `failing_inserts.sql` - duplicate key, missing parent, negative quantity, NULL in mandatory column
- `notes/Normalisation.md` - anomalies and 1NF/2NF/3NF steps
- `notes/ER_Diagram.md` - ER diagram (Mermaid)
- `notes/Complexity_or_Notes.md` - constraints/operations notes
- `output/console_output.txt` - failing insert evidence, before/after UPDATE/DELETE, `information_schema` listing
