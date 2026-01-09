# Write your MySQL query statement below
with cte as(
SELECT person_name,
SUM(weight) OVER(ORDER BY turn ) as total_weight
from Queue
)
select person_name
from cte
where total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1;