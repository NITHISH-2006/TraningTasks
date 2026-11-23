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
├── Day7/   # Joins & subqueries (MySQL 8.4)
│   ├── README.md
│   ├── Set1_Logistics/         (advanced_reports.sql, join_choice_table.md, notes/)
│   ├── Set2_BankLoan/          (advanced_reports.sql, justification.md, notes/)
│   └── Set3_RetailReturns/     (advanced_reports.sql, explanation.md, notes/)
├── Day8/   # CTEs, window functions & transactions (MySQL 8.4)
│   ├── README.md
│   ├── Set1_BankTransfer/      (schema.sql, seed_data.sql, transfer.sql, statement_cte.sql, isolation_level_note.md, ...)
│   ├── Set2_AirlineBooking/    (schema.sql, seed_data.sql, booking_transaction.sql, ranking_report.sql, locking_note.md, ...)
│   └── Set3_RetailReservation/ (schema.sql, seed_data.sql, reservation.sql, rank_report.sql, acid_explanation.md, ...)
├── Day9/   # Views, procedures, functions & cursors (MySQL 8.4)
│   ├── README.md
│   ├── Set1_RetailFulfilment/  (views.sql, procedures.sql, cursor.sql, cursor_vs_setbased.md, ...)
│   ├── Set2_InsurancePremium/  (views.sql, procedures.sql, cursor.sql, comparison.md, ...)
│   └── Set3_TelecomFollowup/   (views.sql, procedures.sql, cursor.sql, timing_comparison.md, ...)
├── Day10/  # Triggers (MySQL 8.4)
│   ├── README.md
│   ├── Set1_RetailPriceAudit/  (triggers.sql, test_evidence.sql, pitfalls_note.md, ...)
│   ├── Set2_BankBalanceGuard/  (triggers.sql, test_evidence.sql, limitations_note.md, ...)
│   └── Set3_HospitalBedCapacity/ (triggers.sql, test_evidence.sql, justification_note.md, ...)
└── Day11/  # Java JDK 25 LTS - introduction & control statements
    ├── README.md
    ├── Set1_LoanEligibility/   (src/day11/set1/loan/, output/console_output.txt, notes/Test_Cases.md)
    ├── Set2_UtilityBilling/    (src/day11/set2/billing/, output/console_output.txt, notes/Boundary_Tests.md)
    └── Set3_InsurancePremiums/ (src/day11/set3/insurance/, output/console_output.txt, notes/Memory_Model.md)
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
| Day 8 | CTEs, window functions & transactions | BankTransfer, AirlineBooking, RetailReservation | `transfer.sql`, `booking_transaction.sql`, `reservation.sql`, ranking/ratio reports, ACID & isolation notes |
| Day 9 | Views, procedures, functions & cursors | RetailFulfilment, InsurancePremium, TelecomFollowup | `views.sql`, `procedures.sql`, `cursor.sql`, handler/`SIGNAL` demos, cursor vs set-based notes |
| Day 10 | Triggers | RetailPriceAudit, BankBalanceGuard, HospitalBedCapacity | `triggers.sql`, `test_evidence.sql`, row-level/multi-row evidence, pitfalls & JDBC notes |
| Day 11 | Java JDK 25 LTS basics | LoanEligibility, UtilityBilling, InsurancePremiums | Package structure, records/sealed types, pattern switch, loops, `output/console_output.txt`, notes |


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

### Day 8 - CTEs, Window Functions and Transactions (MySQL 8.4)
- `START TRANSACTION`, `COMMIT`, `ROLLBACK`, savepoints, autocommit and isolation levels
- `SELECT ... FOR UPDATE` locking for bank, seat and stock reservations
- CTEs, correlated subqueries, `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG`, `LEAD`, `SUM() OVER`
- ACID explanation and two-session locking/isolation experiments

### Day 9 - Views, Stored Procedures, Functions and Cursors (MySQL 8.4)
- Security views, updatable views and `WITH CHECK OPTION`
- `IN`/`OUT`/`INOUT` parameters, transactions, `EXIT HANDLER`, `SIGNAL SQLSTATE '45000'`
- Deterministic stored functions and reusable business calculations
- Cursors with `NOT FOUND` handlers versus set-based rewrites with timing/comparison notes

### Day 10 - Triggers (MySQL 8.4)
- `BEFORE`/`AFTER` triggers with `OLD`/`NEW`, audit tables and derived-column maintenance
- `SIGNAL SQLSTATE '45000'` guards and row-level multi-row statement behaviour
- Trigger discovery through `information_schema`, pitfalls, `CHECK`/procedure alternatives and a JDBC test example

### Day 11 - Java JDK 25 LTS
- Packages, records, sealed interfaces and `var`
- `if`/`else`, nested conditions, pattern-matching `switch` expressions with `when` guards
- `for`, enhanced `for`, `do-while`, `continue`, `break` and labelled `break`
- Operator precedence, primitive casting, stack/heap and garbage-collection explanation

## Prerequisites


- **Java (Day 1, 2, 4):** JDK 17+
- **Java (Day 11):** JDK 25 LTS (verified with Temurin 25.0.5)
- **Database (Day 5-10):** MySQL 8.4+


## Run Java tasks

```powershell
$set = "Day1\Set1_RetailOrderDesk"
New-Item -ItemType Directory -Force -Path "$set\out" | Out-Null
javac -d "$set\out" (Get-ChildItem "$set\src\*.java" | ForEach-Object { $_.FullName })
java -cp "$set\out" Task1_Search
```

Day 11 uses packages:

```powershell
$set = "Day11\Set1_LoanEligibility"
New-Item -ItemType Directory -Force -Path "$set\out" | Out-Null
javac -d "$set\out" (Get-ChildItem "$set\src" -Recurse -Filter *.java | ForEach-Object { $_.FullName })
java -cp "$set\out" day11.set1.loan.LoanEligibilityApp
```


## Run SQL scripts (MySQL 8.4)

```sql
SOURCE Day5/Set1_RetailInventory/schema.sql;
SOURCE Day5/Set1_RetailInventory/seed_data.sql;
-- Day 6/7: run reports after creating/loading the assumed sample tables
SOURCE Day6/Set1_RetailSales/reports.sql;
-- Day 8-10: each set includes schema.sql and seed_data.sql; run them first
SOURCE Day8/Set1_BankTransfer/schema.sql;
SOURCE Day8/Set1_BankTransfer/seed_data.sql;
SOURCE Day8/Set1_BankTransfer/transfer.sql;
SOURCE Day9/Set1_RetailFulfilment/views.sql;
SOURCE Day10/Set1_RetailPriceAudit/triggers.sql;
```
