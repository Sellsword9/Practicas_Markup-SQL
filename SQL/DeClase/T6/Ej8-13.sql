-- Ej 8
DROP PROCEDURE if EXISTS getConferencias;
delimiter $$
CREATE PROCEDURE getConferencias(IN n VARCHAR(50), IN a1 VARCHAR(50), IN a2 VARCHAR(50))
BEGIN
    DECLARE v_ponente CHAR(6);
    SELECT idPonente into v_ponente FROM ponente WHERE nombre=n AND apellido1 = a1 AND apellido2 = a2;
    SELECT * FROM conferencia WHERE idConferencia IN ( SELECT idConferencia FROM participa WHERE idPonente = v_ponente );
END $$
delimiter ;
SET @sentencia = 'CALL getConferencias(?, ?, ?)';
PREPARE sentPreparada FROM @sentencia;
SET @nombre = 'Luisa';
SET @ap1 = 'Soriano';
SET @ap2 = 'López';
EXECUTE sentPreparada USING @nombre, @ap1, @ap2;
DEALLOCATE PREPARE sentPreparada;
-- Ej 9
-- No entiendo el enunciado
set @sentencia = select * from conferencia limit ?; PREPARE sente from sentencia; EXECUTE sente using 2; --????