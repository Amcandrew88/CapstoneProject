--Creating a View enabling the query of the last 12 months

CREATE VIEW AnnualBikeUse AS
SELECT
	started_at, ended_at, start_station_name, end_station_name,
	start_lat, start_lng, end_lat, end_lng, member_casual, ride_length,
	day_of_week
FROM
	PortfolioProject..[202010-divvy-tripdata]
	--the table used has been changed to include each month for brevity and 
	--readability I have included the first month only.


--Top 1,000,000 longest rides excluding null rider type
SELECT TOP 1000000
	started_at, start_station_name, MAX(ride_length) AS 'LongestRide', member_casual, day_of_week
FROM
	PortfolioProject..AnnualBikeUse
WHERE
	member_casual <> ''
GROUP BY
	started_at, start_station_name, day_of_week, member_casual
ORDER BY
	'LongestRide' DESC


--check the busiest day for all users 
SELECT
	member_casual , day_of_week, COUNT(day_of_week) AS 'BusiestDay'
FROM
	PortfolioProject..AnnualBikeUse
GROUP BY
	member_casual, day_of_week
ORDER BY
	'BusiestDay' DESC

--Busiest day for members 
SELECT
	day_of_week, COUNT(day_of_week) AS 'BusiestDay'
FROM
	PortfolioProject..AnnualBikeUse
WHERE
	member_casual = 'member'
GROUP BY
	day_of_week
ORDER BY
	'BusiestDay' DESC


--Busiest day for casual 
SELECT
	day_of_week, COUNT(day_of_week) AS 'BusiestDay'
FROM
	PortfolioProject..AnnualBikeUse
WHERE
	member_casual = 'casual'
GROUP BY
	day_of_week
ORDER BY
	'BusiestDay' DESC


-- busiest Start_Stations not counting null or blank

SELECT
	start_station_name, COUNT(start_station_name) AS StationCount, start_lat, start_lng --, member_casual
FROM
	PortfolioProject..AnnualBikeUse
WHERE
	start_station_name IS NOT NULL
AND
	start_station_name <> ''
GROUP BY
	start_station_name, start_lat, start_lng--, member_casual 
ORDER BY
	StationCount DESC

--looking to see number of overall uses by members
SELECT
	COUNT(member_casual) AS TotalDaysUsed
FROM
	PortfolioProject..AnnualBikeUse
WHERE 
	member_casual = 'member'

--looking to see number of overall uses by casual
SELECT
	COUNT(member_casual) AS TotalDaysUsed
FROM
	PortfolioProject..AnnualBikeUse
WHERE 
	member_casual = 'casual'


--looking to pull stations locations for timelapsed heatmap
--this query pulls until 04/30

SELECT TOP 900458
	 started_at , start_lng, start_lat, start_station_name, COUNT(start_station_name) AS Station_Popularity
FROM
	PortfolioProject..AnnualBikeUse
WHERE
	member_casual = 'member'
AND
	start_station_name <> ''
--AND
	--started_at > '2021-04-30 23:59:53.000'
GROUP BY
	started_at, start_lng, start_lat, start_station_name


--pull stations from 5/1
SELECT TOP 906970
	 started_at , start_lng, start_lat, start_station_name, COUNT(start_station_name) AS Station_Popularity
FROM
	PortfolioProject..AnnualBikeUse
WHERE
	member_casual = 'member'
AND
	start_station_name <> ''
AND
	started_at > '2021-04-30 23:59:53.000'
GROUP BY
	started_at, start_lng, start_lat, start_station_name

--start from 8/1

SELECT
	 started_at , start_lng, start_lat, start_station_name, COUNT(start_station_name) AS Station_Popularity
FROM
	PortfolioProject..AnnualBikeUse
WHERE
	member_casual = 'member'
AND
	start_station_name <> ''
AND
	started_at > '2021-07-31 23:59:42.000'
GROUP BY
	started_at, start_lng, start_lat, start_station_name


--Beginning Casual station dates

SELECT TOP 693789
	 started_at , start_lng, start_lat, start_station_name, COUNT(start_station_name) AS Station_Popularity
FROM
	PortfolioProject..AnnualBikeUse
WHERE
	member_casual = 'casual'
AND
	start_station_name <> ''
--AND
	--started_at > '2021-05-31 23:59:16.000'
GROUP BY
	started_at, start_lng, start_lat, start_station_name
	

--second worksheet for the year 6-1 through 7-31
SELECT  TOP 718477
	 started_at , start_lng, start_lat, start_station_name, COUNT(start_station_name) AS Station_Popularity
FROM
	PortfolioProject..AnnualBikeUse
WHERE
	member_casual = 'casual'
AND
	start_station_name <> ''
AND
	started_at > '2021-05-31 23:59:16.000'
GROUP BY
	started_at, start_lng, start_lat, start_station_name


--Third casual chart from 8-1 till end
SELECT
	 started_at , start_lng, start_lat, start_station_name, COUNT(start_station_name) AS Station_Popularity
FROM
	PortfolioProject..AnnualBikeUse
WHERE
	member_casual = 'casual'
AND
	start_station_name <> ''
AND
	started_at > '2021-07-31 23:59:57.000'
GROUP BY
	started_at, start_lng, start_lat, start_station_name
