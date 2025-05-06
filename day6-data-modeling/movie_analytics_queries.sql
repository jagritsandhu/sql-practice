-- "What are the 3 most streamed titles?"
SELECT 
  m.title,
  COUNT(*) AS watch_count
FROM watch_history AS wh
JOIN movies AS m ON wh.movie_id = m.movie_id
GROUP BY m.title
ORDER BY watch_count DESC
LIMIT 3;


-- "How long are people watching per film?"
SELECT 
  m.title,
  m.duration,
  COUNT(wh.history_id) AS total_views,
  (m.duration * COUNT(wh.history_id)) AS total_minutes_streamed -- total screentime
FROM movies AS m
LEFT JOIN watch_history AS wh ON m.movie_id = wh.movie_id
GROUP BY m.title;

--"Where are users watching the most — TV, mobile, laptop?"
SELECT 
  device,
  COUNT(*) AS views
FROM watch_history
GROUP BY device
ORDER BY views DESC;


-- Which genres are most popular among Premium subscribers?
SELECT 
  g.name AS genre,
  COUNT(*) AS views
FROM watch_history AS wh
JOIN users AS u ON wh.user_id = u.user_id
JOIN subscriptions AS s ON u.user_id = s.user_id
JOIN movies AS m ON wh.movie_id = m.movie_id
JOIN movie_genres AS mg ON m.movie_id = mg.movie_id
JOIN genres AS g ON mg.genre_id = g.genre_id
WHERE s.plan = 'Premium' AND s.is_active = 1
GROUP BY g.name
ORDER BY views DESC;
