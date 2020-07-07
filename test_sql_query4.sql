-- continuation of the test assignment - more complex query

-- generating a stored procedure to abstract all unnecessary details away for the final step
CREATE PROCEDURE sql_assignment.SelectViewsPerLoc (loc STRING)
BEGIN
DECLARE loc_name STRING DEFAULT loc;  -- procedure parameter 'loc' will correspond to the loc_name in WHERE clause
WITH views_per_month AS
  (SELECT FORMAT_TIMESTAMP('%b %Y', view_date) as month,
        source_url,
        SUM(pageviews_count) AS views
  FROM sql_assignment.pageviews AS p
  INNER JOIN sql_assignment.news_posts AS n ON p.post_url = n.url
  GROUP BY source_url, month
  ORDER BY month DESC)
SELECT month,
       ANY_VALUE(if(source_url = 'allo.ua', views, null)) AS allo,
       ANY_VALUE(if(source_url = 'facebook.com', views, null)) AS facebook,
       ANY_VALUE(if(source_url = 'google.com', views, null)) AS google,
       ANY_VALUE(if(source_url = 'amazon.com', views, null)) AS amazon,
       ANY_VALUE(if(source_url = 'root.kz', views, null)) AS root,
       ANY_VALUE(if(source_url = 'rozetka.ua', views, null)) AS rozetka
FROM views_per_month AS vp
INNER JOIN sql_assignment.news_sources AS ns ON vp.source_url = ns.url
WHERE ns.location_name = loc_name -- corresponds to the 'loc' parameter
GROUP BY month
ORDER BY month DESC;
END;


-- Final query with highest level of abstraction (commented out): 
-- replacing the 'UA' string by 'US' or 'KZ' will produce location-specific results 

DECLARE loc STRING DEFAULT 'UA';
CALL sql_assignment.SelectViewsPerLocation(loc);
