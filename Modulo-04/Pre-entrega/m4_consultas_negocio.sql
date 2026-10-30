-- Verifico la existencia de la base de datos

if DB_ID('Ventas_Tech_DB') is null
	CREATE DATABASE Ventas_Tech_DB;
GO

USE Ventas_Tech_DB;
GO

-- Verifico los datos de la tabla ventas

SELECT * FROM ventas;

-- Consulta 1 — Resumen ejecutivo mensual --

SELECT 
	SUM(cantidad * precio_unitario) AS total_facturado,
	COUNT(id_venta) AS cantidad_pedidos,
	CAST(AVG(cantidad * precio_unitario) AS DECIMAL(10,2)) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);


-- Consulta 2 — Ranking de productos --

SELECT TOP 5 
	id_producto,
	SUM(cantidad) AS cantidades_vendidas,
	SUM(precio_unitario * cantidad) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;


-- Consulta 3 — Clientes recurrentes --

SELECT 
	id_cliente,
	COUNT(id_venta) AS cantidad_pedidos,
	SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;


-- Consulta 4 — Productos por encima/por debajo del promedio --

WITH facturacion_producto AS (
	SELECT 
		id_producto,
		SUM(cantidad * precio_unitario) AS total_producto
	FROM ventas
	GROUP BY id_producto
)
SELECT 
	id_producto,
	total_producto,
	CASE
		WHEN total_producto > (SELECT AVG(total_producto) FROM facturacion_producto) THEN 'Por encima'
		ELSE 'Por debajo'
	END AS comparacion
FROM facturacion_producto;


-- Bloque de cierre --

-- 1: En la consulta 3, podemos identificar que los 5 clientes registrados tuvieron recurrencia, sin embargo el cliente con id 1 fue el que mayor facturacion tuvo con un total de $2640
-- 2: En la consulta 4, podemos identificar que si bien hay 2 productos con facturacion por encima del promedio, hay 4 que estan por debajo de la facturacion promedio.
-- 3: En la consulta 2, podemos identificar que el producto con id 1, se lleva una facturacion muy por encima que el resto con un total de $3600, casi triplicando al producto del segundo puesto que fue de $1350.

