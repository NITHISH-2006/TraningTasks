# Day 1 - Set 2: Retail Banking Transaction Review

**Scenario:** A retail bank's operations team reviews the day's card transactions. Auditors need quick look-ups by transaction ID, ordered statements for customers, and an early warning when the same transaction is posted twice.

## Tasks

| File | Task | Key idea |
| --- | --- | --- |
| `src/Task1_Search.java` | Search 100,000 sorted transaction IDs | Count best/average/worst comparisons for binary vs linear search |
| `src/Task2_Sorting.java` | Sort statements by posting date | Stable insertion sort and merge sort, including equal timestamps |
| `src/Task3_Duplicates.java` | Detect duplicate postings within 60 seconds | `HashMap` of account + amount + merchant to last timestamp |
| `src/Task4_StackQueue.java` | Manual-review backlog and reverse adjustment | Custom queue/stack from scratch, then `ArrayDeque` |
| `src/Task5_MinMax.java` | Highest and lowest transaction amount | Divide-and-conquer tournament `3n/2 - 2` comparisons vs brute force `2n - 2` |

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
java -cp out Task5_MinMax
```

## Results

- Full console output: [`output/console_output.txt`](output/console_output.txt)
- Complexity and rationale: [`notes/Complexity_Note.md`](notes/Complexity_Note.md)
