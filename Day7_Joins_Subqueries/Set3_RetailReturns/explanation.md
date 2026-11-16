# Explanation Note - Set 3 Retail Returns and Refunds

## Ten solutions summary (Q1–Q10)
1. **Return rate > 10%:** JOIN order_items/products with LEFT JOIN returns; rate = returned/sold * 100 filtered by HAVING.
2. **Customers with returns but no refund:** JOIN customers/orders/returns and `NOT EXISTS` on refunds (correct/NULL-safe).
3. **Stores with highest refund value:** JOIN stores/orders/returns/refunds, aggregate SUM(amount), ORDER BY DESC LIMIT 1.
4. **Employees and their managers:** SELF LEFT JOIN on employees (manager_id) to include employees without managers.
5. **Orders with no returns:** LEFT JOIN orders->returns, `WHERE r.id IS NULL`.
6. **Return details with product and customer:** INNER JOIN returns/products/orders/customers for complete matched context.
7. **Refunds per store including stores with none:** chained LEFT JOINs from stores to refunds with IFNULL(SUM,0).
8. **Products never returned:** LEFT JOIN products->returns, `WHERE r.id IS NULL`.
9. **All returns and refund status:** RIGHT JOIN refunds onto returns (or LEFT from returns) to keep returns without refunds.
10. **Pairs of returns for same product:** SELF JOIN returns on product_id with `id < id` to dedupe pairs.

## Task 2: NULL pitfall with NOT IN vs NOT EXISTS
`NOT IN (subquery)` returns no rows if the subquery result contains any `NULL` because comparisons become UNKNOWN (three-valued logic). For "customers with returns but no refund", if a nullable key appeared, `NOT IN` could incorrectly filter out all rows. `NOT EXISTS (correlated subquery)` checks row existence and is NULL-safe for this semantics; alternatively filter `NOT IN (SELECT ... WHERE col IS NOT NULL)`.

## Task 3: ANY and ALL
- `> ANY (subquery)`: store refund greater than at least one other store’s refund in the same region.
- `>= ALL (subquery)`: store refund greater than or equal to every other store’s refund in the same region (regional maximum). Correlated by region and excluding self.

## Task 4: Nested subqueries (with execution results)
- **N1** Product(s) with highest number of returns: inner counts per product, middle `MAX(cnt)`, outer matches -> result `T-Shirt (id 7)` in sample data.
- **N2** Stores with refund value above overall average store refund: per-store refund sum compared to `AVG` of per-store refunds -> result `City Center (2), Lakeside (5)` in sample data.

## Task 5: How solutions change at 100x data volume
| # | Solution | Change/considerations at 100x volume |
|---|---|---|
| 1 | Return rate per product | Aggregation over much larger joins; needs indexes on `order_items.product_id`, `returns.product_id`, `products.id`. Consider pre-aggregated/materialized stats for dashboards. |
| 2 | Returns but no refund (NOT EXISTS) | Still correct; performance relies on indexes on `refunds.return_id`, `returns.order_id/id`; NOT EXISTS can short-circuit. Avoid non-sargable functions on join keys. |
| 3 | Store with highest refund value | Full aggregation then sort; index `orders.store_id`, `returns.order_id`, `refunds.return_id/amount`. For top-1, can limit early in some engines/materialize store totals. |
| 4 | Employees and managers (self join) | Linear in employees; index `employees.manager_id`, `store_id`. Hierarchy depth same, but more rows scanned; negligible relative to fact tables. |
| 5 | Orders with no returns | Anti-join on large orders/returns; needs index on `returns.order_id`. Partitioning orders by date can help if filtered by time. |
| 6 | Return details with joins | Result set grows; ensure selective predicates and indexes on all join keys (`returns.product_id/order_id`, `orders.customer_id`). Paginate in applications. |
| 7 | Refunds per store incl. none | Large outer-join aggregation; indexes as in #3. Consider caching periodic totals. |
| 8 | Products never returned | Anti-join products vs returns; index `returns.product_id`. Result size may shrink proportionally but scan cost grows. |
| 9 | All returns and refund status | Large outer join; index `refunds.return_id`. If listing, requires pagination/batching. |
| 10 | Pairs of returns for same product | Self-join can explode (O(n^2) per product group); at 100x becomes very expensive or infeasible for hot products. Must restrict scope (time window/product) or avoid pair generation in favor of grouped counts. |

**General:** add/verify indexes and foreign-key-supporting indexes, analyze table statistics, consider partitioning large fact tables (orders/returns/refunds) by date, use EXPLAIN to validate plans, and move heavy analytics to precomputed aggregates/OLAP where appropriate.
