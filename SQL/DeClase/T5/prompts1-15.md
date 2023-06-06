1. Insertar un nuevo fabricante (por ejemplo, Apple) indicando su id y su nombre.
2. Insertar dos nuevos fabricantes (por ejemplo, MSI y TP-Link) indicando solamente su nombre haciendo uso de una única sentencia SQL. 
3. Insertar un nuevo producto (ver algún producto del fabricante en cuestión) asociado a uno de los nuevos fabricantes. La sentencia de inserción debe incluir: id, nombre, precio e id_fabricante.
4. Insertar dos nuevos productos (ver productos del fabricante en cuestión) asociado a uno de los nuevos fabricantes. La sentencia de inserción debe ser única e incluir: nombre, precio e id_fabricante. 
5. Crear una nueva tabla con el nombre fabricante_productos que tenga las siguientes columnas: nombre_fabricante, nombre_producto y precio. Una vez creada la tabla insertar todos los registros de la BD “tienda” en esta tabla haciendo uso de una única operación de inserción. 
6. Crear una vista con el nombre vista_fabricante_productos que tenga las siguientes columnas: nombre_fabricante, nombre_producto y precio. 
7. Eliminar el fabricante Xiaomi. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios se deberían realizar para que fuese posible borrarlo? 
8. Eliminar el fabricante Asus. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios se deberían realizar para que fuese posible borrarlo? 
9. Actualizar el código del fabricante Huawei y asignarle el valor 30. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios se deberían realizar para que fuese posible actualizarlo? 
10. Actualizar el código del fabricante Lenovo y asignarle el valor 20. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios se deberían realizar para que fuese posible actualizarlo? 
11. Actualizar el precio de todos los productos sumándole 5 € al precio actual. 
12. Eliminar todas las impresoras que tienen un precio menor de 200 €. 
13. Incrementar en un 5% el precio de los productos que pertenecen a los fabricantes en los que el nombre en su segundo carácter tiene una “e”. 
14. Añadir un “*” al final del nombre del fabricante para aquellos en los que el precio medio de sus productos sea superior a 200. 
15. Eliminar todos los fabricantes que no tienen productos asignados. 
