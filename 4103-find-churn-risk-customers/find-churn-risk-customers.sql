# Write your MySQL query statement below
with cte as (
select *,
row_number() over(partition by user_id order by event_date desc ) as rk
from subscription_events
),
cte2 as (
select user_id,
max(case when rk = 1 then plan_name else null end) as current_plan,
sum(case when rk = 1 then monthly_amount else 0 end) as  current_monthly_amount, max(monthly_amount) as max_historical_amount,
datediff(max(event_date),min(event_date)) as days_as_subscriber
from cte
group by user_id)
select* 
from cte2
where current_plan is not null
and current_monthly_amount < 0.5 * max_historical_amount 
and days_as_subscriber >= 60
order by days_as_subscriber desc, user_id;
