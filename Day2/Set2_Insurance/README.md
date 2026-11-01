# Day 2 - Set 2: Insurance Claims Processing

**Scenario:** An insurer must route claims through approval stages, detect duplicate claim submissions and monitor claim spikes after a regional event.

## Tasks

| File | Task | Key idea |
| --- | --- | --- |
| `src/Task1_BST.java` | Claim ID tree | BST insert/search plus inorder, preorder and postorder traversals |
| `src/Task2_Hashing.java` | Duplicate/near-duplicate claims | Normalised policy key in a `HashMap` (case, spacing and separators ignored) |
| `src/Task3_Graph.java` | Approval stages | Directed graph; BFS shortest path and DFS loop detection |
| `src/Task4_SlidingWindow.java` | Longest run of high-claim days | Sliding window over daily claim counts |
| `src/Task5_TwoPointers.java` | Merge regional claim lists | Two-pointer merge of two sorted arrays |

## Run

From this folder (PowerShell):

```powershell
Remove-Item -Recurse -Force out -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path out | Out-Null
javac -d out (Get-ChildItem src\*.java | ForEach-Object { $_.FullName })
java -cp out Task1_BST
java -cp out Task2_Hashing
java -cp out Task3_Graph
java -cp out Task4_SlidingWindow
java -cp out Task5_TwoPointers
```

## Test cases covered

- Empty input: `Task2_Hashing` reports zero duplicate groups.
- Duplicate and near-duplicate policies with different case, spacing and separators.
- Cyclic and acyclic approval graphs.
- Two sorted claim lists of different lengths.

## Results

- Full console output: [`output/console_output.txt`](output/console_output.txt)
- Complexity table and rationale: [`notes/Complexity_Note.md`](notes/Complexity_Note.md)
