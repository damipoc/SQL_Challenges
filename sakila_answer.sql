USE sakila;

-- List all actors.
SELECT * FROM actor;

-- Find the surname of the actor with the forename 'John'.
SELECT last_name FROM actor WHERE first_name = "John";

-- Find all actors with surname 'Neeson'.
SELECT * FROM actor WHERE last_name = "Neeson";

-- Find all actors with ID numbers divisible by 10.
SELECT * FROM actor WHERE actor_id % 10 = 0;

-- What is the description of the movie with an ID of 100?
SELECT description FROM film WHERE film_id = 100;

-- Find every R-rated movie.
SELECT * FROM film WHERE rating = "R";

-- Find every non-R-rated movie.
SELECT * FROM film WHERE rating != "R";

-- Find the ten shortest movies.
SELECT * FROM film ORDER BY length ASC LIMIT 10;

-- Find the movies with the longest runtime, without using LIMIT.
SELECT * FROM film WHERE length = (
	SELECT MAX(length) FROM film
);

-- Find all movies that have deleted scenes.
SELECT * FROM film WHERE special_features LIKE "%Deleted Scenes%";

-- Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name FROM actor GROUP BY last_name HAVING count(*)>=1 ORDER BY last_name DESC;

-- Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name FROM actor GROUP BY last_name HAVING count(*)>=2 ORDER BY count(*) DESC;

-- Which actor has appeared in the most films?
SELECT a.first_name "First Name", a.last_name "Last Name", COUNT(f.film_id) "Films" FROM actor a
	INNER JOIN film_actor f ON a.actor_id = f.actor_id
GROUP BY f.actor_id ORDER BY COUNT(f.film_id) DESC;

-- When is 'Academy Dinosaur' due?
SELECT f.title, DATE_ADD(r.rental_date, INTERVAL f.rental_duration DAY) AS due_date FROM film f
	INNER JOIN inventory i ON f.film_id = i.film_id
    INNER JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.title = "ACADEMY DINOSAUR" AND r.return_date IS NULL;

-- What is the average runtime of all films?
SELECT AVG(length) "Average runtime" FROM film;

-- List the average runtime for every film category.
SELECT c.name, AVG(f.length) FROM film f
	INNER JOIN film_category fc ON f.film_id = fc.film_id
	INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY fc.category_id ORDER BY AVG(f.length);

-- List all movies featuring a robot.
SELECT title, description FROM film WHERE description LIKE "%Robot%";

-- How many movies were released in 2010?
SELECT COUNT(*) "Movies release in 2010" FROM film WHERE YEAR(release_year) = 2010;

-- Find the titles of all the horror movies.
SELECT f.title, c.name FROM film f
	INNER JOIN film_category fc ON fc.film_id = f.film_id
    INNER JOIN category c ON c.category_id = c.category_id
WHERE c.name = "Horror";    

-- List the full name of the staff member with the ID of 2.
SELECT first_name, last_name FROM staff WHERE staff_id = 2;

-- List all the movies that Fred Costner has appeared in.
SELECT f.title FROM film f
	INNER JOIN film_actor fa ON f.film_id = fa.film_id
    INNER JOIN actor a ON a.actor_id = fa.actor_id
WHERE a.first_name = "FRED" AND last_name = "COSTNER";

-- How many distinct countries are there?
SELECT DISTINCT COUNT(*) "Distinct countries" FROM country;

-- List the name of every language in reverse-alphabetical order.
SELECT * FROM language ORDER BY name DESC;

-- List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name FROM actor WHERE last_name LIKE "%son" ORDER BY first_name ASC;

-- Which category contains the most films?
SELECT c.name, COUNT(*) FROM category c
	INNER JOIN film_category fc ON c.category_id = fc.category_id
    INNER JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name;
