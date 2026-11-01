# Complexity, Decisions & Rationale - Day 2 Set 1 (E-Commerce)

## Decision table

| Problem | Data structure / pattern | Reason |
| --- | --- | --- |
| Category browsing and ordered listing | Binary search tree | O(log n) search on a balanced tree and inorder traversal yields sorted categories |
| Instant SKU look-up | Hash table with chaining | O(1) average insert/search; chaining resolves collisions |
| Deployment dependency order | Graph + BFS/DFS | Topological order captures dependencies; DFS colours detect cycles |
| Busiest 3-hour window | Sliding window | O(n) instead of recomputing every window in O(nk) |
| Gift-card pair sums | Two pointers | O(n) after sorting instead of O(n^2) pair enumeration |

## Task 1 - BST of Product Categories

| Operation | Average | Worst (skewed tree) | Space |
| --- | --- | --- | --- |
| Insert | O(log n) | O(n) | O(n) |
| Search | O(log n) | O(n) | O(1) |
| Traversals | O(n) | O(n) | O(n) recursion |

- Inorder = left, node, right -> alphabetical order.
- Preorder = node, left, right -> useful for copying/serialising the tree.
- Postorder = left, right, node -> useful for deleting bottom-up.
- Insertion order affects the height; sorted input would produce a linked-list-shaped tree.

## Task 2 - Hash Table with Chaining

| Operation | Average | Worst | Space |
| --- | --- | --- | --- |
| Insert | O(1) | O(n) | O(n) |
| Search | O(1) | O(n) | O(n) |

- Hash function: `floorMod(key.hashCode(), capacity)`.
- Separate chaining stores colliding entries in a linked list per bucket.
- The small demo uses capacity 5 and 8 keys to force visible collisions.
- The 100,000-SKU benchmark uses a larger table; `HashMap` is faster in practice due to treeified bins and JIT-friendly internals.

## Task 3 - Microservice Dependency Graph

| Algorithm | Time | Space |
| --- | --- | --- |
| DFS post-order deployment order | O(V + E) | O(V) |
| BFS / Kahn topological order | O(V + E) | O(V + E) |
| DFS cycle detection | O(V + E) | O(V) |

- Edge `service -> dependency` means the dependency must be deployed first.
- DFS post-order emits dependencies before dependents.
- Kahn's algorithm repeatedly starts services whose dependency count is zero.
- A cycle makes a complete deployment order impossible; DFS colouring (white/grey/black) detects it.

## Task 4 - Busiest 3-Hour Window

| Approach | Time | Space |
| --- | --- | --- |
| Sliding window | O(n) | O(1) |
| Recomputing each window | O(nk) | O(1) |

- Add the incoming hour, subtract the outgoing hour, and track the maximum sum.

## Task 5 - Two-Pointer Pair Sums

| Approach | Time | Space |
| --- | --- | --- |
| Two pointers on sorted data | O(n) | O(1) |
| Nested loops | O(n^2) | O(1) |

- Move `left` forward when the sum is too small and `right` backward when it is too large.
- Skipping duplicate values avoids printing the same pair repeatedly.
