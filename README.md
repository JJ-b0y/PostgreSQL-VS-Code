# Introduction
## Explore the data job market! This project delves into Data Analysis roles, examining the highest-paying positions, essential skills in demand, and the intersection of high demand and lucrative salaries in data analytics.

## For the SQL queries, check out this link: [project_sql folder](/project_sql/)
# Background
## Motivated by the goal of effectively navigating the data analyst job market, this project emerged from a desire to identify the highest-paying and most sought-after skills, thereby simplifying the job search process and helping individuals find the best opportunities.

## Data hails from [SQL Course](https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### Insights were based on the following questions, which were answered through my SQL queries;

### 1. What are the top-paying jobs for my role?
### 2. What are the skills required for these top-paying roles?
### 3. What are the most in-demand skills for my role?
### 4. What are the top skills based on salary for my role?
### 5. What are the most optimal skills to learn?

# Tools I Used
## For adequate and comprehensive analysis into the data analysis job market, I harnessed the power of several key tools:
### - **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
### - **PostgreSQL:** The chosen database management system, ideal for handling our data.
### - **Visual Studio Code:** My go-to for database management and executing SQL queries.
### - **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring peer-review, collaboration and project tracking.

# The Analysis
## Each query for this project aimed at investigating specific aspects of the Data Analyst job market. Here's how  approached each question:

## 1. **Top Paying Data Analyst Jobs**
#### In order to identify the highest-paying roles, I filtered Data Analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

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
WHERE
    job_title_short = 'Data Analyst'
    AND
    job_location = 'Anywhere'
    AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
### Breaking down my findings of the top Data Analyst jobs in 2023:
### - **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
### - **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
### - **Job Title Variety:** Job titles are diverse, for example; Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Companies](project_sql\assets\top_10_paying_data_jobs.png)
*Bar graph visualizing the salary for the top 10 salaries for Data Analysts, as well as the companies associated with these offers.*

## 2. **Top Skills for Top Paying Jobs**
### In detecting the skills required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high compensation roles.

```sql
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
```
### Skill Frequency Analysis:
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

### Key Skills Overview
#### Programming Language:
1. SQL: This is the most frequently mentioned skill across all job postings, indicating its critical role in data analysis.
2. Python: Another highly sought-after programming language, often used for data manipulation and analysis.
3. R: Frequently listed, particularly for roles focused on statistical analysis and data visualization.
#### Data Visualization Tools:
Tableau and Power BI are prominent tools mentioned for visualizing data, suggesting that employers prioritize candidates who can effectively communicate insights through visual means.
#### Cloud Platforms:
Skills in AWS, Azure, and Snowflake are common, reflecting a trend towards cloud-based data solutions and storage.
#### Data Processing Frameworks:
Tools like Databricks, Pandas, and PySpark are highlighted, indicating a need for expertise in handling large datasets and performing complex transformations.
#### Version Control and Collaboration Tools:
Familiarity with tools such as GitLab, Bitbucket, and collaboration platforms like Atlassian (including Jira and Confluence) is essential, pointing to the importance of teamwork in data projects.
#### Other Notable Skills:
Knowledge of tools like Excel remains relevant, as it is widely used for basic data analysis tasks.
Skills in programming languages like Go and familiarity with big data technologies such as Hadoop are also emerging as valuable assets.

#### Conclusively, the analysis of the skills required for top data analyst roles in 2023 reveals a strong emphasis on programming languages (especially SQL and Python), data visualization tools (Tableau and Power BI), and cloud technologies (AWS, Azure).
#### This indicates that candidates should focus on developing proficiency in these areas to enhance their employability in the competitive job market.
#### Additionally, familiarity with collaboration tools and big data frameworks can provide a significant advantage.

## 3. **In-Demand Skills for Data Analysts**
### Here I queried the top 5 skills with the highest demand in the job market for Data Analyst roles. This will provide insights into the most valuable skills for job seekers.
### The query below pulled the top 5 skills by the count of job posted.

```
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
```
![Top 5 Skills in demand](project_sql\assets\top_5_skills.png)

### The Top 5 In-Demand Skills from our result:
#### **1. SQL:** With a demand count of 92,628, SQL stands out as the most critical skill for data analysts. Its importance lies in its ability to manage and query databases efficiently.
#### **2. Excel:** Following SQL, Excel has a significant demand of 67,031. This tool is essential for data manipulation, analysis, and visualization.
#### **3. Python:** The programming language Python is also crucial, with a demand count of 57,326. Its versatility in data analysis and machine learning makes it a valuable skill.
#### **4. Tableau:** With a demand count of 46,554, Tableau is recognized for its powerful data visualization capabilities.
#### **5. Power BI:** Lastly, Power BI has a demand count of 39,468, indicating its growing popularity in business intelligence and reporting.

## 4. Skill Based on Salary
### Exploring the average salaries associated with different skills revealed which skills attract the highest pay.

```sql
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
```

### Breaking down our result:
#### **Top Skills in Demand:** The highest-paying skill for data analysts is PySpark with an average salary of $208,172 reflecting the strong demand for big data processing capabilities.
#### **Collaboration Tools:** Skills like Bitbucket and GitLab, with salaries of $189,155 and $154,500, respectively, highlight the importance of collaboration and version control in data projects.
#### **AI and Cloud Technologies:** Proficiency in AI tools such as Watson and cloud technologies like Databricks (average salary of $141,907) indicates a growing trend towards integrating advanced technologies in data analytics roles.

![Skills Based on Salary](project_sql\assets\top_paying_data_skills.png)

## 5. **Most Optimal Skills to Acquire**
### Combining insights from our demand count and salary data, this query aim to pinpoint skills that are both in demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT (skills_job_dim.job_id) AS demand_count,
    ROUND(AVG (job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND
    salary_year_avg IS NOT NULL
    AND
    job_work_from_home = 'True'
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT (skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

![Most Optimal Skills](project_sql\assets\most_optimal_skill.PNG)
*Illustrating the Top 10 Most Optimal Skill, comparing their average salary to their demand count.*

### Breaking down the most optimal skills for Data Analysts in 2023.
### - **High-Demand Programming Language:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python, and $100,499 for R. This indicates that proficiency in these languages is highly valued, but also widely available.
### - **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show signnificant demand with relatively high average salaries, signifying the growing importance of cloud platforms and big data technologies in data analysis.
### - **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively and average salaries of about $99,288 and $103,795 respectively. This information highlights the crucial role of business inteliigence and data visualization in deriving actionable insights from data to inform business strategy.
### - **Database Technology:** The demand for skills in traditional and NoSQL database (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What I learned
### Through out this project, I have turbocharged my SQL toolkit with some firepower:
### - **Complex Query Crafting:** Mastered the art of Advanced Query, expertly merging tables and wielding WITH clause in maneuvering them.
### - **Data Aggregation:** Utilizing aggregate functions such as; GROUP BY, COUNT (), and AVG () in data summary.
### - **Analytical Wizardry:** Turning questions into actionable, insightful queries.
### - **Extractions:** Extracting information beyond surface-level through functions like JOIN, UNION, DATE (AND TIME) FUNCTIONS, SUBQUERIES, AND CTEs.

# Conclusions
### **Insights**
### 1. **Top-Paying Data Analyst Jobs:** The highest paying jobs for Data Analysts that allow remote work offer a wide range of salaries, the highest is $650,000.
### 2. **Skills for Top-Paying Jobs:** High-paying Data Analyst jobs require advanced proficiency in SQL, suggesting it is a critical skill for earning top salary.
### 3. **Most In-Demand Skills:** SQL is also the most sought-after skill in the Data Analyst job market, thus making it essential for job seekers.
### 4. **Skills with Higher Salaries:** Specialized skills, such as Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
### 5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for Data Analysts to acquire in order to maximize their market value.
### **Closing Thoughts**
#### This project enhanced my SQL skills and provided valuable insights into the competitive nature of the Data Analyst job market. The findings from this project serve as a guide to prioritize skill development and expansion, while widening my job search efforts. Aspiring Data Analysts can better position themselves in the current job market by focusing on high-demand, high-salary skills. While the market pool is saturated with Data Analyst, the demand for these skills are also equally high, which gives me hope to continue to improve and embark on more complex projects, so as to continually update my knowledge to the emerging trends in the field of analytics.