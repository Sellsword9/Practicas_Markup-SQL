-- Ej 1
Insert into fabricante (id, nombre) values (10, 'Apple');
-- Ej 2
INSERT INTO fabricante (nombre) VALUES ('MSI'), ('TP-Link');
-- Ej 3
INSERT INTO producto VALUES (12, "Portátil UltraTurbo ejemplo 3000", 800, 11);
-- Ej 4
INSERT INTO producto (nombre, precio, id_fabricante) VALUES ("Servicio de asistencia vitalicio", 500, 12);
INSERT INTO producto (nombre, precio, id_fabricante) VALUES ("Pórtatil básico tp-link", 400, 12);
-- Ej 5
DROP TABLE IF EXISTS fabricante_productos;
CREATE TABLE fabricante_productos (
    nombre_fabricante VARCHAR(30),
    nombre_producto VARCHAR(50),
    precio DECIMAL(5,2)
);
INSERT INTO fabricante_productos 
SELECT fabricante.nombre, producto.nombre, producto.precio 
FROM fabricante JOIN producto ON fabricante.id = producto.id_fabricante;
-- Ej 6
CREATE VIEW vista_fabricante_producto AS
SELECT fabricante.nombre AS "nombre_fabricante", producto.nombre, producto.precio
FROM fabricante JOIN producto ON fabricante.id = producto.id_fabricante;
-- Ej 7
DELETE from fabricante where nombre = "Xiomi"; -- Funciona
-- Ej 8
ALTER TABLE producto DROP if exists FOREIGN KEY id_fabricante;
ALTER TABLE producto MODIFY COLUMN id_fabricante INT UNSIGNED ;
ALTER TABLE producto ADD FOREIGN KEY (id_fabricante) REFERENCES fabricante(id) ON DELETE CASCADE;
DELETE FROM fabricante WHERE nombre = "Asus"; -- TODO: No funciona
-- Ej 9
UPDATE fabricante 
set id = 30
WHERE nombre = "huawei"; -- Funciona
-- Ej 10
UPDATE fabricante 
set id = 20
WHERE nombre = "lenovo"; -- no funciona
-- Ej 11
UPDATE producto 
SET precio = precio + 5
WHERE 1 = 1; 
-- Ej 12
DELETE FROM producto
WHERE nombre LIKE "%impresora%"
AND 
precio < 200
-- Ej 13
UPDATE producto
SET precio = precio * 1.05
WHERE id_fabricante IN (
	SELECT id FROM fabricante 
	WHERE 
	nombre LIKE "_e%"
)
-- Ej 14
UPDATE fabricante 
SET nombre = CONCAT(nombre, "*")
WHERE id IN ( 
	SELECT id_fabricante FROM producto
    GROUP BY id_fabricante
    having AVG(precio) > 200
) 
-- Ej 15
DELETE FROM fabricante
WHERE id NOT IN (
	SELECT id_fabricante
	FROM producto
)