CREATE DATABASE Amazone_Sale_Report

USE Amazone_Sale_Report


DROP TABLE IF EXISTS sales_data;
CREATE TABLE sales_data (
	index_no INT,
    Order_ID VARCHAR(200),
    Order_Date DATE,
	Category VARCHAR(255),
	Qty INT,
	Amount DECIMAL(18, 2),
    ship_state VARCHAR(100),
    Ship_zip_code INT,
	Customer_ID VARCHAR(100)
);

BULK INSERT sales_data
FROM 'C:\Users\SURJIT PATIL\OneDrive\Desktop\Elevate Lab\Day 6th Task\Amazon Sale Report.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n' ,
	TABLOCK
);


SELECT * 
FROM sales_data;


SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month
FROM sales_data;



-- Grouped by Year and Month with Revenue Calculation
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(Amount) AS total_revenue
FROM sales_data
GROUP BY 
    YEAR(order_date), MONTH(order_date);



-- Total Revenue and Orders by Category
 SELECT 
    category,
    SUM(Amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_data
GROUP BY category
ORDER BY total_revenue DESC;



-- Monthly Revenue by Category
SELECT 
    category,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(Amount) AS total_revenue
FROM sales_data
GROUP BY category, YEAR(order_date), MONTH(order_date)
ORDER BY category, order_year, order_month;


--Revenue by ZIP Code
SELECT 
    Ship_zip_code AS zip_code,
    SUM(Amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_data
GROUP BY Ship_zip_code
ORDER BY total_revenue DESC;



--Category + ZIP Code Combo Analysis
SELECT 
    category,
    Ship_zip_code AS zip_code,
    SUM(Amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_data
GROUP BY category, Ship_zip_code
ORDER BY category, total_revenue DESC;



--Add Volume Using COUNT(DISTINCT order_id)
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(Amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_data
GROUP BY 
    YEAR(order_date), MONTH(order_date);


	--Order the Results
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(Amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_data
GROUP BY 
    YEAR(order_date), MONTH(order_date)
ORDER BY 
    order_year, order_month;


--Limit Results for a Specific Time Period
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(Amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_data
WHERE order_date BETWEEN '2022-04-01' AND '2022-10-31'
GROUP BY 
    YEAR(order_date), MONTH(order_date)
ORDER BY 
    order_year, order_month;


