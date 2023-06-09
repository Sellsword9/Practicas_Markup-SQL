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
-- 6
/*
Devolver el nombre del cliente con menor límite de crédito de la región de
“Barcelona” (no se puede utilizar LIMIT ni ORDER BY en la sentencia SELECT).
*/
select nombre_cliente
from cliente
WHERE limite_credito = 
      (SELECT MIN(limite_credito)
       FROM cliente
	WHERE region = 'Barcelona')
AND
region = 'Barcelona'
-- 7
/*
Devolver el nombre del producto del que se han vendido más unidades
(tener en cuenta que se tendrá que calcular cuál es el número total de
unidades que se han vendido de cada producto a partir de los datos de la
tabla detalle_pedido).
*/
SELECT producto.nombre
FROM detalle_pedido
JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
GROUP BY detalle_pedido.codigo_producto
ORDER BY SUM(cantidad) DESC
LIMIT 1;
-- 8
/*
Devolver un listado con los nombres de los clientes que han realizado algún
pedido pero no han realizado ningún pago. Ordenar el resultado por el nombre
de cliente de forma ascendente.
*/
SELECT nombre_cliente
FROM cliente
WHERE 
id_cliente NOT IN (SELECT id_cliente FROM pago) -- No ha pagado
AND
id_cliente IN (SELECT id_cliente FROM pedido) -- Pero ha pedido
-- 9
/*
Obtener el total facturado por producto (únicamente se deben
tener en cuenta los pedidos realizados en el año 2009 y que se
encuentren en estado de entregados para el cálculo) del cliente
que tiene menor límite de crédito.
*/
SELECT precio_unidad * sum(cantidad) AS 'Facturado',
producto.nombre
FROM detalle_pedido
JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
JOIN pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
WHERE pedido.id_cliente IN
 (SELECT id_cliente
	FROM cliente 
	WHERE limite_credito =
	(	SELECT Min(limite_credito)
		FROM cliente))
AND year(pedido.fecha_pedido) = 2009
AND pedido.estado = 'Entregado'
GROUP BY detalle_pedido.codigo_producto
ORDER BY nombre;
-- 10
/*
Obtener los productos de la gama “Ornamentales” que tengan un precio de
venta mayor o igual al de todos los productos de la gama “Frutales” (no se
puede utilizar las funciones MAX y MIN, ni la cláusula ORDER BY).
*/
select nombre
from producto
where gama = 'Ornamentales'
AND precio_venta >= ALL 
(SELECT precio_venta
 FROM producto
 WHERE gama = 'Frutales')
GROUP BY producto.nombre; --Hay nombres repetidos
-- 11
/*
Obtener el nombre de los productos con mayor stock que compra un cliente
cuyo representante de ventas trabaje en la oficina de la ciudad de Madrid.
*/
select producto.nombre, cantidad_en_stock
from producto
inner JOIN detalle_pedido on producto.codigo_producto = detalle_pedido.codigo_producto
inner JOIN pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
inner join cliente ON pedido.id_cliente = cliente.id_cliente
inner join empleado ON cliente.id_empleado_rep_ventas = empleado.id_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina
where cantidad_en_stock >= ALL (
       SELECT cantidad_en_stock
       FROM producto
       inner JOIN detalle_pedido on producto.codigo_producto = detalle_pedido.codigo_producto
       inner JOIN pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
       inner join cliente ON pedido.id_cliente = cliente.id_cliente
       inner join empleado ON cliente.id_empleado_rep_ventas = empleado.id_empleado
       inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina
       WHERE oficina.ciudad = 'Madrid') 
       and oficina.ciudad = 'Madrid';
-- 12
/*
Devolver las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutales.
*/
SELECT codigo_oficina, ciudad
FROM oficina
WHERE oficina.codigo_oficina NOT IN(
	SELECT codigo_oficina
   FROM empleado
   WHERE id_empleado IN(
   	SELECT id_empleado_rep_ventas
   	FROM cliente
   	WHERE id_cliente IN(
   		SELECT id_cliente
   		FROM pedido
   		WHERE codigo_pedido IN(
   			SELECT codigo_pedido
   			FROM detalle_pedido
   			WHERE codigo_producto IN(
   				SELECT codigo_producto
   				FROM producto
   				WHERE gama = 'Frutales')))));