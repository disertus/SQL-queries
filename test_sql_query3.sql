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
SELECT news_sources.location_name,
      (SELECT COUNT(source_url), 
                    source_url
       FROM news_posts
       GROUP BY source_url)
FROM news_sources
      WHERE source_url IN 
            (SELECT MAX(post_count) 
             FROM (
                   SELECT COUNT(news_posts.rource_url) AS post_count,
                                news_sources.location_name
                   FROM news_posts
                   INNER JOIN news_sources ON news_posts.source_url = news_sources.url
                   GROUP BY news_sources.location_name) AS grouped_table
GROUP BY location_name;
