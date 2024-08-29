-- Airplane crash
select *
from crash


--. Finding out the total number of deaths and death percent
-- from the data

select sum(Aboard) as total_aboard,sum(Fatalities) as total_death, 
(sum(Fatalities)/sum(Aboard))*100 as death_percent
from crash


-- Which route is the dangerous for aiplane

select Route,count(Route) as total_route,sum(Aboard) as total_aboard,
sum(Fatalities) as total_death,(sum(Fatalities)/sum(Aboard))*100 as death_percent
from crash
group by Route
order by 2 desc

-- Which operator has been in most number of airplane crash
select Operator,count(Operator) as total_number_crash,sum(Aboard) as total_aboard,
sum(Fatalities) as total_death,(sum(Fatalities)/NULLIF(sum(Aboard),0))*100 as death_percent
from crash
where Operator is not null
group by Operator
order by 2 desc


-- Which type of airplane is involved in more aircrash

select Type,count(Type) as total_no_crash,sum(Aboard) as total_aboard,
sum(Fatalities) as total_death,(sum(Fatalities)/NULLIF(sum(Aboard),0))*100 as death_percent
from crash
WHERE Type is not null
group by Type
order by 2 desc

--which location had the highest nummber of crashes

SELECT Location,count(Location) as total,sum(Aboard) as total_aboard,
sum(Fatalities) as total_death,(sum(Fatalities)/NULLIF(sum(Aboard),0))*100 as death_percent
from crash
where Location is not null
group by Location
order by 2 desc

-- Which date has the highest number of Airplane crash

SELECT Date, count(Date) as total,sum(Aboard) as total_aboard,
sum(Fatalities) as total_death,(sum(Fatalities)/NULLIF(sum(Aboard),0))*100 as death_percent
from crash
where Date is not null
group by Date
order by 2 desc

-- Converting date from varchar to date
update crash
SET [Date] = CAST([Date] as DATE)

ALTER TABLE crash
ALTER COLUMN [Date]DATE

-- Finding out the number of crashes in different years 
-- Total deaths and death percent in each year

Select YEAR(Date) as year,count(YEAR(Date)) as total,sum(Aboard) as total_aboard,
sum(Fatalities) as total_death,(sum(Fatalities)/NULLIF(sum(Aboard),0))*100 as death_percent
from Crash
group by YEAR(Date)
order by 2 desc

-- Finding out which month has the highest number of crashes

select Datename(month,Date) as month,count(month(Date)) as total,sum(Aboard) as total_aboard,
sum(Fatalities) as total_death,(sum(Fatalities)/NULLIF(sum(Aboard),0))*100 as death_percent
from crash
group by Datename(month, Date)
order by 2 desc

-- Which day of the month has the highest number of crashes

SELECT Day(Date) as date, Count(Day(Date)) as total,sum(Aboard) as total_aboard,
sum(Fatalities) as total_death,(sum(Fatalities)/NULLIF(sum(Aboard),0))*100 as death_percent
from crash
group by Day(Date)
order by 2 desc

-- Highest number of crashes recorded in a given time

SELECT Time,count(Time) as total,sum(Aboard) as total_aboard,
sum(Fatalities) as total_death,(sum(Fatalities)/NULLIF(sum(Aboard),0))*100 as death_percent
FROM crash
Where Time is not null
group by Time
order by 2 desc

-- Calculating the surivival percent
Select sum(Aboard) as total_aboard,
sum(Fatalities) as total_death,(sum(Fatalities)/NULLIF(sum(Aboard),0))*100 as death_percent,
100-((sum(Fatalities)/NULLIF(sum(Aboard),0))*100 ) as survival_percent
from crash


--Finding out the major cause of crash

select summary,count(summary) as total,sum(Aboard) as total_aboard,
sum(Fatalities) as total_death,(sum(Fatalities)/NULLIF(sum(Aboard),0))*100 as death_percent,
100-((sum(Fatalities)/NULLIF(sum(Aboard),0))*100 ) as survival_percent
from crash
group by summary
order by 2 desc


-- Finding out the major cause of crash in different year

SELECT YEAR(Date) as year, count(YEAR(Date)) as total,summary,count(summary) as no_of_summary
from crash
where summary is not null
group by YEAR(Date),summary
Having count(summary) >=2
order by 2 desc

