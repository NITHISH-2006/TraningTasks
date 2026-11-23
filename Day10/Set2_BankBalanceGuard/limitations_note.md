# MySQL Trigger Limitations (Day 10 Set 2)

## No `INSTEAD OF` trigger

MySQL only supports `BEFORE`/`AFTER` triggers on base tables for `INSERT`, `UPDATE` and `DELETE`. There is no `INSTEAD OF` trigger, including on views. An `INSTEAD OF` trigger in other databases replaces the triggering operation entirely; MySQL instead executes the triggering statement and gives you a `BEFORE` hook that may modify `NEW` or raise `SIGNAL`, followed by an `AFTER` hook for auditing.

The usual MySQL substitute is:

1. Use a `BEFORE` trigger for validation or for small derived changes to `NEW` values.
2. Use a database `CHECK` constraint or a foreign key for simple row-level invariants.
3. Use a stored procedure when the caller needs an alternative workflow (for example, "insert a reversal transaction instead of deleting this transaction"). Applications call the procedure instead of issuing the raw DML.
4. Use an updatable view plus triggers only for hiding/restructuring rows, never for replacing writes entirely.

## `CHECK` vs trigger vs procedure here

| Rule | Best mechanism | Reason |
|---|---|---|
| `balance >= 0` for every account | `CHECK` constraint | Simple column invariant; enforced even if a trigger is dropped |
| Savings accounts specifically cannot go negative | `BEFORE UPDATE` trigger | Conditional on `account_type`; needs a custom error message |
| Keep `last_txn_date` in sync | `AFTER INSERT` trigger | Derived data maintained for every client automatically |
| Reverse rather than delete a transaction | Stored procedure | The replacement workflow is business logic, not a row hook |

## Other pitfalls

- Triggers are row-level: the batch update of five accounts invokes the guard five times and the first violation aborts all five rows.
- Multiple triggers on the same event/timing are allowed in MySQL 8, but their relative order matters when both modify data; use `FOLLOWS`/`PRECEDES` if you need a guaranteed order.
- Triggers cannot use `START TRANSACTION` or `COMMIT`; they run inside the triggering statement's transaction.
- A trigger that writes to the same table it watches can cause confusing behaviour or recursion errors; keep audit tables separate.
