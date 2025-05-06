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
