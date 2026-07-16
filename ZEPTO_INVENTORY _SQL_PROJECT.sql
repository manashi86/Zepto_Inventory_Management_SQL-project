create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);
select COUNT(*) from zepto limit 10;

SELECT * FROM zepto
limit 10;

--check for NULL Values
select * from zepto
where name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
availableQuantity IS NULL
OR 
weightInGms IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

--different product categories.

SELECT DISTINCT(category)
from zepto
order by category;

--product in stock & out of stock

SELECT outOfStock, COUNT(sku_id)
from zepto
group by outOfStock;

--product name that present multiple times

SELECT  name, COUNT(sku_id)as Number_of_SKU
from zepto
group by name
HAVING COUNT(sku_id)>1
ORDER BY COUNT(sku_id)DESC;

--product with price = 0

select * from zepto
where mrp = 0 or discountedSellingPrice =0;

DELETE FROM zepto
where mrp = 0;

--to change the value from paise to rupees
UPDATE zepto
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT mrp, discountedSellingPrice
from zepto;

--Find the Top 10 product based on the discounted percentage?

Select DISTINCT name,mrp,discountPercent
from zepto
order by discountPercent desc
limit 10;

--What are the product with high MRP but out of stock?

select DISTINCT name, mrp 
from zepto
where outOfStock = 'TRUE' and mrp > 300
order by mrp desc;

--calculate estimated revenue for each category?

SELECT category, sum(discountedSellingPrice * availableQuantity) as Total_Revenue
from zepto
group by category
order by Total_Revenue;

--Find all product where mrp is greater than 500 but discount is less than 10%?

SELECT DISTINCT name, mrp, discountPercent
from zepto
where mrp > 500 and  discountPercent < 10
order by 2,3 DESC;

--Identify the top 5 categories offering the highest average discount percentage?

SELECT category, ROUND(AVG(discountPercent),2)as Avg_discount
from zepto 
group by category
order by Avg_discount desc
limit 5;

--Find the price per gram for product above 100g and sort by best value?

SELECT DISTINCT name,discountedSellingPrice,weightInGms,
ROUND(discountedSellingPrice/weightInGms,2) as price_per_gram
from zepto
where weightInGms >= 100
order by price_per_gram;

--Group the product in categories by grams like low, medium and bulk?
 SELECT DISTINCT name, weightInGms,
 CASE WHEN weightInGms < 1000 THEN 'Low'
      WHEN weightInGms < 5000 THEN 'Medium'
	  ELSE 'Bulk'
	  END AS weight_category
	  from zepto;

--What is the total inventory  weight per category?

select category, 
Sum(weightInGms * availableQuantity)as Total_weight
from zepto
group by category
order by Total_weight;











