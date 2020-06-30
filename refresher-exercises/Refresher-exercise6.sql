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

-- 2. Select fields
SELECT name, country_code, urbanarea_pop
  -- 3. From cities
  FROM cities
-- 4. Where city name in the field of capital cities
WHERE name IN
  -- 1. Subquery
  (SELECT capital
   FROM countries)
ORDER BY urbanarea_pop DESC;
