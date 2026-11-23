USE day9_telecom_followup;

-- V1: only prepaid rows; phone and email are hidden.
CREATE OR REPLACE VIEW vw_prepaid_subscribers AS
SELECT s.id AS subscriber_id,
       s.subscriber_no,
       s.full_name,
       pl.name AS plan_name,
       pl.validity_days,
       s.balance,
       s.last_recharge_date,
       s.status
FROM subscribers s
JOIN plans pl ON pl.id = s.plan_id
WHERE s.connection_type = 'PREPAID';

-- V2: aggregate recharge behaviour per subscriber.
CREATE OR REPLACE VIEW vw_recharge_summary AS
SELECT s.id AS subscriber_id,
       s.subscriber_no,
       COUNT(r.id) AS recharge_count,
       COALESCE(SUM(r.amount), 0.00) AS total_recharged,
       MAX(r.recharge_date) AS last_recharge_time
FROM subscribers s
LEFT JOIN recharges r ON r.subscriber_id = s.id
GROUP BY s.id, s.subscriber_no;

SELECT * FROM vw_prepaid_subscribers ORDER BY subscriber_id;
SELECT * FROM vw_recharge_summary ORDER BY subscriber_id;
