-- This query shows the news sources, which produce the most posts for each location

-- old solution
SELECT COUNT(news_posts.source_url) as frequency,
      news_posts.source_url,
      news_sources.location_name
FROM news_posts
INNER JOIN news_sources ON news_posts.source_url = news_sources.url
GROUP BY location_name, source_url  -- the query works because the non-aggregate source_url is in GROUP BY statement, tolerated by SQL
ORDER BY location_name, frequency DESC;

-- new solution
SELECT COUNT(source_url) AS frequency,
       source_url,
       location_name
    FROM news_posts AS np
    INNER JOIN news_sources ns on np.source_url = ns.url
    WHERE source_url = (  -- Main difference - WHERE clause filtering only the top first result
        SELECT n1.source_url
        FROM news_posts AS n1
        INNER JOIN news_sources n2 ON n1.source_url = n2.url
        WHERE n2.location_name = ns.location_name
        GROUP BY n1.source_url
        ORDER BY COUNT(*) DESC, n1.source_url
        LIMIT 1)  -- leaving only 1 result per each group
    GROUP BY location_name, source_url
    ORDER BY location_name, frequency DESC;
