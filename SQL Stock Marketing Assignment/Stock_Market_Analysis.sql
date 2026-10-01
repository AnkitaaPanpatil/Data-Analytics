CREATE DATABASE stock_market_analysis;
USE stock_market_analysis;

SELECT *
FROM bajaj_auto;

DESCRIBE bajaj_auto;
SHOW TABLES;

SHOW COLUMNS FROM bajaj_auto;

SELECT *
FROM bajaj_auto
WHERE `Close Price` IS NULL;

SELECT COUNT(*) AS Total_Records
FROM bajaj_auto;

SELECT
MAX(`Close Price`) AS Highest_Price,
MIN(`Close Price`) AS Lowest_Price
FROM bajaj_auto;

SELECT Date, `Close Price`
FROM bajaj_auto
ORDER BY `Close Price` DESC
LIMIT 1;

SELECT Date, `Close Price`
FROM bajaj_auto
ORDER BY `Close Price` ASC
LIMIT 1;

SELECT MIN(Date) AS Start_Date
FROM bajaj_auto;

SELECT MAX(Date) AS End_Date
FROM bajaj_auto;

SELECT Date, `Close Price`
FROM bajaj_auto
WHERE Date = (SELECT MIN(Date) FROM bajaj_auto);

SELECT Date, `Close Price`
FROM bajaj_auto
WHERE Date = (SELECT MAX(Date) FROM bajaj_auto);

SELECT
(
(
(SELECT `Close Price`
 FROM bajaj_auto
 WHERE Date = (SELECT MAX(Date) FROM bajaj_auto))
-
(SELECT `Close Price`
 FROM bajaj_auto
 WHERE Date = (SELECT MIN(Date) FROM bajaj_auto))
)
/
(SELECT `Close Price`
 FROM bajaj_auto
 WHERE Date = (SELECT MIN(Date) FROM bajaj_auto))
) * 100 AS Percentage_Change;

SELECT
    Date,
    `Open Price`,
    `Close Price`,
    CASE
        WHEN `Close Price` > `Open Price` THEN 'BUY'
        WHEN `Close Price` < `Open Price` THEN 'SELL'
        ELSE 'HOLD'
    END AS Recommendation
FROM bajaj_auto;

SELECT
MAX(`Close Price`) AS Highest_Price,
MIN(`Close Price`) AS Lowest_Price
FROM bajaj_auto;

SELECT
MAX(`Close Price`) AS Highest_Price,
MIN(`Close Price`) AS Lowest_Price
FROM eicher_motors;

SELECT
MAX(`Close Price`) AS Highest_Price,
MIN(`Close Price`) AS Lowest_Price
FROM hero_motocorp;

SELECT
MAX(`Close Price`) AS Highest_Price,
MIN(`Close Price`) AS Lowest_Price
FROM infosys;

SELECT
MAX(`Close Price`) AS Highest_Price,
MIN(`Close Price`) AS Lowest_Price
FROM tcs;

SELECT
MAX(`Close Price`) AS Highest_Price,
MIN(`Close Price`) AS Lowest_Price
FROM tvs_motors;

SELECT
SUM(CASE WHEN `Close Price` > `Open Price` THEN 1 ELSE 0 END) AS Buy_Opportunities,
SUM(CASE WHEN `Close Price` < `Open Price` THEN 1 ELSE 0 END) AS Sell_Opportunities
FROM bajaj_auto;

SELECT
(
(
(SELECT `Close Price`
 FROM bajaj_auto
 WHERE Date = (SELECT MAX(Date) FROM bajaj_auto))
-
(SELECT `Close Price`
 FROM bajaj_auto
 WHERE Date = (SELECT MIN(Date) FROM bajaj_auto))
)
/
(SELECT `Close Price`
 FROM bajaj_auto
 WHERE Date = (SELECT MIN(Date) FROM bajaj_auto))
) * 100 AS Percentage_Change;

SELECT
(
(
(SELECT `Close Price`
 FROM eicher_motors
 WHERE Date = (SELECT MAX(Date) FROM eicher_motors))
-
(SELECT `Close Price`
 FROM eicher_motors
 WHERE Date = (SELECT MIN(Date) FROM eicher_motors))
)
/
(SELECT `Close Price`
 FROM eicher_motors
 WHERE Date = (SELECT MIN(Date) FROM eicher_motors))
) * 100 AS Percentage_Change;

SELECT
(
(
(SELECT `Close Price`
 FROM hero_motocorp
 WHERE Date = (SELECT MAX(Date) FROM hero_motocorp))
-
(SELECT `Close Price`
 FROM hero_motocorp
 WHERE Date = (SELECT MIN(Date) FROM hero_motocorp))
)
/
(SELECT `Close Price`
 FROM hero_motocorp
 WHERE Date = (SELECT MIN(Date) FROM hero_motocorp))
) * 100 AS Percentage_Change;

SELECT
(
(
(SELECT `Close Price`
 FROM infosys
 WHERE Date = (SELECT MAX(Date) FROM infosys))
-
(SELECT `Close Price`
 FROM infosys
 WHERE Date = (SELECT MIN(Date) FROM infosys))
)
/
(SELECT `Close Price`
 FROM infosys
 WHERE Date = (SELECT MIN(Date) FROM infosys))
) * 100 AS Percentage_Change;

SELECT
(
(
(SELECT `Close Price`
 FROM tcs
 WHERE Date = (SELECT MAX(Date) FROM tcs))
-
(SELECT `Close Price`
 FROM tcs
 WHERE Date = (SELECT MIN(Date) FROM tcs))
)
/
(SELECT `Close Price`
 FROM tcs
 WHERE Date = (SELECT MIN(Date) FROM tcs))
) * 100 AS Percentage_Change;

SELECT
(
(
(SELECT `Close Price`
 FROM tvs_motors
 WHERE Date = (SELECT MAX(Date) FROM tvs_motors))
-
(SELECT `Close Price`
 FROM tvs_motors
 WHERE Date = (SELECT MIN(Date) FROM tvs_motors))
)
/
(SELECT `Close Price`
 FROM tvs_motors
 WHERE Date = (SELECT MIN(Date) FROM tvs_motors))
) * 100 AS Percentage_Change;

CREATE TABLE master_stock AS
SELECT Date, `Close Price`, 'Bajaj Auto' AS Company
FROM bajaj_auto

UNION ALL

SELECT Date, `Close Price`, 'Eicher Motors'
FROM eicher_motors

UNION ALL

SELECT Date, `Close Price`, 'Hero Motocorp'
FROM hero_motocorp

UNION ALL

SELECT Date, `Close Price`, 'Infosys'
FROM infosys

UNION ALL

SELECT Date, `Close Price`, 'TCS'
FROM tcs

UNION ALL

SELECT Date, `Close Price`, 'TVS Motors'
FROM tvs_motors;

SELECT *
FROM master_stock
LIMIT 10;

SELECT COUNT(*)
FROM master_stock;

SELECT
    Date,
    Company,
    `Close Price`,
    AVG(`Close Price`) OVER (
        PARTITION BY Company
        ORDER BY STR_TO_DATE(Date, '%d-%b-%Y')
        ROWS BETWEEN 19 PRECEDING AND CURRENT ROW
    ) AS MA20
FROM master_stock;

SELECT
    Date,
    Company,
    `Close Price`,
    AVG(`Close Price`) OVER (
        PARTITION BY Company
        ORDER BY STR_TO_DATE(Date, '%d-%b-%Y')
        ROWS BETWEEN 49 PRECEDING AND CURRENT ROW
    ) AS MA50
FROM master_stock;

SELECT
    Date,
    Company,
    `Close Price`,
    CASE
        WHEN `Close Price` >
             AVG(`Close Price`) OVER (
                 PARTITION BY Company
                 ORDER BY STR_TO_DATE(Date, '%d-%b-%Y')
                 ROWS BETWEEN 19 PRECEDING AND CURRENT ROW
             )
        THEN 'BUY'
        ELSE 'SELL'
    END AS Trading_Signal
FROM master_stock;