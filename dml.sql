
INSERT INTO clientes (id, nombre, apellidos, celular, direccion, correo_electronico)
VALUES ('1', 'Bob', 'Esponja', '3001234567', 'Fondo de Bikini 123', 'bob.esponja@bikiny.com'),
        ('2', 'Patricio', 'Estrella', '3012345678', 'Calle Rocosa 45', 'patricio.estrella@bikiny.com'),
        ('3', 'Calamardo', 'Tentaculos', '3023456789', 'Avenida Coral 10', 'calamardo.tentaculos@bikiny.com');


INSERT INTO categorias (descripcion, estado)
VALUES ('Bicicletas', 1),
        ('Accesorios', 1),
        ('Calzado Deportivo', 1);


INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado)
VALUES ('Bicicleta de montaña', 1, '111', 50000.00, 10, 1),
        ('Termo', 2, '222', 5000.00, 50, 1),
        ('Zapatos de running', 3, '333', 80000.00, 30, 1);


INSERT INTO compras (id_cliente, fecha, medio_pago, comentario, estado)
VALUES ('1', '2024-07-31 10:00:00', 'T', 'Compra de Bicicleta', 'A'),
        ('2', '2024-07-31 11:00:00', 'E', 'Compra de accesorios', 'A'),
        ('3', '2024-07-31 12:00:00', 'T', 'Compra de ropa deportiva', 'A');


INSERT INTO compras_productos (id_compra, id_producto, cantidad, total, estado)
VALUES (1, 1, 1, 50000.00, 1),
        (2, 2, 2, 10000.00, 1),
        (3, 3, 1, 80000.00, 1);