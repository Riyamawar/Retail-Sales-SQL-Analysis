CREATE DATABASE retail_sales_db;
USE retail_sales_db;
SELECT DATABASE();

SHOW TABLES;

SELECT *
FROM retail_sales_dataset
LIMIT 10;

-- DATABASE EXPLORATION -- 

-- Total Number Of Records--  
SELECT COUNT(*) AS total_records
FROM retail_sales_dataset;                  

-- Table Structure-- 
DESCRIBE retail_sales_dataset;                 

 -- Date Range--
 SELECT
 MIN(Date) AS first_date,
 MAX(Date) AS last_date
 FROM retail_sales_dataset;
 
 -- Unique Product Category--
 SELECT DISTINCT `Product Category`
FROM retail_sales_dataset;

-- Total Customers--
  SELECT COUNT(DISTINCT `Customer ID`) AS total_customers
FROM retail_sales_dataset;                                         

-- DATA CLEANING --

SELECT *
FROM retail_sales_dataset
WHERE
`Transaction ID` IS NULL
OR Date IS NULL
OR `Customer ID` IS NULL
OR Gender IS NULL
OR Age IS NULL
OR `Product Category` IS NULL
OR Quantity IS NULL
OR `Price per Unit` IS NULL
OR `Total Amount` IS NULL;        

-- Check Duplicate Transaction IDs -- 
SELECT `Transaction ID`, COUNT(*) AS duplicate_count
FROM retail_sales_dataset
GROUP BY `Transaction ID`
HAVING COUNT(*) > 1;                                          

-- Invalid Ages --
SELECT *
FROM retail_sales_dataset
WHERE Age <= 0;                                                             

-- Invalid Quantity --
SELECT *
FROM retail_sales_dataset
WHERE Quantity <= 0;                                                         

-- Invalid Price --
SELECT *
FROM retail_sales_dataset
WHERE `Price per Unit` <= 0; 

-- Invalid Total Amount --
SELECT *
FROM retail_sales_dataset
WHERE `Total Amount` <= 0;

-- NORMAL QUERY--  

-- Display All Records --
SELECT * 
FROM retail_sales_dataset; 

-- Transactions with Total Amount Greater Than 500 --
SELECT *
FROM retail_sales_dataset
WHERE `Total Amount`> 500;

-- Transactions from the Beauty Category --
SELECT *
FROM retail_sales_dataset
WHERE `Product Category`= 'Beauty';

-- Female Customers --
SELECT *
FROM retail_sales_dataset
WHERE `Gender`= 'Female';

-- Top 5 Highest Transactions --
SELECT *
FROM retail_sales_dataset
ORDER BY `Total Amount` DESC
LIMIT 5;

-- AGGREGATION & GROUP BY --

-- Total Revenue --
SELECT SUM(`Total Amount`) AS Total_revenue
FROM retail_sales_dataset; 

-- Average Transaction Amount --
SELECT AVG(`Total Amount`) AS Average_Transaction
FROM retail_sales_dataset; 

-- Total Sales by Product Category --
SELECT `Product Category`,
       SUM(`Total Amount`) AS Total_Sales
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY Total_Sales DESC;

-- Number of Transactions by Gender -- 
SELECT Gender,
       COUNT(*) AS Total_Transactions
FROM retail_sales_dataset
GROUP BY Gender;

-- ADVANCED FILTERS --
  
-- Customers Aged Between 25 and 35 --
SELECT *
FROM retail_sales_dataset
WHERE Age BETWEEN 25 AND 35;
  
--  Electronics Transactions Above ₹1000 -- 
SELECT *
FROM retail_sales_dataset
WHERE `Product Category` = 'Electronics'
AND `Total Amount` > 1000;

-- Beauty or Clothing Transactions --  
SELECT *
FROM retail_sales_dataset
WHERE `Product Category` IN ('Beauty', 'Clothing');

-- Female Customers Above Age 30 --
SELECT *
FROM retail_sales_dataset
WHERE Gender = 'Female'
AND Age > 30;  

-- SUBQUERIES -- 

 -- Transactions Above the Average Transaction Amount -- 
SELECT *
FROM retail_sales_dataset
WHERE `Total Amount` >
(
    SELECT AVG(`Total Amount`)
    FROM retail_sales_dataset
);

-- Customer Who Spent the Highest Total Amount -- 
SELECT `Customer ID`,
       SUM(`Total Amount`) AS Total_Spent
FROM retail_sales_dataset
GROUP BY `Customer ID`
HAVING SUM(`Total Amount`) =
(
    SELECT MAX(total_spent)
    FROM
    (
        SELECT `Customer ID`,
               SUM(`Total Amount`) AS total_spent
        FROM retail_sales_dataset
        GROUP BY `Customer ID`
    ) AS customer_sales
);