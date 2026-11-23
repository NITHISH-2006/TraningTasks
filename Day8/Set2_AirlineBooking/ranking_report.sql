USE day8_airline_booking;

-- Q3: RANK leaves gaps after ties; DENSE_RANK does not.
SELECT f.flight_no,
       p.full_name AS passenger,
       b.fare,
       RANK() OVER (PARTITION BY b.flight_id ORDER BY b.fare DESC) AS fare_rank,
       DENSE_RANK() OVER (PARTITION BY b.flight_id ORDER BY b.fare DESC) AS dense_fare_rank
FROM bookings b
JOIN flights f ON f.id = b.flight_id
JOIN passengers p ON p.id = b.passenger_id
WHERE b.status = 'CONFIRMED'
ORDER BY f.flight_no, fare_rank, b.id;

-- Q4: Rewritten as a CTE with a running total of revenue per flight.
WITH fare_ranked AS (
    SELECT b.id AS booking_id,
           b.flight_id,
           f.flight_no,
           b.fare,
           RANK() OVER (PARTITION BY b.flight_id ORDER BY b.fare DESC) AS fare_rank,
           DENSE_RANK() OVER (PARTITION BY b.flight_id ORDER BY b.fare DESC) AS dense_fare_rank
    FROM bookings b
    JOIN flights f ON f.id = b.flight_id
    WHERE b.status = 'CONFIRMED'
),
running_revenue AS (
    SELECT r.*,
           SUM(r.fare) OVER (
               PARTITION BY r.flight_id
               ORDER BY r.fare DESC, r.booking_id
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ) AS running_revenue
    FROM fare_ranked r
)
SELECT rr.flight_no,
       rr.booking_id,
       rr.fare,
       rr.fare_rank,
       rr.dense_fare_rank,
       rr.running_revenue
FROM running_revenue rr
ORDER BY rr.flight_no, rr.fare DESC, rr.booking_id;

-- Q5: Correlated subquery - passengers paying above their own flight's average fare.
SELECT b.id AS booking_id,
       f.flight_no,
       p.full_name AS passenger,
       b.fare,
       ROUND(avg_stats.avg_fare, 2) AS flight_avg_fare
FROM bookings b
JOIN flights f ON f.id = b.flight_id
JOIN passengers p ON p.id = b.passenger_id
JOIN (
    SELECT flight_id, AVG(fare) AS avg_fare
    FROM bookings WHERE status = 'CONFIRMED' GROUP BY flight_id
) avg_stats ON avg_stats.flight_id = b.flight_id
WHERE b.status = 'CONFIRMED'
  AND b.fare > (
      SELECT AVG(b2.fare)
      FROM bookings b2
      WHERE b2.flight_id = b.flight_id AND b2.status = 'CONFIRMED'
  )
ORDER BY f.flight_no, b.fare DESC;
