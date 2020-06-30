-- Recalling all previous concepts in combination

-- Select fields
SELECT DISTINCT c.name, e.total_investment,  e.imports
  FROM countries AS c
    LEFT JOIN economies AS e
      -- Match on code
      ON (c.code = e.code
      -- and code in Subquery
        AND c.code IN (
          SELECT l.code
          FROM languages AS l
          WHERE official = 'True'
        ) )
  -- in Central America for year 2015
  WHERE c.region = 'Central America' AND year = 2015
-- Order by country name
ORDER BY c.name;



SELECT c.region, c.continent, AVG(p.fertility_rate) AS avg_fert_rate
  FROM countries AS c
    INNER JOIN populations AS p
      ON c.code = p.country_code
  -- Where specific records match year 2015
  WHERE year = 2015
-- Group appropriately (both region and continent should be included, as they do not represent AGGREGATE values)
GROUP BY region, continent
ORDER BY avg_fert_rate DESC;

SELECT name, country_code, city_proper_pop, metroarea_pop,
      -- Calculate percentage of metro area population from the total population of the city
      city_proper_pop / metroarea_pop * 100 AS city_perc
  FROM cities
  WHERE name IN  -- Select only the resutls for Europe and Americas
    (SELECT capital
     FROM countries
     WHERE (continent = 'Europe'
        OR continent LIKE '%America'))
       AND metroarea_pop IS NOT NULL  -- select records that are not NULL
ORDER BY city_perc DESC
LIMIT 10;  -- select only top 10 results
