# Day 2 - Set 3: Logistics Network and Delivery Windows

**Scenario:** A courier company is optimising hub-to-hub routing and delivery-window planning across a national network.

## Tasks

| File | Task | Key idea |
| --- | --- | --- |
| `src/Task1_BST.java` | Hub-code tree | BST insert/search, height for a given insertion order, sorted-input degeneracy |
| `src/Task2_HashMap.java` | Parcel tracking look-up | `HashMap` of tracking number to scanned hubs; reports repeat scans at the same hub |
| `src/Task3_Graph.java` | Hub network | Adjacency list of 10 hubs; BFS fewest hops and DFS reachability from the central depot |
| `src/Task4_SlidingWindow.java` | Highest-average 4-hour window | Sliding-window sum over hourly parcel counts |
| `src/Task5_TwoPointers.java` | Route palindrome | Two pointers over hub-code tokens, ignoring case and separators |

## Network used

```text
HUB-DEL --- HUB-BOM --- HUB-PNQ
   |           |
HUB-JAI      HUB-BLR --- HUB-MAA --- HUB-KOC
   |           |
HUB-AMD      HUB-HYD --- HUB-CCU
```

## Run

From this folder (PowerShell):

```powershell
Remove-Item -Recurse -Force out -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path out | Out-Null
javac -d out (Get-ChildItem src\*.java | ForEach-Object { $_.FullName })
java -cp out Task1_BST
java -cp out Task2_HashMap
java -cp out Task3_Graph
java -cp out Task4_SlidingWindow
java -cp out Task5_TwoPointers
```

## Results

- Full console output: [`output/console_output.txt`](output/console_output.txt)
- Complexity and rationale: [`notes/Complexity_Note.md`](notes/Complexity_Note.md)
