-- Ej 16
insert into socio
(num_socio, nombre, apellido1, domicilio, poblacion, fec_nac)
values
(1007, "Francisco", "Sánchez", "Avda. de las Palmeras, 2", "Armilla", "1970-02-02");
-- Ej 17
insert into alquiler (socio, copia_pel, fec_alquila)
values
(1007, 105, curdate());
-- Ej 18
update copia_pelicula
set estado = "ESTROPEADA", observacion = "Rayado"
where id_copia = 101;
-- Ej 19
delete from pelicula
where titulo = "El Orfanato";
-- Ej 20
insert into pelicula
values
('PRP', 'La princesa prometida', 120, '1980', 'Aventura', 2.2);
-- Ej 21
update 
pelicula
set genero = "Dibujos"
where genero = "Animación";
-- Ej 22
/*
Eliminar aquellos socios cuya última película 
alquilada sea anterior al 1 de diciembre de 2014
*/
delete from socio
where num_socio in (
    select num_socio
    from alquiler
    where fec_alquila < "2014-12-01"
);
-- Ej 23
update pelicula
set precio_alquiler = precio_alquiler + 0.2
WHERE codigo IN (
    SELECT pelicula FROM
    copia_pelicula
    GROUP BY pelicula
    HAVING COUNT(DISTINCT(copia_pelicula.id_Copia)) > 2);
-- Ej 24
delete from copia_pelicula
where 
pelicula in
    (select pelicula from pelicula where nombre like '%frozen%')
and
estado = "ESTROPEADA";