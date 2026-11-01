# Complexity & Rationale - Day 2 Set 3 (Logistics)

## Task 1 - Hub-Code BST

| Operation | Mixed insertion | Sorted insertion |
| --- | --- | --- |
| Search | O(log n) average | O(n) worst case |
| Insert | O(log n) average | O(n) worst case |
| Height | 4 edges / 5 levels | 9 edges / 10 levels |
| Space | O(n) | O(n) |

- Inorder traversal lists hub codes alphabetically.
- With sorted input every new key is larger than the previous one, so every node is inserted to the right.
- The resulting tree is a linked list; this is why self-balancing trees (AVL/red-black) exist.

## Task 2 - Parcel Tracking HashMap

| Operation | Time | Space |
| --- | --- | --- |
| Record a scan | O(1) expected | O(scans) |
| Detect same-hub repeat | O(1) expected | O(hubs per parcel) |

- `Map<trackingNumber, Set<hubCode>>` stores the unique hubs already seen for each parcel.
- If `Set.add(hub)` returns `false`, the parcel was already scanned at that hub.
- A list scan per scan event would be O(n^2) overall.

## Task 3 - Hub Network Graph

| Algorithm | Time | Space |
| --- | --- | --- |
| BFS fewest hops | O(V + E) | O(V) |
| DFS reachability | O(V + E) | O(V) |

- The graph is undirected, so each route is added in both adjacency lists.
- BFS guarantees the minimum number of hops (unweighted graph).
- DFS from the central depot visits every hub reachable through the route network.
- For 10 hubs the difference is small, but the same code scales to thousands of hubs.

## Task 4 - Highest-Average 4-Hour Window

| Approach | Time | Space |
| --- | --- | --- |
| Sliding window | O(n) | O(1) |
| Recomputing each window | O(nk) | O(1) |

- The window sum is updated in constant time: add the new hour, subtract the old hour.
- The best average is `bestSum / 4`.

## Task 5 - Palindrome Route Check

| Approach | Time | Space |
| --- | --- | --- |
| Tokenise + two pointers | O(n) | O(n) for tokens |
| Reverse and compare | O(n) | O(n) |

- Split on any non-alphanumeric separator, uppercase the tokens, then compare from both ends.
- For example, `DEL-BOM-BLR-BOM-DEL` becomes `[DEL, BOM, BLR, BOM, DEL]`, which is a palindrome of hub codes.
- Comparing raw characters would fail because each hub code has multiple letters; the task is a token-level palindrome.
