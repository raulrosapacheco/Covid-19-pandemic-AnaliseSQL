# Case study 

# Total Records
SELECT COUNT(*) FROM pandemic.covid_deaths;
SELECT COUNT(*) FROM pandemic.covid_deaths;

# Order by column name or column number
 SELECT * FROM pandemic.covid_deaths ORDER BY location, date;
 SELECT * FROM pandemic.covid_deaths ORDER BY location DESC, date;
 # By default, SQL sorts in ascending order
 SELECT * FROM pandemic.covid_deaths ORDER BY 3,4;
 SELECT * FROM pandemic.covid_vaccination ORDER BY 3,4;
 
 # Changing date column from text to data type
 # Disabling security lock
 SET SQL_SAFE_UPDATES = 0;
 
 UPDATE pandemic.covid_deaths
 SET date = str_to_date(date, '%d/%m/%y');
 
 UPDATE pandemic.covid_vaccination
 SET date = str_to_date(date, '%d/%m/%y');
 
 # Enabling security lock
 SET SQL_SAFE_UPDATES = 1;
 
 # Querying columns relevant to the analysis
 SELECT 
	date,
    location,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM pandemic.covid_deaths
ORDER BY 2,1; # 2: location / 1: date

# UNIVARIATE ANALYSIS
# Average deaths and new cases by country
SELECT 
	location, 
    ROUND(AVG(total_deaths),2) avg_deaths,
    ROUND(AVG(new_cases),2) avg_new_cases
FROM pandemic.covid_deaths
GROUP BY location
ORDER BY avg_deaths DESC;

# MULTIVARIATE ANALYSIS
# What is proportions of dealths in relation to the total number of cases in Brazil?
SELECT
	location,
    date,
	total_deaths,
    total_cases,
    (total_deaths/total_cases) * 100 percentage_deaths
FROM pandemic.covid_deaths
WHERE location = 'Brazil'
ORDER BY 2;

# What is average proportion between the total number of cases and the population of each location?
SELECT
	location,
    AVG(total_cases/population)*100 avg_cases_per_population
FROM pandemic.covid_deaths
GROUP BY location
ORDER BY avg_cases_per_population DESC;

# Considering the highest value of total cases, 
# Which countries have highest rate of infectios in relation to population?
SELECT 
	location,
    MAX(total_cases) max_total_cases,
	MAX((total_cases/population))*100 percentage_cases
FROM pandemic.covid_deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY percentage_cases DESC;
	
# Which location have the highest number of deaths?
SELECT
	location,
    MAX(total_deaths*1) total_deaths # The total_deaths column id of type text, when multiplied by 1 the SGBD will return a numeric value
FROM pandemic.covid_deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_deaths DESC;

# Solving the previous problem optimally
SELECT location,
	MAX(CAST(total_deaths AS UNSIGNED)) total_deaths
FROM pandemic.covid_deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_deaths DESC;



 
 
 