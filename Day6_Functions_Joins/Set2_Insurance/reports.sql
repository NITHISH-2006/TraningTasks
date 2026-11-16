/* Day 6 - Set 2: Insurance Policy Reporting (MySQL 8.4)
   Assumed: customers(id,name,dob,age), agents(id,name), products(id,name),
   policies(id,policy_no,customer_id,agent_id,product_id,premium,status,start_date,end_date),
   claims(id,policy_id,claim_amount,claim_date)
*/

-- Q1: Policies expiring in the next 30 days
SELECT p.id, CONCAT('****', SUBSTRING(p.policy_no, -4)) AS masked_policy,
       p.end_date, DATEDIFF(p.end_date, CURDATE()) AS days_to_expiry
FROM policies p
WHERE p.end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
  AND p.status = 'ACTIVE';

-- Q2: Premium per product
SELECT pr.name AS product_name, ROUND(SUM(p.premium),2) AS total_premium
FROM policies p JOIN products pr ON pr.id = p.product_id
GROUP BY pr.id, pr.name
ORDER BY total_premium DESC;

-- Q3: Customers with more than one active policy
SELECT c.id, c.name, COUNT(p.id) AS active_policies
FROM customers c JOIN policies p ON c.id = p.customer_id
WHERE p.status = 'ACTIVE'
GROUP BY c.id, c.name
HAVING COUNT(p.id) > 1;

-- Q4: Claim ratio per product
SELECT pr.name AS product_name,
       ROUND(SUM(p.premium),2) AS total_premium,
       ROUND(IFNULL(SUM(cl.claim_amount),0),2) AS total_claims,
       ROUND(100 * IFNULL(SUM(cl.claim_amount),0) / NULLIF(SUM(p.premium),0),2) AS claim_ratio_pct
FROM products pr
JOIN policies p ON pr.id = p.product_id
LEFT JOIN claims cl ON cl.policy_id = p.id
GROUP BY pr.id, pr.name;

-- Q5: Policies without claims (LEFT JOIN)
SELECT p.id, CONCAT('****', SUBSTRING(p.policy_no,-4)) AS masked_policy, pr.name AS product
FROM policies p
JOIN products pr ON pr.id = p.product_id
LEFT JOIN claims cl ON cl.policy_id = p.id
WHERE cl.id IS NULL;

-- Q6: Average premium by age band (CASE, DATE)
SELECT CASE
         WHEN TIMESTAMPDIFF(YEAR,c.dob,CURDATE()) < 25 THEN '<25'
         WHEN TIMESTAMPDIFF(YEAR,c.dob,CURDATE()) BETWEEN 25 AND 34 THEN '25-34'
         WHEN TIMESTAMPDIFF(YEAR,c.dob,CURDATE()) BETWEEN 35 AND 44 THEN '35-44'
         WHEN TIMESTAMPDIFF(YEAR,c.dob,CURDATE()) BETWEEN 45 AND 60 THEN '45-60'
         ELSE '60+' END AS age_band,
       ROUND(AVG(p.premium),2) AS avg_premium
FROM policies p JOIN customers c ON c.id = p.customer_id
GROUP BY age_band
ORDER BY age_band;

-- Q7: Monthly new policies
SELECT DATE_FORMAT(p.start_date,'%Y-%m') AS month, COUNT(*) AS new_policies
FROM policies p
GROUP BY DATE_FORMAT(p.start_date,'%Y-%m')
ORDER BY month;

-- Q8: Top-5 agents by premium
SELECT a.id, a.name, ROUND(SUM(p.premium),2) AS total_premium
FROM agents a JOIN policies p ON a.id = p.agent_id
GROUP BY a.id, a.name
ORDER BY total_premium DESC
LIMIT 5;

-- Task 3: Products whose claim ratio is above 60% (HAVING)
SELECT pr.name AS product_name,
       ROUND(100 * IFNULL(SUM(cl.claim_amount),0) / NULLIF(SUM(p.premium),0),2) AS claim_ratio_pct
FROM products pr
JOIN policies p ON pr.id = p.product_id
LEFT JOIN claims cl ON cl.policy_id = p.id
GROUP BY pr.id, pr.name
HAVING (100 * IFNULL(SUM(cl.claim_amount),0) / NULLIF(SUM(p.premium),0)) > 60;

-- Task 4 join choices (examples):
-- INNER JOIN policies-products/customers/agents: only existing related records needed for premium/age/agent reports.
-- LEFT JOIN policies-claims: include policies with no claims (Q4,Q5,ratio).
-- CROSS JOIN example (pairing for comparison/demo): products x regions grid
SELECT pr.name AS product, r.region
FROM products pr CROSS JOIN (SELECT DISTINCT 'North' AS region UNION SELECT 'South' UNION SELECT 'East' UNION SELECT 'West') r;
