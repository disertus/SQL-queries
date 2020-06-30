-- FULL JOINs are the least efficient among outer joins, try not to use them

-- do not use Subqueries inside the FROM clause - it's less efficient than in WHERE or SELECT clauses

-- or, one can use the common table expressions (CTE), wrapped by a WITH statement - a standalone query returning a temporary result set
-- more time- and resource-effective comparing to the subqueries

-- Creating Temp tables can be useful, because they allow to perform several queries upon them (till the session is alive)
-- this opposes them to CTEs, which disappear directly after they have been used
CREATE TEMP TABLE tmp AS
  SELECT holiday, holiday_types
  FROM world_holidays
  WHERE country_code = 'USA'
 
