CREATE DATABASE bellabeat_db;
USE bellabeat_db;
SELECT DATABASE();
SHOW TABLES;
DESCRIBE daily_activity;

SELECT *
FROM daily_activity
LIMIT 10;

SELECT COUNT(*)
FROM daily_activity;

SELECT *
FROM daily_activity
LIMIT 1;

SELECT
Id,
ActivityDate,
COUNT(*) AS Duplicate_Count
FROM daily_activity
GROUP BY Id, ActivityDate
HAVING COUNT(*) > 1;

SELECT *
FROM daily_activity
WHERE TotalSteps IS NULL;

SELECT *
FROM daily_activity
WHERE Calories IS NULL;

SELECT *
FROM daily_activity
WHERE TotalSteps < 0;

SELECT *
FROM daily_activity
WHERE Calories < 0;

SELECT
MIN(ActivityDate) AS Start_Date,
MAX(ActivityDate) AS End_Date
FROM daily_activity;

SELECT COUNT(DISTINCT Id) AS Total_Users
FROM daily_activity;

SELECT ROUND(AVG(TotalSteps), 2) AS Average_Daily_Steps
FROM daily_activity;

SELECT ROUND(AVG(Calories), 2) AS Average_Calories
FROM daily_activity;

SELECT
MAX(TotalSteps) AS Maximum_Steps,
MIN(TotalSteps) AS Minimum_Steps
FROM daily_activity;

SELECT
MAX(Calories) AS Maximum_Calories,
MIN(Calories) AS Minimum_Calories
FROM daily_activity;

SELECT ROUND(AVG(SedentaryMinutes), 2) AS Average_Sedentary_Minutes
FROM daily_activity;

SELECT
ROUND(AVG(VeryActiveMinutes),2) AS Avg_Very_Active,
ROUND(AVG(FairlyActiveMinutes),2) AS Avg_Fairly_Active,
ROUND(AVG(LightlyActiveMinutes),2) AS Avg_Lightly_Active,
ROUND(AVG(SedentaryMinutes),2) AS Avg_Sedentary
FROM daily_activity;

SELECT
Id,
SUM(TotalSteps) AS Total_Steps
FROM daily_activity
GROUP BY Id
ORDER BY Total_Steps DESC
LIMIT 10;

SELECT
Id,
SUM(Calories) AS Total_Calories
FROM daily_activity
GROUP BY Id
ORDER BY Total_Calories DESC
LIMIT 10;

SELECT
Id,
AVG(SedentaryMinutes) AS Average_Sedentary
FROM daily_activity
GROUP BY Id
ORDER BY Average_Sedentary DESC
LIMIT 10;

SELECT
DAYNAME(ActivityDate) AS Weekday,
ROUND(AVG(TotalSteps),2) AS Avg_Steps
FROM daily_activity
GROUP BY DAYNAME(ActivityDate)
ORDER BY Avg_Steps DESC;

SELECT
DAYNAME(ActivityDate) AS Weekday,
ROUND(AVG(Calories),2) AS Avg_Calories
FROM daily_activity
GROUP BY DAYNAME(ActivityDate)
ORDER BY Avg_Calories DESC;

SELECT
DAYNAME(ActivityDate) AS Weekday,
SUM(TotalSteps) AS Total_Steps,
SUM(Calories) AS Total_Calories
FROM daily_activity
GROUP BY DAYNAME(ActivityDate)
ORDER BY Total_Steps DESC;

SELECT
Id,
ActivityDate,
TotalSteps,
CASE
    WHEN TotalSteps < 5000 THEN 'Inactive'
    WHEN TotalSteps BETWEEN 5000 AND 9999 THEN 'Moderately Active'
    ELSE 'Active'
END AS Activity_Level
FROM daily_activity;

SELECT
CASE
    WHEN TotalSteps < 5000 THEN 'Inactive'
    WHEN TotalSteps BETWEEN 5000 AND 9999 THEN 'Moderately Active'
    ELSE 'Active'
END AS Activity_Level,
COUNT(*) AS Total_Days
FROM daily_activity
GROUP BY Activity_Level;

SELECT
Id,
ROUND(AVG(TotalSteps),2) AS Avg_Steps
FROM daily_activity
GROUP BY Id
HAVING AVG(TotalSteps) >= 10000
ORDER BY Avg_Steps DESC;

SELECT
Id,
ROUND(AVG(Calories),2) AS Avg_Calories
FROM daily_activity
GROUP BY Id
ORDER BY Avg_Calories DESC
LIMIT 5;

SELECT
MONTHNAME(ActivityDate) AS Month,
SUM(TotalSteps) AS Total_Steps,
SUM(Calories) AS Total_Calories
FROM daily_activity
GROUP BY MONTHNAME(ActivityDate);

SELECT
Id,
COUNT(*) AS Total_Days,
SUM(TotalSteps) AS Total_Steps,
ROUND(AVG(TotalSteps),2) AS Avg_Steps,
SUM(Calories) AS Total_Calories
FROM daily_activity
GROUP BY Id
ORDER BY Avg_Steps DESC;

SELECT
Id,
ActivityDate,
TotalSteps
FROM daily_activity
WHERE TotalSteps >
(
SELECT AVG(TotalSteps)
FROM daily_activity
);

SELECT
    Id,
    SUM(TotalSteps) AS Total_Steps,
    RANK() OVER (ORDER BY SUM(TotalSteps) DESC) AS User_Rank
FROM daily_activity
GROUP BY Id;

SELECT
    Id,
    Total_Steps,
    DENSE_RANK() OVER (ORDER BY Total_Steps DESC) AS `Dense_Rank`
FROM
(
    SELECT
        Id,
        SUM(TotalSteps) AS Total_Steps
    FROM daily_activity
    GROUP BY Id
) AS t;

SELECT
    Id,
    Total_Steps,
    ROW_NUMBER() OVER (ORDER BY Total_Steps DESC) AS RowNum
FROM
(
    SELECT
        Id,
        SUM(TotalSteps) AS Total_Steps
    FROM daily_activity
    GROUP BY Id
) AS t;

SELECT
    ActivityDate,
    TotalSteps,
    SUM(TotalSteps) OVER (
        ORDER BY ActivityDate
    ) AS Running_Total_Steps
FROM daily_activity;

SELECT
    ActivityDate,
    Calories,
    SUM(Calories) OVER (
        ORDER BY ActivityDate
    ) AS Running_Total_Calories
FROM daily_activity;

WITH UserSummary AS
(
    SELECT
        Id,
        AVG(TotalSteps) AS Avg_Steps
    FROM daily_activity
    GROUP BY Id
)

SELECT
    Id,
    ROUND(Avg_Steps,2) AS Average_Steps
FROM UserSummary
ORDER BY Average_Steps DESC;

WITH OverallAverage AS
(
    SELECT AVG(TotalSteps) AS AvgSteps
    FROM daily_activity
)

SELECT
    Id,
    ActivityDate,
    TotalSteps
FROM daily_activity
WHERE TotalSteps >
(
    SELECT AvgSteps
    FROM OverallAverage
)
ORDER BY TotalSteps DESC;

SELECT
    Id,
    SUM(TotalSteps) AS User_Total_Steps,
    ROUND(
        SUM(TotalSteps) * 100 /
        (SELECT SUM(TotalSteps)
         FROM daily_activity),
         2
    ) AS Percentage_Contribution
FROM daily_activity
GROUP BY Id
ORDER BY Percentage_Contribution DESC;

SELECT
    ActivityDate,
    SUM(TotalSteps) AS Total_Steps
FROM daily_activity
GROUP BY ActivityDate
ORDER BY Total_Steps DESC
LIMIT 1;

SELECT
    ActivityDate,
    SUM(Calories) AS Total_Calories
FROM daily_activity
GROUP BY ActivityDate
ORDER BY Total_Calories DESC
LIMIT 1;

SELECT
    Id,
    COUNT(*) AS Total_Days,
    SUM(TotalSteps) AS Total_Steps,
    ROUND(AVG(TotalSteps),2) AS Average_Steps,
    MAX(TotalSteps) AS Maximum_Steps,
    MIN(TotalSteps) AS Minimum_Steps,
    SUM(Calories) AS Total_Calories,
    ROUND(AVG(Calories),2) AS Average_Calories
FROM daily_activity
GROUP BY Id
ORDER BY Average_Steps DESC;

SELECT
    Id,
    SUM(VeryActiveMinutes) AS Total_Very_Active_Minutes
FROM daily_activity
GROUP BY Id
ORDER BY Total_Very_Active_Minutes DESC
LIMIT 5;

SELECT
    Id,
    SUM(SedentaryMinutes) AS Total_Sedentary_Minutes
FROM daily_activity
GROUP BY Id
ORDER BY Total_Sedentary_Minutes DESC
LIMIT 5;

SELECT
    Id,
    ActivityDate,
    TotalSteps,
    CASE
        WHEN TotalSteps < 5000 THEN 'Inactive'
        WHEN TotalSteps BETWEEN 5000 AND 9999 THEN 'Moderately Active'
        ELSE 'Active'
    END AS Activity_Level
FROM daily_activity;

SELECT
    Activity_Level,
    COUNT(*) AS Total_Records
FROM
(
    SELECT
        CASE
            WHEN TotalSteps < 5000 THEN 'Inactive'
            WHEN TotalSteps BETWEEN 5000 AND 9999 THEN 'Moderately Active'
            ELSE 'Active'
        END AS Activity_Level
    FROM daily_activity
) AS ActivitySummary
GROUP BY Activity_Level;

SELECT
    COUNT(DISTINCT Id) AS Total_Users,
    COUNT(*) AS Total_Records,
    ROUND(AVG(TotalSteps),2) AS Average_Daily_Steps,
    ROUND(AVG(Calories),2) AS Average_Daily_Calories,
    ROUND(AVG(VeryActiveMinutes),2) AS Average_Very_Active_Minutes,
    ROUND(AVG(FairlyActiveMinutes),2) AS Average_Fairly_Active_Minutes,
    ROUND(AVG(LightlyActiveMinutes),2) AS Average_Lightly_Active_Minutes,
    ROUND(AVG(SedentaryMinutes),2) AS Average_Sedentary_Minutes
FROM daily_activity;