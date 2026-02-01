--Case When statement is basically used whenver we want apply certain conditions while retriving the data from the table 
--Or we can also create a new conditional columns using the existing columns based on certain conditions we wanted to achive
-- It’s basically SQL’s if–els
--ex:
    Select
        employee,
        sum(case when salary <= 20000 then 'Low' 
             when salary >=20000 and salary <= 30000 then 'average'
             when salary >= 50000 then 'High'
             else 0
        END ) as Salary_range
----------------------------------------------------------------------------
-- ex:2 
    Select 
        sum(case when state = 'approved' then amount else 0 end) as approved_count,
        sum(case when state-'not approved' then amount else 0 end) as not_appr_cnt
    from employee
