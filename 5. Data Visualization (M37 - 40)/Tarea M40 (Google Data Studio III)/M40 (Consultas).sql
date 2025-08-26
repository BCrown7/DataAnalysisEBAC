/* Consulta general para verificación de datos */

SELECT *
FROM dbo.kc_house_data;

/* Precio promedio de una casa por zipcode, agrupado por año de construcción y ordenado de mayor a menor (Top 50). 
Además incluir el número promedio de habitaciones (bedrooms) y baños (bathrooms) para la agrupación. */

SELECT	TOP 50
		ZipCode,
		yr_built,
		ROUND(AVG(price),2) as PrecioPromedio,
		ROUND(AVG(bedrooms),0) as HabitacionesPromedio,
		ROUND(AVG(bathrooms),0) as BañosPromedio

FROM dbo.kc_house_data
WHERE 
	price IS NOT NULL AND 
	yr_built IS NOT NULL
GROUP BY 
	yr_built, 
	zipcode
ORDER BY 
	PrecioPromedio DESC;

/* Precio por m² agrupado por ZipCode (Código Postal) */

SELECT	DISTINCT ZipCode,
		ROUND(AVG(price / sqft_living),2) as PrecioPromedio_M2
		
FROM dbo.kc_house_data
GROUP BY zipcode;