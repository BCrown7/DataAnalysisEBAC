/************** PUNTO 1 **************/

SELECT	ProductID,
		SUM(OrderQty) as TotalQuantity,
		SUM(LineTotal) as TotalSales

FROM Sales.SalesOrderDetail
GROUP BY ProductID;

/************** PUNTO 2 **************/

SELECT	ProductID,
		SUM(OrderQty) as TotalQuantity

FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty)>50

/************** PUNTO 3 **************/

SELECT	SalesOrderID,
		ProductID,
		LineTotal,
		SUM(LineTotal) OVER(PARTITION BY SalesOrderID) as TotalOrderValue

FROM Sales.SalesOrderDetail;

/************** PUNTO 4 **************/

SELECT	SalesOrderID,
		SalesOrderDetailID,
		ProductID,
		LineTotal,
		ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY SalesOrderDetailID) as RowNum

FROM Sales.SalesOrderDetail;

/************** PUNTO 5 **************/

SELECT	SalesOrderID,
		ProductID,
		LineTotal,
		RANK() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC) as Rank

FROM Sales.SalesOrderDetail;

/************** PUNTO 6 **************/

SELECT	SalesOrderID,
		ProductID,
		LineTotal,
		DENSE_RANK() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC) As DenseRank

FROM Sales.SalesOrderDetail;

/************** PUNTO 7 **************/

SELECT	ProductID, 
		SUM(LineTotal)as TotalSales

FROM Sales.SalesOrderDetail  
GROUP BY ProductID
HAVING SUM(LineTotal) > 5000.00
ORDER BY TotalSales DESC;