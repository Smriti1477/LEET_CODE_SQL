# Write your MySQL query statement below
WITH CTE AS (
SELECT DISTINCT visited_on,
SUM(amount) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS amount,
ROUND(SUM(amount) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW)/7,2) AS average_amount
FROM Customer
)
SELECT visited_on, amount, average_amount
FROM CTE
WHERE DATEDIFF(visited_on, (SELECT MIN(visited_on) FROM Customer)) >= 6