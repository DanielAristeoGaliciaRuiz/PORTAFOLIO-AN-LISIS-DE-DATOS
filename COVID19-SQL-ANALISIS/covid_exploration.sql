/*
Análisis de Datos COVID-19 con SQL

Habilidades aplicadas: Joins, CTEs, Tablas temporales, Funciones de ventana, Funciones agregadas, Creación de vistas
*/

-- Exploración inicial del dataset con filtro para excluir agregados globales y nulos
SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 3,4

-- Selección de variables clave para análisis general
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Tasa de letalidad (muertes sobre casos totales) por fecha para un país específico
SELECT location, date, total_cases, total_deaths, 
       ROUND((total_deaths/total_cases)*100, 2) AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location = 'Jamaica'
ORDER BY 1,2

-- Porcentaje de la población que ha sido infectada por fecha
SELECT location, date, total_cases, population, 
       ROUND((total_cases/population)*100, 5) AS CasesByPopulation
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

-- Países con mayor porcentaje de población infectada
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, 
       ROUND(MAX((total_cases/population))*100, 2) AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

-- Países con mayor cantidad absoluta de muertes
SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

-- Muertes totales por continente
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Números globales diarios con cálculo de tasa de letalidad
SELECT date, SUM(new_cases) AS TotalCases, 
       SUM(CAST(new_deaths AS int)) AS TotalDeaths,
       ROUND((SUM(CAST(new_deaths AS int))/SUM(new_cases))*100, 2) AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2

-- Números globales acumulados
SELECT SUM(new_cases) AS TotalCases, 
       SUM(CAST(new_deaths AS int)) AS TotalDeaths,
       ROUND((SUM(CAST(new_deaths AS int))/SUM(new_cases))*100, 2) AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL

-- Avance acumulado de vacunación por país (función de ventana)
SELECT dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations,
       SUM(CONVERT(int, vax.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vax
  ON dea.location = vax.location AND dea.date = vax.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

-- CTE para calcular porcentaje acumulado de vacunación
WITH PopulationvsVaccinations (Continent, Location, date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS (
    SELECT dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations,
           SUM(CONVERT(int, vax.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
    FROM PortfolioProject..CovidDeaths dea
    JOIN PortfolioProject..CovidVax vax
      ON dea.location = vax.location AND dea.date = vax.date
    WHERE dea.continent IS NOT NULL
)
SELECT *, ROUND((RollingPeopleVaccinated/Population)*100, 2) AS RollingPercent
FROM PopulationvsVaccinations

-- Tabla temporal para almacenar resultados de vacunación acumulada
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated (
  Continent NVARCHAR(255),
  Location NVARCHAR(255),
  date DATETIME,
  Population NUMERIC,
  New_Vaccinations NUMERIC,
  RollingPeopleVaccinated NUMERIC
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations,
       SUM(CONVERT(int, vax.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVax vax
  ON dea.location = vax.location AND dea.date = vax.date
WHERE dea.continent IS NOT NULL

SELECT *, ROUND((RollingPeopleVaccinated/Population)*100, 2) AS RollingPercent
FROM #PercentPopulationVaccinated

-- Vista para guardar el cálculo de vacunación acumulada para visualización posterior
CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations,
       SUM(CONVERT(int, vax.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVax vax
  ON dea.location = vax.location AND dea.date = vax.date
WHERE dea.continent IS NOT NULL

