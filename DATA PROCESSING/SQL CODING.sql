

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

     
