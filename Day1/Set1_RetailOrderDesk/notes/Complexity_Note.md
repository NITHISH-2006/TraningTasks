# Complexity & Rationale - Set 1 (Retail Order Desk)

## Task 1 - Search

| Algorithm | Best | Average | Worst | Space |
| --- | --- | --- | --- | --- |
| Linear search | O(1) | O(n) | O(n) | O(1) |
| Binary search | O(1) | O(log n) | O(log n) | O(1) |

- Linear search scans up to all 50,000 records per look-up.
- Binary search discards half the remaining range each step, so 1,000 look-ups complete far faster.
- **Precondition:** binary search requires the array to be sorted by `orderId`. The data is generated in sorted order and the same array is used for both algorithms.

## Task 2 - Sorting by Amount (Descending)

| Algorithm | Best | Average | Worst | Space | Stable |
| --- | --- | --- | --- | --- | --- |
| Bubble sort | O(n) | O(n^2) | O(n^2) | O(1) | Yes |
| Merge sort | O(n log n) | O(n log n) | O(n log n) | O(n) | Yes |
| Built-in TimSort | O(n) | O(n log n) | O(n log n) | O(n) | Yes |

- Bubble sort is fine for teaching the mechanics but performs poorly at 10,000 records.
- Merge sort scales predictably and the benchmark confirms the expected gap.
- The built-in sort is usually the fastest practical choice because it is highly optimised and adaptive.

**Bubble-sort trace (first three passes):**

```text
Start : [1200.0, 450.0, 980.0, 300.0, 760.0, 150.0]
Pass 1: [1200.0, 980.0, 450.0, 760.0, 300.0, 150.0]
Pass 2: [1200.0, 980.0, 760.0, 450.0, 300.0, 150.0]
Pass 3: [1200.0, 980.0, 760.0, 450.0, 300.0, 150.0]
```

## Task 3 - Duplicate Orders

| Operation | Time | Space |
| --- | --- | --- |
| Scan all orders with `HashSet` | O(n) expected | O(n) |

- Key = `customerId + amount + createdAt` truncated to the minute.
- A `HashSet` gives O(1) average membership checks; a nested-loop comparison would be O(n^2).
- Space is O(n) for the set of unique keys.

## Task 4 - Custom Stack & Queue

| Operation | Custom linked-node structure | `ArrayDeque` |
| --- | --- | --- |
| Push / enqueue | O(1) | O(1) amortised |
| Pop / dequeue | O(1) | O(1) amortised |
| Space | O(n) | O(n) |

- The stack uses LIFO order to undo the most recent edit first.
- The queue uses FIFO order to dispatch the oldest order first.
- Both custom structures are pointer-based, so no element shifting is needed.
- `ArrayDeque` is the recommended library replacement; it is also O(1) amortised and avoids manual node management.

## Task 5 - Refund (Greedy vs DP)

| Algorithm | Time | Space | Optimal? |
| --- | --- | --- | --- |
| Greedy | O(number of denominations) | O(1) | No, not for arbitrary denominations |
| Dynamic programming | O(amount x denominations) | O(amount) | Yes |

- Greedy repeatedly takes the largest coin that fits.
- With Indian notes (`2000, 500, 200, 100, 50, 20, 10, 5, 2, 1`) greedy happens to be optimal.
- Greedy fails for the denomination set `{4, 3, 1}` and amount `6`: it returns `4 + 1 + 1` (3 coins), while DP finds `3 + 3` (2 coins).
- DP guarantees the global minimum by solving every smaller amount first.
