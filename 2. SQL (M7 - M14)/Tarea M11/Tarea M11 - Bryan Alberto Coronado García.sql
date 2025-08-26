/****************** PUNTO 1 *****************/

SELECT	p.Name,
		p.ProductID
FROM Production.Product p
WHERE p.ProductID IN
		(SELECT sod.ProductID
		FROM Sales.SalesOrderDetail sod)
ORDER BY p.Name

/****************** PUNTO 2 *****************/

SELECT 
    e.BusinessEntityID, 
    p.FirstName + ' ' + p.LastName AS NombreEmpleado, 
    d.Name AS NombreDepartamento
FROM 
    HumanResources.Employee e
JOIN 
    Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
JOIN 
    HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN 
    HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
WHERE 
    edh.EndDate IS NULL
ORDER BY e.BusinessEntityID;

/****************** PUNTO 3 *****************/

WITH EmpleadosDepartamentos AS (
    SELECT 
        e.BusinessEntityID, 
        p.FirstName + ' ' + p.LastName AS NombreEmpleado, 
        d.Name AS NombreDepartamento
    FROM 
        HumanResources.Employee e
    JOIN 
        Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    JOIN 
        HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
    JOIN 
        HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
    WHERE 
        edh.EndDate IS NULL
)

SELECT * 
FROM EmpleadosDepartamentos
ORDER BY BusinessEntityID;

/****************** PUNTO 4 *****************/

--Tabla temporal local
USE AdventureWorks2022
CREATE TABLE dbo.#ProductsID_Names
			(ProductId INT, 
			Name nvarchar(50));

INSERT INTO #ProductsID_Names ( ProductId, Name)
SELECT p.ProductID, p.Name
FROM Production.Product p
WHERE p.ProductID IN
		(SELECT sod.ProductID
		FROM Sales.SalesOrderDetail sod);

--Tabla temporal global
USE AdventureWorks2022
CREATE TABLE dbo.##ProductsID_Names
			(ProductId INT, 
			Name nvarchar(50));

INSERT INTO ##ProductsID_Names ( ProductId, Name)
SELECT p.ProductID, p.Name
FROM Production.Product p
WHERE p.ProductID IN
		(SELECT sod.ProductID
		FROM Sales.SalesOrderDetail sod);

--Consulta de tabla
SELECT *
FROM #ProductsID_Names pn

SELECT *
FROM ##ProductsID_Names pn

--Eliminación de tabla
DROP TABLE dbo.#ProductsID_Names
DROP TABLE dbo.##ProductsID_Names

/****************** PUNTO 5 *****************/

SELECT	soh.SalesOrderNumber,
		soh.PurchaseOrderNumber
FROM Sales.SalesOrderHeader soh
WHERE soh.OrderDate BETWEEN '20110101' AND '20111231'
ORDER BY soh.SalesOrderNumber

/****************** PUNTO 6 *****************/

SELECT RIGHT (soh.SalesOrderNumber,5) as NewSalesOrderNumber,
		RIGHT (soh.PurchaseOrderNumber,11) as NewPurchaseOrderNumber
FROM Sales.SalesOrderHeader soh
ORDER BY soh.SalesOrderNumber