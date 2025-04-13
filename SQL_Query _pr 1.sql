-- sql retail sales analysis - p1

CREATE DATABASE sql_project_p2;

--create TABLE 
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
              (
		        transactions_id	INT PRIMARY KEY,
				sale_date DATE, 	
				sale_time TIME,	
				customer_id	INT,
				gender VARCHAR(15),	
				age	INT,
				category varchar(15),
				quantiy	INT,
				price_per_unit FLOAT,
				cogs FLOAT,	
				total_sale FLOAT
			  );
select * from retail_sales
LIMIT 10


select
    count (*) 
from retail_sales

select * from retail_sales
where transactions_id is null

select * from retail_sales
where sale_date is null 

select * from retail_sales
where sale_time is null

select * from retail_sales
where 
     quantiy is null 
	 or
	 transactions_id is null
     or
	 sale_date is null
	 or
	 sale_time is null
	 or 
	 customer_id is null
	 or 
	 gender is null
	 or 
	 age is null
	 or 
	 category is null
	 or 
	 price_per_unit is null
	 or 
	 cogs is null
	 or
	 total_sale is null

delete from retail_sales
where 
      quantiy is null 
	 or
	 transactions_id is null
     or
	 sale_date is null
	 or
	 sale_time is null
	 or 
	 customer_id is null
	 or 
	 gender is null
	 or 
	 age is null
	 or 
	 category is null
	 or 
	 price_per_unit is null
	 or 
	 cogs is null
	 or
	 total_sale is null

-- data exploration
How many sales we have?

SELECT COUNT (*) as Total_sales from retail_sales

How many uniuque customer we have?

Select count(distinct customer_id)as Total_sales from retail_sales

select count (distinct category)as Total_sales from retail_sales

select distinct category from retail_sales

--Data Analysis & business key problems and Answers 

--Analysis & finding
--1. write a Sql query to retrieve all columns for sales made on '2022-11-05'

select *
from retail_sales
where sale_date = '2022-11-05';

--2. write a sql to retrieve all transactions where category is 'clothing'and the quantiy sold is more then 10 in the month for Nov-2022 

select 
      *
from retail_sales 
where 
	category ='Clothing'
	And 
	To_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4

--3. write a Sql query to calculate teh total sales (total_sale)for each category

SELECT 
      category,
	  sum(total_sale) as net_sale,
	  count(*)total_orders
FROM retail_sales
GROUP BY 1
SELECT * from retail_sales

--4.write query to find the average age of customers who purchased items from the 'Beauty' category

select
     ROUND(AVG(age), 2) as avg_age
from retail_sales
where category = 'Beauty'

--5. Sql query to find all transaction where the total_sales is greater than 1000

select * from retail_sales
where total_sale > 1000

--6.write a Sql query to find the total number of transactions(transaction_id)made by each gender in each category

select 
     category,
	 gender,
	 count (*)as total_trans
from retail_sales
group 
    by
	category,
	gender
order by 1

--7.write a sql query to calculate the average sales for each month find out best selling month in each year

select 

	 year,
	 month,
	 avg_sale
from
(
  select
	  EXTRACT(YEAR from sale_date) as year,
	  EXTRACT(month from sale_date) as month,
	  AVG(total_sale)as avg_sale,
	  Rank()over(PARTITION BY EXTRACT(YEAR from sale_date) ORDER BY AVG(total_sale) desc)as rank
  from retail_sales
  group by 1, 2 
)as t1
where rank = 1
--order by 1,3 desc

--8.write a sql query to find the Top 5 customer based on the highest total sales

select 
     customer_id,
	 sum(total_sale)as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

--9. write a sql query to find the number of unique customer who purchased items from each category

select
     category,
	 count(distinct customer_id)as count_unique_customer
from retail_sales 
group by category

select * from retail_sales

--10. write a sql query to create each shift and number of orders (Example morning <=12, Afternoon between 12 ,17,Evening>17)
with hourly_sale
as
(
select *,
    case
      when extract(hour from sale_time)<12 then 'morning'
	  when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	  Else 'Evening'
	End as shift
from retail_sales
)
select
     shift,
	 count(*) as total_orders
from hourly_sale
group by shift

--End of the project


	  

	 
	 

	 



