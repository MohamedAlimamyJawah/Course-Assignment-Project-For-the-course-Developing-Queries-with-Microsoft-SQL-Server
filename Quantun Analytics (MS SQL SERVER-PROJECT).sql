-- Project ( Developing Queries with Microsoft SQL Server)

--Developing Queries with Microsoft SQL Server
--Business Requirements

--Question 1

--Retrieve information about the products with colour values except null, red, silver/black, white and list price between
--£75 and £750. Rename the column StandardCost to Price. Also, sort the results in descendin

SELECT 
    ProductID, 
    Name, 
    ProductNumber, 
    Color, 
    ListPrice AS Price
FROM 
    Production.Product
WHERE 
    Color NOT IN ('red', 'silver/black', 'white') AND
    Color IS NOT NULL AND
    ListPrice BETWEEN 75 AND 750
ORDER BY 
    ListPrice DESC;

--Question 2
--Find all the male employees born between 1962 to 1970 and with hire date greater than 2001 and female employees.
--born between 1972 and 1975 and hire date between 2001 and 2002.

Select *
from HumanResources.Employee

SELECT 
    BusinessEntityID,  
    Gender, 
	JobTitle
    BirthDate, 
    HireDate
FROM 
    HumanResources.Employee
WHERE 
    (Gender = 'M' AND YEAR(BirthDate) BETWEEN 1962 AND 1970 AND YEAR(HireDate) > 2001)
    OR 
    (Gender = 'F' AND YEAR(BirthDate) BETWEEN 1972 AND 1975 AND YEAR(HireDate) BETWEEN 2001 AND 2002)
ORDER BY 
    HireDate;

--Question 3
--Create a list of 10 most expensive products that have a product number beginning with ‘BK’. Include only the product
--ID, Name and colour.

SELECT *
FROM Production.Product

SELECT TOP 10 
    ProductID, 
    Name, 
    Color
FROM 
    Production.Product
WHERE 
    ProductNumber LIKE 'BK%'
ORDER BY 
    ListPrice DESC;

--Question 4
--Create a list of all contact persons, where the first 4 characters of the last name are the same as the first four characters of the email address. 
--Also, for all contacts whose first name and last name begin with the same characters, create a new column called full name combining first name 
--and last name only. Also, provide the length of the new column's full name.

SELECT *
FROM Person.Person

SELECT 
    FirstName, 
    LastName, 
    CONCAT(FirstName, ' ', LastName) AS FullName,
    LEN(CONCAT(FirstName, ' ', LastName)) AS FullNameLength
FROM 
    Person.Person
WHERE 
    LEFT(LastName, 4) = LEFT(FirstName, 4)
    OR LEFT(FirstName, 1) = LEFT(LastName, 1)
ORDER BY 
    FullName;


--Question 5
--Return all product subcategories that take an average of 3 days or longer to manufacture

SELECT *
FROM  Production.Product

--Question 6
--Create a list of product segmentation by defining criteria that place each item in a predefined segment as follows.
--If The price is less than £200 then low value. 
--If the price is between £201 and £750 then mid value.
--If between £750 and £1250 then mid to high value else higher value. 
--Filter the results only for black, silver, and red color products.

SELECT *
FROM Production.Product

SELECT 
    ProductID, 
    Name, 
    Color, 
    ListPrice,
    CASE
        WHEN ListPrice < 200 THEN 'Low Value'
        WHEN ListPrice BETWEEN 201 AND 750 THEN 'Mid Value'
        WHEN ListPrice BETWEEN 751 AND 1250 THEN 'Mid to High Value'
        ELSE 'High Value'
    END AS ValueSegment
FROM 
    Production.Product
WHERE 
    Color IN ('Black', 'Silver', 'Red')
ORDER BY 
    ValueSegment;

--Question 7
--How many Distinct Job titles is present in the Employee table?

SELECT 
    COUNT(DISTINCT JobTitle) AS DistinctJobTitles
FROM 
    HumanResources.Employee;


--Question 8
--Use the employee table and calculate the ages of each employee at the time of hiring.

SELECT * 
FROM HumanResources.Employee

SELECT 
    BusinessEntityID, 
    Gender,  
    BirthDate, 
    HireDate, 
    DATEDIFF(YEAR, BirthDate, HireDate) AS AgeAtHiring
FROM 
    HumanResources.Employee;

-- Question 9
-- How many employees will be due a long service award in the next 5 years, if long service is 20 years?

SELECT *
FROM HumanResources.Employee

SELECT 
    COUNT(*) AS EmployeesDueForLongServiceAward
FROM 
    HumanResources.Employee
WHERE 
    DATEDIFF(YEAR, HireDate, DATEADD(YEAR, 5, GETDATE())) >= 20;

-- Question 10
--How many more years does each employee have to work before reaching sentiment, if sentiment age is 65?

SELECT *
FROM HumanResources.Employee

SELECT 
    BusinessEntityID, 
    JobTitle,  
    BirthDate, 
    65 - DATEDIFF(YEAR, BirthDate, GETDATE()) AS YearsToRetirement
FROM 
    HumanResources.Employee
WHERE 
    DATEDIFF(YEAR, BirthDate, GETDATE()) < 65;

--Question 11

--Implement a new price policy on the product table based on the color of the item.
--If white increases the price by 8%, yellow reduces the price by 7.5%, and black increases the price by 17.2%. If multi, silver,
--silver/black, or blue take the square root of the price and double the value. The column should be called new price. 
--For each item, also calculate the commission as 37.5% of the newly computed list price.

SELECT *
FROM Production.Product


SELECT 
    ProductID, 
    Name, 
    Color, 
    ListPrice,
    CASE
        WHEN Color = 'White' THEN ListPrice * 1.08
        WHEN Color = 'Yellow' THEN ListPrice * 0.925
        WHEN Color = 'Black' THEN ListPrice * 1.172
        WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN SQRT(ListPrice) * 2
        ELSE ListPrice
    END AS NewPrice,
    CASE
        WHEN Color = 'White' THEN ListPrice * 1.08 * 0.375
        WHEN Color = 'Yellow' THEN ListPrice * 0.925 * 0.375
        WHEN Color = 'Black' THEN ListPrice * 1.172 * 0.375
        WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN SQRT(ListPrice) * 2 * 0.375
        ELSE ListPrice * 0.375
    END AS Commission
FROM 
    Production.Product;


--Question 12
--Print the information about all the Sales. Person and their sales quota. For every Salesperson, you should provide their
--FirstName, LastName, Hire Date, Sick Leave Hours, and Region where they work.


SELECT 
    sp.BusinessEntityID, 
    p.FirstName, 
    p.LastName, 
    e.HireDate, 
    e.SickLeaveHours, 
    t.Name AS TerritoryName, 
    sp.SalesQuota
FROM 
    Sales.SalesPerson AS sp
JOIN 
    HumanResources.Employee AS e ON sp.BusinessEntityID = e.BusinessEntityID
JOIN 
    Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
LEFT JOIN 
    Sales.SalesTerritory AS t ON sp.TerritoryID = t.TerritoryID;	


--Question 13

--Using Adventure works, write a query to extract the following information 
--Product name,Product category name, Product subcategory name, Salesperson, Revenue,
--Month of transaction, Quarter of transaction, Region


SELECT 
    p.Name AS ProductName, 
    pc.Name AS ProductCategoryName, 
    psc.Name AS ProductSubcategoryName, 
    CONCAT(pe.FirstName, ' ', pe.LastName) AS Salesperson, 
    sod.LineTotal AS Revenue, 
    MONTH(soh.OrderDate) AS MonthOfTransaction, 
    DATEPART(QUARTER, soh.OrderDate) AS QuarterOfTransaction, 
    st.Name AS Region
FROM 
    Sales.SalesOrderDetail AS sod
JOIN 
    Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN 
    Sales.SalesPerson AS sp ON soh.SalesPersonID = sp.BusinessEntityID
JOIN 
    HumanResources.Employee AS e ON sp.BusinessEntityID = e.BusinessEntityID
JOIN 
    Person.Person AS pe ON e.BusinessEntityID = pe.BusinessEntityID
JOIN 
    Production.Product AS p ON sod.ProductID = p.ProductID
JOIN 
    Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN 
    Production.ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN 
    Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID;

--Question 14
--Display the information about the details of an order i.e. order number, order date, 
--amount of order, which customer gives the order which salesman works for that customer, 
--and how much commission he gets for an order.

SELECT 
    soh.SalesOrderID AS OrderNumber, 
    soh.OrderDate, 
    soh.TotalDue AS OrderAmount, 
    sp.CommissionPct * soh.TotalDue AS Commission
FROM 
    Sales.SalesOrderHeader AS soh
JOIN 
    Sales.Customer AS c ON soh.CustomerID = c.CustomerID
JOIN 
    Sales.SalesPerson AS sp ON soh.SalesPersonID = sp.BusinessEntityID
JOIN 
    HumanResources.Employee AS e ON sp.BusinessEntityID = e.BusinessEntityID;


--Question 15

	SELECT 
    ProductID,
    Name,
    Color,
    StandardCost,
    CASE
        WHEN Color = 'Black' THEN StandardCost * 1.22
        WHEN Color = 'Red' THEN StandardCost * 0.88
        WHEN Color = 'Silver' THEN StandardCost * 1.15
        WHEN Color = 'Multi' THEN StandardCost * 1.05
        WHEN Color = 'White' THEN 2 * StandardCost / SQRT(StandardCost)
        ELSE StandardCost
    END AS AdjustedCost,
    StandardCost * 0.1479 AS Commission,
    CASE
        WHEN Color = 'Black' THEN StandardCost * 1.22 - StandardCost * 0.1479
        WHEN Color = 'Red' THEN StandardCost * 0.88 - StandardCost * 0.1479
        WHEN Color = 'Silver' THEN StandardCost * 1.15 - StandardCost * 0.1479
        WHEN Color = 'Multi' THEN StandardCost * 1.05 - StandardCost * 0.1479
        WHEN Color = 'White' THEN 2 * StandardCost / SQRT(StandardCost) - StandardCost * 0.1479
        ELSE StandardCost - StandardCost * 0.1479
    END AS Margin
FROM 
    Production.Product


--Question 16
--Create a view to find out the top 5 most expensive products for each color.

SELECT 
    Color,
    ProductID,
    Name,
    ListPrice
FROM 
(
    SELECT 
        Color,
        ProductID,
        Name,
        ListPrice,
        ROW_NUMBER() OVER (PARTITION BY Color ORDER BY ListPrice DESC) as RowNumber
    FROM 
        Production.Product
) AS Products
WHERE 
    RowNumber <= 5