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
DROP PROCEDURE IF EXISTS getConferencias;
-- Ej 9
-- No entiendo el enunciado
set @sentencia = select * from conferencia limit ?; PREPARE sente from sentencia; EXECUTE sente using 2; --????
-- Ej 10
drop procedure if exists getConferenciasSala;
delimiter $$
create procedure getConferenciasSala(in s varchar(50))
begin
    if NOT EXISTS (SELECT nombreSala FROM sala WHERE nombreSala = s)
    then
        select 'LA SALA NO EXISTE' as Resultado;
    else
        if not exists (select * from conferencia where nombreSala = s) 
		  then
            select 'SIN CONFERENCIAS' as Resultado;
        else
        select tema, precio, turno from conferencia where nombreSala = s;
        end if;
    end if;
end $$
delimiter ;
call getConferenciasSala('Apolo');
call getConferenciasSala('Apolllo');
call getConferenciasSala('Hermes');
DROP PROCEDURE getConferenciasSala;
-- Ej 11
DROP PROCEDURE if EXISTS howManyConferencias;
DELIMITER $$
CREATE PROCEDURE howManyConferencias(IN dia DATE)
BEGIN
    DECLARE c_count INT;
    SELECT COUNT(*) INTO c_count FROM conferencia WHERE fecha = dia;
    IF c_count = 0 OR c_count IS NULL THEN
        SET c_count = -1;
    END IF;
    SELECT c_count AS 'Conferencias ese dia';
END $$
DELIMITER ;

SET @sentencia = 'CALL howManyConferencias(?)';
PREPARE sentPreparada FROM @sentencia;

SET @dia = DATE('2013-10-3');
EXECUTE sentPreparada USING @dia;

DEALLOCATE PREPARE sentPreparada;
