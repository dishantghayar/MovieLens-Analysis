CREATE DATABASE movielens;
USE movielens;

CREATE TABLE movies (
    movieId INT,
    title VARCHAR(255),
    genres VARCHAR(255),
    PRIMARY KEY (movieId)
);

CREATE TABLE ratings (
    userId INT,
    movieId INT,
    rating FLOAT,
    timestamp BIGINT
);

CREATE TABLE tags (
    userId INT,
    movieId INT,
    tag VARCHAR(255),
    timestamp BIGINT
);

CREATE TABLE links (
    movieId INT,
    imdbId INT,
    tmdbId INT
);


CREATE TABLE users (
    userId INT PRIMARY KEY,
    gender CHAR(1),
    age INT
);

SELECT COUNT(*) FROM movies;
SELECT COUNT(*) FROM ratings;
SELECT COUNT(*) FROM tags;
SELECT COUNT(*) FROM links;

SELECT 
    u.age,
    m.genres,
    AVG(r.rating) AS avg_rating
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
JOIN users u ON r.userId = u.userId
GROUP BY u.age, m.genres
HAVING COUNT(*) > 20
ORDER BY u.age, avg_rating DESC;

SELECT 
    m.title,
    AVG(r.rating) AS avg_rating,
    COUNT(r.rating) AS total_ratings
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
GROUP BY r.movieId
HAVING total_ratings > 50
ORDER BY avg_rating DESC
LIMIT 10;

SELECT 
    userId,
    COUNT(*) AS total_ratings
FROM ratings
GROUP BY userId
ORDER BY total_ratings DESC
LIMIT 10;

SELECT 
    u.age,
    u.gender,
    m.genres,
    AVG(r.rating) AS avg_rating
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
JOIN users u ON r.userId = u.userId
GROUP BY u.age, u.gender, m.genres
HAVING COUNT(*) > 20
ORDER BY avg_rating DESC;

SELECT 
    COUNT(*) AS users_above_500
FROM (
    SELECT userId, COUNT(*) AS total
    FROM ratings
    GROUP BY userId
    HAVING total > 500
) AS t;

SELECT 
    m.movieId,
    m.title,
    AVG(r.rating) AS avg_rating
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
GROUP BY m.movieId, m.title
ORDER BY avg_rating DESC; 

SELECT 
    genres,
    COUNT(*) AS count_movies
FROM movies
GROUP BY genres
ORDER BY count_movies DESC;

SELECT 
    m.title,
    r.rating,
    FROM_UNIXTIME(r.timestamp) AS rating_date
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
WHERE r.rating > 4.5
  AND FROM_UNIXTIME(r.timestamp) >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
ORDER BY r.rating DESC;




