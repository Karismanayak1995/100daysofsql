-- Part 3 — Performance & Promotion Analysis
-- Write a query returning:
-- Column                        Description
--full_name                      Employee name
--job_level                      Current level
--avg_rating                     Average rating across all years
--total_promotions               Count of years where promoted = true
--years_since_hire               Years from hire_date to today
--promotion_rate                 total_promotions / years_since_hire * 100
--performance_tier               'Star' if avg_rating >= 4.5, 'Strong' if >= 3.5, 'Average' if >= 2.5, else 'Low'
--manager_name                   Their manager's name (self join)

SELECT * FROM departments_20;
SELECT * FROM employees_20 ;
SELECT * FROM payroll_20;
SELECT * FROM performance_20;




WITH employee_data AS (
	SELECT e.emp_id,
           e.full_name,
           e.job_level,
	       e.manager_id,
	       ROUND(
			   AVG(p.rating)
			   ,2
		   ) AS avg_rating,
	       SUM(
			   CASE WHEN promoted = true THEN 1 ELSE 0 END
		   ) AS total_promotions,
	       EXTRACT (
		       YEAR FROM AGE(CURRENT_DATE,hire_date)
	       ) AS years_since_hire ,
	       ROUND(
		       (SUM(CASE WHEN promoted = true THEN 1 ELSE 0 END)*100)
	           /NULLIF(EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.hire_date)), 0)
			   ,2
	       ) AS promotion_rate
     FROM employees_20 e
     JOIN performance_20 p ON e.emp_id = p.emp_id
     GROUP BY e.emp_id,e.full_name,e.job_level,e.hire_date,e.manager_id
     
	)
	,performance AS(
		SELECT emp_id,
		CASE WHEN avg_rating >= 4.5 THEN 'Star'
		     WHEN avg_rating >= 3.5 THEN 'Strong'
		     WHEN avg_rating >= 2.5 THEN 'Average'
		ELSE 'Low'
		END AS performance_tier
		FROM employee_data
		
	)
SELECT 
     e.emp_id,
	 e.full_name,
     e.job_level,
	 e.avg_rating,
	 e.total_promotions,
	 e.years_since_hire,
	 e.promotion_rate,
	 p.performance_tier,
	 em.full_name AS manager_name
FROM employee_data e 
JOIN performance p ON e.emp_id = p.emp_id
LEFT JOIN employees_20 em ON e.manager_id = em.emp_id
ORDER BY e.emp_id
		   
	   
	   