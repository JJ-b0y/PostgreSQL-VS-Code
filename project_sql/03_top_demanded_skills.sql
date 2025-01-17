/*
Question: What are the most in-demand skills for Data Analysts?
- Join job postings to Inner Join table similar to query 2.
- Identify the top 5 in-demand skills for a Data Analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
  providing insights into the most valuable skills for job seekers.
  BONUS: Filter for remote jobs.
*/

SELECT
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

/*
Insights
SQL: With a demand count of 92,628, SQL stands out as the most critical skill for data analysts.
    Its importance lies in its ability to manage and query databases efficiently.
Excel: Following SQL, Excel has a significant demand of 67,031. This tool is essential for data manipulation, analysis, and visualization.
Python: The programming language Python is also crucial, with a demand count of 57,326.
    Its versatility in data analysis and machine learning makes it a valuable skill.
Tableau: With a demand count of 46,554, Tableau is recognized for its powerful data visualization capabilities.
Power BI: Lastly, Power BI has a demand count of 39,468, indicating its growing popularity in business intelligence and reporting.
*/