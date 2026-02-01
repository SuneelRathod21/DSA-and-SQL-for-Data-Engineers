--CTE's are basically used when your Query has 2 or more logics in it to implement or add-up
-- Note: CTEs are not mandatory — they’re mainly for readability, maintainability, and step-wise logic.
'''IMP::::  CTEs are like temporary result sets created during query execution.
They behave like temp tables inside the query only
✔ Not stored in the database
✔ Not reusable outside that query
✔ Exist only while the query runs'''
--example if we need to find the top-N products by revenue for each category or
--top-N employee with highest salary in each department 
-- top-n, latest, top-3 etc

--EX: we have 3 tables, Product(p_id)-->Sales(p_id) and product(cat_id)-->category(cat_id)
--I need to find the top-5 products by revenue for each category

WITH Products_Revenue As(
    Select 
        p.Product_name,
        c.category_Name,
        sum(s.sales * s.price) as revenue
    From product p 
    JOIN sales s on p.p_id = s.p_id
    JOIN category c on p.cat_id = c.cat_id
    GROUP BY p.Product_name, c.category_Name
),
Ranked_cat As(
    select *,
        Row_Number() over(PARTITION by category_Name order by revenue desc) as Rn 
        from Products_Revenue
)

Select 
    Product_name, 
    category_Name,
     revenue 
FROM Ranked_cat
where rn <=5

-------------------------------------------------------------------------------

--Running total
-- Given a sales table with order_date, amount, calculate the running total of sales by date.
Select 
    order_date,
    sum(amount) over(order by order_date) as total_running
from sales
-- No GROUP BY → window functions work row-wise
----------------------------------------------------------------------------
-- From daily_sales, show current sales and next day sales.
Select
    order_date,
    sales as current_sales,
    LEAD(sales) over(order by order_date) as next_day_sales
from sales

-----------------------------------------------------
-- From daily_sales, show current sales and previous day sales.
Select
    order_date,
    sales as current_sales,
    LAG(sales) over(order by order_date) as previous_day_sales
from sales
------------------------------------------------------------------------
-- combine

with group_date as 
( select
	transaction_date,
	sum(price) as price
from raw_schema.transactions
group by  transaction_date
)

select 
	transaction_date,
	lag(price) over(order by transaction_date ) as previous_day_price,
	price as current_price,
	LEAD(price) over(order by transaction_date ) as next_day_price,
	sum(price) over(order by transaction_date ) as comu_sum		
from group_date

--------------------------------------------------------------------------
    