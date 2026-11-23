# Notes - Day 9 Set 1

## Procedure vs function

| Feature | Stored procedure | Stored function |
|---|---|---|
| Parameters | `IN`, `OUT`, `INOUT` | `IN` only |
| Return | Zero or more result sets / `OUT` values | Exactly one scalar value |
| Call | `CALL sp_place_order(...)` | Usable inside `SELECT`, e.g. `fn_order_total_with_tax(total_amount, 0.18)` |
| Transactions | Commonly owns `START TRANSACTION` / `COMMIT` / `ROLLBACK` | Should avoid transaction control and SQL side effects |
| Use case | Multi-step business workflow (place an order) | Reusable calculation (tax-inclusive total) |

## Other implementation notes

- `vw_order_summary` exposes only customer, product, quantity and price columns; `cost_price`, `supplier_id` and supplier contact data are deliberately absent.
- `vw_low_stock` is a single-table view and therefore updatable. `WITH CHECK OPTION` prevents an update that would move a row outside `qty_in_stock <= reorder_level`.
- `sp_place_order` stages JSON lines in a temporary table, validates stock inside the transaction, and rolls back order, items and stock changes on any error.
- `sp_reject_cancelled_order` uses `SIGNAL SQLSTATE '45000'`; the MySQL client receives `ERROR 1644 (45000)` with the custom message.
- The cursor uses `DECLARE CONTINUE HANDLER FOR NOT FOUND` to terminate the loop; the set-based rewrite in `cursor.sql` is faster for bulk work.
