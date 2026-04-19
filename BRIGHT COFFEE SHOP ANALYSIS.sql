-- Databricks notebook source
--THIS IS JUST TO CHECK IF THE TABLE IS LOADED CORRECTLY AND I AM ABLE TO READ IT PROPERLY
SELECT * FROM workspace.default.bright_coffee_shop LIMIT 10;

--------------------------------------------------------------
--1.CHECKING THE DATE RANGE
--------------------------------------------------------------

--THEY STARTED COLLECTING THE DATA ON 2023-01-01
SELECT MIN(transaction_date) AS START_DATE
FROM workspace.default.bright_coffee_shop;

--WHEN LAST DID THEY COLLECT THE DATA? 2023-06-30
SELECT MAX(transaction_date) AS END_DATE
FROM workspace.default.bright_coffee_shop;

--------------------------------------------------------------
--2.CHECKING THE NAMES OF THE COFFEE STORE LOCATIONS
--------------------------------------------------------------

-- WE HAVE THREE STORE LOCATIONS
SELECT DISTINCT store_location
FROM workspace.default.bright_coffee_shop;

--------------------------------------------------------------
--3.CHECKING PRODUCTS SOLD ACROSS ALL THE STORES
--------------------------------------------------------------

SELECT DISTINCT PRODUCT_CATEGORY
FROM workspace.default.bright_coffee_shop;

SELECT DISTINCT PRODUCT_DETAIL
FROM workspace.default.bright_coffee_shop;

SELECT DISTINCT PRODUCT_TYPE
FROM workspace.default.bright_coffee_shop;

SELECT DISTINCT PRODUCT_DETAIL AS PRODUCT_NAME,
                product_type,
                PRODUCT_CATEGORY AS CATEGORY 
FROM workspace.default.bright_coffee_shop;

--------------------------------------------------------------
--4.SALES TRANSACTIONS AND CALCULATED REVENUE
--------------------------------------------------------------

SELECT transaction_id,
       transaction_date, 
dayname(transaction_date) AS day_name,
monthname(transaction_date) AS month_name,
transaction_qty*unit_price AS revenue_per_transaction
FROM workspace.default.bright_coffee_shop;

SELECT 
COUNT(*) AS number_of_rows,
      COUNT(DISTINCT transaction_id) AS number_of_sales,
      COUNT(DISTINCT product_id) AS number_of_products,
      COUNT(DISTINCT store_id) AS number_of_stores
FROM workspace.default.bright_coffee_shop;

SELECT COUNT(*)
FROM workspace.default.bright_coffee_shop;

------------------------------------------------------------------------
--5.SALES TRANSACTIONS AND CALCULATED REVENUE CLASSIFIED BY TIME OF DAY
------------------------------------------------------------------------

SELECT 
--DATES
      transaction_date AS purchase_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
     
    Case
           WHEN Day_name IN ('Saturday','Sunday') THEN 'Weekend'
           ELSE 'Weekday'
           END AS day_classification,
   
      
    Case
        when  date_format(transaction_time, 'HH:mm:ss') between '00:00:00' and '11:59:59' then '01. Morning'
        when  date_format(transaction_time, 'HH:mm:ss') between '12:00:00' and '16:59:59' then '02. Afternoon'
        when  date_format(transaction_time,  'HH:mm:ss') >= '17:00:00' then '03. Evening'
        end AS time_buckets,

    
--COUNTS of ids
        COUNT(DISTINCT transaction_id) AS Number_of_sales,
        COUNT(DISTINCT product_id) AS Number_of_products,
        COUNT(DISTINCT store_id) AS Number_of_stores,

--REVENUE
      SUM(transaction_qty*unit_price) AS revenue_per_day,

      CASE 
             WHEN revenue_per_day <=50 THEN '01. Low Spend'
             WHEN revenue_per_day between 51 and 100 THEN '02. Medium Spend'
             else '03. High Spend'
             END AS spend_buckets,


--CATEGORICAL COLUMNS
         Product_category,
         Product_detail,
         Store_location
FROM workspace.default.bright_coffee_shop
GROUP BY transaction_date,
         Dayname(transaction_date),
         Monthname(transaction_date),
       Case
           WHEN Dayname(transaction_date) IN ('Saturday','Sunday') THEN 'Weekend'
           ELSE 'Weekday'
           END ,

       Case
           when  date_format(transaction_time, 'HH:mm:ss') between '00:00:00' and '11:59:59' then '01. Morning'
           when  date_format(transaction_time, 'HH:mm:ss') between '12:00:00' and '16:59:59' then '02. Afternoon'
           when  date_format(transaction_time,  'HH:mm:ss') >= '17:00:00' then '03. Evening'
           END ,

      
         Product_category,
         Product_detail,
         Store_location;



