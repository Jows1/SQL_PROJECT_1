/*
Question: What are the skills required for the top-paying software engineer jobs?
*/
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
LIMIT 10
 
/*
Skills Insights for Top-Paying Software Engineer Roles:

Programming Languages:
Python, JavaScript, and TypeScript frequently appear, showcasing their high demand in these roles.

Cloud Platforms:
Azure and AWS are common, indicating that cloud computing expertise is vital for high-paying software roles.

Combination of Skills:
Top positions often require a mix of backend (Python) and frontend (JavaScript/TypeScript) skills along with cloud platform proficiency (AWS, Azure).
[
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "salary_year_avg": "225000.0",
    "company_name": "Datavant",
    "skills": "python"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "salary_year_avg": "225000.0",
    "company_name": "Datavant",
    "skills": "javascript"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "salary_year_avg": "225000.0",
    "company_name": "Datavant",
    "skills": "typescript"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "salary_year_avg": "225000.0",
    "company_name": "Datavant",
    "skills": "azure"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "salary_year_avg": "225000.0",
    "company_name": "Datavant",
    "skills": "aws"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "salary_year_avg": "225000.0",
    "company_name": "Datavant",
    "skills": "snowflake"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "salary_year_avg": "225000.0",
    "company_name": "Datavant",
    "skills": "spark"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "salary_year_avg": "225000.0",
    "company_name": "Datavant",
    "skills": "react"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "salary_year_avg": "205000.0",
    "company_name": "SmarterDx",
    "skills": "python"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "salary_year_avg": "205000.0",
    "company_name": "SmarterDx",
    "skills": "elasticsearch"
  }
]
*/