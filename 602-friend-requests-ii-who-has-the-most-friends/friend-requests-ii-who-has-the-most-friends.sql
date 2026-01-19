# Write your MySQL query statement below
 SELECT
        id,
        SUM(num) AS num
    FROM (
        SELECT accepter_id AS id, COUNT(*) AS num
        FROM RequestAccepted
        GROUP BY accepter_id

        UNION ALL

        SELECT requester_id AS id, COUNT(*) AS num
        FROM RequestAccepted
        GROUP BY requester_id
    ) t
    group by id
    order by num desc
    limit 1;