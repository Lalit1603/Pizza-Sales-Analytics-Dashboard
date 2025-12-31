SELECT * FROM pizza_sales;

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

-- Average Order Value
SELECT CAST(SUM(total_price) / COUNT (DISTINCT order_id) 
AS Avg_Order_Value
FROM  pizza_sales;

-- Total Pizza Sold
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales;

-- Total Order Placed
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;


-- Average Pizza Per Order
SELECT CAST(
CAST(SUM(quantity) AS DECIMAL(10,2))/ 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
AS DECIMAL(10,2))
AS Avg_Pizza_Per_Order
FROM pizza_sales;

-- Daily Trends for Order
SELECT DATENAME(DW, order_date) as order_day,
COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW,order_date);

-- Monthly Trends for Order
SELECT DATENAME(MONTH, order_date) AS Month_Name,
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC;

-- Percentage of Sales by Pizza Category
SELECT pizza_category,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,CAST(SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales )AS DECIMAL(10,2)) AS PCT_Total_Sales -- WHERE MONTH(order_date) = 3
FROM pizza_sales
-- WHERE MONTH(order_date) = 3
GROUP BY pizza_category

-- Percentage of Sales by Pizza Size
SELECT pizza_size,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,CAST( SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales ) AS DECIMAL(10,2)) AS PCT_Total_Sales 
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT_Total_Sales DESC

-- Quarter wise sales 
SELECT pizza_size,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,CAST( SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date) = 1) AS DECIMAL(10,2)) AS PCT_Total_Sales 
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT_Total_Sales DESC

-- Total Pizzas Sold by Pizza Category
SELECT pizza_category,
SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_pizzas_sold DESC;


-- Top 5 best seller
SELECT TOP 5 pizza_name,
SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

-- Bottom 5 best seller
SELECT TOP 5 pizza_name,
CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

