# TraningTasks

Hands-on training assignments for the **Mavericks Segue 2026 - Java Foundation** track.

Repository organised by day and by business set. Java tasks include runnable source, console output and complexity notes; database tasks include MySQL 8.4 scripts, normalisation/ER notes and query evidence.

## Structure

```text
TraningTasks/
├── README.md
├── .gitignore
├── Day1/   # DSA basics: search, sort, duplicates, stack/queue, greedy/DP
├── Day2/   # DSA: BST, hashing, graphs, sliding window, two pointers
├── Day3/   # Agile & Scrum: roles, backlog, sprint plan, DoR/DoD
├── Day4/   # Additional Java/practice tasks
├── Day5/   # Databases & normalisation (MySQL 8.4)
│   ├── README.md
│   ├── Set1_RetailInventory/   (schema.sql, seed_data.sql, failing_inserts.sql, notes/, output/)
│   ├── Set2_BankBranch/        (schema.sql, seed_data.sql, notes/, output/)
│   └── Set3_HospitalRecords/   (schema.sql, seed_data.sql, notes/, output/)
├── Day6/   # Functions, aggregation, GROUP BY/HAVING, joins (MySQL 8.4)
│   ├── README.md
│   ├── Set1_RetailSales/       (reports.sql, expected_output.md, notes/)
│   ├── Set2_Insurance/         (reports.sql, expected_output.md, notes/)
│   └── Set3_Telecom/           (reports.sql, expected_output.md, notes/)
└── Day7/   # Joins & subqueries (MySQL 8.4)
    ├── README.md
    ├── Set1_Logistics/         (advanced_reports.sql, join_choice_table.md, notes/)
    ├── Set2_BankLoan/          (advanced_reports.sql, justification.md, notes/)
    └── Set3_RetailReturns/     (advanced_reports.sql, explanation.md, notes/)
```

## Day-wise overview

| Day | Topic | Sets / Contents | Key Deliverables |
|---|---|---|---|
| Day 1 | DSA fundamentals | RetailOrderDesk, BankingTransactions, HospitalAppointments | `src/*.java`, `output/console_output.txt`, `notes/Complexity_Note.md` |
| Day 2 | Data structures & algorithms | Ecommerce, Insurance, Logistics | BST, hash table/map, graph, sliding window, two pointers (`src/`, `output/`, `notes/`) |
| Day 3 | Agile & Scrum | E-commerce (5 roles), Insurance, Bug tracking & release | Role responsibilities, backlog, sprint plan, DoR/DoD, challenge responses (`docs/`) |
| Day 4 | Practice tasks | Java exercises | `src/`, `output/`, `notes/` |
| Day 5 | Databases, normalisation & DDL/DML | RetailInventory, BankBranch, HospitalRecords | `schema.sql`, `seed_data.sql`, failing-insert evidence, normalisation & ER notes, console evidence |
| Day 6 | Functions, aggregation & joins | RetailSales, Insurance, Telecom | `reports.sql`, `expected_output.md`, function/NULL/WHERE vs HAVING demos, notes |
| Day 7 | Joins & subqueries | Logistics, BankLoan, RetailReturns | `advanced_reports.sql`, join/subquery justifications, NOT IN vs NOT EXISTS, scaling notes |

## Day details

### Day 1 - DSA Fundamentals
- Linear vs binary search, benchmarking
- Bubble/insertion/selection/merge/quick sort (stability)
- Duplicate detection with hash-based structures
- Custom linked-node stack & queue vs `ArrayDeque`
- Greedy vs DP, divide-and-conquer min/max, weighted-interval scheduling

### Day 2 - Data Structures & Algorithms
- Binary search trees and traversals
- Hash tables with separate chaining vs `HashMap`
- Adjacency-list graphs, BFS/DFS, topological order, cycle detection
- Sliding-window aggregation; two-pointer techniques

### Day 3 - Agile & Scrum
- Agile vs Waterfall (and why Waterfall fails for changing requirements)
- Scrum roles, backlog, user stories & acceptance criteria, sprint planning
- Definition of Ready / Definition of Done and mid-sprint change handling

### Day 5 - Databases, Normalisation and Data Definition (MySQL 8.4)
- 3NF/BCNF design, ER modelling, anomalies and keys
- InnoDB schemas with PK/FK/UNIQUE/CHECK/DEFAULT and referential actions
- DML with failing-constraint evidence, UPDATE/DELETE before/after, `information_schema` exploration
- DROP vs TRUNCATE vs DELETE, ALTER TABLE effects, SQL vs NoSQL comparison

### Day 6 - Functions, Aggregation, Grouping and Joins (MySQL 8.4)
- String/date/math functions for reporting output
- Aggregates with `GROUP BY`/`HAVING`, NULL behaviour (COUNT/SUM/AVG, IFNULL/COALESCE)
- `WHERE` vs `HAVING`, INNER/LEFT/CROSS join usage

### Day 7 - Joins and Subqueries (MySQL 8.4)
- INNER/LEFT/RIGHT/SELF joins for business questions
- Subqueries: IN, EXISTS, ANY, ALL, correlated/uncorrelated and nested
- Rewriting subqueries as joins, NOT IN NULL pitfall vs NOT EXISTS
- Performance/scaling considerations at higher data volumes

## Prerequisites

- **Java (Day 1, 2, 4):** JDK 17+
- **Database (Day 5, 6, 7):** MySQL 8.4+

## Run Java tasks

```powershell
$set = "Day1\Set1_RetailOrderDesk"
New-Item -ItemType Directory -Force -Path "$set\out" | Out-Null
javac -d "$set\out" (Get-ChildItem "$set\src\*.java" | ForEach-Object { $_.FullName })
java -cp "$set\out" Task1_Search
```

## Run SQL scripts (MySQL 8.4)

```sql
SOURCE Day5/Set1_RetailInventory/schema.sql;
SOURCE Day5/Set1_RetailInventory/seed_data.sql;
-- Day 6/7: run reports after creating/loading the assumed sample tables
SOURCE Day6/Set1_RetailSales/reports.sql;
```
