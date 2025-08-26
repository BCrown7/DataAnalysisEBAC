/**********PUNTO 1************/

USE AdventureWorks2022;
SELECT Person.FirstName,
	   Person.LastName,
	   Employee.JobTitle
FROM 
	Person.Person

INNER JOIN 
	HumanResources.Employee

ON 
	Person.Person.BusinessEntityID = HumanResources.Employee.BusinessEntityID

/**********PUNTO 2************/

USE AdventureWorks2022;
SELECT	c.CustomerID,
		p.FirstName,
		p.LastName
FROM
	Sales.Customer c
LEFT JOIN
	Person.Person p

ON
	c.CustomerID = p.BusinessEntityID

/**********PUNTO 3************/

USE AdventureWorks2022;
SELECT	soh.SalesOrderID,
		c.CustomerID
FROM
	Sales.SalesOrderHeader soh
RIGHT JOIN
	Sales.Customer c

ON
	soh.CustomerID = c.CustomerID

/**********PUNTO 4************/

USE AdventureWorks2022;
SELECT	p.Name,
		pr.Comments
FROM
	Production.Product p
FULL JOIN
	Production.ProductReview pr

ON
	p.ProductID = pr.ProductID

/**********PUNTO 5************/

USE AdventureWorks2022;
SELECT	p.Name,
		pc.Name
FROM 
	Production.Product p
CROSS JOIN
	Production.ProductCategory pc

/**********PUNTO 6************/

--Anexo1: UNION

USE AdventureWorks2022;
SELECT Name
	FROM Production.Product
UNION
SELECT Name
	FROM Production.ProductModel

--Anexo 2: UNION ALL

USE AdventureWorks2022;
SELECT Name
	FROM Production.Product
UNION ALL
SELECT Name
	FROM Production.ProductModel

/**********PUNTO 7************/

USE AdventureWorks2022;
SELECT	BusinessEntityID,
		JobTitle,

CASE
	WHEN JobTitle LIKE '%Manager%' THEN 'Manager'
	ELSE 'No Manager'
	END AS JobCategory
	
FROM
	HumanResources.Employee

/**********PUNTO 8************/

USE AdventureWorks2022;
SELECT	BusinessEntityID,
		SalesQuota,
		ISNULL (SalesQuota,NULL) as NoQuota
FROM Sales.SalesPerson;