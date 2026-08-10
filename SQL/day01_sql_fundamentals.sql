/*
====================================================
DAY 01 - SQL FUNDAMENTALS
====================================================

Dataset  : Online Retail
Database : SQLPractice

Focus:
- SELECT
- WHERE
- TOP
- NULL values
- COUNT
- DISTINCT
- GROUP BY
- ORDER BY
- Basic calculations

Goal:
Practice basic SQL queries and understand the structure
of the dataset before moving to advanced analysis.
====================================================
*/


-- Q1. Display all columns and all records from the table.

       SELECT *
       FROM dbo.data;

-- Q2. Display only InvoiceNo, Description, Quantity, UnitPrice, and Country.

       SELECT InvoiceNo, Description, Quantity, UnitPrice,Country
       FROM dbo.data;


-- Q3. Find the first 20 transactions with the highest Quantity.

       SELECT Top 20 InvoiceNo
       FROM dbo.data
       ORDER BY Quantity DESC;
       


-- Q4. Find all transactions where Quantity is greater than 50.
       SELECT InvoiceNo
       FROM dbo.data
       WHERE Quantity>50;


-- Q5. Find all transactions where Country is 'United Kingdom'.
       SELECT InvoiceNo
       FROM dbo.data
       WHERE Country='United Kingdom';


-- Q6. Find all transactions where CustomerID is NULL.
       SELECT InvoiceNo
       FROM dbo.data
       WHERE CustomerID IS NULL;


-- Q7. Find the total number of transactions in the dataset.
       SELECT COUNT(*) AS TotalTransactions
       FROM dbo.data


-- Q8. Find the number of unique products using StockCode.
       SELECT COUNT(DISTINCT(StockCode))
       FROM dbo.data


-- Q9. Find the total quantity of products sold for each Country.
-- Display Country and TotalQuantity, sorted from highest to lowest.
       SELECT Country,SUM(Quantity) AS TotalQuantity
       FROM dbo.data
       GROUP BY Country
       ORDER BY SUM(Quantity) DESC;


-- Q10. Calculate the total sales value for each transaction using Quantity × UnitPrice.
-- Display InvoiceNo, Description, Quantity, UnitPrice, and TotalSales.
       SELECT InvoiceNo, Description, Quantity, UnitPrice,Quantity*UnitPrice AS TotalSales
       FROM dbo.data
    