-- Insert Users
INSERT INTO users (user_id, name, email, signup_date) VALUES
(1, 'Alice', 'alice@example.com', '2024-01-15'),
(2, 'Bob', 'bob@example.com', '2024-03-22'),
(3, 'Charlie', 'charlie@example.com', '2024-02-10');

-- Insert Subscriptions
INSERT INTO subscriptions (subscription_id, user_id, plan, is_active, renewal_date) VALUES
(101, 1, 'Premium', 1, '2025-01-15'),
(102, 2, 'Basic', 1, '2025-03-22'),
(103, 3, 'Premium', 0, '2024-03-10');

-- Insert Movies
INSERT INTO movies (movie_id, title, release_year, duration) VALUES
(201, 'Inception', 2010, 148),
(202, 'The Matrix', 1999, 136),
(203, 'Interstellar', 2014, 169),
(204, 'The Office: Finale', 2013, 60);

-- Insert Genres
INSERT INTO genres (genre_id, name) VALUES
(1, 'Sci-Fi'),
(2, 'Drama'),
(3, 'Comedy');

-- Insert Movie Genres
INSERT INTO movie_genres (movie_id, genre_id) VALUES
(201, 1),
(202, 1),
(203, 1),
(203, 2),
(204, 3);

-- Insert Watch History
INSERT INTO watch_history (history_id, user_id, movie_id, watched_at, device) VALUES
(1001, 1, 201, '2024-04-01 21:00', 'TV'),
(1002, 1, 203, '2024-04-10 20:15', 'Mobile'),
(1003, 2, 202, '2024-04-11 19:00', 'Tablet'),
(1004, 2, 204, '2024-04-12 18:30', 'TV'),
(1005, 3, 204, '2024-03-05 22:00', 'Laptop');

-- QUESTIONS --
-- “Top 3 most watched movies in the last 30 days”

-- SELECT m.title,
-- Count(*) AS watch_count
-- FROM watch_history AS w
-- Join movies AS m
-- USING (movie_id)
-- GROUP BY m.title
-- ORDER BY watch_count DESC
-- LIMIT 3;
-- OR
-- SELECT m.title,
-- Count(w.movie_id) AS watch_count
-- FROM movies AS m
-- Left Join watch_history AS w
-- USING (movie_id)
-- GROUP BY m.title
-- ORDER BY watch_count DESC
-- LIMIT 3;

--“How long are people watching per film?”
-- For each movie, how many times was it watched, and how much 
--total screen time did it generate?

-- SELECT  m.title,
--         m.duration,
--         COUNT(w.history_id) AS total_views, -- how many times was it watched?
--         (m.duration * COUNT(w.history_id)) -- what is the total screen time?
-- FROM movies AS m
-- LEFT JOIN watch_history AS w
-- USING (movie_id)
-- GROUP BY 1, 2;


-- Where are users watching the most — TV, mobile, laptop?
-- SELECT  w.device,
--         COUNT(w.history_id)
-- FROM watch_history AS w 
-- GROUP BY 1
-- ORDER BY 2 DESC;



--“Which genre gets the most engagement from Premium users?”
SELECT  g.genre_id,
        g.name,
        COUNT(w.user_id) -- engagement
FROM genres AS g 
LEFT JOIN movie_genres
    USING (genre_id)
LEFT JOIN movies 
    USING (movie_id)
LEFT JOIN watch_history AS w
    USING (movie_id)
LEFT JOIN subscriptions AS s 
    USING (user_id)
WHERE s.plan = 'Premium' 
AND s.is_active = 1
GROUP BY 1, 2
ORDER BY 3 DESC;

-- ⚠️ One Subtle Gotcha: WHERE Kills LEFT JOIN Logic
-- Because your WHERE clause references s.plan, the LEFT JOIN to subscriptions effectively becomes an INNER JOIN.

-- Why? Because if there's no matching subscription (i.e., NULL), the row is excluded by the WHERE.

-- SELECT  
--   g.genre_id,
--   g.name AS genre,
--   COUNT(w.user_id) AS premium_views
-- FROM genres AS g 
-- JOIN movie_genres USING (genre_id)
-- JOIN movies USING (movie_id)
-- JOIN watch_history AS w USING (movie_id)
-- JOIN subscriptions AS s USING (user_id)
-- WHERE s.plan = 'Premium' AND s.is_active = 1
-- GROUP BY g.genre_id, g.name
-- ORDER BY premium_views DESC;

-- If you’re filtering a field from a LEFT JOINed table in the WHERE clause, you're not really doing a LEFT JOIN anymore