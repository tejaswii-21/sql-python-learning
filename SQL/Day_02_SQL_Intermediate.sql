/*
===========================================================
DAY 02 - SQL INTERMEDIATE

Table : dbo.data

Columns:
InvoiceNo, StockCode, Description, Quantity,
InvoiceDate, UnitPrice, CustomerID, Country

Focus:
GROUP BY, HAVING, CASE, Subqueries, Date Functions
===========================================================
*/


-- Q1. Find the top 10 customers based on their total spending.
-- Revenue = Quantity * UnitPrice
-- Return CustomerID and TotalSpent.
	   SELECT
	   Top 10 Quantity * UnitPrice AS TotalSpending,
	   CustomerID
	   FROM dbo.data
	   ORDER BY TotalSpending DESC


-- Q2. Find products whose average UnitPrice is greater
-- than the overall average UnitPrice.
-- Return StockCode, Description and AveragePrice.
SELECT
StockCode,
Description,
AVG(UnitPrice) AS AveragePrice
FROM dbo.data
GROUP BY StockCode, Description
HAVING AVG(UnitPrice) > (
    SELECT AVG(UnitPrice)
    FROM dbo.data
)
ORDER BY AveragePrice DESC;
	   


-- Q3. Find customers whose total spending is greater
-- than the average spending of all customers.
-- Return CustomerID and TotalSpent.
SELECT 
CustomerID,
SUM(Quantity * UnitPrice) AS TotalSpendingCust
FROM dbo.data
GROUP BY CustomerID
HAVING SUM(Quantity * UnitPrice)>(
SELECT AVG(TotalSpending)
FROM (
    SELECT
    CustomerID,
    SUM(Quantity * UnitPrice) AS TotalSpending
    FROM dbo.data
    GROUP BY CustomerID
) AS CustomerTotals
)


-- Q4. Find the country with the highest total revenue.
-- Exclude the United Kingdom.
-- Revenue = Quantity * UnitPrice.
SELECT 
Top 1 Country,
SUM(Quantity * UnitPrice) AS TotalRevenue
FROM dbo.data
WHERE Country!='United Kingdom' 
GROUP BY Country
ORDER BY TotalRevenue DESC


-- Q5. Find products purchased by more than 50 different
-- customers.
-- Return StockCode, Description and UniqueCustomers.
SELECT
StockCode, 
Description,
COUNT(DISTINCT CustomerID) AS UniqueCustomers
FROM dbo.data
GROUP BY StockCode, Description
HAVING COUNT(DISTINCT(CustomerID))>50


-- Q6. Find the top 5 products based on total quantity sold.
-- Ignore transactions where Quantity <= 0.
-- Return StockCode, Description and TotalQuantity.
SELECT Top 5 StockCode,
SUM(Quantity) AS TotalQuantity,
Description
FROM dbo.data
WHERE Quantity>0
GROUP BY StockCode,Description

-- Q7. Use CASE to classify each transaction:
-- UnitPrice >= 10  -> 'High Value'
-- UnitPrice >= 5   -> 'Medium Value'
-- UnitPrice < 5    -> 'Low Value'
--
-- Return InvoiceNo, StockCode, UnitPrice and PriceCategory.
SELECT 
InvoiceNo,
StockCode,
CASE
WHEN UnitPrice>=10 THEN 'High Value'
WHEN UnitPrice>=5THEN 'Medium Value'
WHEN UnitPrice<5 THEN 'Low Value'
END  AS PriceCategory
FROM dbo.data

-- Q8. Find the second-highest spending customer.
-- Return CustomerID and TotalSpent.
-- Do not simply use TOP 2.
SELECT CustomerID,
SUM(Quantity*UnitPrice) AS TotalSpent
FROM dbo.data
GROUP BY CustomerID
ORDER BY TotalSpent DESC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY


-- Q9. Find countries whose average transaction value is
-- greater than the overall average transaction value.
-- TransactionValue = Quantity * UnitPrice.
-- Return Country and AverageTransactionValue.
SELECT 
AVG(Quantity*UnitPrice) AS AvgCountry,
Country
FROM dbo.data
GROUP BY Country
HAVING AVG(Quantity*UnitPrice)>(
    SELECT AVG(Quantity*UnitPrice) AS TotalAvg
    FROM dbo.data)


-- Q10. Find the month with the highest total revenue.
-- Revenue = Quantity * UnitPrice.
-- Return Month and TotalRevenue.
SELECT 
TOP 1 SUM(Quantity * UnitPrice) AS TotalRevenue,
DATENAME(MONTH,InvoiceDate) AS Month
FROM dbo.data
GROUP BY DATENAME(MONTH,InvoiceDate)
ORDER BY TotalRevenue DESC