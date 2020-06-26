-- This query calculates the median of the titles lengths for each location
-- Note: MySQL 

SET @row_number := 0;
SET @median_group :='';

SELECT
      median_group, AVG(FORMAT(LENGTH(post_title), 4)) AS median
FROM
   (SELECT
           @row_number:=CASE WHEN @median_group = location_name THEN @row_number + 1 ELSE 1
           END AS count_of_group,
           @median_group:=location_name AS median_group,
           location_name,
           post_title,
           (SELECT COUNT(*) FROM news_posts INNER JOIN news_sources ON news_posts.source_url = news_sources.url
               WHERE a.location_name = location_name) AS total_of_group
   FROM
        (SELECT
                location_name,
                post_title
           FROM
                news_posts INNER JOIN news_sources ON news_posts.source_url = news_sources.url
           ORDER BY location_name, post_title) AS a) AS b
WHERE
     count_of_group IN (FLOOR(total_of_group / 2.0), CEIL(total_of_group / 2.0 + 1))
GROUP BY median_group
