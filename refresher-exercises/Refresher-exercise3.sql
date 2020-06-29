-- INNER and LEFT joins - two most common types of table joins
-- KEY FIELD - used to reference one table to another

-- INNER JOIN **only includes records in which the key is in both tables - other keys are ignored and left out**
-- look up the matches in the right table corresponding to the key in the left table

SELECT p1.country, p1.continent,
       prime_minister, president
FROM prime_ministers AS p1
INNER JOIN presidents AS p2  -- joins two tables having the same keys on 'country' key filed
ON p1.country = p2.country
