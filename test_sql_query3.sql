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
SELECT news_posts.source_url,
       grouped_table.location_name
FROM news_posts INNER JOIN news_sources ON news_posts.source_url = news_sources.url
GROUP BY news_sources.location_name
HAVING COUNT (news_posts.source_url) = (
            SELECT COUNT(news_posts.rource_url) AS post_count,
                   news_sources.location_name
            FROM news_posts
            INNER JOIN news_sources ON news_posts.source_url = news_sources.url
            GROUP BY news_sources.location_name) AS grouped_table
