USE day8_retail_reservation;

-- Q2: Correlated subquery - products below the average stock of their own category.
SELECT c.name AS category,
       p.id,
       p.name AS product,
       p.qty_in_stock,
       ROUND((
           SELECT AVG(p2.qty_in_stock)
           FROM products p2
           WHERE p2.category_id = p.category_id
       ), 2) AS category_avg_stock
FROM products p
JOIN categories c ON c.id = p.category_id
WHERE p.qty_in_stock < (
    SELECT AVG(p2.qty_in_stock)
    FROM products p2
    WHERE p2.category_id = p.category_id
)
ORDER BY c.name, p.qty_in_stock;

-- Q3: CTE ranking products by sales within each category; return the top three per category.
WITH product_sales AS (
    SELECT p.id AS product_id,
           p.name AS product,
           p.category_id,
           SUM(ms.revenue) AS total_revenue,
           SUM(ms.units_sold) AS total_units
    FROM monthly_sales ms
    JOIN products p ON p.id = ms.product_id
    GROUP BY p.id, p.name, p.category_id
),
ranked_sales AS (
    SELECT ps.*,
           ROW_NUMBER() OVER (PARTITION BY ps.category_id ORDER BY ps.total_revenue DESC) AS sales_rank
    FROM product_sales ps
)
SELECT c.name AS category,
       r.sales_rank,
       r.product,
       r.total_units,
       r.total_revenue
FROM ranked_sales r
JOIN categories c ON c.id = r.category_id
WHERE r.sales_rank <= 3
ORDER BY c.name, r.sales_rank;

-- Q4: LEAD and LAG show month-on-month revenue movement for every product.
WITH monthly_totals AS (
    SELECT product_id, sales_month, SUM(revenue) AS revenue
    FROM monthly_sales
    GROUP BY product_id, sales_month
),
with_neighbours AS (
    SELECT product_id,
           sales_month,
           revenue,
           LAG(revenue) OVER w AS previous_month_revenue,
           LEAD(revenue) OVER w AS next_month_revenue
    FROM monthly_totals
    WINDOW w AS (PARTITION BY product_id ORDER BY sales_month)
)
SELECT p.name AS product,
       n.sales_month,
       n.revenue,
       n.previous_month_revenue,
       n.revenue - n.previous_month_revenue AS change_from_previous,
       n.next_month_revenue,
       n.next_month_revenue - n.revenue AS change_to_next
FROM with_neighbours n
JOIN products p ON p.id = n.product_id
ORDER BY p.name, n.sales_month;
