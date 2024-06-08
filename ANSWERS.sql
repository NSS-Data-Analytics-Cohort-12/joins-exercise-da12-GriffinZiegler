-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT film_title, release_year, worldwide_gross
FROM specs
INNER JOIN revenue
USING(movie_id)
ORDER BY worldwide_gross ASC
LIMIT 1;

-- 2. What year has the highest average imdb rating?

SELECT release_year, AVG(imdb_rating)
FROM specs
FULL JOIN rating
USING(movie_id)
GROUP BY release_year
ORDER BY AVG(imdb_rating) DESC;

-- 3. What is the highest grossing G-rated movie? Which company distributed it?

SELECT film_title, mpaa_rating, worldwide_gross, company_name
FROM specs
FULL JOIN rating USING(movie_id)
FULL JOIN revenue USING(movie_id)
FULL JOIN distributors ON specs.domestic_distributor_id = distributors.distributor_id
WHERE mpaa_rating LIKE 'G'
ORDER BY worldwide_gross DESC
LIMIT 1;

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT company_name, count(film_title)
FROM distributors
FULL JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY company_name;

-- 5. Write a query that returns the five distributors with the highest average movie budget.

SELECT company_name, ROUND(AVG(film_budget), 2) AS avg_film_budget
FROM specs
FULL JOIN revenue USING(movie_id)
FULL JOIN distributors ON specs.domestic_distributor_id = distributors.distributor_id
WHERE company_name IS NOT NULL AND film_budget IS NOT NULL
GROUP BY company_name
ORDER BY AVG(film_budget) DESC
LIMIT 5;

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?