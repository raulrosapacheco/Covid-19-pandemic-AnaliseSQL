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

# Average deaths and new cases by country
# Univariate Analysis
SELECT location, ROUND(AVG(total_deaths),2) avg_deaths
FROM pandemic.covid_deaths
GROUP BY location
ORDER BY avg_deaths DESC;

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
    

 
 
 