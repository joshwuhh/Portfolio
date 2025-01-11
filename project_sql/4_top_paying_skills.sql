/*
Most of the core query can be carried over from the previous one, but rather than 
getting a count, we want to get the roles with specified salaries
Since we utilized AVG, the salaries resulted in long decimals. 
So I used ROUND to clean this 

*/

SELECT skills,
ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
AND job_location = 'New York, NY'
AND salary_year_avg IS NOT NULL 
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25