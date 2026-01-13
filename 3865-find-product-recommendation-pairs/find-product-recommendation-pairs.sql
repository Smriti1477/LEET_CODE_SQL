# Write your MySQL query statement below
SELECT p1.product_id as product1_id, p2.product_id as product2_id,
pi1.category as product1_category,
pi2.category as product2_category,
COUNT(p1.user_id) AS customer_count
FROM ProductPurchases p1
inner join ProductPurchases p2 on p1.user_id = p2.user_id and p1.product_id < p2.product_id
left join ProductInfo pi1 on p1.product_id = pi1.product_id
left join ProductInfo pi2 on p2.product_id = pi2.product_id
group by product1_id, product2_id
having count(p1.user_id) >= 3
ORDER BY customer_count DESC,product1_id,product2_id


