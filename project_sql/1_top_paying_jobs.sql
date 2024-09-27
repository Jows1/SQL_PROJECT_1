/*
Question: What are the top-paying software engineer jobs?
- identify the top 10 highest-paying software engineer roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls)
- Why? highlight the top-paying opportunities for software engineers, offering inisights into empower
*/

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
