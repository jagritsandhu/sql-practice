-- Users table
CREATE TABLE users (
  user_id INTEGER PRIMARY KEY,
  name TEXT,
  email TEXT UNIQUE,
  signup_date DATE
);

-- Subscriptions table
CREATE TABLE subscriptions (
  subscription_id INTEGER PRIMARY KEY,
  user_id INTEGER,
  plan TEXT,
  is_active BOOLEAN,
  renewal_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Movies table
CREATE TABLE movies (
  movie_id INTEGER PRIMARY KEY,
  title TEXT,
  release_year INTEGER,
  duration INTEGER
);

-- Genres table
CREATE TABLE genres (
  genre_id INTEGER PRIMARY KEY,
  name TEXT UNIQUE
);

-- Movie_Genres (junction)
CREATE TABLE movie_genres (
  movie_id INTEGER,
  genre_id INTEGER,
  PRIMARY KEY (movie_id, genre_id),
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
  FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

-- Watch History
CREATE TABLE watch_history (
  history_id INTEGER PRIMARY KEY,
  user_id INTEGER,
  movie_id INTEGER,
  watched_at DATETIME,
  device TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);
