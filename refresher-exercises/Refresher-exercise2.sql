-- Aggregate functions can be combined with the WHERE clause to gain further insights from data
SELECT SUM(budget)
FROM films
WHERE release_year >= 2010; -- returns the sum budget of fimls released after/in 2010

SELECT AVG(gross)
FROM films
WHERE title LIKE 'A%'
AND release_year BETWEEN 2000 AND 2012;

SELECT title, 
        (gross - budget) AS net_profit -- usual arithmetic operations between values
FROM films;
SELECT AVG (duration) / 60.0 AS avg_duration_hours
FROM films;

-- calculating death rate in PERCENTAGE
SELECT (COUNT(deathdate) * 100.0 / COUNT(*)) AS percentage_dead 
FROM people;

                                         
                                         
-- SORTING AND GROUPING:
-- ORDER BY keyword is used to sort results in ascending or descending order 
SELECT title
FROM films
ORDER BY release_year DESC; -- returns the results sorted in DESCENDING order

SELECT title
FROM films
WHERE release_year BETWEEN 2000 AND 2012
ORDER BY release_year; -- returns titles of films released btw 2000 and 2012 in ascending order
										 
SELECT title, gross
FROM films
WHERE title LIKE 'M%'
ORDER BY title;
-- ordering can be odne based on multiple columns:
SELECT birthdate, name
FROM people
ORDER BY birthdate, name; -- first ordered by birthdate, then - by name alphabetically
			
					 
-- GROUP BY - groups (aggregates) a result by one or more columns
-- commonly, GROUP BY is used with aggregate functions like COUNT() or MAX()
-- SQL will return an error if you try to SELECT a field that is not in your GROUP BY clause 
-- without using it to calculate some kind of value about the entire group
SELECT release_year, COUNT(*)
FROM films
GROUP BY release_year
ORDER BY release_year;
					 
SELECT country, release_year, MIN (gross)
FROM films
GROUP by country,release_year
ORDER BY country, release_year; -- returns the contry name, year and min gross revenue
-- works fine, because both country and release year (unaggregated values) are in the GROUP BY statement

					 
-- AGGREGATE functions can not be used in WHERE statements in SQL
-- to filter this way, use HAVING instead of WHERE, it allows aggregate functions
SELECT release_year
FROM films
GROUP BY release_year
HAVING COUNT(title) > 10;


SELECT country, AVG(budget) as avg_budget, AVG(gross) as avg_gross
FROM films
GROUP BY country
HAVING COUNT(title) > 10
ORDER BY country
LIMIT 5;

