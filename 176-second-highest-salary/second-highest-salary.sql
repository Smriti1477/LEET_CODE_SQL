# Write your MySQL query statement below
select max(case when rn = 2 then salary else Null end) as SecondHighestSalary
from (
select salary 
, dense_rank() over(order by salary  desc) as rn
from Employee) a