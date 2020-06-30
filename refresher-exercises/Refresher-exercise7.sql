-- Recalling all previous concepts in combination

-- Select fields
SELECT DISTINCT c.name, e.total_investment,  e.imports
  FROM countries AS c
    LEFT JOIN economies AS e
      -- Match on code
      ON (c.code = e.code
      -- and code in Subquery
        AND c.code IN (
          SELECT l.code
          FROM languages AS l
          WHERE official = 'True'
        ) )
  -- in Central America for year 2015
  WHERE c.region = 'Central America' AND year = 2015
-- Order by country name
ORDER BY c.name;
