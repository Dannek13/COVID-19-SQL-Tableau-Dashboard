-- Dotazy použité pro vizualizaci v Tableau Public
-- Queries used for Tableau Public visualization

-- (1/4)

SELECT country, population, MAX(total_cases) AS TotalCases,
	ROUND((MAX(total_cases)/population)*100,2) AS infection_rate
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY country, population
HAVING infection_rate IS NOT NULL
ORDER BY infection_rate DESC;

-- (2/4)

SELECT country as continent, MAX(total_deaths) AS DeathCount
FROM coviddeaths
WHERE country IN ('Europe','North America', 'Asia', 'South America', 'Africa', 'Oceania')
GROUP BY country
ORDER BY DeathCount DESC;

-- (3/4) 

SELECT country, population, date, total_cases as InfectionCount, (total_cases/population)*100 AS PercentPopulationInfected
FROM CovidDeaths
WHERE continent IS NOT NULL AND date < '2025-09-28'
-- GROUP BY country, Population, date
HAVING PercentPopulationInfected IS NOT NULL
ORDER BY PercentPopulationInfected DESC;

-- (4/4) 

WITH eachtotal AS (
SELECT 
    country,
    MAX(total_cases) AS cases,
    MAX(total_deaths) AS deaths
FROM
    coviddeaths
WHERE
    continent IS NOT NULL
GROUP BY country)

SELECT 
    SUM(cases) AS GlobalCases,
    SUM(deaths) AS GlobalDeaths,
    ROUND((SUM(deaths) / SUM(cases)) * 100, 2) DeathPercentage
FROM
    eachtotal;