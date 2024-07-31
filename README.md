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
