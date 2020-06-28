-- Queries of intermediate complexity with commented explanations for myself


-- Aggregate functions can be combined with the WHERE clause to gain further insights from data
SELECT SUM(budget)
FROM films
WHERE release_year >= 2010; -- returns the sum budget of fimls released after/in 2010

SELECT AVG(gross)
FROM films
WHERE title LIKE 'A%'
AND release_year BETWEEN 2000 AND 2012;

