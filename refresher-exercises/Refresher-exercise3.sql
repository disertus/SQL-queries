-- INNER and LEFT joins - two most common types of table joins
-- KEY FIELD - used to reference one table to another
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
    
    
-- INNER JOIN with USING
-- when a key firld has the same name in both tables it's possible to use USING instead of ON
SELECT l.id
       l.val
       r.val
FROM l
INNER JOIN r
USING (id); -- id field's name is the same in both tables, such wording is shorter and more readable
            -- the order of joins in this case does not play a big role


