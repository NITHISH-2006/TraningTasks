# Complexity & Rationale - Set 3 (Hospital Appointments)

## Task 1 - Patient Search

| Algorithm | Best | Average | Worst | Space |
| --- | --- | --- | --- | --- |
| Linear search | O(1) | O(n) | O(n) | O(1) |
| Binary search | O(1) | O(log n) | O(log n) | O(1) |

- 20,000 records keyed by patient ID; binary search needs the records sorted by ID, which the generator guarantees.
- 1,000 look-ups show the binary version is roughly an order of magnitude faster in wall-clock time.
- The speed-up grows with n because linear work grows linearly and binary work grows logarithmically.

## Task 2 - Priority Sorting

| Algorithm | Best | Average | Worst | Space | Swaps observed |
| --- | --- | --- | --- | --- | --- |
| Selection sort | O(n^2) | O(n^2) | O(n^2) | O(1) | at most n - 1 |
| Quick sort (middle pivot) | O(n log n) | O(n log n) | O(n^2) | O(log n) stack | can exceed n - 1 |

- Comparator: urgency ascending (1 = most urgent), then arrival time ascending.
- Selection sort always performs ~n^2/2 comparisons but only one swap per pass (up to n - 1 swaps).
- Quick sort usually does far fewer comparisons and runs much faster, but each partition can swap many pairs.
- A middle pivot reduces the chance of the sorted-input worst case, but a deterministic pivot can still degrade to O(n^2).

## Task 3 - Double-Booking Validation

| Operation | Time | Space |
| --- | --- | --- |
| Validate one booking | O(1) expected | O(1) |
| Validate all bookings | O(n) expected | O(number of slots) |

- Key = `patientId | slotTime`.
- A `HashSet` rejects a repeated key immediately.
- Scanning a list for conflicts would be O(n) per booking and O(n^2) overall, which is not acceptable at hospital volume.

## Task 4 - Custom Queue & Stack

| Operation | Custom | `ArrayDeque` |
| --- | --- | --- |
| Enqueue / push | O(1) | O(1) amortised |
| Dequeue / pop | O(1) | O(1) amortised |
| Space | O(n) | O(n) |

- Queue models the walk-in token line (FIFO).
- Stack models "recent patients viewed" (LIFO).
- Both are implemented from scratch with linked nodes before comparing against the library version.

## Task 5 - Maximum Appointments (DP)

| Algorithm | Time | Space | Optimal? |
| --- | --- | --- | --- |
| Greedy earliest start | O(n log n) | O(1) | No |
| Dynamic programming (weighted interval scheduling) | O(n log n) | O(n) | Yes |

- Slots are sorted by end time. For each slot, binary search finds the latest non-conflicting slot.
- `dp[i] = max(dp[i - 1], 1 + dp[latest non-conflicting])`.
- Greedy earliest start can pick a long appointment that blocks many shorter ones.
- In the sample, greedy schedules 3 appointments while DP schedules 9.

**Selection/quick sort trace summary:** the benchmark prints the number of swaps for each algorithm; quick sort's higher swap count does not imply slower execution because selection sort pays for far more comparisons.
