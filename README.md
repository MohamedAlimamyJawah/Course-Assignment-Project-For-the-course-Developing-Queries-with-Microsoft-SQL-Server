## Course-Assignment-Project-For-the-course-Developing-Queries-with-Microsoft-SQL-Server
You have been asked by Quantum Analytics to develop Queries using Adventures Works2022

Firstly I called the Adventures Works2022 Database "Use Adventures Works2022"

Image 1
![Use Adventuesr Works2022](https://github.com/MohamedAlimamyJawah/Course-Assignment-Project-For-the-course-Developing-Queries-with-Microsoft-SQL-Server/assets/131864852/3a1c9b15-442b-474a-8ec8-c4cb0222921e)


### Now I will by using Adventures Works2022, to answer the 15 questions provided.

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

![Screenshot (35)](https://github.com/MohamedAlimamyJawah/Course-Assignment-Project-For-the-course-Developing-Queries-with-Microsoft-SQL-Server/assets/131864852/69a4a4ee-dd6c-4dfb-9668-08b1692d957d)


