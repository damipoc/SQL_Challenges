USE world;


-- Using COUNT, get the number of cities in the USA.
SELECT COUNT(*) from city WHERE CountryCode = "USA";

-- Find out the population and life expectancy for people in Argentina.
SELECT Name, Population, LifeExpectancy from country WHERE Name = "Argentina";

-- Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?
SELECT Name, LifeEXpectancy from country WHERE LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy DESC LIMIT 1;

-- Using JOIN ... ON, find the capital city of Spain.
SELECT city.Name, country.Name from city
	JOIN country ON country.Code = city.CountryCode
WHERE country.Name = "Spain" AND country.Capital = City.ID;

-- Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.
SELECT countrylanguage.Language FROM countrylanguage
	JOIN country ON country.Code = countrylanguage.CountryCode
WHERE country.Region = "Southeast Asia";

-- Using a single query, list 25 cities around the world that start with the letter F.
SELECT Name FROM City WHERE Name LIKE "F%" LIMIT 25;

-- Using COUNT and JOIN ... ON, get the number of cities in China.
SELECT COUNT(*) FROM city
	JOIN country ON country.Code = city.CountryCode
WHERE country.Name = "China";

-- Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.
SELECT Name, Population FROM country WHERE Population IS NOT NULL AND Population = 0 ORDER BY Population LIMIT 1;

-- Using aggregate functions, return the number of countries the database contains.
SELECT COUNT(*) "Number of countries" FROM country;

-- What are the top ten largest countries by area?
SELECT * FROM country ORDER BY SurfaceArea DESC LIMIT 10;

-- List the five largest cities by population in Japan.
SELECT city.Name, city.Population FROM city
	JOIN country ON country.Code = city.CountryCode
WHERE country.Name = "Japan"
ORDER BY city.Population DESC LIMIT 5;

-- List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
SELECT Code, Name FROM country WHERE HeadOfState LIKE "Elisabeth II";

-- List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
SELECT Name, SurfaceArea, Population, (Population%SurfaceArea) AS "Ratio" FROM country WHERE Population%SurfaceArea != 0 ORDER BY Population%SurfaceArea;

-- List every unique world language.
SELECT Distinct Language FROM countrylanguage ORDER BY Language;

-- List the names and GNP of the world's top 10 richest countries.
SELECT Name, GNP FROM country ORDER BY GNP DESC LIMIT 10;

-- List the names of, and number of languages spoken by, the top ten most multilingual countries.
SELECT country.Name, COUNT(countrylanguage.Language) "Languages" FROM country
	JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
GROUP BY country.Name
ORDER BY COUNT(countrylanguage.Language) DESC LIMIt 10;

-- List every country where over 50% of its population can speak German.
SELECT country.Name FROM country
	JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE Language = "German" AND Percentage > 50;

-- Which country has the worst life expectancy? Discard zero or null values.
SELECT Name, LifeExpectancy FROM country WHERE LifeExpectancy IS NOT NULL AND LifeExpectancy != 0
ORDER BY LifeExpectancy LIMIT 1;

-- List the top three most common government forms.
SELECT GovernmentForm, COUNT(GovernmentForm) "Amount" FROM country GROUP BY GovernmentForm ORDER BY COUNT(GovernmentForm) DESC LIMIt 3;

-- How many countries have gained independence since records began?
SELECT COUNT(IndepYear) "Independed countries" FROM COUNTRY WHERE IndepYear IS NOT NULL;
