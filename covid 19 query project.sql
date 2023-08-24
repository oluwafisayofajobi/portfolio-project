--SELECT TOP (1000) [iso_code]
--      ,[continent]
--      ,[location]
--      ,[date]
--      ,[total_cases]
--      ,[new_cases]
--      ,[new_cases_smoothed]
--      ,[total_deaths]
--      ,[new_deaths]
--      ,[new_deaths_smoothed]
--      ,[total_cases_per_million]
--      ,[new_cases_per_million]
--      ,[new_cases_smoothed_per_million]
--      ,[total_deaths_per_million]
--      ,[new_deaths_per_million]
--      ,[new_deaths_smoothed_per_million]
--      ,[reproduction_rate]
--      ,[icu_patients]
--      ,[icu_patients_per_million]
--      ,[hosp_patients]
--      ,[hosp_patients_per_million]
--      ,[weekly_icu_admissions]
--      ,[weekly_icu_admissions_per_million]
--      ,[weekly_hosp_admissions]
--      ,[weekly_hosp_admissions_per_million]
--      ,[new_tests]
--      ,[total_tests]
--      ,[total_tests_per_thousand]
--      ,[new_tests_per_thousand]
--      ,[new_tests_smoothed]
--      ,[new_tests_smoothed_per_thousand]
--      ,[positive_rate]
--      ,[tests_per_case]
--      ,[tests_units]
--      ,[total_vaccinations]
--      ,[people_vaccinated]
--      ,[people_fully_vaccinated]
--      ,[new_vaccinations]
--      ,[new_vaccinations_smoothed]
--      ,[total_vaccinations_per_hundred]
--      ,[people_vaccinated_per_hundred]
--      ,[people_fully_vaccinated_per_hundred]
--      ,[new_vaccinations_smoothed_per_million]
--      ,[stringency_index]
--      ,[population]
--      ,[population_density]
--      ,[median_age]
--      ,[aged_65_older]
--      ,[aged_70_older]
--      ,[gdp_per_capita]
--      ,[extreme_poverty]
--      ,[cardiovasc_death_rate]
--      ,[diabetes_prevalence]
--      ,[female_smokers]
--      ,[male_smokers]
--      ,[handwashing_facilities]
--      ,[hospital_beds_per_thousand]
--      ,[life_expectancy]
--      ,[human_development_index]
--select location, date, total_cases, new_cases, total_deaths,population
-- FROM [covid main project].[dbo].['Covid mdeaths$']
-- order by 1,2

 --looking at total versus total deaths
 --this shows likelihood of dying if you contract covid in your country

 --select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'deathpercent'
 --FROM [covid main project].[dbo].['Covid mdeaths$']
 --where location like '%state%'
 --order by total_deaths asc


 --looking at total cases vs population
 --shows what % of population got covid

 --select location, date, total_cases, total_deaths, population, (total_cases/population)*100 as 'casepercentage'
 --FROM [covid main project].[dbo].['Covid mdeaths$']
 --where total_deaths not like '%null'
 --order by location, total_cases asc

---looking at countries with highest infection rate compared to population

--select location, max(total_cases) as 'highestinfection', population, max(total_cases/population)*100 as 'maxcasepercentage'
-- FROM [covid main project].[dbo].['Covid mdeaths$']
-- --where total_deaths not like '%null'
-- group by location, population
-- order by maxcasepercentage desc


 ----showing countries with highest death count per population

 --select location, max(cast (total_deaths as int)) as 'highestdeaths'
 --FROM [covid main project].[dbo].['Covid mdeaths$']
 --where continent not like '%null'
 --group by location
 --order by highestdeaths desc

--break things down by continent

 -- select continent, max(cast (total_deaths as int)) as 'highestdeaths'
 --FROM [covid main project].[dbo].['Covid mdeaths$']
 --where location is not null
 --group by continent
 --order by highestdeaths desc

 --showing the continent with the highest death count

 --select *
 --FROM [covid main project].[dbo].['Covid mdeaths$']
 --where continent is not null

 --GLOBAL NUMBERS


 -- select *
 --from [covid main project].[dbo].['Covid m vaccine$']
 
-- select sum(new_cases) as newcasesum, sum(cast(new_deaths as int)) as newdsum,  sum(cast(new_deaths as int))/sum(new_cases)*100 
-- total_cases, total_deaths, (total_cases/total_deaths)*100 as deathpercent 
-- FROM [covid main project].[dbo].['Covid mdeaths$']
-- where continent is not null
--group by date
-- order by 1,2


--looking at total population vs vaccination

-- select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as peoplevaccinated
-- FROM [covid main project].[dbo].['Covid mdeaths$'] dea
--  join [covid main project].[dbo].['Covid m vaccine$'] vac
--  on dea.location = vac.location
--  and dea.date = vac.date
--where dea. continent is not null
-- order by 2,3


 --use cte

 with popvsvac (continent, location, date, population, new_vaccinations, peoplevaccinated)
 as 
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as peoplevaccinated
 FROM [covid main project].[dbo].['Covid mdeaths$'] dea
  join [covid main project].[dbo].['Covid m vaccine$'] vac
  on dea.location = vac.location
  and dea.date = vac.date
where dea. continent is not null
 --order by 2,3
)
select *, (peoplevaccinated/population)*100
from popvsvac



--creating view to store data later for data visualizations

