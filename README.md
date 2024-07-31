# PROYECTO MYSQL 2 
## JORGE JAIMES GONZALEZ
### Consultas Básicas

Consultar todos los productos y sus categorías

```mysql
SELECT p.id_producto AS ID, p.nombre, c.descripcion
FROM productos p
JOIN categorias c ON c.id_categoria= p.id_categoria;

+----+----------------------+-------------------+
| ID | nombre               | descripcion       |
+----+----------------------+-------------------+
|  1 | Bicicleta de montaña | Bicicletas        |
|  2 | Termo                | Accesorios        |
|  3 | Zapatos de running   | Calzado Deportivo |
+----+----------------------+-------------------+
```

Consultar todas las compras y los clientes que las realizaron

```mysql
SELECT c.id_compra, cl.nombre, cl.apellidos
FROM compras c
JOIN clientes cl ON cl.id = c.id_cliente;

+-----------+-----------+------------+
| id_compra | nombre    | apellidos  |
+-----------+-----------+------------+
|         1 | Bob       | Esponja    |
|         2 | Patricio  | Estrella   |
|         3 | Calamardo | Tentaculos |
+-----------+-----------+------------+
```

Consultar los productos comprados en una compra específica

```mysql
SELECT cp.id_compra, p.nombre, cp.cantidad 
FROM compras_productos cp
JOIN productos p ON p.id_producto = cp.id_producto
WHERE cp.id_compra = 1;

+-----------+----------------------+----------+
| id_compra | nombre               | cantidad |
+-----------+----------------------+----------+
|         1 | Bicicleta de montaña |        1 |
+-----------+----------------------+----------+
```

Agregar un nuevo producto

```mysql
INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado)
VALUES ('Gorra', 2, '223', 50000.00, 20, 1);
```

Actualizar el stock de un producto

```mysql
UPDATE productos
SET cantidad_stock = 1000
WHERE id_producto =  2;
```

Consultar todas las compras de un cliente específico

```mysql
SELECT id_compra, fecha 
FROM compras
WHERE id_cliente = 2;

+-----------+---------------------+
| id_compra | fecha               |
+-----------+---------------------+
|         2 | 2024-07-31 00:00:00 |
+-----------+---------------------+
```

Consultar todos los clientes y sus correos electrónicos

```mysql
SELECT nombre, apellidos, correo_electronico 
FROM clientes;

+-----------+------------+---------------------------------+
| nombre    | apellidos  | correo_electronico              |
+-----------+------------+---------------------------------+
| Bob       | Esponja    | bob.esponja@bikiny.com          |
| Patricio  | Estrella   | patricio.estrella@bikiny.com    |
| Calamardo | Tentaculos | calamardo.tentaculos@bikiny.com |
+-----------+------------+---------------------------------+
```

Consultar la cantidad total de productos comprados en cada compra

```mysql
SELECT cp.id_compra, p.nombre, cp.cantidad 
FROM compras_productos cp
JOIN productos p ON p.id_producto = cp.id_producto;

+-----------+----------------------+----------+
| id_compra | nombre               | cantidad |
+-----------+----------------------+----------+
|         1 | Bicicleta de montaña |        1 |
|         2 | Termo                |        2 |
|         3 | Zapatos de running   |        1 |
+-----------+----------------------+----------+
```

Consultar las compras realizadas en un rango de fechas

```mysql
SELECT id_compra
FROM compras
WHERE fecha BETWEEN  '2024-06-31' AND '2024-10-31';

+-----------+
| id_compra |
+-----------+
|         1 |
|         2 |
|         3 |
+-----------+
```

### Consultas usando funciones agregadas

Contar la cantidad de productos por categoría

```mysql
SELECT c.descripcion AS categoria, COUNT(id_producto) AS 'Cantidad de productos'
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY categoria;

+-------------------+-----------------------+
| categoria         | Cantidad de productos |
+-------------------+-----------------------+
| Bicicletas        |                     1 |
| Accesorios        |                     2 |
| Calzado Deportivo |                     1 |
+-------------------+-----------------------+
```



Calcular el precio total de ventas por cada cliente

```mysql
SELECT cl.nombre, cl.apellidos, SUM(cp.total) AS Total
FROM compras_productos cp
LEFT JOIN compras c ON cp.id_compra = c.id_compra 
LEFT JOIN clientes cl ON c.id_cliente = cl.id
GROUP BY cl.nombre, cl.apellidos;

+-----------+------------+----------+
| nombre    | apellidos  | Total    |
+-----------+------------+----------+
| Bob       | Esponja    | 50000.00 |
| Patricio  | Estrella   | 10000.00 |
| Calamardo | Tentaculos | 80000.00 |
+-----------+------------+----------+
```

Calcular el precio promedio de los productos por categoría

```mysql
SELECT c.descripcion AS Categoria, AVG(p.precio_venta) AS Promedio
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY c.descripcion;

+-------------------+--------------+
| Categoria         | Promedio     |
+-------------------+--------------+
| Bicicletas        | 50000.000000 |
| Accesorios        | 27500.000000 |
| Calzado Deportivo | 80000.000000 |
+-------------------+--------------+
```

Encontrar la fecha de la primera y última compra registrada

```mysql
SELECT MIN(fecha) AS 'Fecha primera compra registrada', MAX(fecha) AS ' Fecha última compra registrada'
FROM compras;

+---------------------------------+--------------------------------+
| Fecha primera compra registrada | Fecha última compra registrada |
+---------------------------------+--------------------------------+
| 2024-07-31 00:00:00             | 2024-07-31 00:00:00            |
+---------------------------------+--------------------------------+
```

Calcular el total de ingresos por ventas

```mysql
/*Ingresos totales*/
SELECT SUM(total) AS 'Total ingresos'
FROM compras_productos

+----------------+
| Total ingresos |
+----------------+
|      140000.00 |
+----------------+

/*Ingresos por venta, por si llegan a haber muchos productos en una sola compra*/
SELECT id_compra, SUM(total) AS 'Total ingresos'
FROM compras_productos 
GROUP BY id_compra;

+-----------+----------------+
| id_compra | Total ingresos |
+-----------+----------------+
|         1 |       50000.00 |
|         2 |       10000.00 |
|         3 |       80000.00 |
+-----------+----------------+
```

Contar la cantidad de compras realizadas por cada medio de pago

```mysql
SELECT medio_pago, COUNT(id_compra) 
FROM compras
GROUP BY medio_pago;

+------------+------------------+
| medio_pago | COUNT(id_compra) |
+------------+------------------+
| T          |                2 |
| E          |                1 |
+------------+------------------+
```

Calcular el total de productos vendidos por cada producto

```mysql
SELECT p.id_producto, p.nombre, SUM(cp.cantidad) AS CANTIDAD
FROM compras_productos cp
RIGHT JOIN productos p ON cp.id_producto =p.id_producto
GROUP BY p.id_producto, p.nombre;

+-------------+----------------------+----------+
| id_producto | nombre               | CANTIDAD |
+-------------+----------------------+----------+
|           1 | Bicicleta de montaña |        1 |
|           2 | Termo                |        2 |
|           3 | Zapatos de running   |        1 |
|           4 | Gorra                |     NULL |
+-------------+----------------------+----------+
```

Obtener el promedio de cantidad de productos comprados por compra

```mysql
SELECT AVG(cantidad) AS 'PROMEDIO TOTAL'
FROM compras_productos;

+----------------+
| PROMEDIO TOTAL |
+----------------+
|         1.3333 |
+----------------+

/*----------------------------------------------------------------------*/

SELECT id_compra, AVG(cantidad) AS 'PROMEDIO POR COMPRA'
FROM compras_productos
GROUP BY id_compra;

+-----------+---------------------+
| id_compra | PROMEDIO POR COMPRA |
+-----------+---------------------+
|         1 |              1.0000 |
|         2 |              2.0000 |
|         3 |              1.0000 |
+-----------+---------------------+
```

Encontrar los productos con el stock más bajo

```mysql
SELECT id_producto, cantidad_stock AS cantidad
FROM productos
WHERE cantidad_stock = (
	SELECT MIN(cantidad_stock)
	FROM productos
);

+-------------+----------------+
| id_producto | cantidad_stock |
+-------------+----------------+
|           1 |             10 |
+-------------+----------------+
```

Calcular el total de productos comprados y el total gastado por cliente

```mysql
SELECT cl.nombre, cl.apellidos, SUM(cantidad) AS 'Total productos', SUM(total) AS 'Total gastado'
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY cl.nombre, cl.apellidos

+-----------+------------+-----------------+---------------+
| nombre    | apellidos  | Total productos | Total gastado |
+-----------+------------+-----------------+---------------+
| Bob       | Esponja    |               1 |      50000.00 |
| Patricio  | Estrella   |               2 |      10000.00 |
| Calamardo | Tentaculos |               1 |      80000.00 |
+-----------+------------+-----------------+---------------+
```

### Consultas usando join

Consultar todos los productos con sus categorías 

```mysql
SELECT p.id_producto, p.nombre,c.descripcion AS categoria
FROM productos p
JOIN categorias c ON c.id_categoria = P.id_categoria

+-------------+----------------------+-------------------+
| id_producto | nombre               | categoria         |
+-------------+----------------------+-------------------+
|           1 | Bicicleta de montaña | Bicicletas        |
|           2 | Termo                | Accesorios        |
|           4 | Gorra                | Accesorios        |
|           3 | Zapatos de running   | Calzado Deportivo |
+-------------+----------------------+-------------------+
```

Consultar todas las compras y los clientes que las realizaron

```mysql
SELECT c.id_compra, cl.nombre, cl.apellidos
FROM compras c
JOIN clientes cl ON c.id_cliente = cl.id;

+-----------+-----------+------------+
| id_compra | nombre    | apellidos  |
+-----------+-----------+------------+
|         1 | Bob       | Esponja    |
|         2 | Patricio  | Estrella   |
|         3 | Calamardo | Tentaculos |
+-----------+-----------+------------+
```

Consultar los productos comprados en cada compra

```mysql
SELECT c.id_compra, GROUP_CONCAT(p.nombre SEPARATOR ' - ') AS productos
FROM compras c
JOIN compras_productos cp ON cp.id_compra = c.id_compra
JOIN productos p ON p.id_producto = cp.id_producto
GROUP BY c.id_compra;

+-----------+----------------------+
| id_compra | productos            |
+-----------+----------------------+
|         1 | Bicicleta de montaña |
|         2 | Termo                |
|         3 | Zapatos de running   |
+-----------+----------------------+
```

Consultar las compras realizadas por un cliente específico

```mysql
SELECT cl.nombre AS cliente, c.id_compra, p.nombre AS producto
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN productos P ON p.id_producto = cp.id_producto
JOIN clientes cl ON cl.id = c.id_cliente
WHERE cl.id = 1;

+---------+-----------+----------------------+
| cliente | id_compra | producto             |
+---------+-----------+----------------------+
| Bob     |         1 | Bicicleta de montaña |
+---------+-----------+----------------------+
```

Consultar el total gastado por cada cliente

```mysql
SELECT cl.nombre, cl.apellidos, SUM(cp.total) as total
FROM compras_productos cp
JOIN compras c ON c.id_compra =cp.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY cl.nombre, cl.apellidos;

+-----------+------------+----------+
| nombre    | apellidos  | total    |
+-----------+------------+----------+
| Bob       | Esponja    | 50000.00 |
| Patricio  | Estrella   | 10000.00 |
| Calamardo | Tentaculos | 80000.00 |
+-----------+------------+----------+

```



Consultar el stock disponible de productos y su categoría

```mysql
SELECT p.id_producto, p.nombre, p.cantidad_stock, c.descripcion AS categoria
FROM productos p
JOIN categorias c ON c.id_categoria = p.id_categoria;

+-------------+----------------------+----------------+-------------------+
| id_producto | nombre               | cantidad_stock | categoria         |
+-------------+----------------------+----------------+-------------------+
|           1 | Bicicleta de montaña |             10 | Bicicletas        |
|           2 | Termo                |           1000 | Accesorios        |
|           4 | Gorra                |             20 | Accesorios        |
|           3 | Zapatos de running   |             30 | Calzado Deportivo |
+-------------+----------------------+----------------+-------------------+
```

Consultar los detalles de compras junto con la información del cliente y el producto

```mysql
SELECT c.id_compra, 
	c.fecha, 
	c.medio_pago, 
	p.nombre AS producto, 
	cg.descripcion as categoria, 
	cp.cantidad, 
	cp.total, 
	c.comentario,
	cl.nombre AS Cliente ,
	cl.apellidos as apellido_cliente,
    cl.celular, 
    cl.direccion, 
    cl.correo_electronico
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN productos P ON p.id_producto = cp.id_producto
JOIN clientes cl ON cl.id = c.id_cliente
JOIN categorias cg ON cg.id_categoria = p.id_categoria;

+-----------+---------------------+------------+----------------------+-------------------+----------+----------+--------------------------+-----------+------------------+------------+---------------------+---------------------------------+
| id_compra | fecha               | medio_pago | producto             | categoria         | cantidad | total    | comentario               | Cliente   | apellido_cliente | celular    | direccion           | correo_electronico              |
+-----------+---------------------+------------+----------------------+-------------------+----------+----------+--------------------------+-----------+------------------+------------+---------------------+---------------------------------+
|         1 | 2024-07-31 00:00:00 | T          | Bicicleta de montaña | Bicicletas        |        1 | 50000.00 | Compra de Bicicleta      | Bob       | Esponja          | 3001234567 | Fondo de Bikini 123 | bob.esponja@bikiny.com          |
|         2 | 2024-07-31 00:00:00 | E          | Termo                | Accesorios        |        2 | 10000.00 | Compra de accesorios     | Patricio  | Estrella         | 3012345678 | Calle Rocosa 45     | patricio.estrella@bikiny.com    |
|         3 | 2024-07-31 00:00:00 | T          | Zapatos de running   | Calzado Deportivo |        1 | 80000.00 | Compra de ropa deportiva | Calamardo | Tentaculos       | 3023456789 | Avenida Coral 10    | calamardo.tentaculos@bikiny.com |
+-----------+---------------------+------------+----------------------+-------------------+----------+----------+--------------------------+-----------+------------------+------------+---------------------+---------------------------------+
```



Consultar los productos que han sido comprados por más de una cantidad específica

```mysql
SELECT p.nombre, cp.id_compra, cp.cantidad
FROM compras_productos cp
JOIN productos P ON p.id_producto = cp.id_producto
WHERE cantidad > 1;

+--------+-----------+----------+
| nombre | id_compra | cantidad |
+--------+-----------+----------+
| Termo  |         2 |        2 |
+--------+-----------+----------+
```

Consultar la cantidad total de productos vendidos por categoría

```mysql
SELECT cg.descripcion AS categoria, SUM(cp.cantidad) AS 'cantidad vendida'
FROM compras_productos cp
JOIN productos P ON p.id_producto = cp.id_producto
JOIN categorias cg ON cg.id_categoria = p.id_categoria
GROUP BY cg.descripcion;

+-------------------+------------------+
| categoria         | cantidad vendida |
+-------------------+------------------+
| Bicicletas        |                1 |
| Accesorios        |                2 |
| Calzado Deportivo |                1 |
+-------------------+------------------+
```

Consultar los clientes que han realizado compras en un rango de fechas específico

```mysql
SELECT DISTINCT cl.nombre, cl.apellidos
FROM compras c
JOIN clientes cl ON cl.id = c.id_cliente
WHERE c.fecha BETWEEN  '2024-06-31' AND '2024-10-31';

+-----------+------------+
| nombre    | apellidos  |
+-----------+------------+
| Bob       | Esponja    |
| Patricio  | Estrella   |
| Calamardo | Tentaculos |
+-----------+------------+
```

Consultar el total gastado por cada cliente junto con la cantidad total de productos comprados

```mysql

SELECT cl.nombre, cl.apellidos, SUM(cp.cantidad) AS 'Cantidad de productos comprados'
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN productos P ON p.id_producto = cp.id_producto
JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY cl.nombre, cl.apellidos;

+-----------+------------+---------------------------------+
| nombre    | apellidos  | Cantidad de productos comprados |
+-----------+------------+---------------------------------+
| Bob       | Esponja    |                               1 |
| Patricio  | Estrella   |                               2 |
| Calamardo | Tentaculos |                               1 |
+-----------+------------+---------------------------------+
```

Consultar los productos que nunca han sido comprados

```mysql
SELECT p.id_producto, p.nombre, cg.descripcion AS categoria
FROM compras_productos cp
RIGHT JOIN productos P ON p.id_producto = cp.id_producto
RIGHT JOIN categorias cg ON cg.id_categoria = p.id_categoria
GROUP BY p.id_producto, p.nombre, cg.descripcion
HAVING SUM(cp.cantidad) IS NULL;

+-------------+--------+------------+
| id_producto | nombre | categoria  |
+-------------+--------+------------+
|           4 | Gorra  | Accesorios |
+-------------+--------+------------+
```

Consultar los clientes que han realizado más de una compra y el total gastado por ellos

```mysql
SELECT cl.nombre, cl.apellidos, SUM(cp.total)
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY cl.nombre, cl.apellidos
HAVING COUNT(c.id_compra)>1;
```

Consultar los productos más vendidos por categoría

```mysql
SELECT cg.descripcion AS Categoria, SUM(cantidad) AS cantidad
FROM compras_productos cp
JOIN productos P ON p.id_producto = cp.id_producto
JOIN categorias cg ON cg.id_categoria = p.id_categoria
GROUP BY cg.descripcion
ORDER BY cantidad DESC;

+-------------------+----------+
| Categoria         | cantidad |
+-------------------+----------+
| Accesorios        |        2 |
| Bicicletas        |        1 |
| Calzado Deportivo |        1 |
+-------------------+----------+
```

Consultar las compras realizadas por clientes de una ciudad específica y el total gastado

```mysql
SELECT c.id_compra, cl.nombre, cl.apellidos, cl.direccion
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
WHERE cl.direccion LIKE '%Bikini%';

+-----------+--------+-----------+---------------------+
| id_compra | nombre | apellidos | direccion           |
+-----------+--------+-----------+---------------------+
|         1 | Bob    | Esponja   | Fondo de Bikini 123 |
+-----------+--------+-----------+---------------------+
```
### Subconsultas

Consultar los productos que tienen un precio de venta superior al precio promedio de todos los productos

```mysql
SELECT p.nombre, p.precio_venta
FROM productos p
WHERE p.precio_venta > (
    SELECT AVG(p.precio_venta)
	FROM productos p);
	
+----------------------+--------------+
| nombre               | precio_venta |
+----------------------+--------------+
| Bicicleta de montaña |     50000.00 |
| Zapatos de running   |     80000.00 |
| Gorra                |     50000.00 |
+----------------------+--------------+
```

Consultar los clientes que han gastado más del promedio general en sus compras

```mysql
SELECT cl.nombre, cl.apellidos, SUM(total) AS total
FROM compras_productos cp
JOIN compras c ON c.id_compra = cp.id_compra
JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY cl.nombre, cl.apellidos
HAVING SUM(total)>(
    SELECT AVG(total)
    FROM compras_productos cp
)

+-----------+------------+----------+
| nombre    | apellidos  | total    |
+-----------+------------+----------+
| Bob       | Esponja    | 50000.00 |
| Calamardo | Tentaculos | 80000.00 |
+-----------+------------+----------+
```

Consultar las categorías que tienen más de 5 productos

```mysql
SELECT (SELECT cg.descripcion 
        FROM categorias cg
        WHERE cg.id_categoria = p.id_categoria) AS categoria, 
        COUNT(p.id_producto) AS productos
FROM productos p
GROUP BY categoria
HAVING COUNT(p.id_producto) > 5;

+------------+-----------+
| categoria  | productos |
+------------+-----------+
| Accesorios |         2 |
+------------+-----------+
```

Consultar los productos más vendidos (top 5) por categoría

```mysql
SELECT cp.id_producto, SUM(cp.cantidad),
(SELECT p.nombre                                     
 FROM productos p                                         
 WHERE p.id_producto = cp.id_producto) as producto
FROM compras_productos cp
GROUP BY cp.id_producto, producto
ORDER BY SUM(cp.cantidad) DESC
LIMIT 2;

+-------------+------------------+----------------------+
| id_producto | SUM(cp.cantidad) | producto             |
+-------------+------------------+----------------------+
|           2 |                2 | Termo                |
|           1 |                1 | Bicicleta de montaña |
+-------------+------------------+----------------------+

```