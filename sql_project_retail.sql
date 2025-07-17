--sql retail sales analysis- p1
create database sql_project_retail_sales1 

--create table 
drop table if exists retail_sales;
Create table retail_sales 
	(
		transactions_id INT primary key,
		sale_date date,
		sale_time time,
		customer_id	int,
		gender varchar(20),
		age	int,
		category varchar(50),
		quantity int,
		price_per_unit float,
		cogs float,
		total_sale float
    );
----------------
select* from retail_sales
limit 10;

select count(*)
from retail_sales

--data cleaning

SELECT *
from retail_sales
where transactions_id is  null or
	sale_date is  null or
	sale_time is  null or
	customer_id is  null or
	gender is  null or
	age is  null or
	category is  null or
	quantity is  null or
	price_per_unit is  null or
	cogs is  null or
	total_sale is  null


delete from retail_sales
where transactions_id is  null or
	sale_date is  null or
	sale_time is  null or
	customer_id is  null or
	gender is  null or
	age is  null or
	category is  null or
	quantity is  null or
	price_per_unit is  null or
	cogs is  null or
	total_sale is  null

--data exploration

--how mny sales we have?
select count(*) as total_sale from retail_sales

--how many unique customers count we have
select 
count( distinct customer_id) as total_no_of_customers
from retail_sales
--how many unique category we have
select
distinct category
from retail_sales

--data analysis and business key problems and answers
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select *
from retail_sales
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
select *
from retail_sales
where category = 'Clothing'
and
to_char(sale_date, 'YYYY-MM') = '2022-11'
and quantity >3

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
	category,
	sum(total_sale) as TOTAL_SALES,
	count(*) as total_order
from
	retail_sales
group by 
	category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
	round(avg(age),2) as average_age
from
	retail_sales
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from retail_sales
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
	category,
	count(*) as total_transactions,
	gender
from 
	retail_sales
group by
	category,
	gender
order by category

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from (
	select
		extract(year from sale_date) as sale_year,
		extract(month from sale_date) as sale_month,
		avg(total_sale) as total_sales,
		rank() over (partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
	from 
		retail_sales
	group by 1,2
	) as t1
where rank = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select 
	customer_id,
	sum(total_sale) as total_sales
from
	retail_sales
group by customer_id
order by 2 DESC
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
	category,
	count(DISTINCT customer_id) as unique_customers
from
	retail_sales
group by 1

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sales
as 
	(select *,
		case
			when extract (hour from sale_time ) < 12 then 'Morning'
			when extract (hour from sale_time ) between 12 and 17 then 'Afternoon'
			else 'Evening'
		end as shift
	from retail_sales)
	select 
		shift,
		count(transactions_id) as total_orders
	from hourly_sales
	group by shift


-- end of project_sql_p1_retail_sales















































































































