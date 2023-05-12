-- Ej 1
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
-- TODO