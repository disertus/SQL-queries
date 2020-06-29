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


-- UNION names the resulting field as the first selected record ('country_code'):
SELECT cities.country_code
  FROM cities
	UNION
SELECT currencies.code
  FROM currencies
ORDER BY country_code;
