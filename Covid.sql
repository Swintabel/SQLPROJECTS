
-- column counts from 1 
select * 
from dbo.CovidDeaths
order by 3,4;


--select * 
--from dbo.CovidVaccinations	
--order by 3,4;

select location, date, total_cases, new_cases, total_deaths, population
from dbo.CovidDeaths
order by 1,2;

-- looking at total cases vs total deaths
-- likelihood of death if infected
select location, date, total_cases, total_deaths, (convert(float,total_deaths)/nullif(convert(float,total_cases),0))*100 as death_rate
from dbo.CovidDeaths
where location like 'Gh%'
order by 1,2;


-- looking at the total cases vs population
-- shows the percentage of population that gets infected
select location, date, total_cases, population, (convert(float,total_cases)/nullif(convert(float,population),0))*100 as infection_rate
from dbo.CovidDeaths
where location like '%kingdom%'
order by 1,2;

-- Looking at countries with the highest infection rate
-- specify that the max is needed on the column of interest and the calculated column as well
-- Once an agregate func is introduced with other columns, we need to group by
select location, max(total_cases) as Max_Cases, population, Max(convert(float,total_cases)/nullif(convert(float,population),0))*100 as infection_rate
from dbo.CovidDeaths
--where location like '%kingdom%'
group by location, population
order by infection_rate desc;

--showing max deaths
select location, max(total_deaths) as Max_Deaths, Max(convert(float,total_cases)/nullif(convert(float,population),0))*100 as infection_rate
from dbo.CovidDeaths
--where location like '%kingdom%'
where continent is not null
group by location
order by Max_Deaths desc;


--showing max deaths 
select location, max(total_deaths) as Max_Deaths, Max(convert(float,total_cases)/nullif(convert(float,population),0))*100 as infection_rate
from dbo.CovidDeaths
--where location like '%kingdom%'
where continent is null
group by location
order by Max_Deaths desc;


--showing max deaths by continent 
select continent, max(total_deaths) as Max_Deaths, Max(convert(float,total_cases)/nullif(convert(float,population),0))*100 as infection_rate
from dbo.CovidDeaths
--where location like '%kingdom%'
where continent is not null
group by continent
order by Max_Deaths desc;

-- Global cases
select date, sum(new_cases)as TC, sum(convert(float,new_deaths)) as TD, (sum(convert(float,new_deaths))/sum(new_cases))*100 as death_rate
from dbo.CovidDeaths
where continent is not null
group by date
order by 1,2;



-- Joins
-- looking at total population vs vaccination(rolling count)
select CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
SUM(convert(int,CV.new_vaccinations)) over (partition by CD.location order by CD.location, CD.date) as rollCountVaccins
from dbo.CovidDeaths as CD
join dbo.CovidVaccinations as CV
on CD.location=CV.location
and CD.date=CV.date
where CD.continent is not null
order by 2,3;

--creating a CTE
-- column order must match 
with PopvsVac (continent, location,  date, population,new_vaccinations,rollCountVaccins)
 as 
(
select CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
SUM(convert(int,CV.new_vaccinations)) over (partition by CD.location order by CD.location, CD.date) as rollCountVaccins
from dbo.CovidDeaths as CD
join dbo.CovidVaccinations as CV
on CD.location=CV.location
and CD.date=CV.date
where CD.continent is not null
)
select *, (rollCountVaccins/nullif(convert(float,population),0))*100 as VacRate
from PopvsVac 
order by 2,3;


-- Temp Table
drop table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),  
date datetime, 
population numeric,
new_vaccinations numeric,
rollCountVaccins numeric
)

insert into #PercentPopulationVaccinated
select CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
SUM(convert(int,CV.new_vaccinations)) over (partition by CD.location order by CD.location, CD.date) as rollCountVaccins
from dbo.CovidDeaths as CD
join dbo.CovidVaccinations as CV
on CD.location=CV.location
and CD.date=CV.date
where CD.continent is not null


select *, (rollCountVaccins/population)*100 as VacRate
from #PercentPopulationVaccinated
order by 2,3;


-- create views
create view PercentPopulationVaccinated as
select CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
SUM(convert(int,CV.new_vaccinations)) over (partition by CD.location order by CD.location, CD.date) as rollCountVaccins
from dbo.CovidDeaths as CD
join dbo.CovidVaccinations as CV
on CD.location=CV.location
and CD.date=CV.date
where CD.continent is not null