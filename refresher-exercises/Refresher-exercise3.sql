-- INNER and LEFT joins - two most common types of table joins
-- KEY FIELD - required to reference one table's values to another
-- PRIMARY KEYS are the unique identifiers, therefore can not have duplicates 

-- INNER JOIN **only includes records in which the key is in both tables - other keys are ignored and left out**
-- look up the matches in the right table corresponding to the key in the left table

SELECT p1.country, p1.continent,
       prime_minister, president
FROM prime_ministers AS p1
INNER JOIN presidents AS p2  -- joins two tables having the same keys on 'country' key filed
ON p1.country = p2.country

SELECT cities.name AS city, 
       countries.name AS country, 
       countries.region
FROM cities
INNER JOIN countries
    ON cities.country_code = countries.code;
    
SELECT c.code AS country_code, 
        name, 
        year, 
        inflation_rate
FROM countries AS c
  INNER JOIN economies AS e
    ON e.code = c.code;

-- it is possible to COMBINE MULTIPLE JOINS in SQL. 
-- It's useful to alias table names like their first letters to make queries more readable
SELECT *
FROM left_table
  INNER JOIN right_table
    ON left_table.id = right_table.id  -- joins the first 'right' table
  INNER JOIN another_table
    ON left_table.id = another_table.id;  -- joins the second 'right' table
    
SELECT c.code,
    c.name, 
    c.region, 
    p.year,
    p.fertility_rate
FROM countries AS c
INNER JOIN populations AS p
ON p.country_code = c.code;


-- !! if the field name is unique (not used in different tables), it can be referenced without the 'table.field' statement, just 'field'
SELECT c.code, 
    name, 
    region, 
    e.year, 
    fertility_rate, -- unique names, no need for the table name preceding it
    unemployment_rate
  FROM countries AS c
  INNER JOIN populations AS p
    ON c.code = p.country_code
  INNER JOIN economies AS e
    ON c.code = e.code;
    
    
-- INNER JOIN with USING as a shortcut
-- when a key field has the same name in both tables it's possible to use USING instead of ON
SELECT l.id
       l.val
       r.val
FROM l
INNER JOIN r
USING (id); -- id field's name is the same in both tables, such wording is shorter and more readable
            -- the order of joins in this case does not play a big role
            
SELECT c.name AS country,
    continent,
    l.name AS language,
    l.official
  FROM countries AS c
  INNER JOIN languages AS l
    USING (code);

-- SELF (inner) JOINS - when a table is joined with itself
-- used to compare values from the field to other values from the same field of the same table
SELECT p1.country AS country1,
       p2.country as country2,
       p1.continent
FROM prime_ministers AS p1
INNER JOIN prime_ministers AS p2
ON p1.continent = p2.continent
LIMIT 14;  -- query creates pairs - repeated country 1 -> all countries 2 which are on the same continent, including ITSELF AS COUNTRY2
-- to fix the above, use:
ON p1.continent = p2.continent AND p1.country <> p2.country


-- CASE WHEN and THEN, ELSE, END (finally)
-- equivalent to if-else statements in other programming languages
SELECT name, continent, indep_year
       CASE WHEN indep_year < 1900 THEN 'before 1900'  -- equivalent to 'if indep_year < 1900 print('before 1900')
            WHEN indep_year <= THEN 'between 1900 and 1930'
            ELSE 'after 1930' END
            AS indep_year_group  -- puts everything from the above CASE staement into the 'indep_year_group' field
FROM states
ORDER BY indep_year_group;

SELECT p1.country_code,
       p1.size AS size2010,
       p2.size AS size2015,
       ((p2.size - p1.size)/p1.size * 100.0) AS growth_perc -- calculates the growth in population in percents for a given time period
FROM populations as p1
  INNER JOIN populations as p2
    ON p1.country_code = p2.country_code
        AND p1.year = (p2.year - 5); -- filters out the repeating results from self join


SELECT name, continent, code, surface_area,
    -- First case
    CASE WHEN surface_area > 2000000 THEN 'large'
        -- Second case
        WHEN surface_area > 350000 THEN 'medium'
        -- Else clause + end (finally)
        ELSE 'small' END
        -- Alias name for the new field
        AS geosize_group
FROM countries
WHERE year = 2015;  -- results only for 2015

-- INTO is used to save the current selection INTO the table named as the following alias 
-- it is possible to create multiple separate selections, store them INTO separate tables, and combine them in another selection
SELECT country_code, size,
  CASE WHEN size > 50000000
            THEN 'large'
       WHEN size > 1000000
            THEN 'medium'
       ELSE 'small' END
       AS popsize_group
INTO pop_plus       
FROM populations
WHERE year = 2015;

-- Select fields
SELECT c.name,
    c.continent,
    c.geosize_group,
    p.popsize_group
-- 1. From countries_plus (alias as c)
FROM countries_plus AS c
  -- 2. Join to pop_plus from previous query (alias as p)
  INNER JOIN pop_plus AS p
    -- 3. Match on country code
    ON c.code = p.country_code
-- 4. Order the table    
ORDER BY popsize_group, continent;





