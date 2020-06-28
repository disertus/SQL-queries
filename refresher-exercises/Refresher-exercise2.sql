-- Queries of intermediate complexity with commented explanations for myself


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
