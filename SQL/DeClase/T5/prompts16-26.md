16. Insertar un nuevo socio con los siguientes datos:
Núm. Socio: 1007
Nombre: Francisco
Apellido 1: Sánchez
Domicilio: Avda. de las Palmeras, 2
Población: Armilla
Fecha de nacimiento: 02/02/1970
NOTA: el resto de campos no deben ser introducidos.
17. Registrar el primer alquiler del socio 1007 que se lleva la copia 105 (correspondiente a la película "Lo
imposible") en la fecha actual (en la que se está haciendo la tarea).
NOTA: la fecha de devolución no se debe introducir aún.
18. Modificar el estado de la copia de la película con id 101 a "ESTROPEADA" incluyendo como observación
"Rayado".
19. Eliminar la película cuyo título es "El Orfanato".
Utilizando sentencias SQL, realizar las siguientes operaciones:
20. Insertar una nueva película (inventando los datos) y después dar de alta dos copias para dicha película con el
estado "FUNCIONA".
21. Actualizar todas las películas que tengan como género "Animación" y reemplazarlo por "Dibujos".
22. Eliminar aquellos socios cuya última película alquilada sea anterior al 1 de diciembre de 2014.
23. Incrementar en 20 céntimos el precio del alquiler a todas las películas que tengan más de dos copias.
24. Eliminar todas las copias de las películas que contengan la palabra "FROZEN" y que su estado sea
"ESTROPEADA".
25. (** Difícil) Actualizar el precio de alquiler de aquellas películas cuyo número total de alquileres (de
todas sus copias) sea inferior a la media de los alquileres de todas las películas. El precio debe reducirse en
un 50% de su precio original.
26. (*** Difícil) Insertar en la tabla socio_vip todos los datos del socio que más número de alquileres
tenga en el último trimestre del año 2014 insertando en el campo trim_anyo_vip el valor "TRIM4_2014".