with total_sal as (
select *
,sum(salary) over(partition by experience order by salary rows between unbounded preceding and current row) as running_sal
 from candidates
)
,seniors as (
select * 
from total_sal
where experience='Senior' and running_sal<=70000
)
select emp_id,experience,salary from seniors
union all
select emp_id,experience,salary from total_sal 
where experience='Junior' 
and running_sal<=70000-(select sum(salary) from seniors)
order by salary desc;