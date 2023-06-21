-- Ej 1
/*
Crear un procedimiento que devuelva las conferencias que da un ponente. Llevará como parámetro el nombre,
apellido1 y apellido2 del ponente. Suponer que el nombre y los apellidos conforman una clave alternativa.
*/
DROP PROCEDURE IF EXISTS getConferencias;
delimiter $$
CREATE PROCEDURE getConferencias(in n VARCHAR(50), in a1 VARCHAR(50), in a2 VARCHAR(50))
BEGIN
    DECLARE v_ponente CHAR(6);
    SELECT idPonente into v_ponente FROM ponente WHERE nombre=n AND apellido1 = a1 AND apellido2 = a2;
    SELECT * FROM conferencia WHERE idConferencia IN ( SELECT idConferencia FROM participa WHERE idPonente = v_ponente );
END $$

Delimiter ;

Call getConferencias('Luisa', 'Soriano', 'López');

-- Ej 2
/*
Crear un procedimiento que devuelva los datos del/os ponente/s que dan más conferencias de las indicadas
en un parámetro que se le envía.
*/
DROP PROCEDURE IF EXISTS getPonentesConMasConferencias;
DELIMITER $$
CREATE PROCEDURE getPonentesConMasConferencias(IN xConferencias INT)
BEGIN
    SELECT pon.idPonente, pon.nombre, pon.apellido1, pon.apellido2
    FROM ponente pon
    JOIN participa par ON pon.idPonente = par.idPonente
    GROUP BY pon.idPonente
    HAVING COUNT(DISTINCT(par.idConferencia)) > xConferencias;
END$$

DELIMITER ;

CALL getPonentesConMasConferencias(3);

-- Ej 3
/*
Crear un procedimiento que añada una nueva sala. Los parámetros deben de tener el mismo tipo de dato y
tamaño que el que está definido a nivel de columnas en la tabla sala.
*/
DROP PROCEDURE IF EXISTS addSala;
DELIMITER $$
CREATE PROCEDURE addSala(IN xNombreSala varchar(50), xCapacidad SMALLINT)
BEGIN
INSERT INTO sala (nombreSala, capacidad) VALUES (xNombreSala, xCapacidad);
END$$
DELIMITER ;

CALL addSala('Sala EJEMPLO', 100);

-- Ej 4
/*
Crear un procedimiento que permita modificar los datos de una conferencia 
(no se permite actualizar su clave primaria).
*/
DROP PROCEDURE IF EXISTS modConferencia;
DELIMITER $$
CREATE PROCEDURE modConferencia(IN xIdConferencia CHAR(7), 
xTema varchar(60), xPrecio DECIMAL(5,2), xFecha DATE 
xTurno varchar(1), xSala varchar(50))
BEGIN
UPDATE conferencia
SET tema = xTema, precio = xPrecio, 
fecha = xFecha, turno = xTurno, 
nombreSala = xSala
WHERE idConferencia = xIdConferencia;
END$$
DELIMITER ;
/* Inserta (y luego borra) una conferencia para ver su uso */
INSERT conferencia VALUES ("abc1234", "Conferencia de ejemplo", 15, "2013-10-03", 'M', 'Afrodita');

SELECT * FROM conferencia c
WHERE c.idConferencia = 'abc1234';

CALL modConferencia('abc1234', "Conferencia ejemplificativa", 10, "2013-10-03", 'M', 'Zeus');

SELECT * FROM conferencia c
WHERE c.idConferencia = 'abc1234';

DELETE FROM conferencia
where idConferencia = 'abc1234';

-- Ej 5
/*
Crear un procedimiento que borre una sala por su nombre. Hacer que borre en base al patrón nombre%
(empleando LIKE)
*/
DROP PROCEDURE IF EXISTS delSala;
DELIMITER $$
CREATE PROCEDURE delSala(IN xNombreSala varchar(50))
BEGIN
DELETE FROM sala WHERE nombreSala LIKE concat(xNombreSala, '%');
END$$
DELIMITER ;
CALL delSala('Sala EJEM');

-- Ej 6
/*
Crear un procedimiento al que se le pase el idPonente de un ponente y devuelva en forma de parámetro de
salida en cuantas conferencias participa.
*/
DROP PROCEDURE IF EXISTS getNumConferencias;
DELIMITER $$
CREATE PROCEDURE getNumConferencias(IN xIdPonente CHAR(6), OUT xNumConferencias INT)
BEGIN
SELECT 0 INTO xNumConferencias; -- Si no encuentra ninguna conferencia, es 0
SELECT COUNT(*) INTO xNumConferencias FROM participa WHERE idPonente = xIdPonente;
END$$
DELIMITER ;

SET @xConfs = 0;
CALL getNumConferencias('USA001', @xConfs);
SELECT @xConfs;

-- Ej 7
/*
Crear un procedimiento al que se le pase como parámetro el idPonente y devuelva en el mismo parámetro el
nombre completo del ponente con el formato: “apellido1 apellido2, nombre”.
*/
DROP PROCEDURE IF EXISTS getNombreCompleto;
DELIMITER $$
CREATE PROCEDURE getNombreCompleto(IN xIdPonente CHAR(6), OUT xNombreCompleto VARCHAR(150))
BEGIN
SELECT
CONCAT(apellido1, ifnull(CONCAT(' ', apellido2), ''), ', ', nombre)
INTO xNombreCompleto
FROM ponente
WHERE idPonente = xIdPonente;
END$$
DELIMITER ;

SET @xNombreCompleto = '';
CALL getNombreCompleto('USA001', @xNombreCompleto);
SELECT @xNombreCompleto;