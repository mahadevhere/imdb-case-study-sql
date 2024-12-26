# IMDb Case Study - SQL Project

This project demonstrates the use of SQL to analyze IMDb's top movies dataset. By leveraging SQL queries, various insights have been drawn from the data, showcasing the ability to solve real-world problems relevant to data analysis roles.

## Project Overview
The goal of this project is to perform data analysis on a dataset of top 1000 movies from IMDb. The dataset includes information such as:
- Movie title
- Release year
- Certification
- Runtime
- Genre
- IMDb rating
- Overview
- Director
- Cast details
- Number of votes
- Gross earnings

The project covers the following key tasks:
1. Data ingestion and table creation.
2. Writing SQL queries to extract meaningful insights.
3. Answering business-relevant questions using data.

## Dataset
The dataset contains the top 1000 movies from IMDb with the following columns:

- **Poster_Link**: URL to the movie poster.
- **Series_Title**: Name of the movie.
- **Released_Year**: Year the movie was released.
- **Certificate**: Certification of the movie (e.g., U, A, UA).
- **Runtime**: Movie duration.
- **Genre**: Genre(s) of the movie.
- **IMDB_Rating**: IMDb rating of the movie.
- **Overview**: Brief summary of the movie.
- **Meta_score**: Metascore rating.
- **Director**: Director of the movie.
- **Star1** to **Star4**: Main cast members.
- **No_of_Votes**: Number of votes the movie received.
- **Gross**: Gross earnings of the movie.

## Key SQL Queries and Insights

### 1. Fetching All Data
Extracting all records from the `imdb_top_movies` table.

```sql
SELECT * FROM imdb_top_movies;
```

### 2. Movies by Name and Release Year
Fetching only the name and release year for all movies.

```sql
SELECT Series_Title, Released_Year FROM imdb_top_movies;
```

### 3. Highly Rated UA Movies
Fetching the name, release year, and IMDb rating of movies that are UA certified and have an IMDb rating above 8.

```sql
SELECT Series_Title, Released_Year, IMDB_Rating
FROM imdb_top_movies
WHERE Certificate = 'UA' AND IMDB_Rating > 8;
```

### 4. Genre Analysis
Counting the number of movies in the Drama genre.

```sql
SELECT COUNT(*) AS Drama_Movies
FROM imdb_top_movies
WHERE Genre LIKE '%Drama%';
```

### 5. Director Popularity
Finding the number of movies directed by renowned directors like Quentin Tarantino, Steven Spielberg, and Christopher Nolan.

```sql
SELECT Director, COUNT(*) AS Movie_Count
FROM imdb_top_movies
WHERE Director IN ('Quentin Tarantino', 'Steven Spielberg', 'Christopher Nolan')
GROUP BY Director;
```

## How to Run This Project

1. Clone the repository.
   ```bash
   git clone <repository_url>
   ```

2. Import the `imdb_top_1000.csv` dataset into your database.

3. Run the SQL scripts provided in `imdb problems.sql` and `imdb Project DA.sql` to create the table and execute queries.

4. Explore the results and modify queries as needed for deeper insights.

## Tools Used
- **SQL**: For data analysis and querying.
- **Database**: Compatible with MySQL or PostgreSQL.
- **Dataset Source**: IMDb (Top 1000 movies).

## Key Learnings
- Data ingestion and table creation in SQL.
- Writing and optimizing SQL queries for real-world problems.
- Analyzing movie data to answer business-relevant questions.

## Future Scope
- Extending the dataset with additional attributes like awards and reviews.
- Visualizing insights using Python libraries like Matplotlib or Tableau.
