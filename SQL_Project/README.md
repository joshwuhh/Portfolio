
# Data Job Market Analysis 📊 
This project dives into the Data job market.🧑🏻‍💻 Focusing on data analyst roles, this project explores top paying jobs 🔥, in demand skills and pin points where demand and salary meet in data analytics. 🏆

🔎 Sql Queries! : [SQL Project Folder](/project_sql) 

# Table of Contents
- [Understanding the Data](#Understanding-the-Data)
- [Questions & Tools](#Questions-asked-of-the-Data)
- [The Analysis](#Analysis-and-Approach)
- [Insights](#Final-Insights)
- [What I Learned](#Learning-Points)


## Understanding the Data
Data has been sourced from [SQL Course](https://lukebarousse.com/sql). 
The data is comprised of 787k+ rows of data on Job Postings which include Job titles, Locations and Pay along with over 3 million rows of data on the skills required within those postings. 


## About
This project was created from my drive to break into a career in data analytics. Streamlining the process of the job hunt by finding the top-paid and in-demand skills needed to secure a promising career optimally!

## Questions asked of the Data
1. Which data analyst jobs have the highest pay?
2. What skills are required for those jobs?
3. What skills are most in-demand for data analyst?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn? 

### Tools
- **SQL** : The foundation of the project utilized SQL in order to unearth insights.
- **PostgreSQL** : As the database management system 
- **Visual Studio Code** : My chosen editor for data-management and SQL query execution
- **Git & Github** : Used for version control and sharing SQL scripts and analysis. Ensuring collaboration and project tracking. 






# Analysis and Approach 

### [1] Top Paying Analyst Jobs

```sql
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
AND job_location = 'Anywhere'
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
```
The breakdown of the top data analyst jobs in 2023.
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000. This indicates significant salary potential in the field. 

- **Diverse Employers:** Companies like SmartAsset, Meta and AT&T are among those offering high salaries. This indicates wide interest across various industries. 

- **Job Title Variety:** There is a high variety of job titles, reflecting varied roles and specializations within data analytics. 


### [2] Skills required for those jobs

To understand what is required for those top paying jobs, I joined the job postings with skills data, providing insights into what employers value for high-pay roles
```
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

    WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
) 
```


![Image](assets/Top_paying_skills.png)
_Bar graph visualizing data analysis skills and their associated salaries, CHATGpt generated using my SQL query results_

### [3] Most in-demand skills for data analysts

This query helped me identify the most frequently 


```
SELECT skills,
COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
AND job_location = 'New York, NY'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5
```
- **SQL** and **Excel** remain fundamental which emphasize the need for strong foundational skills in data processing and spreadsheet manipulation. 

- **Programming** and **Visualizaiton** **Tools** like **Python**, **Tableau** and **PowerBI** are also essential, showing an increasing importance of technical skills in data storytelling and decision support. 


<img width="200" alt="image" src="https://github.com/user-attachments/assets/d70c0188-1469-4063-8d97-32e196c627fa" />

_Tabulated data for the query results, exported from excel_


 ### [4] Skills associated with higher salaries 

Exploring the average salaries with different skills revealed which which skills are highest paying. 

```
SELECT skills,
ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
AND job_location = 'Anywhere'
AND salary_year_avg IS NOT NULL 
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25

```
<img width="200" alt="image" src="https://github.com/user-attachments/assets/3f9ce447-3962-46c2-8fc8-4845d0d8b572" />

_Table for average salaries for top 25 skills_ 

A breakdown of the highest paying skills:

- **High demand for Big Data and ML skills**: The industry seems to place high value on big data technologies (Pyspark, Couchbase), machine learning tools (Datarobot and Jupyter) and Python Libraries (Pandas, Numpy) showing the high value placed data processing and predictive modeling capabilities. 

- **Software development & Deployment proficiency**: Knowldege in development and deployment tools (GitLab, Airflow) indicates a lucrative crossover between engineering and data analysis, showing strength in having skills that facilitate automation and data pipeline management. 

- **Cloud Computing**: The data shows there is an importance in cloud-based analytics enviornments and tools (Databricks, CGP) which can boost potential salary in data analytics.


### [5] Most optimal skills to have

Combining insights from demand and skills, this query aimed to pinpoint skills that are both high demand and have high salaries, offering a strategic focus for skill development. 

```
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
```

A breakdown of the most optimal skills for Data Analysts:

- **High Demand Programming Languages:** Python and R stand out for their demand with counts of 236 and 148. Despite their high demand, the average salaries for these skills are highly valued with salaries over $100,000.
  
- **Cloud Tools and Technologies:** Big data and cloud platform skills are also of growing importance as the data shows that specialized technologies like Snowflake, Azure, AWS, and BigQuery show very high average salaries.
  
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively and average salaries also around the $100,000 mark highlighht the critical role of data visualization and business intelligence in deriving actionable insights from data.
  
- **Database Technologies:** The demand for traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries from $97,000 to $104,000 reflect the enduring need for storage, retrieval, and management expertise. 
  

<img width="292" alt="image" src="https://github.com/user-attachments/assets/f0711bb1-bf59-48fa-a13b-ec83f7f596a5" />

_Table for the most optimal skills for Data Analysts sorted by salaries_

 
### Final Insights

1. **Top Paying Jobs** for data analysts offer a wide range of salaries with the highest paying being $650,000
2. **Skills for those jobs:** High paying jobs require advanced proficiency in SQL, suggesting it truly is a crucial skill.
3. **Most in demand skill** also appears to be SQL making it ESSENTIAL for job seekers.
4. **Skills with higher salaries** include specialized skills like SVN and Solidity, indicating that there is a premium on niche expertise.
5. **Optimal skills:** SQL leads in demand and offers a high average salary. It has proven to be the most optimal skill for analysts to learn if they wish to maximize their market value.   


### Learning Points
Throughout this project I hit many moments that required me to not only test knowledge I posessed but also to take time to learn new things that I can continue to use going forward. Further strengthening my SQL and Data Analysis skills. 

- **Git:** While I have made use of Github and various code editors for some time now, it was this project that solidified not only how to implement version control but also how crucial project management is. This also forced me into a position to learn some problem solving skills with Git, like how to properly merge, push and pull commitments, which will definitely be handy in my future career.
- **Query Crafting:** Using more advanced SQL was necessary here, merging tables and utilizing WITH clauses have helped me better maneuver data with temporary result sets.
- **Analytical Skills:** This project was directly relative to my life as I continue to pursue a career as a Data Analyst. This allowed the questions asked to be more impactful as I could see the true use case for the answers I was looking for. Strengthening my skill of turning real world questions into insightful SQL queries.
