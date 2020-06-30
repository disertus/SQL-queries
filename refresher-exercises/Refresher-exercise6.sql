-- Subqueries inside WHERE statements
SELECT name, fert_rate
FROM states
WHERE continent = 'Asia'
  AND fert_rate <           -- this statement compares the fertility in asian states and selects only those
    (SELECT AVG(fert_rate)  -- which are below the average for all states
     FROM states);


-- Subqueries inside SELECT clause
SELECT DISTINCT continent
  (SELECT COUNT(*)
   FROM states
   WHERE prime_ministers.continent = states.continent) AS countries_num -- it's necessary to create an alias to name the field of a subquery
FROM prime_ministers;
