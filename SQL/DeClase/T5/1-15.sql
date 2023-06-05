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
CREATE TABLE fabricante_productos (
    id_fabricante INT UNSIGNED NOT NULL PRIMARY KEY,
    nombre_producto INT UNSIGNED NOT NULL,
    precio int UNSIGNED NOT NULL,
    FOREIGN KEY (id_fabricante) REFERENCES fabricante(id),
    FOREIGN KEY (nombre_producto) REFERENCES producto(nombre),
    FOREIGN KEY (precio) REFERENCES producto(precio)
);
-- Ej 6
DROP TABLE IF EXISTS fabricante_productos;
CREATE TABLE fabricante_productos (
    nombre_fabricante VARCHAR(30),
    nombre_producto VARCHAR(50),
    precio DECIMAL(5,2)
);
INSERT INTO fabricante_productos 
SELECT fabricante.nombre, producto.nombre, producto.precio 
FROM fabricante JOIN producto ON fabricante.id = producto.id_fabricante;