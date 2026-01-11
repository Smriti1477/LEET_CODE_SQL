# Write your MySQL query statement below
# Write your MySQL query statement below
WITH ranked_scores AS (
  SELECT 
    student_id,
    subject,
    score,
    exam_date,
    ROW_NUMBER() OVER (PARTITION BY student_id, subject ORDER BY exam_date ASC) AS rn_first,
    ROW_NUMBER() OVER (PARTITION BY student_id, subject ORDER BY exam_date DESC) AS rn_last
  FROM Scores
)

SELECT 
  s1.student_id,
  s1.subject,
  s1.score AS first_score,
  s2.score AS latest_score
FROM ranked_scores s1
JOIN ranked_scores s2 
  ON s1.student_id = s2.student_id 
  AND s1.subject = s2.subject
WHERE s1.rn_first = 1
  AND s2.rn_last = 1
  AND s2.score > s1.score
ORDER BY s1.student_id, s1.subject;




