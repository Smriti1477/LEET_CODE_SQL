# Write your MySQL query statement below
select stock_name,
sum(CASE WHEN operation = 'Sell' THEN price else 0 end) -
sum(CASE WHEN operation = 'Buy' THEN price else 0 end) as capital_gain_loss
from Stocks
group by stock_name