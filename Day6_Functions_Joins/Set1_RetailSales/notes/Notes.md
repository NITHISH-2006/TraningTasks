# Notes - Set 1 Retail Sales
- Used INNER JOINs for matched sales facts, LEFT JOINs for missing payments/orders.
- `GROUP BY` with aggregates for per-product/month/customer/city/category/day summaries.
- Demonstrated UPPER/CONCAT/DATE_FORMAT/DATEDIFF/ROUND for presentation, and NULL semantics of COUNT/SUM/AVG.
- `WHERE` filters pre-aggregation rows; `HAVING` filters post-aggregation groups.
