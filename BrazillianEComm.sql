USE bike_store;
-- Identified customers who have made the most purchases and calculated their lifetime value
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
-- Evaluate the performance of staff by calculating the average order processing time (time taken to ship an order) for each staff member
SELECT s.staff_id,CONCAT(s.first_name,' ',s.last_name) AS staff_name,AVG(DATEDIFF(o.shipped_date,o.order_date)) AS Avg_Processing_time
FROM staffs s JOIN orders o ON o.staff_id=s.staff_id
GROUP BY s.staff_id
ORDER BY Avg_Processing_time ASC;
-- Analyze the seasonality of sales by calculating the monthly revenue and comparing it year-over-year
SELECT EXTRACT(MONTH FROM o.order_date) AS month,
EXTRACT(YEAR FROM o.order_date) AS year,
ROUND(SUM(p.list_price-(p.list_price*i.discount)),2) AS Monthly_Revenue
FROM orders o
JOIN order_items i ON o.order_id=i.order_id
JOIN products p ON p.product_id=i.product_id
GROUP BY month,year
ORDER BY year;
-- Determine the inventory turnover rate for each product category to optimize stock levels.
SELECT c.category_name,COUNT(DISTINCT s.product_id) AS distinct_products,SUM(s.quantity) AS total_quantity_sold,
SUM(s.quantity) / COUNT(DISTINCT s.product_id) AS turnover_rate
FROM stocks s
JOIN products p ON s.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY turnover_rate DESC;
-- Determine the inventory turnover rate for each product category to optimize stock levels.
SELECT c.category_name,COUNT(DISTINCT s.product_id) AS distinct_products,SUM(s.quantity) AS total_quantity_sold,
    SUM(s.quantity) / COUNT(DISTINCT s.product_id) AS turnover_rate
FROM stocks s
JOIN products p ON s.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY turnover_rate DESC;






