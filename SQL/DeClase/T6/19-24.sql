-- 19:
ALTER TABLE sala
ADD COLUMN contador INT DEFAULT 0;

DELIMITER $$
CREATE TRIGGER actualizar_contador
AFTER INSERT ON conferencia
FOR EACH ROW
BEGIN
    UPDATE sala SET contador = contador + 1 WHERE nombreSala = NEW.nombreSala;
END$$
DELIMITER ;


UPDATE sala AS s
JOIN (
    SELECT nombreSala, COUNT(*) AS totalConferencias
    FROM conferencia
    GROUP BY nombreSala
) AS c ON s.nombreSala = c.nombreSala
SET s.contador = c.totalConferencias;
-- 20:
DELIMITER $$
CREATE TRIGGER limite_capacidad_insert
BEFORE INSERT ON sala
FOR EACH ROW
BEGIN
    IF NEW.capacidad > 500 OR NEW.capacidad < 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede agregar una sala con capacidad superior a 500 o inferior a 50';
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER limite_capacidad_delete
BEFORE DELETE ON sala
FOR EACH ROW
BEGIN
    IF OLD.capacidad > 500 OR OLD.capacidad < 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar una sala con capacidad superior a 500 o inferior a 50';
    END IF;
END$$
DELIMITER ;

-- 21:
DELIMITER $$
CREATE TRIGGER cambiar_nombre_sala
BEFORE INSERT ON conferencia
FOR EACH ROW
BEGIN
    DECLARE min_conferencias INT;
    DECLARE nombre_sala_min VARCHAR(50);
    SELECT COUNT(*) INTO min_conferencias FROM sala WHERE nombreSala = NEW.nombreSala;
    IF min_conferencias = 0 THEN
        SELECT nombreSala INTO nombre_sala_min FROM sala GROUP BY nombreSala ORDER BY COUNT(*) ASC LIMIT 1;
        SET NEW.nombreSala = nombre_sala_min;
    END IF;
END$$
DELIMITER ;

-- 22: 
CREATE TABLE registro (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(30),
    tabla VARCHAR(50),
    operacion VARCHAR(10),
    datos_antiguos VARCHAR(70),
    datos_nuevos VARCHAR(70),
    fecha_hora DATETIME
);

DELIMITER $$
CREATE TRIGGER registro_sala
AFTER INSERT ON sala
FOR EACH ROW
BEGIN
    INSERT INTO registro (usuario, tabla, operacion, datos_nuevos, fecha_hora)
    VALUES (USER(), 'sala', 'alta', CONCAT(NEW.nombreSala, ':', NEW.capacidad), NOW());
END$$

CREATE TRIGGER registro_sala_update
AFTER UPDATE ON sala
FOR EACH ROW
BEGIN
    INSERT INTO registro (usuario, tabla, operacion, datos_antiguos, datos_nuevos, fecha_hora)
    VALUES (USER(), 'sala', 'modificacion', CONCAT(OLD.nombreSala, ':', OLD.capacidad), CONCAT(NEW.nombreSala, ':', NEW.capacidad), NOW());
END$$

CREATE TRIGGER registro_sala_delete
AFTER DELETE ON sala
FOR EACH ROW
BEGIN
    INSERT INTO registro (usuario, tabla, operacion, datos_antiguos, fecha_hora)
    VALUES (USER(), 'sala', 'baja', CONCAT(OLD.nombreSala, ':', OLD.capacidad), NOW());
END$$
DELIMITER ;

24:
SHOW TRIGGERs LIKE 'sala';
DROP TRIGGER registro_sala_delete; 