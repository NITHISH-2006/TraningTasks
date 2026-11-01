# Day 1 - Set 1: Retail Order Desk

**Scenario:** An online retailer processes about 50,000 orders a day. Support agents must locate an order instantly, the warehouse needs orders ranked for dispatch, and finance must flag duplicate submissions before payment is captured.

## Tasks

| File | Task | Key idea |
| --- | --- | --- |
| `src/Task1_Search.java` | Retrieve an order by ID | Linear search `O(n)` vs binary search `O(log n)` on 50,000 records |
| `src/Task2_Sorting.java` | Rank orders by amount (descending) | Bubble sort `O(n^2)` vs merge sort `O(n log n)` vs built-in TimSort |
| `src/Task3_Duplicates.java` | Flag duplicate orders | `HashSet` keyed by customer + amount + minute |
| `src/Task4_StackQueue.java` | Undo edits and dispatch orders | Custom linked-node Stack/Queue, then `ArrayDeque` |
| `src/Task5_Refund.java` | Minimum notes/coins for a refund | Greedy vs dynamic programming |

## Run

From this folder (PowerShell):

```powershell
Remove-Item -Recurse -Force out -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path out | Out-Null
javac -d out (Get-ChildItem src\*.java | ForEach-Object { $_.FullName })
java -cp out Task1_Search
java -cp out Task2_Sorting
java -cp out Task3_Duplicates
java -cp out Task4_StackQueue
java -cp out Task5_Refund
```

Each file has its own `main` method and uses deterministic seeded data, so results are reproducible. Timings depend on the machine.

## Results

- Full console output: [`output/console_output.txt`](output/console_output.txt)
- Complexity and rationale: [`notes/Complexity_Note.md`](notes/Complexity_Note.md)
