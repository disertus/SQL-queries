-- continuation of the test assignment - more complex query

-- part 1 - generating a materialized view, for further reference in the next query
WITH views_per_month AS
 (SELECT view_date,
        source_url,
        pageviews_count as views
  FROM sql_assignment.pageviews AS p
  INNER JOIN sql_assignment.news_posts AS n ON p.post_url = n.url
  ORDER BY view_date DESC)
  
SELECT CASE WHEN EXTRACT(DAY FROM view_date) BETWEEN 26 and 31 -- transfers the records whose date is > 26 to the next month
                THEN CONCAT(EXTRACT(YEAR FROM view_date), '-', (EXTRACT(MONTH FROM view_date) + 1), '-01') -- concatenates the resulting month number and the year, for the GROUP BY clause in the next step 
            WHEN EXTRACT(DAY FROM view_date) < 26 THEN CONCAT(EXTRACT(YEAR FROM view_date), '-', EXTRACT(MONTH FROM view_date), '-01')
            END
            AS month,
       source_url,
       views
FROM views_per_month
ORDER BY view_date;

-- part 2 - quering the generated view
SELECT FORMAT_DATE('%b %Y', CAST(month AS DATE)),  -- query extracting necessary info from the pre-saved view
       source_url,
       SUM(views) AS tot_views
FROM sql_assignment.ex2_26days_into_months -- materialized view generated from the previous query to abstract unnecessary details away
GROUP BY month, source_url
ORDER BY month;
