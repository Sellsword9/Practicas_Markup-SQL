-- Ej 14
USE conferencias2;
DROP PROCEDURE if EXISTS getSumaCapacidades;
DELIMITER $$
CREATE PROCEDURE getSumaCapacidades(IN salas VARCHAR(255), OUT sumaCapacidades INT)
BEGIN
	 DECLARE INDEXer INT;
    SELECT sum(capacidad) INTO sumaCapacidades FROM sala WHERE salas LIKE CONCAT("%", nombreSala, "%");
    if sumaCapacidades IS NULL then sumaCapacidades = -1 /* El procedimiento no es perfecto, pero me falta tiempo*/
END $$

call getSumaCapacidades('Zeus, Hermes', @resultado);
SELECT @resultado AS 'Resultado';

DROP PROCEDURE if EXISTS getSumaCapacidades;
-- Ej 15
USE conferencias2;
DROP FUNCTION if exists getNumeroConferenciasDeSala;

DELIMITER $$

CREATE FUNCTION getNumeroConferenciasDeSala(nombreDeSala VARCHAR(50)) RETURNS int
BEGIN
    DECLARE confs INT;
    
   SELECT count(idConferencia) INTO confs FROM conferencia WHERE nombreSala = nombreDeSala; 
    
    RETURN confs;
END $$

DELIMITER ;

SELECT getNumeroConferenciasDeSala("Afrodita") as 'Numero de conferencias de Afrodita';

SELECT getNumeroConferenciasDeSala("Apolo") as 'Numero de conferencias de Apolo';

SELECT getNumeroConferenciasDeSala("Zeus") as 'Numero de conferencias de Zeus';

SELECT getNumeroConferenciasDeSala("Hermes") as 'Numero de conferencias de Hermes';

DROP FUNCTION if exists getNumeroConferenciasDeSala;

-- Ej 16
USE conferencias2;
DROP FUNCTION if exists getNumeroConferenciasPonente;

delimiter $

CREATE FUNCTION getNumeroConferenciasPonente(idP CHAR(6)) RETURNS INT
BEGIN 
DECLARE confs INT;
SELECT count(distinct(idConferencia)) INTO confs FROM participa WHERE idPonente = idP;
if confs = 0 or confs is null then set confs = -1; END if;
RETURN confs;
END $

SET @ej16 = 81828123;
SELECT getNumeroConferenciasPonente("ESP001") INTO @ej16;
SELECT @ej16;

SELECT getNumeroConferenciasPonente("ESP002");

select getNumeroConferenciasPonente("ESP003");

select getNumeroConferenciasPonente("ESP004");

SELECT getNumeroConferenciasPonente("USA001");

SELECT getNumeroConferenciasPonente("USA003");

SELECT getNumeroConferenciasPonente("USA002");

SELECT getNumeroConferenciasPonente("FRA001");

DROP FUNCTION if exists getNumeroConferenciasPonente;