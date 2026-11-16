/* Day 6 - Set 3: Telecom Usage and Billing (MySQL 8.4)
   Assumed: subscribers(id,name,circle,plan_id), plans(id,name,data_limit_gb,monthly_fee),
   call_records(id,subscriber_id,call_date,minutes,data_used_gb),
   invoices(id,subscriber_id,invoice_date,due_date,amount,status)
*/

-- Q1: Total call minutes per plan
SELECT p.name AS plan_name, SUM(cr.minutes) AS total_minutes
FROM call_records cr
JOIN subscribers s ON s.id = cr.subscriber_id
JOIN plans p ON p.id = s.plan_id
GROUP BY p.id, p.name
ORDER BY total_minutes DESC;

-- Q2: Subscribers exceeding their data limit
SELECT s.id, s.name, p.name AS plan_name, p.data_limit_gb,
       ROUND(SUM(cr.data_used_gb),2) AS total_data_used_gb
FROM subscribers s
JOIN plans p ON p.id = s.plan_id
JOIN call_records cr ON cr.subscriber_id = s.id
GROUP BY s.id, s.name, p.name, p.data_limit_gb
HAVING SUM(cr.data_used_gb) > p.data_limit_gb;

-- Q3: Month-wise revenue
SELECT DATE_FORMAT(i.invoice_date,'%Y-%m') AS month, ROUND(SUM(i.amount),2) AS revenue
FROM invoices i
GROUP BY DATE_FORMAT(i.invoice_date,'%Y-%m')
ORDER BY month;

-- Q4: Invoices overdue by more than 15 days (formatted invoice no, due-date status)
SELECT CONCAT('INV-', LPAD(i.id,6,'0')) AS invoice_no,
       s.name AS subscriber,
       DATE_FORMAT(i.due_date,'%d-%b-%Y') AS due_date_fmt,
       DATEDIFF(CURDATE(), i.due_date) AS days_overdue,
       CASE WHEN DATEDIFF(CURDATE(), i.due_date) > 15 THEN 'OVERDUE>15'
            WHEN DATEDIFF(CURDATE(), i.due_date) > 0 THEN 'OVERDUE'
            ELSE 'CURRENT' END AS due_status,
       i.amount, i.status
FROM invoices i JOIN subscribers s ON s.id = i.subscriber_id
WHERE i.status <> 'PAID' AND DATEDIFF(CURDATE(), i.due_date) > 15;

-- Q5: Subscribers with no usage (LEFT JOIN)
SELECT s.id, s.name, s.circle
FROM subscribers s LEFT JOIN call_records cr ON s.id = cr.subscriber_id
WHERE cr.id IS NULL;

-- Q6: ARPU by circle
SELECT s.circle,
       ROUND(SUM(i.amount) / COUNT(DISTINCT s.id),2) AS arpu
FROM subscribers s JOIN invoices i ON i.subscriber_id = s.id
GROUP BY s.circle
ORDER BY arpu DESC;

-- Q7: Plan popularity
SELECT p.name AS plan_name, COUNT(s.id) AS subscriber_count
FROM plans p LEFT JOIN subscribers s ON s.plan_id = p.id
GROUP BY p.id, p.name
ORDER BY subscriber_count DESC;

-- Q8: Top-10 data consumers
SELECT s.id, s.name, ROUND(SUM(cr.data_used_gb),2) AS total_data_gb
FROM subscribers s JOIN call_records cr ON cr.subscriber_id = s.id
GROUP BY s.id, s.name
ORDER BY total_data_gb DESC
LIMIT 10;

-- Task 3: NULL effect on SUM/AVG and fix with IFNULL/COALESCE
-- subscribers with missing usage rows yield NULL from SUM/AVG when LEFT JOINed without usage
SELECT s.id, s.name,
       SUM(cr.data_used_gb) AS sum_null_demo,
       AVG(cr.minutes) AS avg_null_demo,
       IFNULL(SUM(cr.data_used_gb),0) AS sum_fixed,
       COALESCE(AVG(cr.minutes),0) AS avg_fixed
FROM subscribers s LEFT JOIN call_records cr ON s.id = cr.subscriber_id
GROUP BY s.id, s.name;

-- Task 4: Join with GROUP BY and aggregate - revenue per plan and circle
SELECT p.name AS plan_name, s.circle,
       ROUND(SUM(i.amount),2) AS revenue,
       COUNT(DISTINCT s.id) AS subscribers
FROM invoices i
JOIN subscribers s ON s.id = i.subscriber_id
JOIN plans p ON p.id = s.plan_id
GROUP BY p.name, s.circle
ORDER BY p.name, revenue DESC;
