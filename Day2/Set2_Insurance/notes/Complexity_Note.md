# Complexity & Rationale - Day 2 Set 2 (Insurance)

## Task 1 - BST of Claim IDs

| Operation | Average | Worst (skewed) | Space |
| --- | --- | --- | --- |
| Insert | O(log n) | O(n) | O(n) |
| Search | O(log n) | O(n) | O(1) |
| Traversals | O(n) | O(n) | O(n) recursion |

- Inorder visits left subtree, node, right subtree and therefore produces claim IDs in ascending sorted order.
- Preorder and postorder are included to show the different visitation orders.
- Sorted insertion order would degrade the tree to a linked list.

## Task 2 - Duplicate / Near-Duplicate Claims

| Operation | Time | Space |
| --- | --- | --- |
| Normalise key | O(length of policy string) | O(length) |
| Group all claims | O(n) expected | O(n) |

- Normalisation: uppercase, then remove every character that is not a letter or digit.
- `POL-1001`, `pol-1001` and `POL 1001` all map to `POL1001`.
- Key = normalised policy number + incident date.
- `HashMap` collisions are resolved by chaining; `equals()` identifies the matching entry.
- Empty input returns an empty map without special-casing in the caller.

## Task 3 - Approval Stage Graph

| Algorithm | Time | Space |
| --- | --- | --- |
| BFS shortest path | O(V + E) | O(V) |
| DFS loop detection | O(V + E) | O(V) |

- BFS explores stages level by level, so the first time it reaches settlement it has used the fewest edges.
- The graph includes a direct `assessment -> settlement` shortcut, producing a 2-edge path instead of the 3-edge path through `surveyor`.
- DFS uses three colours: unvisited, in-progress and finished. Reaching an in-progress node means a loop.

## Task 4 - Longest Run of Days Above 100 Claims

| Approach | Time | Space |
| --- | --- | --- |
| Sliding window / streak | O(n) | O(1) |
| Checking every start day | O(n^2) | O(1) |

- When a day is at or below the threshold, the window restarts at the next day.
- Otherwise the current run length is `right - left + 1`.

## Task 5 - Merge Two Sorted Claim Lists

| Approach | Time | Space |
| --- | --- | --- |
| Two pointers | O(n + m) | O(n + m) output |
| Concatenate then sort | O((n + m) log(n + m)) | O(n + m) |

- Compare the current element of each list, copy the smaller one, and advance that pointer.
- When one list is exhausted, copy the remainder of the other list.
