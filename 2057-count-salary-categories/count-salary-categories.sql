# Write your MySQL query statement below
select "High Salary" as category ,
count(*) as accounts_count
from Accounts
where income > 50000
union all
select "Low Salary" as category ,  
count(*) as accounts_count
from Accounts
where income < 20000
union all
select "Average Salary" as category ,
count(*) as accounts_count
from Accounts
where income between 20000 and 50000
