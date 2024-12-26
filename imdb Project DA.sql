/*
-- Solve the below problems using IMDB dataset:

1) Fetch all data from imdb table 
2) Fetch only the name and release year for all movies.
3) Fetch the name, release year and imdb rating of movies which are UA certified.
4) Fetch the name and genre of movies which are UA certified and have a Imdb rating of over 8.
5) Find out how many movies are of Drama genre.
6) How many movies are directed by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" and "Rajkumar Hirani".
7) What is the highest imdb rating given so far?
8) What is the highest and lowest imdb rating given so far?
8a) Solve the above problem but display the results in different rows.
8b) Solve the above problem but display the results in different rows. And have a column which indicates the value as lowest and highest.
9) Find out the total business done by movies staring "Aamir Khan".
10) Find out the average imdb rating of movies which are neither directed by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" and are not acted by any of these stars "Christian Bale", "Liam Neeson", "Heath Ledger", "Leonardo DiCaprio", "Anne Hathaway".

11) Mention the movies involving both "Steven Spielberg" and "Tom Cruise".
12) Display the movie name and watch time (in both mins and hours) which have over 9 imdb rating.
13) What is the average imdb rating of movies which are released in the last 10 years and have less than 2 hrs of runtime.
14) Identify the Batman movie which is not directed by "Christopher Nolan".
15) Display all the A and UA certified movies which are either directed by "Steven Spielberg", "Christopher Nolan" or which are directed by other directors but have a rating of over 8.
--16) What are the different certificates given to movies?
17) Display all the movies acted by Tom Cruise in the order of their release. Consider only movies which have a meta score.
--18) Segregate all the Drama and Comedy movies released in the last 10 years as per their runtime. Movies shorter than 1 hour should be termed as short film. Movies longer than 2 hrs should be termed as longer movies. All others can be termed as Good watch time.
19) Write a query to display the "Christian Bale" movies which released in odd year and even year. Sort the data as per Odd year at the top.
20) Re-write problem #18 without using case statement.



-- Extra Assignment:
1) Split the value '1234_1234' into 2 seperate columns having 1234 each.

2) We see a string value 'PG' in released_year and we hardcoaded it, can we make a query dynamic to identify string value incase if we have multiple string values in-order to ignore those string values
 Write a query to identify non numeric values in a column.
 */

 
--1) Fetch all data from imdb table 

SELECT * FROM imdb_top_movies;

--2) Fetch only the name and release year for all movies.

SELECT series_title AS movie_name,
	   released_year
FROM imdb_top_movies;

--3) Fetch the name, release year and imdb rating of movies which are UA certified.

SELECT series_title
	   ,released_year
	   ,imdb_rating
FROM imdb_top_movies
WHERE certificate = 'UA';

--4) Fetch the name and genre of movies which are UA certified and have a Imdb rating of over 8.

SELECT series_title, genre, imdb_rating
FROM imdb_top_movies
WHERE imdb_rating > 8
	  and certificate = 'UA'

--5) Find out how many movies are of Drama genre.

 SELECT COUNT(genre)
 FROM imdb_top_movies
 WHERE genre Like '%Drama%'

--6) How many movies are directed by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" and "Rajkumar Hirani".

SELECT count(*) AS directed_movies
FROM imdb_top_movies
WHERE director IN ('Quentin Tarantino', 'Steven Spielberg', 'Christopher Nolan', 'Rajkumar Hirani')

--7) What is the highest imdb rating given so far?

SELECT MAX(imdb_rating) AS highest_rated
FROM imdb_top_movies;

--8) What is the highest and lowest imdb rating given so far?

select max(imdb_rating) as highest_rating,  min(imdb_rating) as lowest_rating
from imdb_top_movies



--8a) Solve the above problem but display the results in different rows.

select max(imdb_rating) as highest_rating
from imdb_top_movies
union  
select min(imdb_rating) as lowest_rating
from imdb_top_movies



--8b) Solve the above problem but display the results in different rows. And have a column which indicates the value as lowest and highest.

select max(imdb_rating) as movie_rating, 'Highest rating' as high_low
from imdb_top_movies
union  
select min(imdb_rating) , 'Lowest rating' as high_low
from imdb_top_movies

--9) Find out the total business done by movies staring "Aamir Khan".

SELECT sum(gross) AS total_business
FROM  imdb_top_movies
WHERE  star1 = 'Aamir Khan'
	OR star2 = 'Aamir Khan'
	OR star3 = 'Aamir Khan'
	OR star4 = 'Aamir Khan'


SELECT sum(gross) AS total_business
FROM  imdb_top_movies
WHERE 'Aamir Khan' IN (star1,star2,star3,star4);


--10) Find out the average imdb rating of movies which are neither directed by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" and are not acted by any of these stars "Christian Bale", "Liam Neeson", "Heath Ledger", "Leonardo DiCaprio", "Anne Hathaway".

SELECT AVG(imdb_rating) AS Avg_Rating
FROM imdb_top_movies
WHERE director NOT IN ('Quentin Tarantino', 'Steven Spielberg', 'Christopher Nolan')
	AND (star1 NOT IN ('Christian Bale', 'Liam Neeson', 'Heath Ledger', 'Leonardo DiCaprio', 'Anne Hathaway') 
	AND  star2 NOT IN ('Christian Bale', 'Liam Neeson', 'Heath Ledger', 'Leonardo DiCaprio', 'Anne Hathaway') 
	AND  star3 NOT IN ('Christian Bale', 'Liam Neeson', 'Heath Ledger', 'Leonardo DiCaprio', 'Anne Hathaway') 
	AND  star4 NOT IN ('Christian Bale', 'Liam Neeson', 'Heath Ledger', 'Leonardo DiCaprio', 'Anne Hathaway') 
	);

--11) Mention the movies involving both "Steven Spielberg" and "Tom Cruise".

SELECT series_title
FROM imdb_top_movies
WHERE director = 'Steven Spielberg'
	 AND (star1 = 'Tom Cruise'
	 	  OR star2 = 'Tom Cruise' 
		  OR star3 = 'Tom Cruise' 
		  OR star4 = 'Tom Cruise')

-- 12) Display the movie name and watch time (in both mins and hours) which have over 9 imdb rating.

SELECT series_title AS movie_name
		, runtime AS watch_time_min
		, ROUND(CAST(REPLACE(runtime, ' min', '') AS decimal) /60 , 2) AS watch_time_hr
--		, replace(runtime, ' min', '')::int
FROM imdb_top_movies
WHERE imdb_rating > 9;

--13) What is the average imdb rating of movies which are released in the last 10 years and have less than 2 hrs of runtime.

SELECT round(avg(imdb_rating),2) AS avg_rating
FROM imdb_top_movies
WHERE released_year > (extract(year from current_date) - 10) :: varchar
AND replace(runtime, ' min', '') :: int <= 120
--AND released_year <> 'PG'
--ORDER BY released_year desc

select round(avg(imdb_rating),2) as avg_rating
from imdb_top_movies
where released_year <> 'PG'
and extract(year from current_date ) - released_year::int <= 10
and round(replace(runtime, ' min', '')::decimal /60,2) < 2;

--14) Identify the Batman movie which is not directed by "Christopher Nolan".

select * from imdb_top_movies
where upper(series_title) like '%BATMAN%'
and director <> 'Christopher Nolan';

---15) Display all the A and UA certified movies which are either directed by "Steven Spielberg", "Christopher Nolan" or which are directed by other directors but have a rating of over 8.

select * from imdb_top_movies
where certificate in ('A','UA')
and (director in ('Steven Spielberg', 'Christopher Nolan')
	 or 
		 (director not in ('Steven Spielberg', 'Christopher Nolan')
		  and imdb_rating > 8
		 )
	);

--16) What are the different certificates given to movies?

select distinct certificate
from imdb_top_movies
order by 1;

select distinct (certificate)
from imdb_top_movies
order by certificate;

--17) Display all the movies acted by Tom Cruise in the order of their release. Consider only movies which have a meta score.

select * from imdb_top_movies
where meta_score is not null
and 'Tom Cruise' IN (star1, star2, star3, star4)
order by released_year;


select * from imdb_top_movies
where meta_score is not null
and (star1 = 'Tom Cruise'
	or star2 = 'Tom Cruise'
	or star3 = 'Tom Cruise'
	or star4 = 'Tom Cruise')
order by released_year;

--18) Segregate all the Drama and Comedy movies released in the last 10 years as per their runtime. Movies shorter than 1 hour should be termed as short film. Movies longer than 2 hrs should be termed as longer movies. All others can be termed as Good watch time.

SELECT series_title AS movie_name,
	  round((replace(runtime,' min','') :: decimal / 60),2) AS run_time,
	  CASE WHEN round((replace(runtime,' min','') :: decimal / 60),2) < 1
	  THEN 'Short Film'
	  WHEN round((replace(runtime,' min','') :: decimal / 60),2) > 2
	  THEN 'Long Film'
	  ELSE 'Good Watch Time'
	  END as Watch_category 
FROM imdb_top_movies
WHERE released_year <> 'PG' 
	  AND extract(year from current_date ) - released_year::int <= 10
	  AND (lower(genre) like '%drama%' OR lower(genre) like '%comedy%')
ORDER BY runtime;

--19) Write a query to display the "Christian Bale" movies which released in odd year and even year. 
--Sort the data as per Odd year at the top.

SELECT Series_title, released_year, CASE WHEN cast (released_year AS int) % 2 = 0 
		   THEN 'Even Year'
		   ELSE 'Odd Year'
		   END As year_details
FROM imdb_top_movies
WHERE 'Christian Bale' IN (director,star1,star2,star3,star4)
ORDER BY year_details DESC;

--20) Re-write problem #18 without using case statement.

SELECT series_title AS movie_name,
	  round((replace(runtime,' min','') :: decimal / 60),2) AS run_time,
	  'Short Film' as Watch_category
FROM imdb_top_movies
WHERE released_year <> 'PG' 
	  AND extract(year from current_date ) - released_year::int <= 10
	  AND (lower(genre) like '%drama%' OR lower(genre) like '%comedy%')
	  AND round((replace(runtime,' min','') :: decimal / 60),2) < 1

  UNION ALL
  
SELECT series_title AS movie_name,
	   round((replace(runtime,' min','') :: decimal / 60),2) AS run_time,
	   'Long Film' AS Watch_category 
FROM imdb_top_movies
WHERE released_year <> 'PG' 
	  AND extract(year from current_date ) - released_year::int <= 10
	  AND (lower(genre) like '%drama%' OR lower(genre) like '%comedy%')
	  AND round((replace(runtime,' min','') :: decimal / 60),2) > 2

	UNION ALL

SELECT series_title AS movie_name,
	  round((replace(runtime,' min','') :: decimal / 60),2) AS run_time,
	  'Good Watch Time' AS Watch_category 
FROM imdb_top_movies
WHERE released_year <> 'PG' 
	  AND extract(year from current_date ) - released_year::int <= 10
	  AND (lower(genre) like '%drama%' OR lower(genre) like '%comedy%')
	  AND round((replace(runtime,' min','') :: decimal / 60),2) BETWEEN 1 AND 2
ORDER BY run_time;

--------------------------------------------------------------------------------------------------------------


-- Extra Assignment:
--1) Split the value '1234_1234' into 2 seperate columns having 1234 each.


--SUBSTRING, POSITION, SPLIT_PART ==> Postgres
--SUBSTR, INSTR ==> Oracle

SELECT substring('techTFQ', 1, 4); -- tech
SELECT substring('techTFQ', 2, 4); -- echT
SELECT substring('techTFQ', 4);    -- hTFQ

SELECT POSITION('_' in 'tech_TFQ');-- 5
SELECT POSITION('F' in 'tech_TFQ');-- 7

SELECT SUBSTRING('1234_1234', 1, POSITION('_' IN '1234_1234')-1) AS col1,
	   SUBSTRING('1234_1234', POSITION('_' IN '1234_1234')+1) AS col2

SELECT split_part('1234@5678','@',1) AS col1,
	   split_part('1234@5678','@',2) AS col2

--2) We see a string value 'PG' in released_year and we hardcoaded it, 
--   can we make a query dynamic to identify string value incase 
--   if we have multiple string values in-order to ignore those string values
--   Write a query to identify non numeric values in a column.


SELECT *
FROM imdb_top_movies
WHERE released_year !~ '[0,9]' ;
