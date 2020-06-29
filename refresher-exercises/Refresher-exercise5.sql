-- Set Theory - UNION, UNION ALL, INTERSECT, EXCEPT
-- UNION - includes the records in both tables, but does not doublecount them:
1
2
3
4
5
6
-- UNION ALL - includes all records in both tables and replicates them:
1*
1*
2
3
4*
4*
5
6
-- INTERSECT - includes only the records found in both tables. Records that do not overlap are excluded
-- EXCEPT - includes only the records unique for left table, and missing or overlapping records are excluded


-- UNION names the resulting field as the first one selected ('country_code'):
SELECT cities.country_code
  FROM cities
	UNION
SELECT currencies.code
  FROM currencies
ORDER BY country_code;




-- INTERSECT - only returns the keys that are present in both tables, the rest is ignored
-- !! IMPORTANT !! INTERSECT selects based on the records, not on the presents of the keys (like JOIN does)
SELECT country
FROM prime_ministers
INTERSECT
SELECT country
FROM presidents; -- shows the countries, which have both the president and the PM

SELECT e.code, e.year
  -- From economies
  FROM economies AS e
	-- Set theory clause
	INTERSECT
-- Select fields
SELECT p.country_code AS code, p.year -- should be named the same as fields in SELECT-1
  -- From populations
  FROM populations AS p
-- Order by code and year
ORDER BY code, year;


-- EXCEPT - selects the records that are uniquely in LEFT table, and not in the RIGHT one
SELECT monarch, country
FROM monarchs
EXCEPT 
SELECT pm, country
FROM prime_ministers;

-- SEMI-JOIN - picks only keys and values from LEFT table if those keys are present in the RIGHT talbe
SELECT DISTINCT l.name -- unique names of languages
  FROM languages AS l
WHERE l.code IN		-- if the country code from language table is inside the subquery
  (SELECT c.code
   FROM countries AS c
   WHERE region = 'Middle East')
ORDER BY l.name;
-- the query above is equivalent to:
SELECT DISTINCT languages.name AS language
FROM languages
INNER JOIN countries
ON languages.code = countries.code
WHERE region = 'Middle East'
ORDER BY language;

-- ANTI-JOIN - seves to determine if certain values or keys were missed out
-- 3. Select fields
SELECT code, name
  -- 4. From Countries
  FROM countries
  -- 5. Where continent is Oceania
  WHERE continent = 'Oceania'
  	-- 1. And code not in
  	AND code NOT IN
  	-- 2. Subquery
  	(SELECT code
  	 FROM currencies);
	 
SELECT c1.name
  -- Alias the table where city name resides
  FROM cities AS c1
  -- Choose only records matching the result of following clauses
  WHERE c1.country_code IN
(
    -- Select appropriate field from economies AS e
    SELECT e.code
    FROM economies AS e
    -- Get all additional (unique) values of the field from currencies AS c2  
    UNION
    SELECT DISTINCT c.code
    FROM currencies AS c
    -- Exclude those appearing in populations AS p
    EXCEPT
    SELECT p.country_code AS code
    FROM populations AS p
);
