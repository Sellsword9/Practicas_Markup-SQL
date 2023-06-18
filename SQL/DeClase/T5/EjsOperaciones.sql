-- Ej 1
/*
1. Insertar una oficina con sede en Granada y tres empleados que sean representantes de
ventas y dependan del empleado Alberto Soria Carrasco.
*/
INSERT INTO oficina 
(codigo_oficina, ciudad, pais, region, codigo_postal, telefono, linea_direccion1)
VALUES 
('GRN-ES', 'Granada', 'España', 'Granada', '18002', '000000000', 'linea direccion');
INSERT INTO empleado (id_empleado, nombre, apellido1, codigo_oficina, id_jefe, extension, email)
VALUES
(35, 'Paco', 'Romero', 'GRN-ES', 3, '4000', 'ejemplo@gmail.com');
INSERT INTO empleado (id_empleado, nombre, apellido1, codigo_oficina, id_jefe, extension, email)
VALUES
(36, 'Paco', 'Romero2', 'GRN-ES', 3, '4000', 'ejemplo@gmail.com');
INSERT INTO empleado (id_empleado, nombre, apellido1, codigo_oficina, id_jefe, extension, email)
VALUES
(37, 'Paco', 'Romero3', 'GRN-ES', 3, '4000', 'ejemplo@gmail.com');
-- Ej 2
/*
Insertar tres clientes que tengan como representantes de ventas los empleados que se han
creado en el ejercicio anterior (cada uno de los clientes dependerá de uno de los
empleados).
*/
INSERT INTO cliente (id_cliente, nombre_cliente, telefono, fax, linea_direccion1, ciudad, id_empleado_rep_ventas)
VALUES 
(39, 'Cliente Vicente', '666666666', '666', 'Calle ejemplo', 'Granada', 35);
INSERT INTO cliente (id_cliente, nombre_cliente, telefono, fax, linea_direccion1, ciudad, id_empleado_rep_ventas)
VALUES 
(40, 'Cliente Pendiente', '666777666', '666', 'Calle ejemplo', 'Granada', 37);
INSERT INTO cliente (id_cliente, nombre_cliente, telefono, fax, linea_direccion1, ciudad, id_empleado_rep_ventas)
VALUES 
(41, 'Cliente Vicente', '666888666', '666', 'Calle ejemplo', 'Granada', 38);

-- Ej 3
/*
Insertar un pedido para cada uno de los clientes creados en el ejercicio anterior. Cada
pedido debe incluir al menos dos productos distintos (detalle_pedido).
*/

-- Pedido 1
INSERT INTO pedido (id_pedido, fecha_pedido, fecha_esperada, estado, id_cliente)
VALUES
(129, '2023-06-15', '2023-06-19', 'Pendiente', 39);
    -- Detalles pedido 1
INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea)
VALUES
(129, 'FR-67', 12, 70.0, 2);
INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea)
VALUES
(129, 'OR-127', 40, 4.0, 1);

-- Pedido 2
INSERT INTO pedido (id_pedido, fecha_pedido, fecha_esperada, estado, id_cliente)
VALUES
(130, '2023-06-15', '2023-06-19', 'Pendiente', 40);
    -- Detalles pedido 2
INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea)
VALUES
(130, 'FR-67', 16, 70.0, 2);
INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea)
VALUES
(130, 'OR-127', 30, 4.0, 1);

-- Pedido 3
INSERT INTO pedido (id_pedido, fecha_pedido, fecha_esperada, estado, id_cliente)
VALUES
(131, '2023-06-15', '2023-06-19', 'Pendiente', 41);
    -- Detalles pedido 3
INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea)
VALUES
(131, 'FR-67', 15, 70.0, 2);
INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea)
VALUES
(131, 'OR-127', 45, 4.0, 1);

-- Ej 8
/*
Reducir en un 20% el precio de todos los productos que no tengan
pedidos
*/
UPDATE producto
set precio = precio * 0.8
where codigo_producto not in (select codigo_producto from detalle_pedido);
-- Ej 10
/*
Borrar los pagos del cliente con menor límite de crédito. ¿Se puede?
*/
DELETE FROM pago 
WHERE id_cliente IN
    (SELECT id_cliente FROM cliente
    WHERE limite_credito = (SELECT min(limite_credito) FROM cliente));
-- Sí que se puede borrar. 
-- Ej 11
/*
Añadir un campo numérico llamado IVA a la tabla detalle_pedido. Establecer el valor de ese
campo a 18 para aquellos registros cuyo pedido tenga una fecha de pedido anterior al 1 de
septiembre de 2012. A continuación actualizar el resto de pedidos estableciendo el IVA al
21 (proponer y ejecutar la sentencia aunque no haya registros que cumplan la condición).
*/
ALTER TABLE detalle_pedido
ADD COLUMN IVA decimal(4,2) default 0;

UPDATE detalle_pedido
SET IVA = 18.00
WHERE codigo_pedido IN
 (SELECT pedido.codigo_pedido
  FROM pedido WHERE
  pedido.fecha_pedido < '2012-09-01');

UPDATE detalle_pedido
SET IVA = 21.00
WHERE codigo_pedido NOT IN
    (SELECT pedido.codigo_pedido FROM pedido
    WHERE pedido.fecha_pedido < '2012-09-01');
-- 13
/*
Establecer a 0 el límite de crédito del cliente que menos unidades pedidas tenga (en total
de todos sus pedidos) del producto 11679
*/
UPDATE cliente 
SET limite_credito = 0
WHERE id_cliente IN (
     SELECT id_cliente FROM pedido
     JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
	  where codigo_producto = '11679' 
	  GROUP BY id_cliente
	  -- El having es complejo, pero sirve para evitar usar LIMIT, que no está soportado en subconsultas.
	  -- Usarlo produce este error:
	  -- Error de SQL (1235): This version of MariaDB doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'
	  HAVING SUM(cantidad) <= ALL (SELECT SUM(cantidad) FROM pedido
                             JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
                             WHERE codigo_producto = '11679'
                             GROUP BY id_cliente, pedido.codigo_pedido)
	  ORDER BY SUM(cantidad) ASC
	   );