# Join Choice Table - Set 1 Logistics Shipment Analysis

| # | Question / Goal | Join/Subquery Type | Reason |
|---|---|---|---|
| Q1 | Shipments delayed > 2 days with carrier names | INNER JOIN (shipments, carriers) | Need only shipments that have a matching carrier and meet delay condition. |
| Q2 | Hubs with no outbound shipments | LEFT JOIN (hubs -> shipments) + `WHERE s.id IS NULL` | Keep all hubs and detect absence of matching outbound shipments. |
| Q3 | Employees with their supervisors | SELF LEFT JOIN (employees e -> employees m) | Hierarchy in same table; LEFT keeps top-level employees with no supervisor. |
| Q4 | Delivered shipments with origin/dest hub names | INNER JOINs (shipments, hubs twice) | Only valid, delivered shipments with existing hub references. |
| Q5 | Carriers and shipment counts incl. none | LEFT JOIN (carriers -> shipments) + GROUP BY | Retain carriers with zero shipments. |
| Q6 | Customers and total shipping cost | INNER JOIN (customers, shipments) + GROUP BY | Aggregate cost only for customers who have shipments. |
| Q7 | All shipments and delivery event count | RIGHT JOIN (delivery_events -> shipments) / equiv LEFT from shipments | Ensure every shipment appears even with zero events. |
| Q8 | Shipment pairs sharing same origin/destination | SELF INNER JOIN (shipments s1,s2) | Compare rows within same table on hub pair; `s1.id < s2.id` avoids duplicates/self-pair. |
| Q9 | Latest delivery event per shipment | INNER JOIN + correlated subquery (MAX event_time) | Match each shipment to its most recent event. |
| Q10 | Customers with no shipments | LEFT JOIN (customers -> shipments) + IS NULL | Find unmatched customers. |
| Sub | Carriers avg delay above overall | IN + nested aggregate subqueries | Filter carriers by group condition vs global aggregate. |
| Sub | Customers shipped to every hub | NOT EXISTS (relational division) | Express "for all hubs there exists a shipment" via double negation. |
| Sub | ANY/ALL examples | ANY / ALL subqueries | Compare a value against sets (any above threshold / >= all in group). |
| Rewrite A | Customers with shipments | Subquery IN vs INNER JOIN | JOIN often clearer and optimizable; returns distinct matched rows. |
| Rewrite B | Carriers above overall avg delay | Nested subquery vs JOIN of derived tables | Derived-table JOIN exposes intermediate aggregates, can be efficient/readable for complex stats. |
| Nested | 2nd-highest shipping cost per hub | Nested scalar subqueries (MAX < MAX) | Compute per-hub second maximum relative to hub maximum. |

## Subquery vs JOIN notes
- **Readability:** Simple existence/membership often clear as `IN/EXISTS`; multi-aggregate comparisons can be clearer as joined derived tables.
- **Performance (typical):** Depends on indexes and optimizer; `EXISTS` can short-circuit, `IN`/derived joins benefit from indexes on join/filter keys. On this small sample differences negligible; on large data proper indexing on `carrier_id`, `customer_id`, hub ids, and dates matters.
