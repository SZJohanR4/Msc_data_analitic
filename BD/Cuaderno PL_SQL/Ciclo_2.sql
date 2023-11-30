SELECT * FROM ClientePLSQL; -- Obtiene todos los datos de los clientes almacenados.
SELECT * FROM AutoPLSQL; -- Visualiza todos los detalles de los autos disponibles para alquilar.
SELECT * FROM AlquilerPLSQL; -- Muestra cada registro de alquiler almacenado.
SELECT c.nombre, a.marca, a.modelo FROM ClientePLSQL c JOIN AlquilerPLSQL a ON c.id_cliente = a.id_cliente; -- Detalles de clientes y sus autos alquilados.
SELECT a.marca, a.modelo, a.ano FROM AutoPLSQL a JOIN AlquilerPLSQL al ON a.id_auto = al.id_auto; -- Información detallada de autos actualmente alquilados.
SELECT * FROM AlquilerPLSQL WHERE id_cliente = 1; -- Detalles de alquileres del cliente identificado como ID 1.
SELECT * FROM AlquilerPLSQL WHERE id_auto = 1; -- Detalles de alquileres del auto con identificador 1.
SELECT * FROM AlquilerPLSQL WHERE id_sucursal = 1; -- Alquileres realizados en la sucursal específica con ID 1.
SELECT * FROM AlquilerPLSQL WHERE fecha_inicio = '2023-09-27'; -- Alquileres que iniciaron el 27 de septiembre de 2023.
SELECT COUNT(*) FROM AlquilerPLSQL; -- Cuenta la cantidad total de registros de alquiler almacenados.

SELECT c.nombre
FROM ClientePLSQL c
JOIN AlquilerPLSQL a ON c.id_cliente = a.id_cliente
JOIN SucursalPLSQL s ON a.id_sucursal = s.id_sucursal
WHERE s.nombre = 'Sucursal Central'; -- Nombres de clientes que alquilaron en la sucursal 'Sucursal Central'.

SELECT a.marca, a.modelo
FROM AutoPLSQL a
JOIN AlquilerPLSQL al ON a.id_auto = al.id_auto
WHERE al.id_cliente = 1 AND al.fecha_inicio = '2023-09-27'; -- Marcas y modelos de autos alquilados por el cliente 1 desde el 27 de septiembre de 2023.

SELECT a.marca, a.modelo
FROM AutoPLSQL a
JOIN AlquilerPLSQL al ON a.id_auto = al.id_auto
WHERE al.id_cliente = 1 AND al.fecha_inicio = '2023-09-27'; -- Marcas y modelos de autos alquilados por el cliente 1 desde el 27 de septiembre de 2023.

SELECT *
FROM AlquilerPLSQL
WHERE fecha_fin - fecha_inicio > 7; -- Alquileres con una duración superior a 7 días.

SELECT c.nombre, COUNT(*) AS numero_alquileres
FROM ClientePLSQL c
JOIN AlquilerPLSQL a ON c.id_cliente = a.id_cliente
GROUP BY c.nombre
ORDER BY numero_alquileres DESC
LIMIT 1; -- Cliente con más alquileres y la cantidad de alquileres que ha realizado.

SELECT a.marca, a.modelo, COUNT(*) AS numero_alquileres
FROM AutoPLSQL a
JOIN AlquilerPLSQL al ON a.id_auto = al.id_auto
GROUP BY a.marca, a.modelo
ORDER BY numero_alquileres DESC
LIMIT 1; -- Auto con más alquileres, su marca, modelo y la cantidad de alquileres realizados.

SELECT s.nombre, COUNT(*) AS numero_alquileres
FROM SucursalPLSQL s
JOIN AlquilerPLSQL al ON s.id_sucursal = al.id_sucursal
GROUP BY s.nombre
ORDER BY numero_alquileres DESC
LIMIT 1; -- Sucursal con más alquileres y la cantidad de alquileres registrados en esa sucursal.

SELECT EXTRACT(MONTH FROM fecha_inicio) AS mes, COUNT(*) AS numero_alquileres
FROM AlquilerPLSQL
GROUP BY EXTRACT(MONTH FROM fecha_inicio)
ORDER BY numero_alquileres DESC
LIMIT 1; -- Mes con más alquileres y la cantidad de alquileres registrados en ese mes.

SELECT EXTRACT(DAYOFWEEK FROM fecha_inicio) AS dia_semana, COUNT(*) AS numero_alquileres
FROM AlquilerPLSQL
GROUP BY EXTRACT(DAYOFWEEK FROM fecha_inicio)
ORDER BY numero_alquileres DESC
LIMIT 1; -- Día de la semana con más alquileres y la cantidad de alquileres registrados en ese día.

SELECT * FROM AlquilerPLSQL
ORDER BY precio DESC
LIMIT 1; -- Detalles del alquiler con el precio más alto.

SELECT * FROM AlquilerPLSQL
ORDER BY precio ASC
LIMIT 1; -- Detalles del alquiler con el precio más bajo.

SELECT * FROM ClientePLSQL
WHERE nombre LIKE '%Juan%'; -- Detalles de los clientes cuyo nombre contiene "Juan".

SELECT a.marca, a.modelo, a.ano
FROM AutoPLSQL a
WHERE precio < 10000; -- Detalles de autos con precios menores a 10000, incluyendo marca, modelo y año.

SELECT * FROM AlquilerPLSQL
WHERE fecha_inicio BETWEEN '2023-09-01' AND '2023-09-30'; -- Alquileres que tuvieron lugar en septiembre de 2023.

SELECT c.nombre, a.marca, a.modelo
FROM ClientePLSQL c
JOIN AlquilerPLSQL a ON c.id_cliente = a.id_cliente
WHERE c.direccion LIKE '%Bogotá%'; -- Detalles de clientes y autos para aquellos con dirección en "Bogotá".

SELECT a.marca, a.modelo, a.ano
FROM AutoPLSQL a
JOIN AlquilerPLSQL al ON a.id_auto = al.id_auto
WHERE al.id_reserva = 1; -- Detalles de autos relacionados con la reserva ID 1.

SELECT * FROM AlquilerPLSQL
WHERE id_cliente IN (1, 2, 3); -- Alquileres de los clientes con ID 1, 2 o 3.

SELECT * FROM AlquilerPLSQL
WHERE id_auto IN (1, 2, 3); -- Alquileres de los autos con ID 1, 2 o 3.

SELECT * FROM AlquilerPLSQL
WHERE id_sucursal IN (1, 2, 3); -- Alquileres de las sucursales con ID 1, 2 o 3.

SELECT * FROM AlquilerPLSQL
WHERE fecha_inicio BETWEEN '2023-09-01' AND '2023-09-30' AND id_cliente IN (1, 2, 3);

SELECT * FROM AlquilerPLSQL
WHERE fecha_inicio BETWEEN '2023-09-01' AND '2023-09-30' AND id_auto IN (1, 2, 3);

SELECT * FROM AlquilerPLSQL
WHERE fecha_inicio BETWEEN '2023-09-01' AND '2023-09-30' AND id_sucursal IN (1, 2, 3);

SELECT c.nombre, COUNT(*) AS numero_alquileres
FROM ClientePLSQL c
JOIN AlquilerPLSQL a ON c.id_cliente = a.id_cliente
GROUP BY c.nombre
ORDER BY numero_alquileres DESC
LIMIT 1;

SELECT a.marca, a.modelo, COUNT(*) AS numero_alquileres
FROM AutoPLSQL a
JOIN AlquilerPLSQL al ON a.id_auto = al.id_auto
GROUP BY a.marca, a.modelo
ORDER BY numero_alquileres DESC
LIMIT 1;

SELECT s.nombre, COUNT(*) AS numero_alquileres
FROM SucursalPLSQL s
JOIN AlquilerPLSQL al ON s.id_sucursal = al.id_sucursal
GROUP BY s.nombre
ORDER BY numero_alquileres DESC
LIMIT 1;

SELECT EXTRACT(MONTH FROM fecha_inicio) AS mes, COUNT(*) AS numero_alquileres
FROM AlquilerPLSQL
GROUP BY EXTRACT(MONTH FROM fecha_inicio)
ORDER BY numero_alquileres DESC
LIMIT 1;

SELECT * FROM AlquilerPLSQL
ORDER BY precio DESC
LIMIT 1; -- Detalles del alquiler con el precio más alto.

SELECT * FROM AlquilerPLSQL
ORDER BY precio ASC
LIMIT 1; -- Detalles del alquiler con el precio más bajo.

SELECT * FROM ClientePLSQL
WHERE nombre LIKE '%Juan%' AND fecha_inicio BETWEEN '2023-09-01' AND '2023-09-30'; -- Detalles de los clientes con nombre "Juan" que alquilaron entre septiembre 1 y 30, 2023.

SELECT a.marca, a.modelo, a.ano
FROM AutoPLSQL a
WHERE precio < 10000 AND fecha_inicio BETWEEN '2023-09-01' AND '2023-09-30'; -- Detalles de autos con precio menor a 10000 y alquilados entre septiembre 1 y 30, 2023.













