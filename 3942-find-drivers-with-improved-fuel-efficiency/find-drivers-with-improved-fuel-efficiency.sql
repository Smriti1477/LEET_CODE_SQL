# Write your MySQL query statement below
WITH first_half AS(
    SELECT driver_id, AVG(distance_km/fuel_consumed) AS first_half_avg
    FROM trips
    WHERE MONTH(trip_date) BETWEEN 1 AND 6
    GROUP BY driver_id),
second_half AS(
    SELECT driver_id, AVG(distance_km/fuel_consumed) AS second_half_avg
    FROM trips
    WHERE MONTH(trip_date) BETWEEN 7 AND 12
    GROUP BY driver_id
)

SELECT d.driver_id, 
    driver_name, 
    ROUND(first_half_avg,2) AS first_half_avg, 
    ROUND(second_half_avg,2) AS second_half_avg, 
    ROUND(second_half_avg-first_half_avg,2) AS efficiency_improvement 
FROM drivers d
JOIN first_half f ON d.driver_id = f.driver_id
JOIN second_half s ON d.driver_id = s.driver_id
HAVING efficiency_improvement>0
ORDER BY efficiency_improvement DESC, driver_name