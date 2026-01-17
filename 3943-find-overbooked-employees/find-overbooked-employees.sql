# Write your MySQL query statement below
with cte as (
select employee_id , week(meeting_date, 1) as week_monday, sum(duration_hours) as total_hours,
case when sum(duration_hours)/40 > 0.5 then "Y" else "N" END AS  meeting_heavy
from meetings
group by employee_id, week(meeting_date, 1)
)
select c.employee_id, e.employee_name, e.department, count(*) as meeting_heavy_weeks
from cte c
left join employees e on c.employee_id = e.employee_id
where meeting_heavy = 'y'
group by c.employee_id, e.employee_name 
having count(*) > 1
order by meeting_heavy_weeks desc, e.employee_name