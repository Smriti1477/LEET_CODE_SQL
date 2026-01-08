# Write your MySQL query statement below
SELECT
LEFT(trans_date, 7) AS month,
country,
COUNT(id) as trans_count,
sum(case when state ='approved' then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state ='approved' then amount else 0 end) as approved_total_amount
FROM Transactions
group by month, country