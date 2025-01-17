/*
    Question: What skills are required for the top-paying Data Analyst jobs?
    - Use the top 10 highest-paying Data Analyst jobs from first query.
    - Add the specific skills required for these roles.
    - WHY? It provides a detailed look at which skills are demanded for these high-paying jobs.
      Helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND
        job_location = 'Anywhere'
        AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_jobs.*,
    skills_dim.skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;

/*
Skill Frequency Analysis:
1. SQL: Mentioned 8 times.
2. Python: Mentioned 7 times.
3. Tableau: Mentioned 6 times.
4. R: Mentioned 4 times.
5. Snowflake: Mentioned 3 times.
6. Pandas: Mentioned 3 times.
7. Excel: Mentioned 3 times.
8. Azure: Mentioned 2 times.
9. Bitbucket: Mentioned 2 times.
10. Go: Mentioned 2 times.

Key Skills Overview
Programming Language:
1. SQL: This is the most frequently mentioned skill across all job postings, indicating its critical role in data analysis.
2. Python: Another highly sought-after programming language, often used for data manipulation and analysis.
3. R: Frequently listed, particularly for roles focused on statistical analysis and data visualization.
Data Visualization Tools:
Tableau and Power BI are prominent tools mentioned for visualizing data, suggesting that employers prioritize candidates who can effectively communicate insights through visual means.
Cloud Platforms:
Skills in AWS, Azure, and Snowflake are common, reflecting a trend towards cloud-based data solutions and storage.
Data Processing Frameworks:
Tools like Databricks, Pandas, and PySpark are highlighted, indicating a need for expertise in handling large datasets and performing complex transformations.
Version Control and Collaboration Tools:
Familiarity with tools such as GitLab, Bitbucket, and collaboration platforms like Atlassian (including Jira and Confluence) is essential, pointing to the importance of teamwork in data projects.
Other Notable Skills:
Knowledge of tools like Excel remains relevant, as it is widely used for basic data analysis tasks.
Skills in programming languages like Go and familiarity with big data technologies such as Hadoop are also emerging as valuable assets.

Conclusion:
The analysis of the skills required for top data analyst roles in 2023 reveals a strong emphasis on programming languages (especially SQL and Python), data visualization tools (Tableau and Power BI), and cloud technologies (AWS, Azure).
This indicates that candidates should focus on developing proficiency in these areas to enhance their employability in the competitive job market.
Additionally, familiarity with collaboration tools and big data frameworks can provide a significant advantage.
*/

