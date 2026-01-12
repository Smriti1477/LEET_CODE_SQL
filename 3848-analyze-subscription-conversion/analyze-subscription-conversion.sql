# Write your MySQL query statement below
SELECT
user_id ,
ROUND(AVG(CASE WHEN activity_type ='free_trial' THEN activity_duration ELSE NULL END),2) AS trial_avg_duration,
ROUND(AVG(CASE WHEN activity_type = 'paid' THEN activity_duration ELSE NULL END),2) AS paid_avg_duration
FROM UserActivity
WHERE user_id IN (
SELECT user_id 
FROM UserActivity
GROUP BY user_id
HAVING COUNT(CASE WHEN activity_type = 'free_trial' THEN 1 END)>0
AND COUNT(CASE WHEN activity_type = 'paid' THEN 1 END)>0
)
group by user_id
order by user_id