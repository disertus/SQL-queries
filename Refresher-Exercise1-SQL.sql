 -- Walkthrough the basic comcepts of SQL with commented explanations for myself

-- selection of single 'field' or 'column' (terms used interchangably)
SELECT name FROM people;

-- selection of two and more fileds
SELECT title, release_year FROM films;

-- selection of all fields 'limited' to first 10 rows 
SELECT * FROM people LIMIT 10;

-- selection of unique entries with DISTINCt for duplicated entries
SELECT DISTINCT language FROM films;

-- COUNT aggregate function; Count all entries:
SELECT COUNT(*) FROM people;
-- Count all unique entries in a column:
SELECT COUNT(DISTINCT birthdate) FROM people;

