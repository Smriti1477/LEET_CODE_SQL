# Write your MySQL query statement below
with rank_t as(select
pr.employee_id, e.name, pr.rating,
rank() over(partition by pr.employee_id order by pr.review_date desc) as rn
from performance_reviews pr 
join employees e on pr.employee_id = e.employee_id
),
rank_classification as(
select
employee_id,
name,
max(case when rn = 1 then rating end) as latest_rating,
max(case when rn = 2 then rating end) as middle_rating,
max(case when rn = 3 then rating end) as initial_rating
from rank_t
group by employee_id, name)

select 
employee_id,
name,
latest_rating - initial_rating as improvement_score
from rank_classification
where latest_rating is not null 
and middle_rating is not null
and initial_rating is not null
and latest_rating > middle_rating
and middle_rating > initial_rating
order by improvement_score desc, name 




