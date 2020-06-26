-- This query shows the dynamics of new posts creation for a given location (kyiv)

SELECT COUNT(news_posts.source_url) as frequency,
      DATE(news_posts.added_at) as posts_date,
      news_sources.location_name
FROM news_posts
INNER JOIN news_sources ON news_posts.source_url = news_sources.url
WHERE location_name = 'kyiv'
GROUP BY posts_date, location_name
ORDER BY posts_date DESC;
