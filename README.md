# TraningTasks

Hands-on problem-solving and data-structures lab work for the **Mavericks Segue 2026 - Java Foundation** track.

The repository is organised by day and by business set. Every task has its own runnable Java file,
captured console output and a short complexity/rationale note.

## Structure

```text
TraningTasks/
├── README.md
├── .gitignore
│
├── Day1/
│   ├── README.md
│   ├── notes/
│   │   └── reference_solution.md
│   │
│   ├── Set1_RetailOrderDesk/
│   │   ├── src/
│   │   │   ├── Task1_Search.java
│   │   │   ├── Task2_Sorting.java
│   │   │   ├── Task3_Duplicates.java
│   │   │   ├── Task4_StackQueue.java
│   │   │   └── Task5_Refund.java
│   │   ├── output/
│   │   │   └── console_output.txt
│   │   ├── notes/
│   │   │   └── Complexity_Note.md
│   │   └── README.md
│   │
│   ├── Set2_BankingTransactions/
│   │   ├── src/ (Task1_Search ... Task5_MinMax)
│   │   ├── output/console_output.txt
│   │   ├── notes/Complexity_Note.md
│   │   └── README.md
│   │
│   └── Set3_HospitalAppointments/
│       ├── src/ (Task1_Search ... Task5_DP_Appointments)
│       ├── output/console_output.txt
│       ├── notes/Complexity_Note.md
│       └── README.md
│
└── Day2/
    ├── README.md
    │
    ├── Set1_Ecommerce/
    │   ├── src/ (Task1_BST, Task2_HashTable, Task3_Graph, Task4_SlidingWindow, Task5_TwoPointers)
    │   ├── output/console_output.txt
    │   ├── notes/Complexity_Note.md
    │   └── README.md
    │
    ├── Set2_Insurance/
    │   ├── src/ (Task1_BST, Task2_Hashing, Task3_Graph, Task4_SlidingWindow, Task5_TwoPointers)
    │   ├── output/console_output.txt
    │   ├── notes/Complexity_Note.md
    │   └── README.md
    │
    └── Set3_Logistics/
        ├── src/ (Task1_BST, Task2_HashMap, Task3_Graph, Task4_SlidingWindow, Task5_TwoPointers)
        ├── output/console_output.txt
        ├── notes/Complexity_Note.md
        └── README.md
```

## Topics covered

**Day 1**

- Linear vs binary search and benchmarking
- Bubble, insertion, selection, merge and quick sort (including stability)
- Duplicate detection with hash-based structures
- Custom linked-node stack and queue vs `ArrayDeque`
- Greedy vs dynamic programming (coin change), divide-and-conquer min/max, weighted-interval scheduling

**Day 2**

- Binary search trees and inorder/preorder/postorder traversals
- Hash tables with separate chaining vs `HashMap`
- Graph modelling with adjacency lists, BFS, DFS, topological order and cycle detection
- Sliding-window aggregation
- Two-pointer pair search, merging and palindrome checks

## Prerequisites

- JDK 17 or newer (verified with JDK 25).
- PowerShell 5.1 or newer for the example commands.

## Run one set

```powershell
$set = "Day1\Set1_RetailOrderDesk"
New-Item -ItemType Directory -Force -Path "$set\out" | Out-Null
javac -d "$set\out" (Get-ChildItem "$set\src\*.java" | ForEach-Object { $_.FullName })
java -cp "$set\out" Task1_Search
```

## Run every task

From the repository root:

```powershell
$sets = @(
    @{ Path = "Day1\Set1_RetailOrderDesk"; Classes = @("Task1_Search","Task2_Sorting","Task3_Duplicates","Task4_StackQueue","Task5_Refund") },
    @{ Path = "Day1\Set2_BankingTransactions"; Classes = @("Task1_Search","Task2_Sorting","Task3_Duplicates","Task4_StackQueue","Task5_MinMax") },
    @{ Path = "Day1\Set3_HospitalAppointments"; Classes = @("Task1_Search","Task2_Sorting","Task3_Duplicates","Task4_StackQueue","Task5_DP_Appointments") },
    @{ Path = "Day2\Set1_Ecommerce"; Classes = @("Task1_BST","Task2_HashTable","Task3_Graph","Task4_SlidingWindow","Task5_TwoPointers") },
    @{ Path = "Day2\Set2_Insurance"; Classes = @("Task1_BST","Task2_Hashing","Task3_Graph","Task4_SlidingWindow","Task5_TwoPointers") },
    @{ Path = "Day2\Set3_Logistics"; Classes = @("Task1_BST","Task2_HashMap","Task3_Graph","Task4_SlidingWindow","Task5_TwoPointers") }
)

foreach ($set in $sets) {
    $out = Join-Path $set.Path "out"
    Remove-Item -Recurse -Force $out -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Force -Path $out | Out-Null
    $files = Get-ChildItem (Join-Path $set.Path "src\*.java") | ForEach-Object { $_.FullName }
    javac -d $out $files
    if (-not $?) { throw "Compilation failed for $($set.Path)" }
    foreach ($class in $set.Classes) {
        Write-Host "===== $($set.Path) :: $class ====="
        java -cp $out $class
    }
}
```

`out/` and `*.class` are ignored by Git.

## Notes and outputs

- Each set's `output/console_output.txt` contains the real captured console output.
- Each set's `notes/Complexity_Note.md` contains the complexity table and rationale for every task.
- Day 1 also preserves the original written solution at `Day1/notes/reference_solution.md`.

## Notes on results

- Test data is generated with fixed seeds, so values and checksums are reproducible.
- Benchmark timings are machine-dependent and should be compared within a single run, not across machines.
