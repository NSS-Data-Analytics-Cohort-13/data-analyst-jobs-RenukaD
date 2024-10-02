-- All the information about data_analyst_jobs table.
SELECT *
FROM data_analyst_jobs;

-- Q1 How many rows are in the data_analyst_jobs table?

SELECT COUNT(*)
FROM data_analyst_jobs;
--Answer = 1793

--Q2 Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;
-- Table with first 10 rows.

--Q3 How many postings are in Tennessee? 

SELECT COUNT(title) AS TN_postings_count
FROM data_analyst_jobs
WHERE location = 'TN';
--Answer = 21

--Q3 How many are there in either Tennessee or Kentucky?

SELECT COUNT(title) AS TN_or_KY_count
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';
--Answer = 27

--Q4 How many postings in Tennessee have a star rating above 4?

SELECT COUNT(title) AS star_rating_above4
FROM data_analyst_jobs
WHERE location = 'TN'
AND star_rating > 4;
--ANSWER = 3

--Q5 How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(title) AS review_count
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
--Answer = 151

--Q6 Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?

SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY location;
-- Answer = Table with 2 columns 'state' and 'avg_rating'.

--Q7 Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT COUNT(DISTINCT(title)) AS job_title_count
FROM data_analyst_jobs;
--Answer = 881

--Q8 How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT(title)) AS job_title_count
FROM data_analyst_jobs
WHERE location = 'CA';
--Answer = 230

--Q9 Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

