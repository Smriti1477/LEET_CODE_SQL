# Write your MySQL query statement below
WITH cte AS (
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders,
        SUM(
            CASE 
                WHEN (EXTRACT(HOUR FROM order_timestamp) >= 11 AND EXTRACT(HOUR FROM order_timestamp) < 14)
                  OR (EXTRACT(HOUR FROM order_timestamp) >= 18 AND EXTRACT(HOUR FROM order_timestamp) < 21)
                THEN 1 ELSE 0
            END
        ) AS peak_order
    FROM restaurant_orders
    GROUP BY customer_id
    HAVING COUNT(order_id) >= 3
),
cte1 AS (
    SELECT
        customer_id,
        COUNT(order_rating) AS rated_orders,              -- only counts NOT NULL ratings
        ROUND(AVG(order_rating),2) AS average_rating
    FROM restaurant_orders
    WHERE order_rating IS NOT NULL
    GROUP BY customer_id
)
SELECT 
    c.customer_id,
    c.total_orders,
    ceiling(c.peak_order * 100.0 / c.total_orders) AS peak_hour_percentage,
    c1.average_rating
FROM cte c
JOIN cte1 c1 ON c1.customer_id = c.customer_id
WHERE (c1.rated_orders * 100.0 / c.total_orders) >= 50   -- rated >= 50% condition
HAVING peak_hour_percentage >= 60
   AND average_rating >= 4.0
ORDER BY average_rating DESC, customer_id DESC;


