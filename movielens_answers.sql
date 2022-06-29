use movielens;


-- List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT title, release_date FROM movies WHERE release_date BETWEEN "1983-01-01" AND "1993-12-31" ORDER BY release_date DESC;

-- Without using LIMIT, list the titles of the movies with the lowest average rating.
SELECT m.title, AVG(r.rating) FROM movies m
	INNER JOIN ratings r ON m.id = r.movie_id
GROUP BY m.title
ORDER BY AVG(r.rating);

-- List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
SELECT distinct m.title Title, g.name Genre , u.gender Gender, u.age Age, o.name Occupation, r.rating Rating FROM movies m
	INNER JOIN genres_movies gm ON gm.movie_id = m.id
    INNER JOIN genres g ON g.id = gm.genre_id
    INNER JOIN ratings r ON r.movie_id = m.id
    INNER JOIN users u ON u.id = r.user_id
    INNER JOIN occupations o ON o.id = u.occupation_id 
WHERE g.name = "Sci-Fi" AND u.gender = "M" AND u.age = 24 AND o.name = "Student" AND r.rating = 5;

-- List the unique titles of each of the movies released on the most popular release day.
SELECT title, release_date FROM movies WHERE release_date =
(SELECT release_date FROM movies GROUP BY release_date ORDER BY COUNT(title) DESC LIMIT 1)
GROUP BY title;

-- Find the total number of movies in each genre; list the results in ascending numeric order.
SELECT g.name, COUNT(*) as "Movie Count" FROM movies m
	INNER JOIN genres_movies gm ON gm.movie_id = m.id
    INNER JOIN genres g ON g.id = gm.genre_id
GROUP BY g.name
ORDER BY COUNT(*) ASC;