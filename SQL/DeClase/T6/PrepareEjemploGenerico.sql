SET @sentencia = 'SELECT * FROM tabla WHERE col1 = ? AND col2 = ?';
-- Se prepara la sentencia. El nombre sentPreparada puede ser el que se quiera
PREPARE sentPreparada FROM @sentencia;
-- Se usan dos variables para establecer los valores que se le van a enviar como parámetros
SET @valorParametro1 = 10;
SET @valorParametro2 = 'Luis Carlos';
EXECUTE sentPreparada USING @valorParametro1, @valorParametro2; -- Se ejecuta la sentencia
DEALLOCATE PREPARE sentPreparada; -- Se libera la memoria
