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

--Q3 part 1 - How many postings are in Tennessee? 

SELECT COUNT(title) AS TN_postings_count
FROM data_analyst_jobs
WHERE location = 'TN';
--Answer = 21

--Q3 Part 2 - How many are there in either Tennessee or Kentucky?

SELECT COUNT(title) AS TN_or_KY_count
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';
--WHERE location IN ('TN','KY');
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

SELECT location AS state, ROUND(AVG(star_rating),3) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC;
-- Answer = 46 records and a table with 2 columns 'state' and 'avg_rating'.

--Q7 Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT COUNT(DISTINCT(title)) AS job_title_count
FROM data_analyst_jobs;
--Answer = 881

--Q8 How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT(title)) AS job_title_count
FROM data_analyst_jobs
WHERE location = 'CA';
--Answer = 230

--Q9 part1 - Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT company, AVG(star_rating) AS avg_star_rating
FROM data_analyst_jobs 
WHERE company IS NOT NULL
GROUP BY company
HAVING MIN(review_count)>5000;
--Answer 40 records

--Q10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company, review_count, AVG(star_rating) AS avg_star_rating 
FROM data_analyst_jobs 
GROUP BY  company, review_count, star_rating 
HAVING review_count > 5000 
ORDER BY 3 DESC
--ORDER BY 3 means avg_star_rating
LIMIT 6;
--Answer - Got 6 rows with same star rating as below, that is why added Limit 6 condition instead of 1

--Q11 Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';
--Answer = 774

--Question 12 How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

--Create a subset word
WITH word AS
(
SELECT 
--step 2, step 3, step 4
REPLACE(UNNEST(string_to_array(title, ' ')),'(','') AS common_word 
FROM 
-- step 1 
(SELECT DISTINCT title AS title
FROM data_analyst_jobs
WHERE 
title NOT ILIKE '%ANALYST%'
AND
title NOT ILIKE '%ANALYTICS%')
)
--Step 5
 SELECT common_word, COUNT(*) AS word_count
 FROM word 
 GROUP BY common_word 
 HAVING LENGTH(common_word)!=1 
 ORDER BY 2 DESC 
 LIMIT 1;

--Answer = "Tableau"
/*
step 1 = Find titles which do not contain either the word ‘Analyst’ or the word ‘Analytics’ Execution time = 154 miliseconds
step 2 = Convert step 1 string, into array using string_to_array() function which splits a string into an array of words using a specified delimiter which in this case is an empty space ''
step 3 = Use UNNEST() function to expand an array into a set of rows
step 4 = Use REPLACE() function to replace ( to empty space since 2 of our Tablau records are attached with opening brackets
Step 5 = Select common word from word subset where length(common_word)!=1.This will remove the words like to, a , characters etc.*/

--End of question 12


