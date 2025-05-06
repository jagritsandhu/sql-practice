# Day 6: Data Modeling — Movie Streaming ERD

This folder contains the ERD for a normalized database schema of a movie streaming platform.

## Entities
- Users
- Subscriptions
- Movies
- Genres
- Movie_Genres (junction table)
- Watch_History

## Relationships
- Users have one subscription
- Users watch many movies
- Movies belong to many genres
- All entities are normalized to 3NF


## 🎯 Bonus: Expert-Level Query

**Most Watched Genres by Premium Users**

This query combines multiple joins across genres, movies, watch history, and subscriptions. It counts views by Premium users only.  
It uses clean join chaining and dynamic grouping.

🧠 Learning Note:  
While written with `LEFT JOIN`, we later switched to `JOIN` because the WHERE clause on `subscriptions` nullified the outer join.  
This is a common real-world gotcha in BI — a filtered `LEFT JOIN` is no longer a true outer join.

```sql
SELECT  
  g.genre_id,
  g.name AS genre,
  COUNT(w.user_id) AS premium_views
FROM genres AS g 
JOIN movie_genres USING (genre_id)
JOIN movies USING (movie_id)
JOIN watch_history AS w USING (movie_id)
JOIN subscriptions AS s USING (user_id)
WHERE s.plan = 'Premium' AND s.is_active = 1
GROUP BY g.genre_id, g.name
ORDER BY premium_views DESC;
