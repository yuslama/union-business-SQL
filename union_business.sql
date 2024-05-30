--code to save the CSV file as unions
SELECT * FROM 'union.csv';

-- Stored Procedure for Counting Businesses by a Specified Column
CREATE PROCEDURE CountBusiness(IN column_name VARCHAR(255))
BEGIN
    SET @sql_query = CONCAT(
        'SELECT ', column_name, ', COUNT(*) AS Business_Count ',
        'FROM unions ',
        'GROUP BY ', column_name, ' ',
        'ORDER BY Business_Count DESC'
    );

    PREPARE stmt FROM @sql_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END;

-- Count the number of businesses by category using CountBusiness SP
CALL CountBusiness('Category');

-- Count the number of businesses by type using CountBusiness SP
CALL CountBusiness('"Type of Business"');

-- Count the number of businesses by ZIP code using CountBusiness SP
CALL CountBusiness('"Zip Code"');

-- Calculate the density of businesses in various community districts
SELECT "Community Districts", COUNT(*) AS Business_Count
FROM unions
WHERE "Community Districts" IS NOT NULL
GROUP BY "Community Districts"
ORDER BY Business_Count DESC;

-- Identify the top 5 most diverse business categories (categories with the most different types of businesses)
SELECT Category, COUNT(DISTINCT "Type of Business") AS Type_Count
FROM unions
GROUP BY Category
ORDER BY Type_Count DESC
LIMIT 5;

-- Analyze the distribution of business types based on geographical coordinates
SELECT "Type of Business", AVG(Latitude) AS Avg_Latitude, AVG(Longitude) AS Avg_Longitude
FROM unions
WHERE Latitude IS NOT NULL AND Longitude IS NOT NULL
GROUP BY "Type of Business"
ORDER BY "Type of Business";