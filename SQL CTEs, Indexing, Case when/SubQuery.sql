--Subqueries are just queries inside another query, 
-- used when I need some intermediate result but don’t want (or need) to break the query into steps like CTEs.

'''BASIC subquery (single value)
Problem:
Find employees earning more than average salary.
Logic (your thinking):
“First I need average salary. Then I compare each employee’s salary with it.”'''
SELECT 
    name, 
    Salary
From employee
where Salary >(select avg(salary) from employee)

'''Why this is good:
Inner query returns one value
Outer query compares against it'''
---------------------------------------------------------------------------------------------
'''🟡 MID-level subquery (multiple rows)
Problem:
Find employees who work in departments located in India.
Logic:
“Get all department IDs in India, then fetch employees belonging to those departments.”'''
SELECT *
FROM employee
WHERE dept_id IN (
    SELECT dept_id
    FROM department
    WHERE location = 'India'
);

-----------------------------------------------------------------------------------
'''🟠 MID–ADVANCED (correlated subquery)
Problem:
Find employees earning more than the average salary of their own department.
Logic:
“For each employee, calculate the average salary of that employee’s department.”'''
SELECT e1.*
FROM employee e1
WHERE salary > (
    SELECT AVG(e2.salary)
    FROM employee e2
    WHERE e2.dept_id = e1.dept_id
);

---------------------------------------------------------------------------------------
'''🔴 ADVANCED (subquery in FROM — derived table)
Problem:
Find departments with average salary greater than 50k.
Logic:
“First calculate avg salary per department, then filter.”'''
SELECT *
FROM (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employee
    GROUP BY dept_id
) t
WHERE avg_salary > 50000;
--------------------------------------------------------------------------------------
'''🔥 REAL-WORLD style (EXISTS)
Problem:
Find customers who have placed at least one order.
Logic:
“I don’t care how many orders — I just need to check existence.”'''
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
