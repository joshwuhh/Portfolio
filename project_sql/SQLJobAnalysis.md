Goals of project  

You are an aspiring data nerd looking to analyze the top-paying roles and skills 

You will create SQL queries to explore this large dataset to be specific to you  

For those job searching or looking for a promotion; you can not only use this project to showcase experience BUT also to extract what roles/skills you should target...


# Data Job Market Analysis 📊 
This project dives into the Data job market.🧑🏻‍💻 Focusing on data analyst roles, this project explores top paying jobs 🔥, in demand skills and pin points where demand and salary meet in data analytics. 🏆

🔎 Sql Queries! : [SQL Project Folder](/project_sql) 

# Table of Contents
- [Understanding the Data](#)
- [Problem Statement](#Problem-Statement)
- [Questions](#Questions)
- [Process](#Steps-followed)
- [The Dashboard](#Snapshot-of-Dashboard)
- [Insights](#Insights)


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

```
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

### [2] Competition weight is largest for one Bedrooms, lowest for properties with 4+ Bedrooms 
  
### [3] Average price earned by rooms increases with property size

 ### [4] The best time to rent a property in Seattle is in Summer and Fall 
 


 
### Dashboard Link : 