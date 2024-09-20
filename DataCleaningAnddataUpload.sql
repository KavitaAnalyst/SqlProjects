create database SqlProjects;
use SqlProjects;
select *  from retailsales;
-- data cleaning 
select count(*) from retailsales;

alter table retailsales 
change ï»¿transactions_id transaction_Id int;

-- rename the quantity column 
alter table retailsales 
change quantiy quantity int;
-- count distict customer_id
select count(distinct customer_id) 
from retailsales;
-- check for null values  
select count(*)
from retailsales
where transaction_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR age IS NULL OR 
category IS NULL OR quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;
SET SQL_SAFE_UPDATES = 0;

-- Write a SQL quer	y to retrieve all columns for sales made on '2022-11-05
use SqlProjects;
select *  from retailsales;
select *
from retailsales
where sale_date = '05-11-2022'
;
-- Write a SQL query
--  to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select * , extract(Month from sale_date) AS MonthNumber
from retailsales
where  
category = 'Clothing' AND
quantity > 3 AND
extract(Month from sale_date) = 11;
-- Write a SQL query to calculate the total sales (total_sale) for each category.:
select category, sum(total_sale) as "total sale" , count(*) as "Total Orders"
from retailsales
group by category;

SELECT * FROM sqlprojects.retailsales;
-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as 'Cust_Avg_age'
from retailsales
where category = 'Beauty';
-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select *, sum(total_sale) as Total_Revenue_by_category, extract(year from sale_date) as year
from retailsales
where total_sale > 1000
group by category
order by total_sale;
-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select count(*) as 'number_of_transaction',gender,category
from retailsales
group by gender,category;
-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

with my_cte as( 
select EXTRACT(MONTH FROM sale_date) as MonthNumber, 
EXTRACT(Year FROM sale_date) as year,
round(avg(total_sale),2) as 'avg_sale'
from retailsales
group by  MonthNumber, year
order by MonthNumber
) 
select MonthNumber, year,avg_sale 
from my_cte
where 
(year, avg_sale) IN (
SELECT 
year,
MAX(avg_sale)
from my_cte
group by year
)
order by 
year,MonthNumber;
-- year count 
select count(*), extract(year from sale_date) as year_count
from retailsales 
group by year_count;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


WITH hourly_sales AS(
select *, 
case 
when extract(hour from sale_time) <12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Night shift'
end as shift
from retailsales
) 
select shift ,
count(*) as total_orders 
from hourly_sales
group by shift;
