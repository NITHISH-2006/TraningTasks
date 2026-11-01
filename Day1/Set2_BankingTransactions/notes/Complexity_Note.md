# Complexity & Rationale - Set 2 (Banking Transactions)

## Task 1 - Search Comparisons

| Algorithm | Best | Average | Worst | Space |
| --- | --- | --- | --- | --- |
| Binary search | 1 | ~log2(n) | ceil(log2(n)) = 17 for 100,000 | O(1) |
| Linear search | 1 | (n + 1) / 2 = 50,000.5 | 100,000 | O(1) |

- Binary search comparisons are counted for every one of the 100,000 IDs; linear search is sampled because scanning all IDs would take ~5 billion comparisons.
- The worst-case binary bound is `ceil(log2(100000)) = 17`.
- The list must already be sorted before binary search.

## Task 2 - Stable Sorting

| Algorithm | Best | Average | Worst | Space | Stable |
| --- | --- | --- | --- | --- | --- |
| Insertion sort | O(n) | O(n^2) | O(n^2) | O(1) | Yes |
| Merge sort | O(n log n) | O(n log n) | O(n log n) | O(n) | Yes |

- Insertion sort compares with strict `>` so equal timestamps keep their original relative order.
- Merge sort takes from the left partition when timestamps are equal, which also preserves stability.
- Stability matters because a purchase and a refund posted in the same minute must not silently swap order in a customer statement.

## Task 3 - 60-Second Duplicate Window

| Step | Time | Space |
| --- | --- | --- |
| Sort by timestamp | O(n log n) | O(1) or O(n) |
| Scan with `HashMap` | O(n) expected | O(n) |
| Total | O(n log n) | O(n) |

- Key = `accountId | amount | merchant`; value = the most recent timestamp for that key.
- Sorting first means each new transaction can be compared only with the latest matching one.
- A `HashMap` gives O(1) average look-up instead of an O(n) scan per transaction.

## Task 4 - Custom Stack & Queue

| Operation | Custom implementation | `ArrayDeque` |
| --- | --- | --- |
| Enqueue / push | O(1) | O(1) amortised |
| Dequeue / pop | O(1) | O(1) amortised |
| Space | O(n) | O(n) |

- Queue = FIFO manual-review backlog.
- Stack = LIFO "reverse last adjustment".
- Both custom versions use linked nodes and manipulate pointers only.

## Task 5 - Divide-and-Conquer Min/Max

| Algorithm | Comparisons | Time | Space |
| --- | --- | --- | --- |
| Tournament (divide and conquer) | 3n/2 - 2 = 149,998 for n = 100,000 | O(n) | O(n) auxiliary |
| Brute force | 2n - 2 = 199,998 | O(n) | O(1) |

- The tournament pairs elements, then merges the candidate minima and maxima level by level.
- Each merge costs two comparisons (one for min, one for max), reducing the total to `3n/2 - 2`.
- The brute-force scan compares every element against both the current min and max, costing `2n - 2`.
