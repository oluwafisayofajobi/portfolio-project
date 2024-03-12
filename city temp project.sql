----select *
----from city_temperature$


----1

----IDENTIFY THE HIGHEST AVG TEMPERATURES IN ALL COUNTRIES FARENHIET

--select Region, country, max(avgtemperature) as maxtemperatures
--from city_temperature$
--group by region, Country
--order by maxtemperatures desc


------2

----IDENTIFY TOP 5 HIGHEST AVGTEMP IN NIGERIA

--SELECT top 5 Region, country, AvgTemperature
--FROM city_temperature$
--where country = 'nigeria'
--order by AvgTemperature desc

------3 HIGHEST AVGTEMPERATURE ABOVE 100 FAHRENHEIT

--Select Region, Country, City, max(AvgTemperature) as maxavgtemp
--from city_temperature$
--where AvgTemperature > 100 
--group by Region, Country, City
--order by maxavgtemp desc

----update city_temperature$
----set Country = 'Niger'
----where City = 'Niamey'


----4 highest avg in europe recorded

--select Region, Country, City, max(avgtemperature) as maxavgtemp
--from city_temperature$
--where region like 'eur%'
--group by Region, Country, City
--order by maxavgtemp desc

-----5 highest avg in africa recorded

--select Region, Country, City, max(avgtemperature) as maxavgtemp
--from city_temperature$
--where region like 'afr%'
--group by Region, Country, City
--order by maxavgtemp desc
