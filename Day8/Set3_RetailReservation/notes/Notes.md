# Notes - Day 8 Set 3

- `p_items` uses MySQL 8 `JSON_TABLE` so a variable number of order lines can be validated, inserted and applied to stock with set-based SQL.
- Validation happens twice: schema constraints catch malformed data; the locked stock check inside the transaction catches the business rule at commit time.
- `EXIT HANDLER` rolls back `orders`, `order_lines` and all stock updates together when any line is short.
- The ranking report uses a correlated subquery for below-average stock, `ROW_NUMBER() OVER (PARTITION BY category_id ...)` for top three, and a named `WINDOW` clause shared by `LAG` and `LEAD`.
- `REPEATABLE READ` plus `FOR UPDATE` on product rows keeps the stock check consistent with the update.
