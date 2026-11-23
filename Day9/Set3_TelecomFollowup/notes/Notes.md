# Notes - Day 9 Set 3

- `vw_prepaid_subscribers` filters out postpaid users and omits `phone` and `email`; `vw_recharge_summary` aggregates recharge count and value.
- `sp_recharge` validates amount, subscriber, prepaid connection and prepaid plan, then updates balance and writes history inside one transaction with an `EXIT HANDLER`.
- `fn_validity_days_left` is deterministic and returns `0` for a missing recharge date or expired validity.
- `sp_recharge_error_demo` declares `EXIT HANDLER FOR SQLEXCEPTION` and shows that a caller can handle the `SIGNAL SQLSTATE '45000'` raised by `sp_recharge`.
- The cursor and set-based notification jobs use the same `NOT EXISTS` duplicate guard; `NOW(6)` timing is captured in `cursor.sql`.
