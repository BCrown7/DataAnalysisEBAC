/******************** PUNTO 1 ********************/

USE AdventureWorks2022;
GO
CREATE VIEW Production.vCostoProductoSimple AS
SELECT	p.ProductID,
		p.Name as NombreProducto,
		p.ListPrice as PrecioLista
FROM Production.Product p;
GO
SELECT *
FROM Production.vCostoProductoSimple;

DROP VIEW Production.vCostoProductoSimple;

/******************** PUNTO 2 ********************/

USE AdventureWorks2022;
GO
CREATE VIEW Production.vProductoConCosto AS
SELECT	p.ProductID,
		p.Name AS NombreProducto,
		p.ListPrice AS PrecioLista,
		pch.StandardCost AS CostoEstandar,
		pch.StartDate AS FechaInicio
FROM Production.Product p
	JOIN Production.ProductCostHistory pch ON p.ProductID = pch.ProductID
GO
SELECT *
FROM Production.vProductoConCosto;

DROP VIEW Production.vProductoConCosto;

/******************** PUNTO 3 ********************/

USE AdventureWorks2022;
GO
CREATE FUNCTION dbo.fnCalcularDescuento
	(
	@Precio DECIMAL (10,2), 
	@Descuento DECIMAL (2,2)
	)
RETURNS DECIMAL(10,2) AS

BEGIN
	RETURN @Precio * (1-@Descuento)
END;
GO
SELECT dbo.fnCalcularDescuento (100,0.1) AS DescuentoAplicado;

DROP FUNCTION dbo.fnCalcularDescuento;

/******************** PUNTO 4 ********************/

USE AdventureWorks2022;
GO
CREATE FUNCTION dbo.fnLimpiarTexto
	(
	@TextoARemplazar NVARCHAR (50)
	)
RETURNS VARCHAR (50) AS

BEGIN
	RETURN (TRIM(UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@TextoARemplazar, 'α','a'), 'ι', 'e'), 'ν', 'i'),'σ','o'),'ϊ', 'u'), 'ρ', 'n'))))
END;
GO
SELECT dbo.fnLimpiarTexto ('    αινσϊρ     ') AS TextoLimpio;

DROP FUNCTION dbo.fnLimpiarTexto;

/******************** PUNTO 5 ********************/
USE AdventureWorks2022;
GO
CREATE OR ALTER PROCEDURE dbo.uspObtenerProductosCostosos @PrecioMin DECIMAL(10,2)
AS
BEGIN
	SELECT	p.ProductID,
			p.Name AS NombreProducto,
			p.ListPrice AS PrecioLista
	FROM Production.Product p
	WHERE p.ListPrice >= @PrecioMin
END;

DROP PROC dbo.uspObtenerProductosCostosos

/******************** PUNTO 6 ********************/

EXEC dbo.uspObtenerProductosCostosos 1000.00