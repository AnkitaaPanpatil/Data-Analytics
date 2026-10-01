CREATE DATABASE uber_db;
USE uber_db;
SHOW DATABASES;
SHOW TABLES;

SELECT *
FROM uber_requests
LIMIT 10;

SELECT COUNT(*) AS Total_Requests
FROM uber_requests;

SELECT Status, COUNT(*) AS Total
FROM uber_requests
GROUP BY Status;

SELECT `Pickup point`, COUNT(*) AS Total_Requests
FROM uber_requests
GROUP BY `Pickup point`;

SELECT COUNT(*) AS Completed_Trips
FROM uber_requests
WHERE Status = 'Trip Completed';

SELECT COUNT(*) AS Cancelled_Trips
FROM uber_requests
WHERE Status = 'Cancelled';

SELECT COUNT(*) AS No_Cars_Available
FROM uber_requests
WHERE Status = 'No Cars Available';

SELECT
    `Pickup point`,
    Status,
    COUNT(*) AS Total
FROM uber_requests
GROUP BY `Pickup point`, Status
ORDER BY `Pickup point`, Status;

SELECT
    `Pickup point`,
    COUNT(*) AS Total_Requests
FROM uber_requests
GROUP BY `Pickup point`
ORDER BY Total_Requests DESC;

SELECT *
FROM uber_requests
WHERE `Pickup point` = 'Airport'
AND Status = 'Trip Completed';

SELECT *
FROM uber_requests
WHERE `Pickup point` = 'City'
AND Status = 'Cancelled';

DESCRIBE uber_requests;

SELECT `Request timestamp`
FROM uber_requests
LIMIT 10;

SELECT `Request timestamp`
FROM uber_requests
LIMIT 5;

SELECT
    HOUR(`Request timestamp`) AS Request_Hour,
    COUNT(*) AS Total_Requests
FROM uber_requests
GROUP BY HOUR(`Request timestamp`)
ORDER BY Request_Hour;

SELECT
    DAYNAME(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i:%s')) AS Day_Name,
    COUNT(*) AS Total_Requests
FROM uber_requests
GROUP BY Day_Name;

SELECT
CASE
    WHEN HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i:%s')) BETWEEN 0 AND 4 THEN 'Late Night'
    WHEN HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i:%s')) BETWEEN 5 AND 9 THEN 'Morning'
    WHEN HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i:%s')) BETWEEN 10 AND 16 THEN 'Day'
    WHEN HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i:%s')) BETWEEN 17 AND 20 THEN 'Evening'
    ELSE 'Night'
END AS Time_Slot,
COUNT(*) AS Total_Requests
FROM uber_requests
GROUP BY Time_Slot;

SELECT
CASE
    WHEN HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i:%s')) BETWEEN 0 AND 4 THEN 'Late Night'
    WHEN HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i:%s')) BETWEEN 5 AND 9 THEN 'Morning'
    WHEN HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i:%s')) BETWEEN 10 AND 16 THEN 'Day'
    WHEN HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i:%s')) BETWEEN 17 AND 20 THEN 'Evening'
    ELSE 'Night'
END AS Time_Slot,
Status,
COUNT(*) AS Total
FROM uber_requests
GROUP BY Time_Slot, Status
ORDER BY Time_Slot;

SELECT
    HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i:%s')) AS Request_Hour,
    COUNT(*) AS Total_Requests
FROM uber_requests
GROUP BY Request_Hour
ORDER BY Total_Requests DESC
LIMIT 1;

SELECT
    `Pickup point`,
    Status,
    COUNT(*) AS Total_Requests
FROM uber_requests
GROUP BY `Pickup point`, Status
ORDER BY `Pickup point`, Total_Requests DESC;

SELECT
ROUND(
(SUM(CASE WHEN Status='Cancelled' THEN 1 ELSE 0 END) * 100.0)
/ COUNT(*),2
) AS Cancellation_Percentage
FROM uber_requests;

SELECT
ROUND(
(SUM(CASE WHEN Status='No Cars Available' THEN 1 ELSE 0 END) * 100.0)
/ COUNT(*),2
) AS No_Cars_Available_Percentage
FROM uber_requests;

SELECT
ROUND(
(SUM(CASE WHEN Status='Trip Completed' THEN 1 ELSE 0 END) * 100.0)
/ COUNT(*),2
) AS Trip_Completion_Percentage
FROM uber_requests;

SELECT
    HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i:%s')) AS Request_Hour,
    COUNT(*) AS Total_Requests
FROM uber_requests
GROUP BY Request_Hour
ORDER BY Total_Requests DESC
LIMIT 5;