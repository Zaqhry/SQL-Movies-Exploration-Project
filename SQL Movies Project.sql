



--Movies Project 

SELECT * 
FROM Movies 



---------------------------------------------------------------------------------------------------

CREATE VIEW B AS
(
SELECT TOP 10 Name,
	      Year,
              Rating,
	      Genre,
	      Budget,
	      Gross,
	      (Gross - Budget) Profit 
FROM Movies 
	ORDER BY Profit DESC
)



CREATE VIEW W AS
(
SELECT TOP 10 Name,
	      Year,
	      Rating,
	      Genre,
	      Budget,
	      Gross,
	      (Gross - Budget) Profit 
FROM Movies 
WHERE Gross < Budget
	ORDER BY Profit 
)



--Top 10 Most Profitable vs Least Profitable movies of all time 

SELECT * 
FROM B 
UNION 
SELECT * 
FROM W



---------------------------------------------------------------------------------------------------

--Score,Genre,Rating,Budget,Gross,Profit,Runtime For Top 10 Most Profitable Movies vs Average Across All Movies 

SELECT TOP 10 Year,
	      Name,
	      Director,
	      Writer,
	      Genre,
	      Score,
	      Rating,
	      (SELECT ROUND(AVG(Score),2) FROM Movies) AvgScore,
              Budget,
	      (SELECT ROUND(AVG(Budget),2) FROM Movies) AvgBudget,
	      Gross,
	      (SELECT ROUND(AVG(Gross),2) FROM Movies) AvgGross,
	      (Gross - Budget) Profit,
	      (SELECT ROUND(AVG(Gross - Budget),2) FROM Movies) AvgProfit,
	      Runtime,
	      (SELECT ROUND(AVG(Runtime),2) FROM Movies) AvgRuntime
FROM Movies 
	ORDER BY Profit DESC



--Score,Genre,Rating,Budget,Gross,Profit,Runtime For Top 10 Least Profitable Movies vs Average Across All Movies 

SELECT TOP 10 Year,
	      Name,
	      Director,
              Writer,
	      Genre,
	      Score,
              Rating,
              (SELECT ROUND(AVG(Score),2) FROM Movies) AvgScore,
	      Budget,
	      (SELECT ROUND(AVG(Budget),2) FROM Movies) AvgBudget,
	      Gross,
  	      (SELECT ROUND(AVG(Gross),2) FROM Movies) AvgGross,
	      (Gross - Budget) Profit,
	      (SELECT ROUND(AVG(Gross - Budget),2) FROM Movies) AvgProfit,
	      Runtime,
	      (SELECT ROUND(AVG(Runtime),2) FROM Movies) AvgRuntime
FROM Movies 
WHERE Gross < Budget
	ORDER BY Profit 



---------------------------------------------------------------------------------------------------

--Score,Budget,Gross,Profit,Runtime Per Movie vs Average Across All Movies 

SELECT Name,
       Score,
       (SELECT ROUND(AVG(Score),2) FROM Movies) AvgScore,
       Budget,
       (SELECT ROUND(AVG(Budget),2) FROM Movies) AvgBudget,
       Gross,
       (SELECT ROUND(AVG(Gross),2) FROM Movies) AvgGross,
       (Gross - Budget) Profit,
       (SELECT ROUND(AVG(Gross - Budget),2) FROM Movies) AvgProfit,
       Runtime,
       (SELECT ROUND(AVG(Runtime),2) FROM Movies) AvgRuntime
FROM Movies 



--Movies that made a negative profit 

SELECT Name,
       Budget,
       Gross,
       (Gross - Budget) Profit 
FROM Movies 
WHERE Gross < Budget
	ORDER BY Profit 



--Profit made for each movie by Writer & Director 

SELECT Name,
       Writer,
       Director,
       SUM(Gross - Budget) Profit 
FROM Movies 
	GROUP BY Name,
		 Writer,
		 Director
	ORDER BY Profit DESC



--How much money Writers have made with all movies combined 

SELECT Writer,
       SUM(Gross - Budget) Profit 
FROM Movies 
	GROUP BY Writer
	ORDER BY Profit DESC



--How much money Directors have made with all movies combined

SELECT Director,
       SUM(Gross - Budget) Profit 
FROM Movies 
	GROUP BY Director
	ORDER BY Profit DESC



--Number of movies for each writer 

SELECT Writer,
       COUNT(*) Movies
FROM Movies
	GROUP BY Writer
	ORDER BY 2 DESC



--Number of movies for each director 

SELECT Director,
       COUNT(*) Movies
FROM Movies
	GROUP BY Director
	ORDER BY 2 DESC



--Budget, Gross & Profit for each movie 

SELECT Name,
       Budget,
       Gross,
       (Gross - Budget) Profit
FROM Movies
WHERE Budget IS NOT NULL
	ORDER BY Budget DESC



--Total & Avg Profit Per Movie (Most profitable Movie) 

SELECT Name,
       SUM(Gross - Budget) TotalProfit,
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
	GROUP BY Name
	ORDER BY TotalProfit DESC



--Budget, Gross & Profit for each genre

SELECT Genre,
       Budget,
       Gross, 
       (Gross - Budget) Profit
FROM Movies
WHERE Budget IS NOT NULL
	ORDER BY Budget DESC



--Total & Avg Profit Per Genre (Most profitable genre) 

SELECT Genre,
       SUM(Gross - Budget) TotalProfit,
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
	GROUP BY Genre
	ORDER BY TotalProfit DESC



--Company that has made the most movies 

SELECT Company,
       COUNT(Name) TotalMovies 
FROM Movies 
	GROUP BY Company
	ORDER BY TotalMovies DESC



--Most movies made per genre 

SELECT Genre,
       COUNT(Name) TotalMovies 
FROM Movies 
	GROUP BY Genre
	ORDER BY TotalMovies DESC



--Company that has made the most profit off of all movies 
	
SELECT Company,
       COUNT(Name) TotalMovies,
       SUM(Gross - Budget) TotalProfit 
FROM Movies 
	GROUP BY Company 
	ORDER BY TotalMovies DESC



--Profit Ratios for movies 

SELECT Name, 
       Budget,
       Gross,
       ROUND(MAX(Gross - Budget) / MIN(Budget),2) ProfitRatio 
FROM Movies 
	GROUP BY Name, 
		 Budget,
		 Gross
	ORDER BY ProfitRatio DESC
	


--TOP 5 Movies with lowest budget but highest profit return 

SELECT TOP 5 Name, 
	     Budget,
	     Gross,
	     ROUND(MAX(Gross - Budget) / MIN(Budget),2) ProfitRatio 
FROM Movies 
	GROUP BY Name,
		 Budget,
		 Gross
	ORDER BY ProfitRatio DESC
	
	

--Number of movies produced by countries 

SELECT Country, 
       COUNT(Name) TotalMovies 
FROM Movies 
	GROUP BY Country
	ORDER BY TotalMovies DESC



--Total & Avg Profit Per Country (Country who produces the most profit from movies) 

SELECT Country,
       SUM(Gross - Budget) TotalProfit,  
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
	GROUP BY Country
	ORDER BY TotalProfit DESC



--Year with the most movies produced

SELECT Year,
       COUNT(Name) TotalMovies
FROM Movies 
	GROUP BY Year 
	ORDER BY TotalMovies DESC



--Total & Avg Profit Per Year (Most profitable Year) 

SELECT Year,
       SUM(Gross - Budget) TotalProfit,
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
	GROUP BY Year
	ORDER BY TotalProfit DESC



--Rating that most movies are labeled under 

SELECT Rating,
       COUNT(Rating) TotalRating
FROM Movies 
WHERE Rating IS NOT NULL
	GROUP BY Rating 
	ORDER BY TotalRating DESC



--Total & Avg Profit Per Rating (Most profitable by Rating) 

SELECT Rating,
       SUM(Gross - Budget) TotalProfit,  
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
WHERE Rating IS NOT NULL
	GROUP BY Rating
	ORDER BY TotalProfit DESC



--Runtime For Movies vs Average Runtime For All Movies 

SELECT Name,
       Runtime,
       (SELECT ROUND(AVG(Runtime),2) FROM Movies) Avg_Runtime_For_All_Movies
FROM Movies
	GROUP BY Name,
		 Runtime
	ORDER BY Runtime DESC



--Total & Avg Profit Per Scores (Most Profitable by Score) 

SELECT Score,
       SUM(Gross - Budget) TotalProfit,
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
	GROUP BY Score
	ORDER BY TotalProfit DESC

---------------------------------------------------------------------------------------------------
