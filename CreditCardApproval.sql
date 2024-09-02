-- --------------------------------------------------------
-- SQL Script for Credit Card Approval
-- --------------------------------------------------------

-- Sample Data
-- Select the first 10 rows from the Clients table
-- SELECT * FROM Clients LIMIT 10;

-- --------------------------------------------------------
-- Null Value Checking
-- --------------------------------------------------------

-- Count of non-null values for various columns
-- SELECT 
--    COUNT(*) AS total_rows,
--    COUNT(ID) AS nonNullID,
--    COUNT(CODE_GENDER) AS nonNullGender,
--    COUNT(FLAG_OWN_CAR) AS nonNullCar,
--    COUNT(FLAG_OWN_REALTY) AS nonNullRealty,
--    COUNT(CNT_CHILDREN) AS nonNullChildren,
--    COUNT(AMT_INCOME_TOTAL) AS nonNullIncome,
--    COUNT(NAME_INCOME_TYPE) AS nonNullIncomeType,
--    COUNT(NAME_EDUCATION_TYPE) AS nonNullEducation,
--    COUNT(NAME_FAMILY_STATUS) AS nonNullFamilyStatus,
--    COUNT(NAME_HOUSING_TYPE) AS nonNullHousing,
--    COUNT(DAYS_BIRTH) AS nonNullBirthDays,
--    COUNT(DAYS_EMPLOYED) AS nonNullEmployedDays,
--    COUNT(FLAG_MOBIL) AS nonNullMobile,
--    COUNT(FLAG_WORK_PHONE) AS nonNullWorkPhone,
--    COUNT(FLAG_PHONE) AS nonNullPhone,
--    COUNT(FLAG_EMAIL) AS nonNullEmail,
--    COUNT(OCCUPATION_TYPE) AS nonNullOccupation,
--    COUNT(CNT_FAM_MEMBERS) AS nonNullFamilyMembers
-- FROM 
--    Clients;

-- --------------------------------------------------------
-- Column Value Distribution
-- --------------------------------------------------------

-- Create a Common Table Expression (CTE) for column values
-- WITH ClientColumns AS (
--    SELECT CODE_GENDER AS value, 'CODE_GENDER' AS column_name FROM Clients
--    UNION ALL
--    SELECT FLAG_OWN_CAR, 'FLAG_OWN_CAR' FROM Clients
--    UNION ALL
--    SELECT FLAG_OWN_REALTY, 'FLAG_OWN_REALTY' FROM Clients
--    UNION ALL
--    SELECT NAME_INCOME_TYPE, 'NAME_INCOME_TYPE' FROM Clients
--    UNION ALL
--    SELECT NAME_EDUCATION_TYPE, 'NAME_EDUCATION_TYPE' FROM Clients
--    UNION ALL
--    SELECT NAME_FAMILY_STATUS, 'NAME_FAMILY_STATUS' FROM Clients
--    UNION ALL
--    SELECT NAME_HOUSING_TYPE, 'NAME_HOUSING_TYPE' FROM Clients
--    UNION ALL
--    SELECT FLAG_MOBIL, 'FLAG_MOBIL' FROM Clients
--    UNION ALL
--    SELECT FLAG_WORK_PHONE, 'FLAG_WORK_PHONE' FROM Clients
--    UNION ALL
--    SELECT FLAG_PHONE, 'FLAG_PHONE' FROM Clients
--    UNION ALL
--    SELECT FLAG_EMAIL, 'FLAG_EMAIL' FROM Clients
--    UNION ALL
--    SELECT OCCUPATION_TYPE, 'OCCUPATION_TYPE' FROM Clients
-- )
-- SELECT column_name, value
-- FROM ClientColumns
-- GROUP BY column_name, value;

-- --------------------------------------------------------
-- Handling Null Values in OCCUPATION_TYPE
-- --------------------------------------------------------

-- Find and count null or empty OCCUPATION_TYPE values
-- SELECT * FROM Clients WHERE OCCUPATION_TYPE = '';
-- SELECT COUNT(*) FROM Clients WHERE OCCUPATION_TYPE = '';

-- Update OCCUPATION_TYPE to "Unknown OCCUPATION" where it is null or empty
-- SET SQL_SAFE_UPDATES = 0;
-- UPDATE Clients SET OCCUPATION_TYPE = 'Unknown OCCUPATION' WHERE OCCUPATION_TYPE = '';
-- SELECT COUNT(*) FROM Clients WHERE OCCUPATION_TYPE = '';

-- --------------------------------------------------------
-- Demographic Analysis
-- --------------------------------------------------------

-- Calculate percentage of males in the dataset
-- SELECT (COUNT(CASE WHEN CODE_GENDER = 'M' THEN 1 END) * 100.0 / COUNT(*)) AS 'male %' FROM Clients;

-- Create a CTE for demographic percentages
-- WITH Percentages AS (
--    SELECT 
--        ROUND(COUNT(CASE WHEN CODE_GENDER = 'M' THEN 1 END) * 100.0 / COUNT(*), 2) AS percent_value, 
--        'Males %' AS column_name 
--    FROM Clients
--    UNION ALL
--    SELECT 
--        ROUND(COUNT(CASE WHEN FLAG_OWN_REALTY = 'Y' THEN 1 END) * 100.0 / COUNT(*), 2) AS percent_value, 
--        'OWN_REALTY %' AS column_name 
--    FROM Clients
--    UNION ALL
--    SELECT 
--        ROUND(COUNT(CASE WHEN FLAG_OWN_CAR = 'Y' THEN 1 END) * 100.0 / COUNT(*), 2) AS percent_value, 
--        'OWN_CAR %' AS column_name 
--    FROM Clients
--    UNION ALL
--    SELECT 
--        ROUND(COUNT(CASE WHEN AMT_INCOME_TOTAL > 100000 THEN 1 END) * 100.0 / COUNT(*), 2) AS percent_value, 
--        'High Income %' AS column_name 
--    FROM Clients
--    UNION ALL
--    SELECT 
--        ROUND(COUNT(CASE WHEN CNT_CHILDREN = '0' THEN 1 END) * 100.0 / COUNT(*), 2) AS percent_value, 
--        'No Kids %' AS column_name 
--    FROM Clients
--    UNION ALL
--    SELECT 
--        ROUND(COUNT(CASE WHEN NAME_INCOME_TYPE = 'Working' THEN 1 END) * 100.0 / COUNT(*), 2) AS percent_value, 
--        'Working %' AS column_name 
--    FROM Clients
--    UNION ALL
--    SELECT 
--        ROUND(COUNT(CASE WHEN NAME_EDUCATION_TYPE = 'Higher education' THEN 1 END) * 100.0 / COUNT(*), 2) AS percent_value, 
--        'Higher Education %' AS column_name 
--    FROM Clients
--    UNION ALL
--    SELECT 
--        ROUND(COUNT(CASE WHEN NAME_FAMILY_STATUS = 'Married' THEN 1 END) * 100.0 / COUNT(*), 2) AS percent_value, 
--        'Married %' AS column_name 
--    FROM Clients
--    UNION ALL
--    SELECT 
--        ROUND(COUNT(CASE WHEN NAME_HOUSING_TYPE = 'House / apartment' THEN 1 END) * 100.0 / COUNT(*), 2) AS percent_value, 
--        'House / Apartment Owners %' AS column_name 
--    FROM Clients
-- )
-- SELECT column_name, percent_value FROM Percentages;

-- --------------------------------------------------------
-- Statistical Analysis
-- --------------------------------------------------------

-- Calculate mean and standard deviation for children and income
-- SELECT 
--    AVG(CNT_CHILDREN) AS mean_children,
--    STDDEV(CNT_CHILDREN) AS stddev_children,
--    AVG(AMT_INCOME_TOTAL) AS mean_income,
--    STDDEV(AMT_INCOME_TOTAL) AS stddev_income
-- FROM Clients;

-- --------------------------------------------------------
-- Adding and Updating New Columns
-- --------------------------------------------------------

-- Add BIRTH_DATE column and calculate birth dates from DAYS_BIRTH
-- ALTER TABLE Clients ADD COLUMN BIRTH_DATE DATE;
-- UPDATE Clients SET BIRTH_DATE = CURDATE() + INTERVAL DAYS_BIRTH DAY;

-- Add HIRE_DATE column and update it based on DAYS_EMPLOYED
-- ALTER TABLE Clients ADD COLUMN HIRE_DATE DATE;
-- SET SQL_SAFE_UPDATES = 0;
-- UPDATE Clients SET HIRE_DATE = CURDATE() + INTERVAL DAYS_EMPLOYED DAY WHERE DAYS_EMPLOYED < 0;
-- UPDATE Clients SET HIRE_DATE = CURDATE() WHERE DAYS_EMPLOYED >= 0;

-- Sample Data after updates
-- SELECT * FROM Clients LIMIT 10;
