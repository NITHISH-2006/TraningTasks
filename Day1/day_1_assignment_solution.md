# Day 1 – Problem Solving Techniques and Data Structures – I
**Name:** Nithish C  
**Date:** 29-10-2026  
**Track:** Mavericks Segue 2026 (Java Foundation)

---

## Set 1 – Retail Order Desk
**Business Scenario:** Processing 50,000 online orders. Requires instant lookups, sorting by amount, duplicate submission flagging, state management (undo/dispatch), and refund optimization.

### 1. Pseudocode
**Task 1 – Search (Linear vs Binary)**
```text
FUNCTION LinearSearch(orders, targetId):
    FOR i = 0 TO orders.length - 1:
        IF orders[i].id == targetId THEN RETURN i
    RETURN -1

FUNCTION BinarySearch(orders, targetId):
    left = 0, right = orders.length - 1
    WHILE left <= right:
        mid = left + (right - left) / 2  // Prevents integer overflow
        IF orders[mid].id == targetId THEN RETURN mid
        IF orders[mid].id < targetId THEN left = mid + 1
        ELSE right = mid - 1
    RETURN -1
```

**Task 2 – Sort by Amount (Bubble vs Merge Sort)**
```text
FUNCTION BubbleSort(orders):
    FOR i = 0 TO n - 2:
        FOR j = 0 TO n - 2 - i:
            IF orders[j].amount < orders[j+1].amount THEN 
                SWAP(orders[j], orders[j+1])

FUNCTION MergeSort(orders, left, right):
    IF left >= right THEN RETURN
    mid = left + (right - left) / 2
    MergeSort(orders, left, mid)
    MergeSort(orders, mid + 1, right)
    MERGE_DESCENDING(orders, left, mid, right)
```

**Task 3 – Duplicate Order Detection**
```text
FUNCTION FindDuplicates(orders):
    seenHashes = NEW HashSet()
    FOR EACH order IN orders:
        hashKey = order.customerId + "-" + order.amount + "-" + Minute(order.createdAt)
        IF seenHashes.contains(hashKey) THEN PRINT "Duplicate Blocked"
        ELSE seenHashes.add(hashKey)
```

**Task 4 – Custom Stack & Queue Implementation**
```text
// Custom Stack (LIFO for Undo) using Linked Nodes
FUNCTION Push(item):
    newNode = Node(item)
    newNode.next = top
    top = newNode

FUNCTION Pop():
    item = top.data
    top = top.next
    RETURN item

// Custom Queue (FIFO for Dispatch)
FUNCTION Enqueue(item):
    newNode = Node(item)
    IF tail != NULL THEN tail.next = newNode
    tail = newNode
    IF head == NULL THEN head = tail
```

**Task 5 – Refund Calculation (Greedy vs DP)**
```text
FUNCTION GreedyRefund(coins, amount):
    count = 0
    FOR coin IN coins (largest to smallest):
        count += amount / coin
        amount = amount % coin
    RETURN count

FUNCTION DPRefund(coins, amount):
    dp = ARRAY of size (amount + 1) filled with INFINITY
    dp[0] = 0
    FOR currentAmount = 1 TO amount:
        FOR coin IN coins:
            IF coin <= currentAmount:
                dp[currentAmount] = MIN(dp[currentAmount], dp[currentAmount - coin] + 1)
    RETURN dp[amount]
```

### 2. Console Output
```text
--- Task 1: Search (50,000 Records) ---
1,000 Iterations -> Linear Search Time: 2145.21 ms
1,000 Iterations -> Binary Search Time: 3.82 ms

--- Task 2: Sort (10,000 Records) ---
Pass 1 Trace: [1200.0, 450.0, 980.0, 300.0, 760.0, 150.0]
Pass 2 Trace: [1200.0, 980.0, 450.0, 760.0, 300.0, 150.0]
Execution -> Bubble Sort: 398.2 ms | Merge Sort: 42.1 ms | Built-in (TimSort): 12.5 ms

--- Task 3: Duplicates ---
Alert: Duplicate Order detected for Customer 8472 (Amt: 45.00)

--- Task 4: Stack & Queue ---
Queue (Dispatch): Order #101 Processed, Order #102 Processed
Stack (Undo): Reverted 'Address Change', Reverted 'Apply Promo'

--- Task 5: Refund ---
Target 2788 (INR) -> Greedy: 9 coins, DP: 9 coins
Target 6 (Coins: 1,3,4) -> Greedy: 3 coins (4,1,1), DP: 2 coins (3,3)
```

### 3. Complexity & Data-Structure Rationale
*   **Search:** Binary search operates at $O(\log n)$ by discarding half the search space per iteration, proving vastly superior to Linear's $O(n)$ scan. Binary search relies on the array being strictly sorted in heap memory.
*   **Sort:** Bubble sort's $O(n^2)$ complexity is inefficient for enterprise volumes. Merge Sort ($O(n \log n)$) scales well but requires $O(n)$ auxiliary space. 
*   **Duplicates:** A `HashSet` provides $O(1)$ amortized lookup time. A brute-force nested loop would be $O(n^2)$, causing severe CPU spikes at 50k records. Space complexity is $O(n)$.
*   **State Management:** Node-based Stacks and Queues achieve strict $O(1)$ time complexity for insertions/deletions because they manipulate memory pointers rather than shifting array indices. 
*   **Optimization:** The Greedy approach $O(N)$ fails on non-standard denominations. DP guarantees the global optimum at the cost of $O(Amount \times Denominations)$ time complexity and $O(Amount)$ space.

---

## Set 2 – Retail Banking Transaction Review
**Business Scenario:** Reviewing 100,000 daily card transactions. Requires stable sorting, time-window duplicate detection, and min/max evaluations.

### 1. Pseudocode
**Task 1 – Search Comparisons**
```text
FUNCTION BinarySearchWithCount(array, target):
    count = 0, left = 0, right = n - 1
    WHILE left <= right:
        count++
        mid = left + (right - left) / 2
        IF array[mid] == target THEN RETURN count
        IF array[mid] < target THEN left = mid + 1 ELSE right = mid - 1
```

**Task 2 – Stable Sort (Insertion vs Merge)**
```text
FUNCTION InsertionSort(statements):
    FOR i = 1 TO n - 1:
        key = statements[i]
        j = i - 1
        // Strict > ensures stability (relative order of equal timestamps is preserved)
        WHILE j >= 0 AND statements[j].time > key.time:
            statements[j+1] = statements[j]
            j = j - 1
        statements[j+1] = key
```

**Task 3 – 60-Second Window Duplicates (HashMap)**
```text
FUNCTION DetectTimeWindowDuplicates(transactions):
    Sort(transactions by time)
    map = NEW HashMap()
    FOR EACH tx IN transactions:
        key = tx.accountId + "-" + tx.amount
        IF map.contains(key) AND (tx.time - map.get(key) <= 60):
            PRINT "Warning: Double Charge"
        map.put(key, tx.time)
```

**Task 5 – Min/Max Divide & Conquer**
```text
FUNCTION FindMinMax(array, left, right):
    IF left == right THEN RETURN (array[left], array[left])
    mid = left + (right - left) / 2
    leftResult = FindMinMax(array, left, mid)
    rightResult = FindMinMax(array, mid + 1, right)
    RETURN (MIN(leftResult.min, rightResult.min), MAX(leftResult.max, rightResult.max))
```

### 2. Console Output
```text
--- Task 1: Search Comparisons (n = 100,000) ---
Binary Search -> Best: 1, Avg: ~15, Worst: 17 comparisons
Linear Search -> Best: 1, Avg: 50,000, Worst: 100,000 comparisons

--- Task 2: Stable Sort ---
Insertion Sort: TX1@09:00(Purchase) -> TX2@09:00(Refund) -> TX3@09:15
Stability Verified: Purchase remains before Refund.

--- Task 3: 60s Window ---
ALERT: TX-77382 double-posted within 42 seconds.

--- Task 5: Min/Max ---
Divide & Conquer -> Min: $1.50, Max: $8,500.00 | Total Comparisons: 150,000
Brute Force      -> Min: $1.50, Max: $8,500.00 | Total Comparisons: 200,000
```

### 3. Complexity & Data-Structure Rationale
*   **Search Comparisons:** Binary search mathematically caps worst-case comparisons at $\lceil\log_2(100,000)\rceil = 17$. 
*   **Stability:** Insertion Sort ($O(n^2)$) and Merge Sort ($O(n \log n)$) are strictly stable. This is critical for enterprise ledgers to ensure chronological operations (like purchases vs. refunds occurring in the same millisecond) don't flip in heap memory.
*   **Time Windows:** A `HashMap` offers $O(1)$ read/write access. By storing the timestamp as the value, we can execute a rolling window check in $O(N)$ total time after sorting.
*   **Min/Max D&C:** The Tournament method (Divide & Conquer) reduces total comparisons to $3n/2 - 2$ versus the standard $2n$ brute force, heavily optimizing CPU cycles on massive datasets.

---

## Set 3 – Hospital Appointment Desk
**Business Scenario:** Managing hospital rosters. Requires priority sorting, rejection of overlapping slot bookings, and capacity optimization for doctors.

### 1. Pseudocode
**Task 2 – Sort by Priority (Urgency then Arrival)**
```text
FUNCTION ComparePatients(p1, p2):
    IF p1.urgency != p2.urgency THEN RETURN p1.urgency - p2.urgency
    RETURN p1.arrivalTime - p2.arrivalTime

FUNCTION QuickSort(arr, low, high):
    IF low >= high THEN RETURN
    pivot = arr[(low + high) / 2]
    i = low, j = high
    WHILE i <= j:
        WHILE arr[i] < pivot: i++
        WHILE arr[j] > pivot: j--
        IF i <= j:
            SWAP(arr[i], arr[j])
            i++, j--
    QuickSort(arr, low, j)
    QuickSort(arr, i, high)
```

**Task 3 – Double Booking Rejection**
```text
FUNCTION PreventDoubleBooking(bookings):
    ledger = NEW HashSet()
    FOR EACH booking IN bookings:
        key = booking.patientId + "-" + booking.slotTime
        IF ledger.contains(key) THEN RETURN "REJECT"
        ledger.add(key)
    RETURN "CONFIRM"
```

**Task 5 – Shift Optimization (Activity Selection)**
```text
FUNCTION MaxAppointmentsDP(slots):
    Sort(slots by endTime)
    dp = ARRAY of size n
    dp[0] = 1
    FOR i = 1 TO n - 1:
        includeCount = 1
        // Find latest non-conflicting slot
        latest = FindNonConflicting(slots, i)
        IF latest != -1 THEN includeCount += dp[latest]
        dp[i] = MAX(includeCount, dp[i-1])
    RETURN dp[n-1]
```

### 2. Console Output
```text
--- Task 1: Search 20,000 Patients ---
1,000 Iterations -> Linear: 92.4 ms | Binary: 1.12 ms

--- Task 2: Priority Sort ---
Sorted Queue: [P009(L1-Urgent, 08:00), P002(L1-Urgent, 08:15), P088(L2-Routine, 08:00)]
QuickSort: 38,102 Swaps | Selection Sort: 18,995 Swaps

--- Task 3: Booking Validation ---
Slot 09:00 -> Patient 105: CONFIRMED
Slot 09:00 -> Patient 105: REJECTED (Double Booking)

--- Task 5: Shift Capacity ---
Given overlapping slots: DP Algorithm scheduled Max 7 Appointments. 
Greedy Algorithm (Earliest Start) scheduled only 3.
```

### 3. Complexity & Data-Structure Rationale
*   **Sorting Benchmarks:** QuickSort provides an expected $O(n \log n)$ performance, significantly outperforming Selection Sort ($O(n^2)$) at 20,000 records, despite QuickSort yielding a higher number of internal pointer swaps.
*   **Booking Sets:** Using a `HashSet` string-key mapping guarantees $O(1)$ validation. Scanning a traditional `ArrayList` for conflicts per booking would degenerate into $O(n^2)$ time.
*   **Activity Optimization:** The Greedy approach fails if a very long appointment starts early, blocking shorter subsequent ones. DP solves this by tracking the optimal sub-structure at $O(n \log n)$ time (using binary search to find non-conflicting slots).