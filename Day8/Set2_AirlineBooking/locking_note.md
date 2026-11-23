# Locking Note (Day 8 Set 2)

## What happens with two sessions

`sp_book_seat` executes `SELECT status, fare ... FOR UPDATE` **inside** the transaction. InnoDB takes an exclusive row lock on the seat. A second session attempting the same seat blocks at its own `FOR UPDATE`, waiting for the first transaction to commit or roll back.

- First session commits: the second session's read returns `BOOKED`; its validation fails with `Seat is no longer available`, so no duplicate booking is inserted.
- First session rolls back: the seat returns to `AVAILABLE`; the second session can now reserve it.
- `innodb_lock_wait_timeout` (50 seconds by default) eventually aborts a waiter that cannot acquire the lock.

The `bookings.seat_id UNIQUE` constraint is a second line of defence: even a buggy application cannot insert two confirmed bookings for the same seat.

## RANK vs DENSE_RANK

With fares `9500, 9500, 4200` in one flight:

| Function | Ranks |
|---|---|
| `RANK()` | `1, 1, 3` - ties share a rank and the next rank is skipped |
| `DENSE_RANK()` | `1, 1, 2` - ties share a rank and no rank is skipped |

`ROW_NUMBER()` would give `1, 2, 3` because it arbitrarily breaks ties; it is not used for equal fares here.

## Running total

`SUM(fare) OVER (PARTITION BY flight_id ORDER BY fare DESC, booking_id ROWS UNBOUNDED PRECEDING)` resets for each flight and accumulates in fare order. Adding `booking_id` to the `ORDER BY` makes the running total deterministic even when fares tie.

## Avoiding deadlocks

Always book seats through the same access path (`seats.id` primary key) and keep the transaction short; do not call external services while holding the row lock. Use `SKIP LOCKED` only for work-queue patterns, never for a seat the customer explicitly selected.
