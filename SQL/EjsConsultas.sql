
-- Ej 1 
SELECT 5+10, 10-5, 10*5, 10/5;
-- Ej 2
SELECT 5+10 AS suma, 10-5 AS resta, 10*5 AS producto, 10/5 AS cociente;
-- Ej 3 
SELECT nombre, apellido1, apellido2 FROM asistente WHERE empresa='BK Programación';
-- EJ 4
SELECT nombre, capacidad FROM sala
ORDER BY capacidad DESC;
-- Ej 5
SELECT * FROM asistente WHERE empresa = 'Bigsoft'
ORDER BY fechaNac DESC;
-- Ej 6
SELECT COUNT(codigo) AS 'Asistentes', empresa FROM asistente 
WHERE empresa IS NOT NULL
GROUP BY empresa ;
-- Ej 7 
SELECT nombre, apellido1, apellido2 FROM asistente
ORDER BY apellido1 ASC 
LIMIT 0, 5;
-- Ej 8 
SELECT tema, fecha FROM conferencia
WHERE turno='T'
AND sala IN ('Apolo', 'Zeus');
-- Ej 9 
SELECT * FROM asistente
WHERE apellido1 LIKE 'M%r%';
-- Ej 10
SELECT * FROM conferencia
WHERE precio>12 AND precio<19
AND tema NOT IN ('Programación web');
-- Ej 11 
SELECT CONCAT(apellido1, if(apellido2 IS NULL, "", concat(" ", apellido2))) 
AS Apellidos, 
fechaNac, empresa 
FROM asistente 
WHERE fechaNac BETWEEN '1974-01-01' AND '1985-01-01' 
ORDER BY fechaNac;
-- Ej 12 
SELECT * FROM conferencia
WHERE tema LIKE 'Programacion%'
ORDER BY precio DESC;
-- Ej 13
SELECT tema,
precio AS 'Sin descuento',
precio * (1 - .05) AS '5% descuento',
precio * (1 - .1) AS '10% descuento',
precio * (1 - .15) AS '15% descuento',
precio * (1 - .2) AS '20% descuento'
FROM conferencia;
-- Ej 14
SELECT tema, 
round(precio * 0.95) AS 'precio final',
DATE_FORMAT(fecha, '%d/%m/%Y') AS fecha
FROM conferencia
ORDER BY 'precio final' desc;
-- Ej 15
SELECT 
UPPER(nombre) AS 'Nombre',
UPPER(if(apellido2 is not NULL, CONCAT(apellido1," ",apellido2), apellido1)) AS 'Apellido Resultante',
UPPER(especialidad) AS 'Especialidad'
FROM ponente
ORDER BY 'Apellido Resultante' ASC;
-- Ej 16 
SELECT 
UPPER(nombre) AS 'Nombre',
UPPER(if(apellido2 is not NULL, CONCAT(apellido1," ",apellido2), concat(apellido1, ' *****'))) AS 'Apellido Resultante',
UPPER(especialidad) AS 'Especialidad'
FROM ponente
ORDER BY 'Apellido Resultante' ASC;
-- Ej 17 
SELECT 
UPPER( RPAD(nombre, 10, '*') ) AS 'Nombre',
UPPER(if(apellido2 is not NULL, CONCAT(apellido1," ",apellido2), concat(apellido1, ' *****'))) AS 'Apellido Resultante',
UPPER(especialidad) AS 'Especialidad'
FROM ponente
ORDER BY 'Apellido Resultante' ASC;
-- Ej 18
SELECT 
if(nombre not IN('Jose'),nombre, 'Pepe') AS 'Nombre',
apellido1 AS 'PrimerApellido',
if(apellido2 is not NULL, apellido2, '') AS 'SegundoApellido', 
LENGTH(CONCAT(nombre, apellido1, if(apellido2 is not NULL, apellido2, ''))) AS 'Longitud'
FROM asistente;
-- Ej 19 
select nombre,
if(apellido2 is null, apellido1, concat(apellido1," ", apellido2)) as 'Apellidos',
DATEDIFF(NOW(), fechaNac) AS 'Días vividos'
from asistente;
-- Ej 20 
SELECT nombre AS Nombre,
if(apellido2 is null, apellido1, concat(apellido1," ", apellido2)) as 'Apellidos',
DATE_FORMAT(fechaNac, '%W') AS DiaSemana, 
DATE_FORMAT(fechaNac, '%j') AS DiaAño, 
WEEK(fechaNac) AS NumeroSemana 
FROM asistente;
-- Ej 21
select count(nombre) as 'Total' 
from sala
where capacidad >= 200;
-- Ej 22
select sum(gratificacion)/count(gratificacion) AS 'Media',
ponente.nombre AS 'Ponente'
from participar
inner JOIN ponente on ponente.codigo = participar.codPonente
GROUP BY codPonente
-- Ej 23
select count(distinct(sala)) as 'Total de salas',
if(turno='T', 'Tarde', 'Mañana') as 'Turno'
from conferencia
group by turno
-- Ej 24
select count(distinct(sala)) as 'Total de salas',
if(turno='T', 'Tarde', 'Mañana') as 'Turno'
from conferencia
where conferencia.sala not in ('Apolo')
group by turno
-- Ej 25
select sala as 'Salas',
'Mañana' as 'Turno'
from conferencia
where conferencia.sala not in ('Apolo') and
turno = 'M'
-- Ej 26
SELECT 
empresa, 
if(sexo='H', 'Hombres', 'Mujeres'), 
COUNT(*) as 'Total'
FROM asistente
GROUP BY empresa, sexo;
-- Ej 27
SELECT 
if(empresa is not null, empresa, 'Sin empresa'), 
if(sexo='H', 'Hombres', 'Mujeres'), 
COUNT(*) as 'Total'
FROM asistente
GROUP BY empresa, sexo;
-- Ej 28
SELECT 
if(empresa is not null, empresa, 'Sin empresa'), 
if(sexo='H', 'Hombres', 'Mujeres'), 
COUNT(*) as 'Total'
FROM asistente
where sexo='H'
GROUP BY empresa, sexo;
-- Ej 29
select nombre,
conferencia.tema,
conferencia.referencia
from ponente
auto join conferencia
where (codigo, conferencia.referencia) in
    (select codPonente, refConferencia from participar)
order by nombre;
-- Ej 30
select nombre,
apellido1, apellido2
from asistente
where codigo in
    (select codAsistente
     from asistir
     where refConferencia = 'PWB1314');
-- Ej 31
select count(codAsistente) as 'Total de asistentes',
conferencia.tema as 'Conferencia'
from asistir
inner join conferencia 
on conferencia.referencia = asistir.refConferencia
group by asistir.refConferencia;
-- Ej 32
-- NULL
-- Ej 33
select count(codAsistente) as 'Asistentes',
conferencia.tema as 'Conferencia',
conferencia.sala as 'Sala'
from asistir
inner join conferencia 
on conferencia.referencia = asistir.refConferencia
group by refConferencia
order by Asistentes;
-- Ej 34
select concat(nombre, " ", apellido1) 
as 'Ponente'
from ponente
where codigo in
    (select codPonente
     from participar
     where refConferencia in
        (select referencia
         from conferencia
         where sala='Afrodita'));     
-- Ej 35
SELECT * FROM ponente
WHERE apellido1 IN 
	(SELECT apellido1 
	 FROM asistente 
	 WHERE fechaNac IN 
	 	(SELECT MAX(fechaNac) 
		 FROM asistente));
-- Ej 36
Select * FROM ponente
WHERE codigo IN
	(SELECT codPonente
	 FROM participar
	 WHERE refConferencia in
	 	(SELECT referencia
	 	 FROM conferencia 
	 	 WHERE sala = 'Afrodita'));
-- Ej 37
Select * FROM asistente
WHERE Empresa='BigSoft' and 
codigo IN
	(SELECT codAsistente
	 FROM asistir
	 WHERE refConferencia in
	 	(SELECT referencia
	 	 FROM conferencia 
	 	 WHERE tema='Programación Web'));
-- Ej 38
select * from asistente
where sexo='H' and
fechaNac BEtween '0000/01/01' AND '1985/01/01' and
codigo IN
	(SELECT codAsistente
	 FROM asistir
	 WHERE refConferencia in
	 	(SELECT referencia
	 	 FROM conferencia 
	 	 WHERE tema='Programación Web'));
-- Ej 39
SELECT
ponente.nombre AS 'Ponente',
SUM(participar.gratificacion) AS 'Suma'
FROM participar
Inner JOIN ponente ON ponente.codigo = participar.codPonente
GROUP BY codPonente;
-- Ej 40
SELECT 
concat(Asistente.nombre," ",Asistente.apellido1) AS 'Asistente',
Conferencia.tema
FROM Asistente
INNER JOIN asistir ON Asistente.codigo = asistir.codAsistente
INNER JOIN Conferencia ON asistir.refConferencia = Conferencia.referencia
WHERE Conferencia.fecha = '2013-10-02'
ORDER BY conferencia.tema, asistente.nombre, asistente.apellido1;