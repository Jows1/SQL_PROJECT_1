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




/*
SELECT 
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count

FROM 
    skills_job_dim
RIGHT JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Software Engineer' AND
    job_work_from_home = True
GROUP BY     
    skills
ORDER BY     
    demand_count DESC
LIMIT 10
*/