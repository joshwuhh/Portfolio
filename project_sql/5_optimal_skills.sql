/*
What are the most optimal skills to learn?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on NY positions
- Targets skills that offer job security (hig demand) and financial benefits (high-paying)
Offering strategic insights into the job market for career development in data analysis in NEW YORK 

*/

-- Using Query 3 & 4 as a CTE 
-- Connected with primary or foreign key 
-- Best practice to GROUP BY the connecting key (skill_id)

WITH skills_demand AS (
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
AND job_location = 'New York, NY'
AND salary_year_avg IS NOT NULL 
GROUP BY skills_dim.skill_id
),
average_salary AS (
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
AND job_location = 'New York, NY'
AND salary_year_avg IS NOT NULL 
GROUP BY skills_dim.skill_id
)

SELECT 
    skills_demand.*,
    avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY 
     avg_salary DESC,
    demand_count DESC
LIMIT 25
