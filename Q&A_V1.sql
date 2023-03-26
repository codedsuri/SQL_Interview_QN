--- Ques1.  What is the total Ad Spend for Jan 6th, 2022?
SELECT Date, SUM(Sales) AS TotalSales 
FROM Town1.dbo.Sales
WHERE Date LIKE '%06%'
GROUP BY Date;

--- Ques2. What 3 days had the lowest sales?
-- This gives Lowest sale on different dates
SELECT TOP 3 Date, MIN(Sales) AS MinSales
FROM Town1.dbo.Sales
GROUP BY Date
ORDER BY MinSales ASC;

-- This gives lowest sales irrespective of dates
SELECT TOP 3 Date, Sales
FROM Town1.dbo.Sales
ORDER BY Sales ASC;

-- Rank Function
SELECT TOP 3 Date, Sales
FROM
(
	SELECT Date, Sales,
	RANK() OVER(PARTITION BY Date ORDER BY Sales ASC) AS RNK
	FROM Town1.dbo.Sales
) AS x
WHERE x.RNK = 1
ORDER BY Sales ASC;
