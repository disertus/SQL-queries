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

SELECT title
FROM films
WHERE release_year > 2000; -- comparison operators

-- WITH clause is used to to emulate a temporary table name for the query
WITH Roster AS
 (SELECT 'Adams' as LastName, 50 as SchoolID UNION ALL
  SELECT 'Buchanan', 52 UNION ALL
  SELECT 'Coolidge', 52 UNION ALL
  SELECT 'Davis', 51 UNION ALL
  SELECT 'Eisenhower', 77)
SELECT * FROM Roster


