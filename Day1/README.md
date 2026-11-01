# Day 1 - Problem Solving Techniques and Data Structures - I

Topics: algorithm basics, data-structure basics, sorting, searching, and Hands-on Lab I.

## Sets

| Set | Business scenario | Folder |
| --- | --- | --- |
| 1 | Retail Order Desk | [`Set1_RetailOrderDesk`](Set1_RetailOrderDesk/README.md) |
| 2 | Retail Banking Transaction Review | [`Set2_BankingTransactions`](Set2_BankingTransactions/README.md) |
| 3 | Hospital Appointment Desk | [`Set3_HospitalAppointments`](Set3_HospitalAppointments/README.md) |

Each set contains:

```text
SetX_Name/
├── src/                 # one Java file per task, each with a main method
├── output/              # captured console output
├── notes/               # complexity and data-structure rationale
└── README.md            # scenario, tasks and run commands
```

The original written solution (pseudocode, console output and notes) is preserved at
[`notes/reference_solution.md`](notes/reference_solution.md).

## Quick run (any set)

```powershell
$set = "Set1_RetailOrderDesk"
Push-Location $set
New-Item -ItemType Directory -Force -Path out | Out-Null
javac -d out (Get-ChildItem src\*.java | ForEach-Object { $_.FullName })
Get-ChildItem out\Task*.class | ForEach-Object { java -cp out $_.BaseName }
Pop-Location
```

## Task coverage

| Task theme | Set 1 | Set 2 | Set 3 |
| --- | --- | --- | --- |
| Search | Orders by ID | Transaction comparison counts | Patient records |
| Sorting | Bubble / merge / TimSort | Insertion / merge (stable) | Selection / quick |
| Duplicates | Order + amount + minute | 60-second double posting | Patient + slot |
| Stack & queue | Undo / dispatch | Review backlog / adjustments | Token line / history |
| Optimisation | Greedy vs DP refund | D&C min/max | Weighted-interval DP |

## Requirements

- JDK 17 or newer (verified with JDK 25).
- Windows PowerShell examples are shown; the Java code itself is platform independent.
