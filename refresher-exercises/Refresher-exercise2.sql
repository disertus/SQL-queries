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

SELECT name
FROM people
ORDER BY name;

SELECT title
FROM films
WHERE release_year BETWEEN 2000 AND 2012
ORDER BY release_year; -- returns titles of films released btw 2000 and 2012 in ascending order
										 

