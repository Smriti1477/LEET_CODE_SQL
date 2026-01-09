# Write your MySQL query statement below
# Write your MySQL query statement below

with highest_user_rated as(
    select u.name from Movierating m
    left join users u
    on m.user_id = u.user_id
    group by m.user_id,u.name
    order by count(m.user_id) desc, u.name asc
    limit 1
),

highest_avg_rated as(
    select m1.title from movies m1
    right join movierating m
    on m1.movie_id = m.movie_id
    where m.created_at >='2020-02-01' and m.created_at < '2020-03-01'
    group by m1.title
    order by avg(m.rating) desc,title asc
    limit 1
),

output as(
    select * from highest_user_rated
    union all
    select * from highest_avg_rated
)
select name as results from output




    