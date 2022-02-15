---- Checking the new imported excel files

SELECT *
FROM PortfolioProject..CovidDeaths
ORDER BY 3,4

SELECT *
FROM PortfolioProject..CovidVaccinations 
ORDER BY 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1, 2

-- Viewing Total Cases vs Total Deaths
-- Shows rough estimate of dying if you contract covid in your country

SELECT Location, date, total_cases, total_deaths, (total_deaths / total_cases) * 100 AS DeathPercent
FROM PortfolioProject..CovidDeaths
ORDER BY 1, 2


SELECT Location, date, total_cases, total_deaths, (total_deaths / total_cases) * 100 AS DeathPercent
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%states%'
AND continent IS NOT NULL
ORDER BY 1, 2

-- Viewing Total Cases vs Population

SELECT Location, date, total_cases, Population, (total_cases / population) * 100 AS CasesToPop
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%states%'
ORDER BY 1, 2


-- Viewing Countries with highest infection rate compared to pop.

SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases / population)) * 100 AS PercentPopInfected 
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%states%'
GROUP BY Location, Population
ORDER BY 1, 2

SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases / population)) * 100 AS PercentPopInfected 
FROM PortfolioProject..CovidDeaths
GROUP BY Location, Population
ORDER BY 1, 2

SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases / population)) * 100 AS PercentPopInfected 
FROM PortfolioProject..CovidDeaths
GROUP BY Location, Population
ORDER BY PercentPopInfected DESC

-- Viewing Countries with highes death count per pop
SELECT Location, MAX(total_deaths) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
GROUP BY Location
ORDER BY TotalDeathCount DESC


-- Upon receiving an error I realized the data type of total_deaths needed to be changed to an interger value instead of varchar

SELECT Location, MAX(CAST(total_deaths AS bigint)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY TotalDeathCount DESC

SELECT location, MAX(CAST(total_deaths AS BIGINT)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

--Viewing death count per continent

SELECT continent, MAX(CAST(total_deaths AS BIGINT)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
GROUP BY continent
ORDER BY TotalDeathCount DESC

--Upon receiving a null value for continent I reviewed the data sets and noticed that Asia was listed as A Country and not a continent so I added
--the following where clause to fix this error

SELECT continent, MAX(CAST(total_deaths AS BIGINT)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

SELECT continent, MAX(CAST(total_deaths AS BIGINT)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- redoing above queries for continent instead of location for tableau

SELECT continent, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1, 2

SELECT continent, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2

SELECT continent, date, total_cases, total_deaths, (total_deaths / total_cases) * 100 AS DeathPercent
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2

SELECT continent, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases / population)) * 100 AS PercentPopInfected 
FROM PortfolioProject..CovidDeaths
GROUP BY continent, Population
ORDER BY 1, 2

SELECT continent, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases / population)) * 100 AS PercentPopInfected 
FROM PortfolioProject..CovidDeaths
GROUP BY continent, Population
ORDER BY PercentPopInfected DESC

SELECT continent, MAX(total_deaths) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
GROUP BY continent
ORDER BY TotalDeathCount DESC

SELECT continent, MAX(CAST(total_deaths AS bigint)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

SELECT continent, MAX(CAST(total_deaths AS BIGINT)) AS TotalDeathCount 
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Global

SELECT date, SUM(new_cases)
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2

SELECT date, SUM(new_cases), SUM(CAST(new_deaths AS BIGINT))
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2

SELECT date, SUM(new_cases) AS TotalCases, SUM(CAST(new_deaths AS BIGINT)) AS TotalDeaths, SUM(CAST(new_deaths AS BIGINT)) / SUM(new_cases) * 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2

SELECT SUM(new_cases) AS TotalCases, SUM(CAST(new_deaths AS BIGINT)) AS TotalDeaths, SUM(CAST(new_deaths AS BIGINT)) / SUM(new_cases) * 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2



-- Viewing Vac Table

SELECT *
FROM PortfolioProject..CovidVaccinations
	

SELECT *
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	 ON dea.location = vac.location
	 AND dea.date = vac.date

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	 ON dea.location = vac.location
	 AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1, 2

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopVac
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	 ON dea.location = vac.location
	 AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1, 2


WITH PopvsVac (Continenet, Location, Date, Population, New_Vaccinations, RollingPeopVac)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopVac
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	 ON dea.location = vac.location
	 AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *, (RollingPeopVac / Population) * 100
FROM PopvsVac



-- TEMP TABLE

CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccination numeric,
RollingPeopVac numeric
)
INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopVac
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	 ON dea.location = vac.location
	 AND dea.date = vac.date
WHERE dea.continent IS NOT NULL

SELECT *, (RollingPeopVac / Population) * 100
FROM #PercentPopulationVaccinated


DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccination numeric,
RollingPeopVac numeric
)
INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopVac
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	 ON dea.location = vac.location
	 AND dea.date = vac.date

SELECT *, (RollingPeopVac / Population) * 100
FROM #PercentPopulationVaccinated



-- Creating Views for later vizs

CREATE VIEW PercentPopulationVaccinated1 AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopVac
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	 ON dea.location = vac.location
	 AND dea.date = vac.date
WHERE dea.continent IS NOT NULL

