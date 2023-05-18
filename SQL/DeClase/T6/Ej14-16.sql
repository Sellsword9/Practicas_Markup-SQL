-- Ej 14
DELIMITER //
CREATE PROCEDURE ObtenerSumaCapacidades(IN salas VARCHAR(255), OUT sumaCapacidades INT)
BEGIN
    DECLARE sala VARCHAR(255);
    DECLARE capacidad INT;
    DECLARE total INT DEFAULT 0;
    DECLARE idx INT DEFAULT 1;
    DECLARE len INT;

    SET len = CHAR_LENGTH(salas);

    IF len > 0 THEN
        WHILE idx <= len DO
            SET sala = TRIM(SUBSTRING(salas, idx, IF(LOCATE(',', salas, idx + 1) > 0, LOCATE(',', salas, idx + 1) - idx - 1, len - idx + 1)));

            IF sala = '' THEN
                SET idx = idx + 1;
                ITERATE;
            END IF;

            SET capacidad = (SELECT capacidad FROM salas WHERE nombreSala = sala);

            IF capacidad IS NULL THEN
                SELECT CONCAT('La sala "', sala, '" no existe') AS mensaje;
            ELSE
                SET total = total + capacidad;
            END IF;

            SET idx = LOCATE(',', salas, idx + 1) + 1;
        END WHILE;

        SET sumaCapacidades = total;
    ELSE
        SET sumaCapacidades = -1;
    END IF;
END //

DELIMITER ;

select ObtenerSumaCapacidades('Zeus', 'Hermes');