# Expected Output - Set 1 Retail Sales Reporting

Representative sample data assumed for 10 customers, 12 products across categories (Grocery, Electronics, Apparel), ~30 orders/items with some unpaid orders and one customer with no orders.

## Q1 Top-5 products by revenue
Purpose: identify highest revenue-generating products.
| id | name | revenue |
|---:|---|---:|
| 3 | Basmati Rice 5kg | 24500.00 |
| 10 | Headphones | 19800.00 |
| 1 | Apple Pack | 15600.00 |
| 7 | T-Shirt | 13200.00 |
| 5 | Dish Soap | 9800.00 |

## Q2 Month-wise sales
Purpose: trend total sales by month.
| month | total_sales |
|---|---:|
| 2026-08 | 41200.00 |
| 2026-09 | 53850.00 |
| 2026-10 | 48900.00 |

## Q3 Customers with more than three orders (HAVING)
Purpose: frequent buyers; HAVING filters aggregated counts.
| id | name | order_count |
|---:|---|---:|
| 2 | Priya Sharma | 5 |
| 5 | Suresh Patil | 4 |

## Q4 Average basket value per city
Purpose: compare average order value across cities.
| city | avg_basket_value |
|---|---:|
| Mumbai | 4250.00 |
| Delhi | 3980.50 |
| Bengaluru | 5100.00 |
| Chennai | 3620.00 |

## Q5 Orders without payment (LEFT JOIN)
Purpose: find unpaid orders (payment_status != PAID).
| id | customer_id | order_date | payment_status |
|---:|---:|---|---|
| 1012 | 4 | 2026-09-18 | PENDING |
| 1019 | 7 | 2026-10-05 | PENDING |
| 1024 | 9 | 2026-10-21 | FAILED |

## Q6 Customers with no orders (LEFT JOIN)
Purpose: customers without any orders.
| id | name |
|---:|---|
| 10 | Tara Singh |

## Q7 Product-category revenue share
Purpose: revenue contribution by category.
| category | category_revenue | revenue_share_pct |
|---|---:|---:|
| Grocery | 58400.00 | 40.62 |
| Electronics | 49200.00 | 34.22 |
| Apparel | 36150.00 | 25.16 |

## Q8 Day with the highest sales
Purpose: peak sales day.
| order_date | day_sales |
|---|---:|
| 2026-09-15 | 12800.00 |

## Task 2 (functions)
Example rows (UPPER, CONCAT, DATE_FORMAT, DATEDIFF, ROUND): `RAVI KUMAR`, `Ravi Kumar (Mumbai)`, `10-Aug-2026`, days_since_order computed from CURDATE, rounded totals.

## Task 3 (NULL behaviour)
`COUNT(*)` counts all rows; `COUNT(column)` ignores NULLs; `SUM/AVG` ignore NULLs (can yield NULL if all inputs NULL). Example: if 2 of 30 rows have NULL payment_status, `COUNT(*)=30`, `COUNT(payment_status)=28`.

## Task 4 (WHERE vs HAVING)
`WHERE payment_status='PAID'` filters before grouping (removes unpaid rows), `HAVING COUNT(o.id)>3` filters after aggregation; only paid-order frequent buyers remain.
