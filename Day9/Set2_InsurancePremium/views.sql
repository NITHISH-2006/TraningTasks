USE day9_insurance_premium;

-- Due within 30 days; phone and PAN are intentionally excluded.
CREATE OR REPLACE VIEW vw_policy_due AS
SELECT p.id AS policy_id,
       p.policy_no,
       c.name AS customer_name,
       c.email AS customer_email,
       p.policy_type,
       p.end_date,
       DATEDIFF(p.end_date, CURDATE()) AS days_to_due,
       p.premium_amount
FROM policies p
JOIN customers c ON c.id = p.customer_id
WHERE p.status = 'ACTIVE'
  AND p.end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

SELECT * FROM vw_policy_due ORDER BY end_date;
