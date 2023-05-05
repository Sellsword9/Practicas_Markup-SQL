DELIMITER $$
CREATE OR REPLACE FUNCTION getConferencias(n VARCHAR(100), a1 VARCHAR(100), a2 VARCHAR(100)) RETURNS CHAR(6)
BEGIN
DECLARE v_ponente CHAR(6);
SELECT idPonente into v_ponente FROM ponente WHERE nombre=n AND apellido1 = a1 AND apellido2 = a2;
RETURN v_ponente;
END; $$
DELIMITER ;

SELECT getConferencias('Luisa', 'Soriano', 'López') AS Mensaje;