# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```
### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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


### 3. data exploration###
How many sales we have?

SELECT COUNT (*) as Total_sales from retail_sales

How many uniuque customer we have?

Select count(distinct customer_id)as Total_sales from retail_sales

select count (distinct category)as Total_sales from retail_sales

select distinct category from retail_sales


The following SQL queries were developed to answer specific business questions:

###Data Analysis & business key problems and Answers###

1. **write a Sql query to retrieve all columns for sales made on '2022-11-05'**:
'''sql
select *
from retail_sales
where sale_date = '2022-11-05';

2. **write a sql to retrieve all transactions where category is 'clothing'and the quantiy sold is more then 10 in the month for Nov-2022**:
'''sql
select 
      *
from retail_sales 
where 
        category ='Clothing'
	And 
	To_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4

3.**write a Sql query to calculate teh total sales (total_sale)for each category**:

SELECT 
      category,
	  sum(total_sale) as net_sale,
	  count(*)total_orders
FROM retail_sales
GROUP BY 1
SELECT * from retail_sales

-4.**write query to find the average age of customers who purchased items from the 'Beauty' category**:

select
     ROUND(AVG(age), 2) as avg_age
from retail_sales
where category = 'Beauty'

-5. **Sql query to find all transaction where the total_sales is greater than 1000**:

select * from retail_sales
where total_sale > 1000

--6.**write a Sql query to find the total number of transactions(transaction_id)made by each gender in each category**:

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

--7.**write a sql query to calculate the average sales for each month find out best selling month in each year**:

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

--8.**write a sql query to find the Top 5 customer based on the highest total sales**:

select 
     customer_id,
	 sum(total_sale)as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

--9.**write a sql query to find the number of unique customer who purchased items from each category**:

select
     category,
	 count(distinct customer_id)as count_unique_customer
from retail_sales 
group by category

select * from retail_sales

--10.**write a sql query to create each shift and number of orders (Example morning <=12, Afternoon between 12 ,17,Evening>17)**:
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

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/manimegalai-yuvaraj-a40a092a0)
- **Email**: [Connect with me professionally](manimegalaiyuvaraj38@gmail.com)

Thank you for your support, and I look forward to connecting with you!
