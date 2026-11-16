/* Day 7 - Set 1: Logistics Shipment Analysis (MySQL 8.4)
   Assumed: hubs(id,name), carriers(id,name), customers(id,name),
   employees(id,name,supervisor_id,hub_id), shipments(id,customer_id,carrier_id,origin_hub_id,dest_hub_id,ship_date,delivery_date,cost,status),
   delivery_events(id,shipment_id,event_time,status)
*/

-- Q1 (INNER JOIN): Shipments delayed by more than two days with carrier names
SELECT s.id, c.name AS carrier, s.ship_date, s.delivery_date,
       DATEDIFF(s.delivery_date, s.ship_date) AS transit_days
FROM shipments s INNER JOIN carriers c ON c.id = s.carrier_id
WHERE DATEDIFF(s.delivery_date, s.ship_date) > 2;

-- Q2 (LEFT JOIN): Hubs with no outbound shipments
SELECT h.id, h.name
FROM hubs h LEFT JOIN shipments s ON s.origin_hub_id = h.id
WHERE s.id IS NULL;

-- Q3 (SELF JOIN): Employees with their supervisors
SELECT e.id, e.name AS employee, m.name AS supervisor
FROM employees e LEFT JOIN employees m ON e.supervisor_id = m.id;

-- Q4 (INNER JOIN): Delivered shipments with origin and destination hub names
SELECT s.id, ho.name AS origin_hub, hd.name AS dest_hub, s.status
FROM shipments s
JOIN hubs ho ON ho.id = s.origin_hub_id
JOIN hubs hd ON hd.id = s.dest_hub_id
WHERE s.status = 'DELIVERED';

-- Q5 (LEFT JOIN): Carriers and their shipment counts (including carriers with none)
SELECT c.id, c.name, COUNT(s.id) AS shipment_count
FROM carriers c LEFT JOIN shipments s ON s.carrier_id = c.id
GROUP BY c.id, c.name;

-- Q6 (INNER JOIN): Customers and total shipping cost
SELECT cu.id, cu.name, ROUND(SUM(s.cost),2) AS total_cost
FROM customers cu JOIN shipments s ON s.customer_id = cu.id
GROUP BY cu.id, cu.name;

-- Q7 (RIGHT JOIN): All shipments and any matching delivery event count
SELECT s.id AS shipment_id, COUNT(de.id) AS event_count
FROM delivery_events de RIGHT JOIN shipments s ON s.id = de.shipment_id
GROUP BY s.id;

-- Q8 (SELF/INNER JOIN): Shipments sharing the same origin and destination hubs
SELECT s1.id AS shipment_a, s2.id AS shipment_b, s1.origin_hub_id, s1.dest_hub_id
FROM shipments s1 JOIN shipments s2
  ON s1.origin_hub_id = s2.origin_hub_id AND s1.dest_hub_id = s2.dest_hub_id AND s1.id < s2.id;

-- Q9 (INNER JOIN): Latest delivery event per shipment
SELECT s.id, de.status, de.event_time
FROM shipments s JOIN delivery_events de ON de.shipment_id = s.id
WHERE de.event_time = (SELECT MAX(de2.event_time) FROM delivery_events de2 WHERE de2.shipment_id = s.id);

-- Q10 (LEFT JOIN): Customers with no shipments
SELECT cu.id, cu.name
FROM customers cu LEFT JOIN shipments s ON s.customer_id = cu.id
WHERE s.id IS NULL;

-- Subqueries (IN, EXISTS, ANY, ALL)
-- Carriers whose average delay is above the overall average (uncorrelated/nested aggregate)
SELECT c.id, c.name
FROM carriers c
WHERE c.id IN (
  SELECT s.carrier_id FROM shipments s
  GROUP BY s.carrier_id
  HAVING AVG(DATEDIFF(s.delivery_date, s.ship_date)) >
         (SELECT AVG(DATEDIFF(delivery_date, ship_date)) FROM shipments)
);

-- Customers who shipped to every hub (division via NOT EXISTS / double NOT EXISTS)
SELECT cu.id, cu.name
FROM customers cu
WHERE NOT EXISTS (
  SELECT 1 FROM hubs h
  WHERE NOT EXISTS (
    SELECT 1 FROM shipments s
    WHERE s.customer_id = cu.id AND s.dest_hub_id = h.id
  )
);

-- ANY: carriers with any shipment cost greater than 5000
SELECT DISTINCT c.id, c.name FROM carriers c
WHERE c.id = ANY (SELECT carrier_id FROM shipments WHERE cost > 5000);

-- ALL: shipments whose cost is >= ALL costs for that carrier's shipments from a given hub (example)
SELECT s.id, s.cost FROM shipments s
WHERE s.cost >= ALL (SELECT s2.cost FROM shipments s2 WHERE s2.carrier_id = s.carrier_id);

-- Rewrite two subqueries as joins
-- (A) Subquery: customers with shipments -> JOIN
-- Subquery form: SELECT * FROM customers WHERE id IN (SELECT customer_id FROM shipments);
SELECT DISTINCT cu.id, cu.name
FROM customers cu JOIN shipments s ON s.customer_id = cu.id;
-- (B) Subquery: carriers above overall avg delay -> JOIN on aggregated derived tables
SELECT a.carrier_id, c.name
FROM (SELECT carrier_id, AVG(DATEDIFF(delivery_date,ship_date)) AS avg_delay FROM shipments GROUP BY carrier_id) a
JOIN (SELECT AVG(DATEDIFF(delivery_date,ship_date)) AS overall_avg FROM shipments) o
JOIN carriers c ON c.id = a.carrier_id
WHERE a.avg_delay > o.overall_avg;

-- Nested subquery: second-highest shipping cost per hub (origin)
SELECT h.id AS hub_id, h.name,
  (SELECT MAX(s.cost) FROM shipments s
    WHERE s.origin_hub_id = h.id
      AND s.cost < (SELECT MAX(s2.cost) FROM shipments s2 WHERE s2.origin_hub_id = h.id)
  ) AS second_highest_cost
FROM hubs h;
