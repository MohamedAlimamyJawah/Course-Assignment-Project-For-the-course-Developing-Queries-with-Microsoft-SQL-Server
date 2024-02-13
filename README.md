### Author : Mohamed Alimamy Jawah

### Tool/s : T-SQL


## Course-Assignment-Project-For-the-course-Developing-Queries-with-Microsoft-SQL-Server
You have been asked by Quantum Analytics to develop Queries using Adventures Works2022

Firstly I called the Adventures Works2022 Database "Use Adventures Works2022"

Image 1
![Use Adventuesr Works2022](https://github.com/MohamedAlimamyJawah/Course-Assignment-Project-For-the-course-Developing-Queries-with-Microsoft-SQL-Server/assets/131864852/3a1c9b15-442b-474a-8ec8-c4cb0222921e)


### Now I will use the Adventures Works2022 Database, to answer the questions provided.

Question 1

Retrieve information about the products with color values except for null, red, silver/black, white, and list price between £75 and £750. Rename the column StandardCost to Price. Also, sort the results in descending order.

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
    
Image 2

![Screenshot (35)](https://github.com/MohamedAlimamyJawah/Course-Assignment-Project-For-the-course-Developing-Queries-with-Microsoft-SQL-Server/assets/131864852/69a4a4ee-dd6c-4dfb-9668-08b1692d957d)


Question 2

Find all the male employees born between 1962 to 1970 and with a hire date greater than 2001 and female employees.
born between 1972 and 1975 and hired date between 2001 and 2002.

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
    
Image 3

![Screenshot (37)](https://github.com/MohamedAlimamyJawah/Course-Assignment-Project-For-the-course-Developing-Queries-with-Microsoft-SQL-Server/assets/131864852/383724ac-b946-4c54-8bd6-ae3d50520e70)


Question 3

Create a list of the 10 most expensive products that have a product number beginning with ‘BK’. Include only the product, Name, and color.

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

Image 4
![Screenshot (38)](https://github.com/MohamedAlimamyJawah/Course-Assignment-Project-For-the-course-Developing-Queries-with-Microsoft-SQL-Server/assets/131864852/6659b5ae-c2af-4dad-8cc5-6996ed53d379)


Question 5
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
    
Image 6

    ![Screenshot (40)](https://github.com/MohamedAlimamyJawah/Course-Assignment-Project-For-the-course-
    Developing-Queries-with-Microsoft-SQL-Server/assets/131864852/f976915d-f58b-4f50-9b80-86467d20866a)



Question 7
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

Image 7

![Screenshot (40)](https://github.com/MohamedAlimamyJawah/Course-Assignment-Project-For-the-course-Developing-Queries-with-Microsoft-SQL-Server/assets/131864852/2abb7887-1ed6-403c-bc0a-4bad2aff7d78)

