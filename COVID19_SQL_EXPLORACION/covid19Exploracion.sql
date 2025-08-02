/*
Exploración de Datos COVID-19 en SQL

Habilidades aplicadas: Joins, CTEs, Tablas temporales, Funciones de ventana, Funciones agregadas, Creación de vistas, Conversión de tipos de datos
*/

-- Revisión general del dataset, filtrando registros nulos o globales
SELECT *
FROM coviddeaths_csv 
WHERE continent IS NOT NULL 
ORDER BY 3, 4

-- Selección básica de columnas clave
SELECT location, total_cases, new_cases, total_deaths, population 
FROM coviddeaths_csv 
ORDER BY 1, 2

-- Total de casos vs muertes en un país específico
SELECT location, `date`, total_cases, total_deaths, 
       (total_cases/population)*100 AS death_percentage
FROM coviddeaths_csv 
WHERE location = 'Afghanistan'
ORDER BY 1, 2

-- Total de casos vs población (para región específica)
SELECT location, `date`, population, total_cases, total_deaths, 
       (total_cases/population)*100 AS death_percentage
FROM coviddeaths_csv 
WHERE location = 'Africa'
ORDER BY 1, 2

-- Países con mayor tasa de infección respecto a su población
SELECT location, population, MAX(total_cases), 
       MAX(total_cases/population)*100 AS percent_population_infected
FROM coviddeaths_csv 
GROUP BY location, population 
ORDER BY percent_population_infected DESC

-- Países con mayor número total de muertes (suma acumulada)
SELECT location, SUM(total_deaths) AS total_death_count
FROM coviddeaths_csv 
WHERE continent IS NOT NULL 
GROUP BY location 
ORDER BY total_death_count DESC

-- Continentes con mayor número de muertes absolutas
SELECT continent, MAX(CAST(total_deaths AS INT)) AS total_death_count
FROM coviddeaths_csv
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY total_death_count DESC

-- Casos y muertes globales por fecha
SELECT `date`, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths,
       SUM(new_deaths)/SUM(new_cases)*100 AS new_death_percentage
FROM coviddeaths_csv 
WHERE continent IS NOT NULL  
GROUP BY `date`

-- Relación población total vs vacunaciones (por fecha y país)
SELECT cd.continent, cd.location, cd.`date`, cd.population, cv.new_vaccinations 
FROM coviddeaths_csv cd 
JOIN covidvacinations_csv cv
  ON cd.location = cv.location AND cd.`date` = cv.`date` 
WHERE cv.new_vaccinations IS NOT NULL

-- CTE para acumulado de vacunación por país y fecha
WITH PopsVsVacc (Continent, Location, Date, New_Vaccination, RollingPeopleVaccinated) AS (
    SELECT cd.continent, cd.location, cd.`date`, cv.new_vaccinations, 
           SUM(CAST(cv.new_vaccinations AS INT)) OVER (
               PARTITION BY cd.location 
               ORDER BY cd.location, cd.`date`
           ) AS rolling_people_vaccinated
    FROM coviddeaths_csv cd 
    JOIN covidvacinations_csv cv
      ON cd.location = cv.location AND cd.`date` = cv.`date`
    WHERE cv.new_vaccinations IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/Population)*100 AS vaccination_percentage
FROM PopsVsVacc

-- Tabla temporal para almacenar y reutilizar cálculo acumulado de vacunación
DROP TABLE IF EXISTS percentage_population_vaccinated;
CREATE TEMPORARY TABLE percentage_population_vaccinated (
    Continent VARCHAR(255), 
    Location VARCHAR(255),
    Date DATETIME,
    Population NUMERIC,
    New_vaccinations NUMERIC,
    RollingPeopleVaccinated NUMERIC
);

INSERT INTO percentage_population_vaccinated
SELECT cd.continent, cd.location, cd.`date`, cd.population, cv.new_vaccinations, 
       SUM(cv.new_vaccinations) OVER (
           PARTITION BY cv.location 
           ORDER BY cv.location, cv.`date` DESC
       ) AS rolling_people_vaccinated
FROM coviddeaths_csv cd 
JOIN covidvacinations_csv cv
  ON cd.location = cv.location AND cd.`date` = cv.`date` 
WHERE cv.new_vaccinations IS NOT NULL;

SELECT *, (RollingPeopleVaccinated/Population)*100 AS vaccination_percentage
FROM percentage_population_vaccinated;

-- Vista para visualizaciones futuras con acumulado de vacunación
CREATE VIEW percentage_population_vaccinated AS
SELECT cd.continent, cd.location, cd.`date`, cd.population, cv.new_vaccinations, 
       SUM(cv.new_vaccinations) OVER (
           PARTITION BY cv.location 
           ORDER BY cv.location, cv.`date` DESC
       ) AS rolling_people_vaccinated
FROM coviddeaths_csv cd 
JOIN covidvacinations_csv cv
  ON cd.location = cv.location AND cd.`date` = cv.`date`
WHERE cv.new_vaccinations IS NOT NULL;
