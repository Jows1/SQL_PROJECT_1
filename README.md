# Introduction

 Dive into the data job market! Focusing on Software engineer roles, this project explores top-paying jobs, in-demand skilss, and where high demand meets high salary in Software engineering.

 SQL queries? Check them out here: [Project file](/project_sql/)

# Background
Drive by a quest to navigate the software engineer job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find the optimal jobs.

Data hails from Luke Barousse's [Sql Course](https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying software engineer jobs?
2. What skills are required for these top paying jobs?
3. What skills are most in-demand for software engineers?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I used
For my deep dive into the software engineer job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSql:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries/.
- **Git & Github:** Essential fir version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how i approached each question.

### 1. Top paying Software Engineer Jobs
To Identify the highest-paying roles, I filtered software engineer postions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field. 

```sql
SELECT
     job_id,
     job_title,
     job_title_short,
     job_location,
     job_schedule_type,
     salary_year_avg,
     job_posted_date,
     company_dim.name AS company_name
FROM 
    job_postings_fact AS job_post
LEFT JOIN company_dim ON job_post.company_id = company_dim.company_id
WHERE
    job_title_short = 'Software Engineer' AND
    job_location = 'Anywhere' AND  
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
```
Here's the breakdown of the top software engineer in 2023:

- **Wide Salary Range:** Top 10 paying software engineer roles span from $182500 to $225000, indicating significant salary potential in the field.
- **Diverse Employment:** Companies like Datavant, SmarterDx and MongoDB are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Staff Frontend Engineer to Director of Software Engineer, reflecting varied roles and specializations within data analytics.

### 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

``` sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        company_dim.name AS company_name
    FROM 
        job_postings_fact AS job_post
    LEFT JOIN company_dim ON job_post.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Software Engineer' AND
        job_location = 'Anywhere' AND  
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
```

### 3. In-Demand Skills For Data Analysts

This query helped identify the skills most frequency requested in job postings, directing focus to areas with high demand.

```
SELECT 
    skills,
    job_title_short,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Software Engineer' AND
      job_location = 'Anywhere'
GROUP BY 
    skills,
    job_title_short,
    salary_year_avg
ORDER BY 
     demand_count DESC
LIMIT 5;
```

### 4. Skills Baseed On Salary

Exploring the average slaries associated with different skills revealed which skills are the highest paying.

```
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Software Engineer' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere'
GROUP BY 
    skills
ORDER BY 
     avg_salary DESC
LIMIT 25;
```
### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed ti pinpoint skills that are both in high demand and have high slaries, offering a strategic focus for skill development.

```
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM 
        job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Software Engineer' AND
                salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    GROUP BY 
        skills_dim.skill_id
),average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Software Engineer' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    GROUP BY 
        skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```