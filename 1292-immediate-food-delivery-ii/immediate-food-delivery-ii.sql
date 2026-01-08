# Write your MySQL query statement below
select ROUND(SUM(IF(order_date = customer_pref_delivery_date, 1 ,0))*100/count(DISTINCT customer_id), 2) AS immediate_percentage
from Delivery 
where (customer_id, order_date) IN(
SELECT customer_id, min(order_date) as first_order_date
FROM Delivery
group by customer_id)