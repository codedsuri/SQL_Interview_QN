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

-- This gives lowest sales irrespective of duplicate dates
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


-- Ques3. What is the total sales and units of OnePlus phones?
USE Town1;
WITH InnSales (ProductCode, TotalSales) AS
(
SELECT ProductCode, SUM(Sales) as TotalSales
FROM Sales
GROUP BY ProductCode )

SELECT X.Brand_Name, X.TotalSalesAmt, TotalSalesAmt/X.TotalUnitPrice AS UnitSold
FROM
(
	SELECT P.BrandName as Brand_Name, SUM(InnSales.TotalSales) AS TotalSalesAmt, SUM(P.UnitPrice) AS TotalUnitPrice 
	FROM InnSales
	JOIN Product P
	ON InnSales.ProductCode= P.ProductCode
	GROUP BY P.BrandName)X
WHERE X.Brand_Name= 'OnePlus';

------ OR 

SELECT P.BrandName , SUM(X.TotalSales) AS SalesAmount, SUM(X.TotalSales)/SUM(P.UnitPrice) AS QTYSold
FROM
(
	SELECT ProductCode, SUM(Sales) AS TotalSales
	FROM Town1.dbo.Sales
	GROUP BY ProductCode) X
JOIN 
Town1.dbo.Product P
	ON X.ProductCode = P.ProductCode
WHERE P.BrandName = 'OnePlus'
GROUP BY P.BrandName

---Ques4. 4. Which products had the highest sales under each brand?

SELECT Z.BrandName, Z.ProductCode, Z.TotalSales
FROM
(
	SELECT Y.*,
	DENSE_RANK() OVER (PARTITION BY Y.BrandName ORDER BY Y.TotalSales ASC) AS RNK 
	FROM 
	( SELECT P.BrandName, P.ProductCode, X.TotalSales
	   FROM
		(	SELECT ProductCode, SUM(Sales) AS TotalSales
			FROM Town1.dbo.Sales
			GROUP BY ProductCode) X
			JOIN 
			Town1.dbo.Product P
			ON X.ProductCode = P.ProductCode) Y) Z
WHERE RNK >1;
