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
