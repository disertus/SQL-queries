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
 
-- WHERE clause can considerably reduce the amount of presented rows, and therefore limit the workload for the DB
-- It appears early in the order of query execution, which is a plus - no need to load unnecessary data

-- EXAPLAIN command - dispalys the order and cost estimation of a query (not valid for BigQuery, though)
-- Handy to use before launching queries on big data sets, which may influence the performance of the DB
EXPLALIN 
SELECT *
FROM phones
WHERE country LIKE ANY(ARRAY(['Ch%', 'In%']) -- this query combines filters into one operation
                       
EXPLAIN
SELECT *
FROM phones
WHERE country LIKE 'Ch%'
OR country LIKE 'In%'  -- filtering happens as two separate operations
                       
-- Same as above goes for the WHERE IN clauses - they are more readable and efficient than checking each value separately
-- as in WHERE ... = '...' AND ... = '...'. WHERE ... IN ('...', '...') is better
                       
-- Integers are easier to search - less workload for the DB (therefore codes are preferred to words when filtering results)
-- they are shorter, take less memory storage

-- Instead of JOINing on multiple values, it's better to use the WHERE filter, which will limit the amount of presented records
-- and make the query faster

-- Always match the records with the same detail granularity to prevent duplication

-- View != table, it just indicates the direction towards the data inside the tables
-- THere are simple and Materialized views - those which store the 

-- SQL DBs are quick to return columns (constant time), and slow returning the rows (linear time complexity)


