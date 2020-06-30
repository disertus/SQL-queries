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


-- Subqueries inside FROM clause
-- It is possible to indicate two fields in the FROM clause

-- Select the maximum inflation rate as max_inf
SELECT max (inflation_rate) as max_inf, continent
  -- Subquery using FROM
  FROM (
      SELECT name, continent, inflation_rate
      FROM countries
      INNER JOIN economies
      USING (code)
      WHERE year = 2015) AS subquery
-- Group by continent
GROUP BY continent;
