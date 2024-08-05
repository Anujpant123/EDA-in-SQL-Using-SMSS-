
-- Movies
select *
from movies

-- 1. Highest grossing movie of all time

select top 1 name,genre,gross
from movies
order by 3 desc

-- Highest rated movie list
select name,score,votes,writer,budget,gross,runtime
from movies
order by 2 desc

-- highest rated genre of movie

select genre,sum(score)/count(genre) as score
from  movies
group by genre
order by 2 desc


-- highest rated movies from certain country
select name,genre,country,score
from movies
where country like '%New zealand%'
order by score desc


--comnpany having the highest gross
 select company,sum(gross) as gross,sum(budget) as budget
 from movies
 group by company
 order by 2 desc


 --comnpany and their profit and loss percent 
 select company,sum(gross) as gross,sum(budget) as budget,(sum(gross)- sum(budget)) as profit_loss, 
 ((sum(gross)- sum(budget))/sum(budget))*100 as profit_loss_perc
 from movies
 group by company  
 order by 3 desc


 -- star who has been in the movie that has grossed a lot of money
 select star,sum(budget) as budget, sum(gross) as gross
 from movies
 group by star
 order by 3 desc
 

  -- director who has been in the movie that has grossed a lot of money
 select director,sum(budget) as budget, sum(gross) as gross
 from movies
 group by director
 order by 3 desc


 

 -- Director who has done more than 3 films and their movies average rating 
 -- finding out the best director according to their movie ratings
 SELECT director, 
       AVG(score) AS avg_director_score, 
       COUNT(director) AS total
FROM movies
GROUP BY director
HAVING COUNT(director) > 3
ORDER BY avg_director_score DESC;


-- movies ouside of united states who has grossed the highest amount of money

select name,genre,director,star,country,budget,gross
from movies
where country not like '%United states%'
order by gross desc


-- Genre of movies and their budget and gross and number of movies made in each genre

select genre,sum(budget) as budget,sum(gross) as gross,count(genre) as no_movies
from movies
group by genre
order by 4 desc

-- Writer with highest number of films and score(Who has done more than 3 movies)

select writer,count(writer) as total_movies,sum(score)/ nullif(count(writer),0) as avg_score
from movies
group by writer
having count(writer) >3
order by 3 desc

-- Number of movies made in different year

select year,count(year) as total_movies
from movies
group by year
order by 2 desc


-- Movies that failed in thaters and their rating and money lost by them

select name,genre,year,score,budget,gross,(gross-budget) as total_loss
from movies
where budget>gross
order by 6

-- Highest rated movie among the movies that failed commercially
select name,genre,year,score,budget,gross,(gross-budget) as total_loss
from movies
where budget>gross
order by 4 desc

-- movie with the highest runtime

select name,genre,year,score,director,star,runtime,budget,gross
from movies
order by 7 desc

-- Best year for movies commercially
 select year,count(year) as totaL_movies,sum(budget) as budget,sum(gross) as gross,
 ((sum(gross)-sum(budget))/sum(budget)) *100 as success_percent
 from movies
 group by year
 order by 5 desc


 -- Highest voted movie
 select name,genre,score,votes,budget,gross
 from movies
 order by 4 desc

 
--Highest number of movies released in a date
select released,count(name) 
from movies
group by released
order  by 2 desc

 -- Highest budget movie
 select name,genre,score,country,released,budget,gross
 from movies
 order by 6 desc

 -- Average budget of movies according to genre

select genre,avg(budget) as avg_budget,avg(gross) as gross
from movies
group by genre
order by 2 desc


-- average budget and gross in each decade from 80s to 2020  using  CTE


WITH avg_budget AS (
    SELECT 
        CASE
            WHEN year >= 1980 AND year <= 1989 THEN '1980s decade'
            WHEN year >= 1990 AND year <= 1999 THEN '1990s decade'
            WHEN year >= 2000 AND year <= 2009 THEN '2000s decade'
            WHEN year >= 2010 AND year <= 2020 THEN '2010s decade'
            ELSE NULL
        END AS decade,
        SUM(budget) AS total_budget,
        SUM(gross) AS total_gross,
		count(NAME) AS total_movies
    FROM movies
    GROUP BY 
        CASE
            WHEN year >= 1980 AND year <= 1989 THEN '1980s decade'
            WHEN year >= 1990 AND year <= 1999 THEN '1990s decade'
            WHEN year >= 2000 AND year <= 2009 THEN '2000s decade'
            WHEN year >= 2010 AND year <= 2020 THEN '2010s decade'
            ELSE NULL
        END
)
SELECT *
FROM avg_budget
ORDER BY decade



-- using stored procedure to find the movies 
-- of your favourite star
CREATE PROCEDURE Films1
  @star Nvarchar(50)
as 
begin
select *
from movies 
where star=@star
End

Exec Films1 @star = 'Christian bale'


 		



    