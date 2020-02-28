--1.1	Write a query that lists all Customers in either Paris or London. Include Customer ID, Company Name and all address fields.

SELECT * FROM Customers
SELECT CustomerID, CompanyName, Address, PostalCode FROM Customers WHERE City = 'Paris' OR City = 'London'


--1.2	List all products stored in bottles.

SELECT * FROM Products
SELECT ProductName FROM Products
WHERE QuantityPerUnit LIKE '%bottles%'


--1.3	Repeat question above, but add in the Supplier Name and Country.

SELECT * FROM Products
SELECT * FROM Suppliers
SELECT p.ProductName, s.CompanyName, s.Country FROM Products AS p
INNER JOIN Suppliers AS s ON p.SupplierID=s.SupplierID
WHERE QuantityPerUnit LIKE '%bottles%'



--1.4	Write an SQL Statement that shows how many products there are in each category. Include Category Name in result set and list the highest number first.

SELECT * FROM Products
SELECT * FROM Categories
SELECT c.CategoryName,
SUM(c.CategoryID) AS 'Products in Category'
FROM Products p INNER JOIN Categories c ON p.CategoryID=c.CategoryID
GROUP BY c.CategoryName ORDER BY SUM(c.CategoryID) DESC


--1.5	List all UK employees using concatenation to join their title of courtesy, first name and last name together. Also include their city of residence.

SELECT * FROM Employees
SELECT CONCAT(TitleOfCourtesy, FirstName, ' ', LastName) AS 'Employee Name' , City FROM Employees WHERE Country = 'UK'


--1.6	List Sales Totals for all Sales Regions (via the Territories table using 4 joins) with a Sales Total greater than 1,000,000. Use rounding or FORMAT to present the numbers. 

SELECT * FROM Region
SELECT * FROM Territories
SELECT * FROM EmployeeTerritories
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT r.RegionDescription, ROUND(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)), 0) AS 'Total Sales'
FROM Region r
INNER JOIN Territories t ON r.RegionID=t.RegionID
INNER JOIN EmployeeTerritories et ON t.TerritoryID=et.TerritoryID
INNER JOIN Orders o ON et.EmployeeID=o.EmployeeID
INNER JOIN [Order Details] od ON o.OrderID=od.OrderID
GROUP BY r.RegionDescription HAVING SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) > 1000000
ORDER BY SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) DESC

--1.7	Count how many Orders have a Freight amount greater than 100.00 and either USA or UK as Ship Country.

SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT COUNT(Freight) AS 'Large Feight From UK or USA' FROM Orders WHERE (Freight > 100) AND (ShipCountry = 'USA' OR ShipCountry = 'UK')


--1.8	Write an SQL Statement to identify the Order Number of the Order with the highest amount of discount applied to that order.

SELECT * FROM [Order Details]

SELECT OrderID, (UnitPrice*Quantity*Discount) AS 'Discount Amount' FROM [Order Details]
GROUP BY OrderID, (UnitPrice*Quantity*Discount) HAVING (UnitPrice*Quantity*Discount) = (SELECT MAX((UnitPrice*Quantity*Discount))FROM [Order Details])
ORDER BY [Discount Amount] DESC


-- 3.1 List all Employees from the Employees table and who they report to. No Excel required. (5 Marks)

SELECT EmployeeID, ReportsTo FROM Employees


-- 3.2 List all Suppliers with total sales over $10,000 in the Order Details table. Include the Company Name from the Suppliers Table and present as a bar chart as below: (5 Marks) 
SELECT * FROM Suppliers
SELECT * FROM Products
SELECT * FROM [Order Details]
SELECT s.CompanyName, ROUND(SUM((od.UnitPrice*od.Quantity)),2) AS 'Supplier Profit'
FROM Suppliers s
INNER JOIN Products p ON s.SupplierID=p.SupplierID
INNER JOIN [Order Details] od ON p.ProductID=od.ProductID
GROUP BY s.CompanyName HAVING ROUND(SUM((od.UnitPrice*od.Quantity)), 2) > 10000
ORDER BY [Supplier Profit]


-- 3.3 List the Top 10 Customers Year To Date for the latest year in the Orders file. Based on total value of orders shipped. No Excel required. (10 Marks)

SELECT TOP 10 o.CustomerID AS 'Customer ID',
c.CompanyName AS 'Company Name',
ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)),2) AS 'Total Value',
YEAR(ShippedDate) AS 'Current Year' FROM 
((Orders o INNER JOIN [Order Details] od ON o.OrderID=od.OrderID)
INNER JOIN Customers c ON c.CustomerID=o.CustomerID)
GROUP BY o.CustomerID, c.CompanyName, YEAR(ShippedDate)
HAVING YEAR(ShippedDate) = (SELECT YEAR(MAX(ShippedDate)) FROM Orders)
ORDER BY [Total Value] DESC


-- 3.4 Plot the Average Ship Time by month for all data in the Orders Table using a line chart as below. (10 Marks)


SELECT * FROM Orders

SELECT MONTH(ShippedDate) AS 'Month',
AVG(DATEDIFF(DD,OrderDate,ShippedDate)) AS 'Average wait in days'
FROM Orders GROUP BY MONTH(ShippedDate)
HAVING AVG(DATEDIFF(DD,OrderDate,ShippedDate)) >= 0
ORDER BY [Month]