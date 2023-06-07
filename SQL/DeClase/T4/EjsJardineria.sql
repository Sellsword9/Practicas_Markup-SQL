-- 1
/*
Realizar una consulta que devuelva el nombre de los clientes, el
código de pedido y los días de retraso de aquellos pedidos que
no han sido entregados a tiempo (fecha de entrega superior a
la fecha estimada y estado igual a entregado). Ordenar el
resultado por el código de pedido de forma ascendente.
*/
USE jardineria;
SELECT 
	(select nombre_cliente from cliente 
	 where id_cliente = pedido.id_cliente) AS 'Nombre_cliente',
codigo_pedido, DATEDIFF(fecha_entrega, fecha_esperada) AS 'Retraso'
FROM pedido
WHERE estado = 'Entregado' AND
fecha_entrega > fecha_esperada
ORDER BY codigo_pedido asc;
-- 2 
/*
Realizar una consulta que muestre el nombre de cada empleado
(aunque no tenga jefe), el nombre de su jefe y el nombre del jefe
de su jefe. En caso de no tener jefe debe mostrar el valor “SIN JEFE”.
*/
SELECT e.nombre AS empleado_nombre, 
       IFNULL(j1.nombre, 'SIN JEFE') AS jefe_nombre, 
       IFNULL(j2.nombre, 'SIN JEFE') AS jefe_jefe_nombre
FROM empleado AS e
LEFT JOIN empleado AS j1 ON e.id_jefe = j1.id_empleado
LEFT JOIN empleado AS j2 ON j1.id_jefe = j2.id_empleado;
-- 3
/* 
Realizar una consulta que muestre las diferentes gamas de producto que
ha comprado cada cliente (no se deben mostrar las filas duplicadas) cuya
fecha de pedido esté comprendida entre el “10/01/2009” y el
“15/05/2009”, y el estado sea “entregado”. Ordenar los resultados por el
nombre del cliente y la gama de forma ascendente. Limitar el listado a
los 10 primeros resultados. 
*/
SELECT nombre_cliente, gama
FROM pedido JOIN cliente on pedido.id_cliente = cliente.id_cliente
LEFT JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
LEFT JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
WHERE estado = 'Entregado' AND
fecha_pedido BETWEEN '2009-01-10' AND '2009-05-15'
GROUP BY nombre_cliente, gama
ORDER BY nombre_cliente, gama ASC
limit 10;
-- 4
/*
Devolver un listado con los 20 productos más vendidos
junto al número total de unidades vendidas de aquellos
pedidos realizados entre el “01/04/2008” y el
“31/01/2009” cuyo estado se encuentre en entregado. El
listado se debe ordenar por el número total de unidades
vendidas de forma descendente
*/
SELECT nombre, SUM(cantidad) AS 'Vendidos'
FROM producto
JOIN detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
JOIN pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
WHERE pedido.estado = 'Entregado'
AND 
pedido.fecha_pedido BETWEEN '2008-04-01' AND '2009-01-31'
GROUP BY producto.nombre
ORDER BY vendidos DESC
LIMIT 20;
/*
Hay productos con el mismo nombre, pero con distinto código de producto.
Por eso el group by entorno al nombre en lugar del código
*/
-- 5
/*
Sin hacer uso de subconsultas devolver un listado que muestre solamente
los empleados que no tienen un cliente asociado.
*/
SELECT nombre, CONCAT(apellido1, IFNULL(CONCAT(" ", apellido2), "")) AS 'Apellidos'
FROM empleado
left JOIN cliente ON empleado.id_empleado = cliente.id_empleado_rep_ventas
WHERE cliente.id_cliente IS NULL;