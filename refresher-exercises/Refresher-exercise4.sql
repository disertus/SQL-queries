-- LEFT and RIGHT JOINs, FULL JOINs are types of OUTER joins
-- they keep the records of the original table while reaching out for the records from the new one.
-- On the contrary, INNER JOINs keep only the records, that are present IN both tables - key fields that are in both tables (on the intersection)



-- ### LEFT JOIN checks the key field in the left table, and the key field in the right table,
-- then it extracts the values from the right table (just as in INNER JOIN) no matter if the keys are present in the right table or not
-- if the keys from LEFT are missing in the RIGHT, the selected values will be NULL
-- keys present in RIGHT but missing in LEFT will not be presented at all.
-- Sometimes there may be multiple matches for one LEFT key, all of those will be represented
SELECT p1.country, prime_minister, president
FROM prime_minsters AS p1
LEFT JOIN presidents AS p2
ON p1.country = p2.country;

SELECT c1.name AS city, code, c2.name AS country,  -- selects all values for all keys in the LEFT table, even if values in the RIGHT are NULL
       region, city_proper_pop
FROM cities AS c1
  -- 1. Join right table (with alias)
  LEFT JOIN countries AS c2
    -- 2. Match on country code
    ON c1.country_code = c2.code
-- 3. Order by descending country code
ORDER BY code DESC;

SELECT c.region, AVG(e.gdp_percapita) AS avg_gdp 
FROM countries AS c
  LEFT JOIN economies AS e
    -- Match on code fields
    USING (code)
-- Focus on 2010
WHERE year = 2010
-- Group by region
GROUP BY c.region;

-- RIGHT JOIN is much less common then inner or left JOINs
-- It is the reverse of the LEFT JOIN


-- FULL JOINs - selects all values for both LEFT and RIGHT table, despite lacking keys or values in any of those
SELECT p1.country AS pm_co, p2.country AS pres_co,
       prime_minister, president
FROM prime_ministers AS p1
FULL JOIN presidents AS p2
USING (country);

SELECT name AS country, code, region, basic_unit
-- 1. From countries
FROM countries
  -- 2. Join to currencies
  FULL JOIN currencies
    -- 3. Match on code
    USING (code)
-- 4. Where region is North America or null
WHERE region = 'North America' OR region IS null
ORDER BY region;

SELECT c.name, code, l.name AS language
FROM languages AS l
  FULL JOIN countries AS c
    USING (code)
-- Where countries.name starts with V or is null
WHERE c.name LIKE 'V%' OR c.name IS NULL
ORDER BY c.name;

-- 7. Select fields
SELECT c1.name AS country, region, l.name AS language,
       basic_unit, frac_unit
-- 1. From countries
FROM countries AS c1
  -- 2. Join with languages
  FULL JOIN languages AS l
  -- 3. Match on code
    USING (code)
  -- 4. Join with currencie
  FULL JOIN currencies AS c2
    -- 5. Match on code
    USING (code)
-- 6. Where region like Melanesia and Micronesia
WHERE region LIKE 'Melanesia' OR region LIKE 'Micronesia';



