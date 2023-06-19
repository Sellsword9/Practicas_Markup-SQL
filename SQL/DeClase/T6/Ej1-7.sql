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
CREATE PROCEDURE modConferencia(IN xIdConferencia CHAR(7), xTema varchar(60), 
xPrecio DECIMAL(5,2), xFecha DATE, xTurno varchar(1), xNombre varchar(50))