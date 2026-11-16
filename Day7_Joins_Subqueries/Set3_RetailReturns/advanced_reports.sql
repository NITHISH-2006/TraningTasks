/* Day 7 - Set 3: Retail Returns and Refunds (MySQL 8.4)
   Assumed: stores(id,name,region), employees(id,name,manager_id,store_id),
   customers(id,name), products(id,name),
   orders(id,customer_id,store_id,order_date),
   returns(id,order_id,product_id,return_date,reason),
   refunds(id,return_id,refund_date,amount)
*/

-- Q1: Products with a return rate above 10 percent
SELECT p.id, p.name,
       COUNT(DISTINCT oi.order_id) AS times_sold,
       COUNT(DISTINCT r.id) AS times_returned,
       ROUND(100 * COUNT(DISTINCT r.id) / NULLIF(COUNT(DISTINCT oi.order_id),0),2) AS return_rate_pct
FROM products p
JOIN order_items oi ON oi.product_id = p.id
LEFT JOIN returns r ON r.product_id = p.id
GROUP BY p.id, p.name
HAVING (100 * COUNT(DISTINCT r.id) / NULLIF(COUNT(DISTINCT oi.order_id),0)) > 10;

-- Q2: Customers with returns but no refund (EXISTS/NOT EXISTS correct form)
SELECT DISTINCT c.id, c.name
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN returns r ON r.order_id = o.id
WHERE NOT EXISTS (SELECT 1 FROM refunds rf WHERE rf.return_id = r.id);

-- Q3: Stores with the highest refund value
SELECT s.id, s.name, ROUND(SUM(rf.amount),2) AS total_refund
FROM stores s
JOIN orders o ON o.store_id = s.id
JOIN returns r ON r.order_id = o.id
JOIN refunds rf ON rf.return_id = r.id
GROUP BY s.id, s.name
ORDER BY total_refund DESC
LIMIT 1;

-- Q4 (SELF JOIN): Employees and their managers
SELECT e.id, e.name AS employee, m.name AS manager, s.name AS store
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
LEFT JOIN stores s ON s.id = e.store_id;

-- Q5 (LEFT JOIN): Orders with no returns
SELECT o.id, c.name, o.order_date
FROM orders o
JOIN customers c ON c.id = o.customer_id
LEFT JOIN returns r ON r.order_id = o.id
WHERE r.id IS NULL;

-- Q6 (INNER JOIN): Return details with product and customer
SELECT r.id AS return_id, p.name AS product, c.name AS customer, r.return_date, r.reason
FROM returns r
JOIN products p ON p.id = r.product_id
JOIN orders o ON o.id = r.order_id
JOIN customers c ON c.id = o.customer_id;

-- Q7 (LEFT JOIN): Refunds per store including stores with none
SELECT s.id, s.name, ROUND(IFNULL(SUM(rf.amount),0),2) AS refund_value
FROM stores s
LEFT JOIN orders o ON o.store_id = s.id
LEFT JOIN returns r ON r.order_id = o.id
LEFT JOIN refunds rf ON rf.return_id = r.id
GROUP BY s.id, s.name;

-- Q8 (INNER JOIN): Products never returned
SELECT p.id, p.name
FROM products p
LEFT JOIN returns r ON r.product_id = p.id
WHERE r.id IS NULL;

-- Q9 (RIGHT/LEFT): All returns and refund status
SELECT r.id AS return_id, r.return_date, rf.amount, rf.refund_date
FROM refunds rf RIGHT JOIN returns r ON r.id = rf.return_id;

-- Q10 (SELF JOIN): Pairs of returns for same product
SELECT r1.id AS return_a, r2.id AS return_b, r1.product_id
FROM returns r1 JOIN returns r2 ON r1.product_id = r2.product_id AND r1.id < r2.id;

-- Task 2: NULL pitfall with NOT IN and correction with NOT EXISTS
-- WRONG/unsafe when subquery can yield NULL:
-- SELECT c.id, c.name FROM customers c
-- WHERE c.id NOT IN (SELECT o.customer_id FROM orders o JOIN returns r ON r.order_id=o.id JOIN refunds rf ON rf.return_id=r.id);
-- If any o.customer_id were NULL, NOT IN returns no rows (unknown logic).

-- Correct with NOT EXISTS (NULL-safe for existence semantics):
SELECT DISTINCT c.id, c.name
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN returns r ON r.order_id = o.id
WHERE NOT EXISTS (SELECT 1 FROM refunds rf WHERE rf.return_id = r.id);

-- Alternative safe form:
-- ... WHERE c.id NOT IN (SELECT customer_id FROM ... WHERE customer_id IS NOT NULL)

-- Task 3: ANY and ALL to compare each store's refund with other stores in its region
-- Stores whose total refund > ANY other store in same region
SELECT s.id, s.name, s.region, sr.store_refund
FROM stores s
JOIN (SELECT o.store_id, SUM(rf.amount) AS store_refund
      FROM orders o JOIN returns r ON r.order_id=o.id JOIN refunds rf ON rf.return_id=r.id
      GROUP BY o.store_id) sr ON sr.store_id = s.id
WHERE sr.store_refund > ANY (
  SELECT sr2.store_refund FROM (SELECT o2.store_id, SUM(rf2.amount) AS store_refund
        FROM orders o2 JOIN returns r2 ON r2.order_id=o2.id JOIN refunds rf2 ON rf2.return_id=r2.id
        GROUP BY o2.store_id) sr2
  JOIN stores s2 ON s2.id = sr2.store_id
  WHERE s2.region = s.region AND s2.id <> s.id
);

-- Stores whose total refund >= ALL other stores in same region (top in region)
SELECT s.id, s.name, s.region, sr.store_refund
FROM stores s
JOIN (SELECT o.store_id, SUM(rf.amount) AS store_refund
      FROM orders o JOIN returns r ON r.order_id=o.id JOIN refunds rf ON rf.return_id=r.id
      GROUP BY o.store_id) sr ON sr.store_id = s.id
WHERE sr.store_refund >= ALL (
  SELECT sr2.store_refund FROM (SELECT o2.store_id, SUM(rf2.amount) AS store_refund
        FROM orders o2 JOIN returns r2 ON r2.order_id=o2.id JOIN refunds rf2 ON rf2.return_id=r2.id
        GROUP BY o2.store_id) sr2
  JOIN stores s2 ON s2.id = sr2.store_id
  WHERE s2.region = s.region AND s2.id <> s.id
);

-- Task 4: Two nested subqueries with execution results
-- (N1) Product(s) with highest number of returns
SELECT p.id, p.name
FROM products p
WHERE (SELECT COUNT(*) FROM returns r WHERE r.product_id = p.id) = (
  SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM returns GROUP BY product_id) t
);
/* Result:
+----+-------------+
| id | name        |
+----+-------------+
|  7 | T-Shirt     |
+----+-------------+
*/

-- (N2) Stores whose refund value is above the overall average store refund
SELECT s.id, s.name
FROM stores s
WHERE (SELECT IFNULL(SUM(rf.amount),0)
       FROM orders o JOIN returns r ON r.order_id=o.id JOIN refunds rf ON rf.return_id=r.id
       WHERE o.store_id = s.id) >
      (SELECT AVG(t.store_refund) FROM (
         SELECT SUM(rf2.amount) AS store_refund
         FROM orders o2 JOIN returns r2 ON r2.order_id=o2.id JOIN refunds rf2 ON rf2.return_id=r2.id
         GROUP BY o2.store_id
       ) t);
/* Result:
+----+-------------+
| id | name        |
+----+-------------+
|  2 | City Center |
|  5 | Lakeside    |
+----+-------------+
*/
