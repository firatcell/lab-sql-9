


-- Create a Python connection with SQL database and retrieve the results of the following queries as dataframes:

USE sakila;

-- How many distinct (different) actors' last names are there?

SELECT COUNT(DISTINCT a1.last_name)
FROM film_actor AS fa1
JOIN actor AS a1 ON fa1.actor_id = a1.actor_id
JOIN film AS f1 ON fa1.film_id = f1.film_id
JOIN film_actor AS fa2 ON f1.film_id = fa2.film_id
JOIN actor AS a2 ON fa2.actor_id = a2.actor_id
WHERE a1.actor_id < a2.actor_id;


-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT rental_id, rental_date, MONTH(rental_date) AS month, DAYNAME(rental_date) AS weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental;

-- Get all films with ARMAGEDDON in the title.

SELECT * FROM film WHERE title LIKE '%ARMAGEDDON%';


-- Get 10 the longest films.

SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 10;


-- How many films include Behind the Scenes content?

SELECT COUNT(*) AS num_films
FROM film
WHERE special_features LIKE '%Behind the Scenes%';

-- Which kind of movies (rating) have a mean duration of more than two hours?

SELECT rating, ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
HAVING AVG(length) > 120;


-- Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.

SELECT title, length, DENSE_RANK() OVER (ORDER BY length DESC) AS film_rank
FROM film
WHERE length IS NOT NULL AND length > 0;

