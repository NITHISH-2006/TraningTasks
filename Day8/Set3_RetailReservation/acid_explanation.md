# ACID Explanation (Day 8 Set 3)

| Property | Meaning | Concrete example from `sp_reserve_order` |
|---|---|---|
| **Atomicity** | A transaction is all-or-nothing. | The order header, all `order_lines` and each `products.qty_in_stock` decrement are in one `START TRANSACTION`. If product 3 has 20 units but an order asks for 999, `SIGNAL` fires and the `EXIT HANDLER` executes `ROLLBACK`; no partial order or stock change remains. |
| **Consistency** | Valid state before and after the transaction. | `CHECK (qty_in_stock >= 0)`, positive line quantities/prices and foreign keys are enforced at commit. Validation before `START TRANSACTION` and locking validation inside it both protect the invariant that reserved stock never exceeds available stock. |
| **Isolation** | Concurrent transactions do not see each other's uncommitted work. | Two customers reserving the last unit both execute the stock check with `FOR UPDATE`. The first transaction holds the row lock; the second waits and then re-reads the committed (reduced) stock, so only one reservation succeeds. |
| **Durability** | Once committed, changes survive a crash. | After `COMMIT`, InnoDB has written the redo log and flushed the change; a subsequent power failure does not lose the confirmed order. |

## Non-transactional counter-example

If the same tables used **MyISAM**, the script would still run but `ROLLBACK` would be ignored. In the insufficient-stock example the `orders` row and some `order_lines` rows could remain while stock stayed unchanged or partially decremented. There would be no `FOR UPDATE` row lock either, so two sessions could both read `qty_in_stock = 1` and both confirm an order, driving stock negative in business terms. InnoDB with explicit transactions prevents both failures.
