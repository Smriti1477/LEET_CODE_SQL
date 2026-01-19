# Write your MySQL query statement below
with uniq_latlong as (
    select lat,lon
    from insurance
    group by lat,lon
    having count(*)=1
),
same_tiv15 as (
    select tiv_2015
    from insurance 
    group by 1
    having count(*)>1
)

select round(sum(a.tiv_2016),2) as tiv_2016
from insurance a
where (lat,lon) in (select lat,lon from uniq_latlong)
and tiv_2015 in (select tiv_2015 from same_tiv15);