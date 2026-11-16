/* Day 6 - Set 1: Retail Sales Reporting (MySQL 8.4)
   Assumed tables: customers(id,name,city), products(id,name,category,price),
   orders(id,customer_id,order_date,payment_status), order_items(id,order_id,product_id,qty,unit_price)
*/

-- Q1: Top-5 products by revenue
SELECT p.id, p.name, ROUND(SUM(oi.qty * oi.unit_price),2) AS revenue
FROM order_items oi JOIN products p ON p.id = oi.product_id
GROUP BY p.id, p.name
ORDER BY revenue DESC
LIMIT 5;

-- Q2: Month-wise sales
SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
       ROUND(SUM(oi.qty * oi.unit_price),2) AS total_sales
FROM orders o JOIN order_items oi ON o.id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date,'%Y-%m')
ORDER BY month;

-- Q3: Customers with more than three orders (HAVING)
SELECT c.id, c.name, COUNT(o.id) AS order_count
FROM customers c JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING COUNT(o.id) > 3;

-- Q4: Average basket value per city
SELECT c.city, ROUND(AVG(t.order_total),2) AS avg_basket_value
FROM customers c
JOIN (SELECT o.id, o.customer_id, SUM(oi.qty * oi.unit_price) AS order_total
      FROM orders o JOIN order_items oi ON o.id = oi.order_id
      GROUP BY o.id, o.customer_id) t ON c.id = t.customer_id
GROUP BY c.city;

-- Q5: Orders without payment (LEFT JOIN orders to payments/status)
SELECT o.id, o.customer_id, o.order_date, o.payment_status
FROM orders o
LEFT JOIN (SELECT id AS paid_order_id FROM orders WHERE payment_status = 'PAID') p
  ON o.id = p.paid_order_id
WHERE p.paid_order_id IS NULL;

-- Q6: Customers with no orders (LEFT JOIN)
SELECT c.id, c.name
FROM customers c LEFT JOIN orders o ON c.id = o.customer_id
WHERE o.id IS NULL;

-- Q7: Product-category revenue share
SELECT p.category,
       ROUND(SUM(oi.qty * oi.unit_price),2) AS category_revenue,
       ROUND(100 * SUM(oi.qty * oi.unit_price) / SUM(SUM(oi.qty * oi.unit_price)) OVER (), 2) AS revenue_share_pct
FROM order_items oi JOIN products p ON p.id = oi.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- Q8: Day with the highest sales
SELECT o.order_date, ROUND(SUM(oi.qty * oi.unit_price),2) AS day_sales
FROM orders o JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.order_date
ORDER BY day_sales DESC
LIMIT 1;

-- Task 2: String, date and mathematical functions (customer-friendly output)
SELECT o.id AS order_id,
       UPPER(c.name) AS customer_name_upper,
       CONCAT(c.name, ' (', c.city, ')') AS customer_label,
       DATE_FORMAT(o.order_date, '%d-%b-%Y') AS order_date_fmt,
       DATEDIFF(CURDATE(), o.order_date) AS days_since_order,
       ROUND(SUM(oi.qty * oi.unit_price), 2) AS order_total_rounded
FROM orders o
JOIN customers c ON c.id = o.customer_id
JOIN order_items oi ON oi.order_id = o.id
GROUP BY o.id, c.name, c.city, o.order_date;

-- Task 3: NULL behaviour in COUNT(*), COUNT(column), SUM, AVG
-- Example: some orders may have NULL discount_note/payment_ref in an extended column
SELECT COUNT(*) AS cnt_all,
       COUNT(payment_status) AS cnt_payment_status,
       COUNT(NULLIF(payment_status,'PENDING')) AS cnt_non_pending,
       SUM(oi.qty) AS sum_qty,
       AVG(oi.unit_price) AS avg_price
FROM orders o JOIN order_items oi ON o.id = oi.order_id;
/* NULL behaviour: COUNT(*) counts all rows; COUNT(col) ignores NULLs;
   SUM/AVG ignore NULLs and can return NULL if all inputs are NULL. */

-- Task 4: WHERE vs HAVING (using Q3)
-- WHERE filters rows before grouping (e.g. only PAID orders):
SELECT c.id, c.name, COUNT(o.id) AS paid_order_count
FROM customers c JOIN orders o ON c.id = o.customer_id
WHERE o.payment_status = 'PAID'
GROUP BY c.id, c.name
HAVING COUNT(o.id) > 3;
-- WHERE applies to individual rows pre-aggregate; HAVING applies to groups post-aggregate.
