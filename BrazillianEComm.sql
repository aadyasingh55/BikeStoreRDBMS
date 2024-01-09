SELECT o.customer_id, c.first_name,c.last_name,
COUNT(o.order_id) AS tot_orders,
ROUND(SUM(i.list_price - (i.list_price*i.discount)),2) AS Lifetime_val,
ROUND(ROUND(SUM(i.list_price - (i.list_price*i.discount)),2)/COUNT(o.order_id),2) AS Avg_order_val
FROM orders o
JOIN order_items i ON o.order_id = i.order_id
JOIN customers c ON c.customer_id = o.customer_id 
JOIN products p ON p.product_id = i.product_id
GROUP BY o.customer_id
ORDER BY Lifetime_val DESC
LIMIT 10;
SELECT s.staff_id,CONCAT(s.first_name,' ',s.last_name) AS staff_name,AVG(DATEDIFF(o.shipped_date,o.order_date)) AS Avg_Processing_time
FROM staffs s JOIN orders o ON o.staff_id=s.staff_id
GROUP BY s.staff_id
ORDER BY Avg_Processing_time ASC;
SELECT EXTRACT(MONTH FROM o.order_date) AS month,
EXTRACT(YEAR FROM o.order_date) AS year,
ROUND(SUM(p.list_price-(p.list_price*i.discount)),2) AS Monthly_Revenue
FROM orders o
JOIN order_items i ON o.order_id=i.order_id
JOIN products p ON p.product_id=i.product_id
GROUP BY month,year
ORDER BY year;





