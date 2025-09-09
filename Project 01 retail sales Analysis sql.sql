-- Sql Retail Sales Analysis - p1 
CREATE DATABASE sql_project_p2;


-- Creating table 
DROP TABLE IF EXISTS retail_sales;
CREATE Table retail_sales
            (
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age	INT,
category VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

SELECT *FROM retail_sales;
SELECT Count(*) FROM  retail_sales

--Data cleaning
SELECT *FROM retail_sales
WHERE   
   transactions_id IS NULL
   OR
   sale_date IS NULL
   OR
   sale_time IS NULL
   OR 
   customer_id IS NULL
   OR 
   gender IS NULL
   OR
   age IS NULL
   OR
   category IS NULL
   OR
   quantiy IS NULL
   OR 
   price_per_unit IS NULL
   OR 
   cogs IS NULL
   OR 
   total_sale IS NULL

   DELETE FROM retail_sales
   WHERE
    transactions_id IS NULL
   OR
   sale_date IS NULL
   OR
   sale_time IS NULL
   OR 
   customer_id IS NULL
   OR 
   gender IS NULL
   OR
   age IS NULL
   OR
   category IS NULL
   OR
   quantiy IS NULL
   OR 
   price_per_unit IS NULL
   OR 
   cogs IS NULL
   OR 
   total_sale IS NULL

-- Data Exploration

-- How many sale we have
SELECT COUNT(*) total_sale FROM retail_sales 

--How many unique customers we have?

SELECT COUNT (DISTINCT customer_id) total_sale FROM retail_sales

--How many unique category we have?
SELECT DISTINCT category FROM retail_sales

--Q1.Write a SQL query to retreive  all colums for sales made on 2022-11-05

SELECT *
FROM retail_sales
WHERE sale_date='2022-11-05';

--Q2.Write a SQL query to retrieve all transaction where the category is 'Clotheing' and the quantity sold is more than or equal to 4 in the month of Nov-2022

SELECT *FROM  retail_sales
WHERE category = 'Clothing'
AND
TO_CHAR (sale_date, 'YYYY-MM')='2022-11'
AND 
quantiy>=4

--Q3 Write a SQL query to calculate the total sales (total_sale) for each category

SELECT 
 category,
 SUM (total_sale) as net_sale,
 COUNT(*) as total_orders
 FROM retail_sales
 GROUP BY 1

 --Q4 Write a SQL query to find the average age of the customers who purschase from the 'Beauty' category
 
 SELECT 
 ROUND(AVG(age),2)  as avg_age
 FROM retail_sales
 WHERE category='Beauty'

 --Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
 SELECT *FROM retail_sales
 WHERE total_sale>1000

 --Q6 Write a SQL query to find the total number of transaction (transaction_id) made by each gender in each category.

SELECT 
 category,
 gender,
 COUNT(*) as total_trans
 FROM retail_sales
 GROUP 
 BY 
 category,
 gender
 ORDER BY 1

 --Q7 Write a SQL query to calculate the average  sale for each month. find out best selling mont in each year

 SELECT
 year,
 month,
 avg_Sale
 FROM
 (
  SELECT
  EXTRACT(YEAR FROM sale_date) as year,
  EXTRACT(MONTH FROM sale_date) as month,
  AVG(total_sale)as avg_sale,
  RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC)as rank
  FROM retail_sales
  GROUP BY 1,2
  )as t1
  WHERE rank =1

  --Q8 Write a SQL query to find the top 5 customers based on the higest total sales

  SELECT 
     customer_id,
	 SUM(total_sale) as total_sales
	 FROM retail_sales
	 GROUP BY 1
	 ORDER BY 2 DESC
	 LIMIT 5

--Q9 Write a SQL query to find the number of unique customers who purchase items from each category

 SELECT 
     category,
	 COUNT(DISTINCT customer_id) as cnt_unique_cs
	 FROM retail_sales
	 GROUP BY category

--Q10 Write a SQL query to create each shifts and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening>17)

WITH hourly_sale
AS
(
SELECT *,
CASE 
  WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
  ELSE 'Evening'
  END as shift
  FROM retail_sales
  )
  SELECT 
  shift,
  COUNT(*) as total_orders
  FROM hourly_sale
  GROUP BY shift

  --END OF PROJECT