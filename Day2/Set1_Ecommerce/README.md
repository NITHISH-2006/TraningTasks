# Day 2 - Set 1: E-Commerce Catalogue and Traffic Analysis

**Scenario:** An e-commerce platform wants faster category browsing, instant SKU look-ups and a way to size infrastructure for peak traffic.

## Tasks

| File | Task | Key idea |
| --- | --- | --- |
| `src/Task1_BST.java` | Product category tree | BST insert/search plus inorder, preorder and postorder traversals for 15 categories |
| `src/Task2_HashTable.java` | SKU look-up | Custom separate-chaining hash table with a forced collision, then `HashMap` on 100,000 SKUs |
| `src/Task3_Graph.java` | Microservice dependencies | Adjacency-list graph, BFS/Kahn and DFS deployment order, cycle detection |
| `src/Task4_SlidingWindow.java` | Busiest 3-hour traffic window | Sliding-window sum over 24 hourly values |
| `src/Task5_TwoPointers.java` | Gift-card pair sums | Two pointers over a sorted list of order values |

## Run

From this folder (PowerShell):

```powershell
Remove-Item -Recurse -Force out -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path out | Out-Null
javac -d out (Get-ChildItem src\*.java | ForEach-Object { $_.FullName })
java -cp out Task1_BST
java -cp out Task2_HashTable
java -cp out Task3_Graph
java -cp out Task4_SlidingWindow
java -cp out Task5_TwoPointers
```

## Results

- Full console output: [`output/console_output.txt`](output/console_output.txt)
- Complexity, decisions and rationale: [`notes/Complexity_Note.md`](notes/Complexity_Note.md)
