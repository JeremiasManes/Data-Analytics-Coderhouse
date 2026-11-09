-- Verifico la existencia de la base de datos

if DB_ID('Ventas_Tech_DB') is null
	CREATE DATABASE Ventas_Tech_DB;
GO

USE Ventas_Tech_DB;
GO

-- Verifico las tablas existentes

SELECT * FROM ventas;
SELECT * FROM categorias;
SELECT * FROM productos;
SELECT * FROM clientes;


-- Consulta 1 — Vista base del proyecto (INNER JOIN)

-- Esta consulta permite analizar cada venta en detalle, integrando información del cliente, del producto y su categoría, para enriquecer el análisis comercial.

SELECT 
	v.fecha_venta,
	v.id_cliente,
	p.nombre_producto,
	v.cantidad,
	v.precio_unitario,
	(v.cantidad * v.precio_unitario) AS venta_total,
	c.ciudad,
	cat.nombre_categoria
FROM ventas AS v
INNER JOIN productos AS p ON v.id_producto = p.id_producto
INNER JOIN clientes AS c ON v.id_cliente = c.id_cliente
INNER JOIN categorias AS cat ON p.id_categoria = cat.id_categoria;

-- Hallazgo: Podemos identificar que los 5 clientes registrados tuvieron un total de 2 compras cada uno.



-- Consulta 2 — Clientes sin ventas (LEFT JOIN)

-- Esta consulta permite identificar cuántos clientes registrados no realizaron ninguna compra.

SELECT 
	c.nombre,
	c.email,
	c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: La consulta devolvió 0 registros. Esto indica que el 100% de los clientes registrados (5) realizaron al menos una compra. 
-- Para el area de CRM, esto implica que no hay clientes pendientes de concretar su primera compra.



-- Consulta 3 — Productos sin ventas (LEFT JOIN)

-- Esta consulta permite identificar cuantos productos registrados no tuvieron ninguna venta.

SELECT
	p.nombre_producto,
	cat.nombre_categoria,
	p.precio
FROM productos AS p
LEFT JOIN ventas AS v ON p.id_producto = v.id_producto
INNER JOIN categorias AS cat ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;

-- Hallazgo: La consulta devolvió 0 registros. Esto indica que el 100% de los productos registrados (6) tienen al menos una venta asociada.
-- Para el área de Producto, no se identifican artículos con 0 ventas que requieran algun tipo de intervencion.



-- Consulta 4 — Consolidado por período (UNION ALL)

-- Esta consulta permite comparar las ventas totales entre 2 períodos.

SELECT
	periodo,
	SUM(total) AS total_periodo
FROM (
	SELECT
		v.fecha_venta,
		(v.cantidad * v.precio_unitario) AS total,
		'Periodo 1' AS periodo
	FROM ventas AS v
	WHERE day(v.fecha_venta) <= 7
	UNION ALL
	SELECT
		v.fecha_venta,
		(v.cantidad * v.precio_unitario) AS total,
		'Periodo 2' AS periodo
	FROM ventas AS v
	WHERE day(v.fecha_venta) BETWEEN 8 AND 15
) AS ventas_por_periodo
GROUP BY periodo;

-- Hallazgo: El período 2 registró un mayor importe de ventas, con un total de $3454, frente a $2990 del otro período.

