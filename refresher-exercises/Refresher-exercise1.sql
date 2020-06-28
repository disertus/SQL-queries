 -- Walkthrough the basic comcepts of SQL with commented explanations for myself

-- selection of single 'field' or 'column' (terms used interchangably)
SELECT name FROM people;

-- selection of two and more fileds
SELECT title, release_year FROM films;

-- selection of all fields 'limited' to first 10 rows 
SELECT * FROM people LIMIT 10;

-- selection of unique entries with DISTINCt for duplicated entries
SELECT DISTINCT language FROM films;



-- COUNT() aggregate function; Count all entries:
SELECT COUNT(*) FROM people;
-- Count all unique entries in a column:
SELECT COUNT(DISTINCT language) FROM films;



-- WHERE keyword allows to filter based on both text and numeric values in a table
-- always comes after the FROM statement
SELECT title
FROM films
WHERE title = 'Metropolis'; -- string search

SELECT name, language, release_year
FROM films
WHERE language = 'Spanish'
AND release_year > 2000
AND release_year < 2010; -- use unlimited amount of AND operators to select entires upon multiple conditions
                         -- NB: specify the column name separately for every AND condition



-- AND / OR conditions, used when some but not all of the conditions need to be met
SELECT title
FROM films
WHERE release_year = 1994
OR release_year = 2000;

-- when combining AND and OR, enclose the individual clauses in parentheses
SELECT title
FROM films
WHERE (release_year = 1994 OR release_year = 1995)
AND (certification = 'PG' OR certification = 'R');

SELECT title, release_year
FROM films
WHERE (release_year >= 1990 AND release_year < 2000)
AND (language = 'French' OR language = 'Spanish')
AND gross > 2000000;


-- BETWEEN keyword filters values within a specified range (replaces the WHERE ... AND ... construction)
SELECT title
FROM films
WHERE release_year
BETWEEN 1994 AND 2000;  -- in this case, there's no need to specify the column name each time


-- WHERE ... IN operator allows to specify multiple values in the same WHERE clause
-- this helps to avoid constructions like:
SELECT *
FROM table_name
WHERE ... = ...
OR ... = ...
OR ... = ...
-- Instead it's better to use where-in clause:
SELECT title, release_year
FROM films
WHERE release_year IN (1990, 2000)
AND duration > 120; 


-- WITH clause allows to give a sub-query block a name which can be referenced in several places within the main SQL query
WITH Roster AS                                         -- first the query mentioned within the  clause is evaluated
 (SELECT 'Adams' as LastName, 50 as SchoolID UNION ALL -- the output of this evaluation is stored in a temporary relation
  SELECT 'Buchanan', 52 UNION ALL
  SELECT 'Coolidge', 52 UNION ALL
  SELECT 'Davis', 51 UNION ALL
  SELECT 'Eisenhower', 77)
SELECT * FROM Roster                                   -- following this, the main query associated with the WITH clause is finally executed


-- IS NULL checks for null (missing) values
SELECT COUNT(*)
FROM people
WHERE birthdate IS NULL;	-- returns the number of missing values in the table

-- IS NOT NULL returns only the entries, which don't contain any missing values
SELECT name
FROM people
WHERE birthdate IS NOT NULL;


-- LIKE and NOT LIKE operators can be used in a WHERE clause to search for a pattern in a column
-- '%' will match zero, one, or many characters in text:
SELECT name
FROM companies
WHERE name LIKE 'Data%'; -- matches 'Datafile' 'Datatable' etc.
-- '_' wildcard will match a single character
SELECT name
FROM companies
WHERE name LIKE 'DataC_mp';  -- matches 'DataCimp', 'DataCymp' etc.

SELECT name
FROM people
WHERE name LIKE '_r%'; -- returns the names of people, that have 'r' as second letter
SELECT name
FROM people
WHERE name NOT LIKE 'A%'; -- returns the names of people, that don't start with 'A'

-- AGGREGATE FUNCTIONS - functions which perform some sort of calculation over the data
-- AVG() returns the average value of all entries in the field
SELECT AVG(budget)
FROM films;
-- MAX() / MIN() returns the maximum/minimum value in the field
SELECT MAX(budget)
FROM films;
-- SUM() returns the sum of all values in the filed
SELECT SUM(budget)
FROM films;







