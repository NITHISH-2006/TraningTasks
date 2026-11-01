# Day 2 - Problem Solving Techniques and Data Structures - II

Topics: trees, hashing and HashMaps, graphs, two-pointer and sliding-window patterns, and Hands-on Lab II.

## Sets

| Set | Business scenario | Folder |
| --- | --- | --- |
| 1 | E-Commerce Catalogue and Traffic Analysis | [`Set1_Ecommerce`](Set1_Ecommerce/README.md) |
| 2 | Insurance Claims Processing | [`Set2_Insurance`](Set2_Insurance/README.md) |
| 3 | Logistics Network and Delivery Windows | [`Set3_Logistics`](Set3_Logistics/README.md) |

Each set contains `src/`, `output/`, `notes/` and a `README.md`, following the same layout as Day 1.

## Quick run (any set)

```powershell
$set = "Set1_Ecommerce"
Push-Location $set
New-Item -ItemType Directory -Force -Path out | Out-Null
javac -d out (Get-ChildItem src\*.java | ForEach-Object { $_.FullName })
Get-ChildItem out\Task*.class | ForEach-Object { java -cp out $_.BaseName }
Pop-Location
```

## Task coverage

| Task theme | Set 1 | Set 2 | Set 3 |
| --- | --- | --- | --- |
| 1. BST | Product categories | Claim IDs | Hub codes + height |
| 2. Hashing | Chained SKU table + `HashMap` | Normalised duplicate claims | Parcel scan look-up |
| 3. Graph | Microservice deployment + cycle | Approval stages + loop | Hub network BFS/DFS |
| 4. Sliding window | Busiest 3-hour window | Longest >100 claims run | Highest-average 4-hour window |
| 5. Two pointers | Gift-card pairs | Merge two sorted lists | Route palindrome |

## Requirements

- JDK 17 or newer (verified with JDK 25).
- No external libraries; everything uses the Java standard library.
