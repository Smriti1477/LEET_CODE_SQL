# Write your MySQL query statement below
# Write your MySQL query statement below

(select u.name as results
from Users u
left join MovieRating mr on u.user_id =mr.user_id
group by mr.user_id, u.name
order by count(mr.user_id) desc, u.name
limit 1)
union all
(select m.title as results
from Movies m
left join MovieRating mr on m.movie_id = mr.movie_id
where extract(year_month from created_at ) = 202002
group by mr.movie_id,m.title 
order by avg(mr.rating) desc, m.title
limit 1)




    