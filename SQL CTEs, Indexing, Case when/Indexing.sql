-- Indexing are basically used to optimize the query performance 
--type1: B tree index

--Creating Index
CREATE INDEX INDEX_NAME 
ON SCHEMA.TABLE_NAME(COLUMN_NAME)

--EX: B- tree 
CREATE INDEX order_date_idx
ON prod.orders(order_date)

'''so next time whenver u fillter somthing based on order_date this perticular index is is used to filter that
The optimizer may use this index when filtering by order_date.'''

-------------------------------------------------------------------------------------------------
--type2 : Composite index
CREATE INDEX order_date_mul_idx
ON prod.orders(order_id, order_date, customer_id)

'''hese composite index are created when you are frequently filter the combination of
 the multiple columns in the same where clausealways use columns from left to right inside the where condition as per the index you created.'''



--2️⃣ “Index is used whenever you filter”
-- Reality:
-- Index is not always used
-- Optimizer chooses based on:
-- table size
-- selectivity
-- statistics
