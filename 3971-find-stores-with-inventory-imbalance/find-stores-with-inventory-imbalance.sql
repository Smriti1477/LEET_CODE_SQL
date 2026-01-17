# Write your MySQL query statement below
WITH a AS (
    SELECT store_id
    FROM inventory
    GROUP BY store_id
    HAVING COUNT(*) > 2
), 
b AS (
    SELECT 
        inventory.*, 
        RANK() OVER (PARTITION BY a.store_id ORDER BY price DESC) AS rk1,
        RANK() OVER (PARTITION BY a.store_id ORDER BY price ASC) AS rk2
    FROM inventory
    JOIN a ON a.store_id = inventory.store_id
)
SELECT 
    b.store_id, 
    c.store_name, 
    c.location,
    MAX(CASE WHEN rk1 = 1 THEN product_name END) AS most_exp_product,
    MAX(CASE WHEN rk2 = 1 THEN product_name END) AS cheapest_product,
    ROUND(
        MAX(CASE WHEN rk2 = 1 THEN quantity END) / 
        MAX(CASE WHEN rk1 = 1 THEN quantity END), 2
    ) AS imbalance_ratio
FROM b
JOIN stores c ON c.store_id = b.store_id
GROUP BY b.store_id, c.store_name, c.location
HAVING imbalance_ratio > 1
ORDER BY imbalance_ratio DESC, store_name ASC;