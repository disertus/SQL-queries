-- This query shows the news sources, which produce the most posts for each location

SELECT COUNT(news_posts.source_url) as frequency,
      news_posts.source_url,
      news_sources.location_name
FROM news_posts
INNER JOIN news_sources ON news_posts.source_url = news_sources.url
GROUP BY location_name, source_url
ORDER BY location_name, frequency DESC;
