/*
    Question: What are the top skills based on salary?
    - Look at the average salary associated with each skill for Data Analyst positions.
    - Focuses on roles with specified salaries, regardless of location.
    - Why? It reveals how different skills impact salary levels for Data Analysts and
      helps identify the most financially rewarding skills to acquire or improve upon.
*/

SELECT
    skills,
    ROUND(AVG (salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 20;

/*
Top Skills in Demand: The highest-paying skill for data analysts is PySpark with an average salary of $208,172,
reflecting the strong demand for big data processing capabilities.
Collaboration Tools: Skills like Bitbucket and GitLab, with salaries of $189,155 and $154,500, respectively,
highlight the importance of collaboration and version control in data projects.
AI and Cloud Technologies: Proficiency in AI tools such as Watson and cloud technologies like Databricks (average salary of $141,907)
indicates a growing trend towards integrating advanced technologies in data analytics roles.
*/