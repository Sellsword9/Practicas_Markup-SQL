8. Crear una sentencia preparada que devuelva las conferencias en las que participa un ponente. La sentencia se
   ejecutará utilizando como parámetros el nombre y apellidos del ponente. No olvidar liberar la memoria
   utilizada por la sentencia preparada.
9. Crear un procedimiento que devuelva el número de conferencias indicado en un parámetro. También se le
   pasará otro parámetro con las columnas que debe mostrar de la forma 'col1, col3, col5'. Poner varios ejemplos
   de llamada al procedimiento.
10. Crear un procedimiento que devuelva las conferencias (tema, precio y turno) que tienen lugar en la sala
    indicada. En caso de que no haya conferencias deberá devolver “SIN CONFERENCIAS” y en el caso de que no
    exista la sala, “LA SALA NO EXISTE”.
11. Crear un procedimiento que devuelva el número de conferencias que se celebraron en la fecha indicada. En
    caso de que no hubiera conferencias ese día debe devolver el número -1.
12. Crear un procedimiento al que se le pase una capacidad y devuelva, empleando el mismo parámetro, cuantas
    salas tienen una capacidad superior a la enviada. Al mismo tiempo debe mostrar los nombres de las salas. En
    caso de que no haya salas, debe devolver -1 y mostrar el texto “SIN SALAS”.
13. Crear un procedimiento al que se le pase un idPonente de un ponente y dos fechas y devuelva en forma de
    parámetro de salida, en cuantas conferencias participó ese ponente entre las dos fechas indicadas.
    1. En caso de que el ponente no exista, el parámetro de salida debe devolver -1 y mostrar la cadena “NO
       EXISTE EL PONENTE”.
    2. En caso de que las fechas no tenga un formato correcto, el parámetro de salida debe devolver -1 y mostrar
       la cadena "FECHAS CON FORMATO INCORRECTO".
    3. Si existe el ponente y hay conferencias, el procedimiento también debe mostrar el nombre de las
       conferencias (sin repetirse) ordenadas alfabéticamente
