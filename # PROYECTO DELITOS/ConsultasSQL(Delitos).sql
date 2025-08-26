-- Selección general de la tabla

SELECT *
FROM dbo.delitos;

-- Agregación de tabla para sumar los delitos por año

ALTER TABLE Delitos_Mexico.dbo.delitos
    ADD suma_anual SMALLINT;

-- Ingreso de datos a columna de delitos por año

UPDATE Delitos_Mexico.dbo.delitos
SET suma_anual = (Enero + Febrero + Marzo + Abril +
		Mayo + Junio + Julio + Agosto +
		Septiembre + Octubre + Noviembre + Diciembre) 
FROM Delitos_Mexico.dbo.delitos;

/***** PUNTOS SOLICITADOS EN AL PRACTICA *****/

-- (A)  Número promedio de delitos agrupados por municipio y año-mes de ocurrencia de estos

SELECT
    Municipio,
    Año,
    mes,
    FORMAT(AVG(suma_anual), 'N2') AS promedio_delitos
FROM
    (SELECT	Municipio,
            Año,
            mes,
            suma_anual
    FROM dbo.delitos
        UNPIVOT(num_delitos FOR mes IN 
                (enero, febrero, marzo, abril, mayo, junio,
                julio, agosto, septiembre, octubre, noviembre, diciembre) 
                )AS unpvt 
                )AS datos
GROUP BY Municipio, Año, mes
ORDER BY promedio_delitos DESC;

-- (B)  El delito más común por municipio

SELECT
    Municipio,
    Tipo_de_delito,
	Subtipo_de_delito,
    suma_anual AS Delitos_Totales
FROM (
    SELECT
        Municipio,
        Tipo_de_delito,
		Subtipo_de_delito,
        suma_anual,
        ROW_NUMBER() OVER (PARTITION BY Municipio ORDER BY suma_anual DESC) AS rn
    FROM
        dbo.delitos
) AS ranked
WHERE rn = 1
ORDER BY suma_anual DESC;

-- (C)  La temporada con más crímenes en México

SELECT TOP 10
    Año,
    Mes,
    SUM(num_delitos) AS TotalDelitos
FROM (
    SELECT
        Año,
        Mes,
        num_delitos
    FROM
        dbo.delitos
    UNPIVOT (
        num_delitos FOR Mes IN (
            Enero, Febrero, Marzo, Abril, Mayo, Junio,
            Julio, Agosto, Septiembre, Octubre, Noviembre, Diciembre
        )
    ) AS unpvt
) AS datos
GROUP BY
    Año,
    Mes
ORDER BY
    TotalDelitos DESC;

-- (D)  El número promedio de delitos agrupados por tipo de delito y año y mes en la ciudad de México ordenados de mayor a menor

SELECT
    Tipo_de_delito,
    Año,
    Mes,
    AVG(num_delitos) AS PromedioDelitos
FROM (
    SELECT
        Tipo_de_delito,
        Año,
        Mes,
        num_delitos
    FROM
        dbo.delitos
    UNPIVOT (
        num_delitos FOR Mes IN (
            Enero, Febrero, Marzo, Abril, Mayo, Junio,
            Julio, Agosto, Septiembre, Octubre, Noviembre, Diciembre
        )
    ) AS unpvt
	    WHERE
        Entidad = 'Ciudad de México'
) AS datos
GROUP BY
    Tipo_de_delito,
    Año,
    Mes
ORDER BY
    PromedioDelitos DESC;

-- (E)  Un análisis propio que sea de tu interés

/** ¿Cuál es el estado con más delitos y de qué tipo? **/

WITH MunicipioTop AS (
    SELECT TOP 1
        Municipio,
        SUM(suma_anual) AS TotalDelitos
    FROM
        dbo.delitos
    GROUP BY
        Municipio
    ORDER BY
        TotalDelitos DESC)
SELECT
    d.Municipio,
    d.Año,
    d.Tipo_de_delito,
    d.Subtipo_de_delito,
    SUM(d.suma_anual) AS DelitosAnuales
FROM
    dbo.delitos d
    INNER JOIN MunicipioTop mt ON d.Municipio = mt.Municipio
GROUP BY
    d.Municipio,
    d.Año,
    d.Tipo_de_delito,
    d.Subtipo_de_delito
ORDER BY
	DelitosAnuales DESC;