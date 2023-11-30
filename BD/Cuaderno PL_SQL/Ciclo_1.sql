-------------CONSULTAS----------------------
-- 1. Mostrar todos los clientes registrados
SELECT * FROM ClientePLSQL;

-- 2. Ver todos los detalles de los autos disponibles
SELECT * FROM AutoPLSQL;

-- 3. Visualizar todos los registros de alquileres realizados
SELECT * FROM AlquilerPLSQL;

-- 4. Listar todas las sucursales y su información
SELECT * FROM SucursalPLSQL;

-- 5. Mostrar todos los detalles de las reservas efectuadas
SELECT * FROM ReservaPLSQL;


--------FILTROS-----------------------
-- 1. Muestra todos los clientes con el nombre "Juan"
SELECT * FROM ClientePLSQL
WHERE Nombre LIKE '%Juan%';

-- 2. Muestra todos los autos de la marca "Toyota" (puede que no haya registros)
SELECT * FROM AutoPLSQL
WHERE MARCA = 'Toyota';

-- 3. Muestra todos los alquileres que iniciaron después de '2023-01-27'
SELECT * FROM AlquilerPLSQL
WHERE FECHA_INICIO > '27/01/2023';

-- 4. Muestra todas las sucursales ubicadas en "Madrid" (puede que no haya registros)
SELECT * FROM SucursalPLSQL
WHERE CIUDAD = 'Madrid';

-- 5. Muestra todas las reservas realizadas por el cliente con ID 1 (puede que no haya registros del cliente 1)
SELECT * FROM ReservaPLSQL
WHERE ID_CLIENTE = 1;


--------JOINs-----------------------
-- 1. Detalles de alquileres con nombres de clientes y marcas de autos
SELECT A.id_alquiler, C.nombre AS nombre_cliente, Au.marca
FROM AlquilerPLSQL A
JOIN ClientePLSQL C ON A.id_cliente = C.id_cliente
JOIN AutoPLSQL Au ON A.id_auto = Au.id_auto;

-- 2. Clientes que reservaron en la sucursal 12
SELECT DISTINCT C.*
FROM ClientePLSQL C
JOIN ReservaPLSQL R ON C.id_cliente = R.id_cliente
WHERE R.id_sucursal = 12;

-- 3. Autos alquilados con nombres de clientes
SELECT A.id_auto, Au.marca, Au.modelo, Au.ano, C.nombre AS nombre_cliente
FROM AlquilerPLSQL A
JOIN ClientePLSQL C ON A.id_cliente = C.id_cliente
JOIN AutoPLSQL Au ON A.id_auto = Au.id_auto;

-- 4. Detalles de reservas con nombres de clientes y ciudades de sucursales
SELECT R.id_reserva, C.nombre AS nombre_cliente, S.ciudad
FROM ReservaPLSQL R
JOIN ClientePLSQL C ON R.id_cliente = C.id_cliente
JOIN SucursalPLSQL S ON R.id_sucursal = S.id_sucursal;

-- 5. Clientes que no han realizado ninguna reserva
SELECT C.*
FROM ClientePLSQL C
LEFT JOIN ReservaPLSQL R ON C.id_cliente = R.id_cliente
WHERE R.id_reserva IS NULL;

----------------AGRUPAMIENTO----------------------
-- 1. Contar la cantidad de autos por marca
SELECT marca, COUNT(*) AS cantidad
FROM AutoPLSQL
GROUP BY marca;

-- 2. Calcular la duración promedio de los alquileres
SELECT AVG(fecha_fin - fecha_inicio) AS duracion_promedio
FROM AlquilerPLSQL;

-- 3. Mostrar el total de reservas realizadas en cada sucursal
SELECT S.id_sucursal, S.nombre, COUNT(R.id_reserva) AS total_reservas
FROM SucursalPLSQL S
LEFT JOIN ReservaPLSQL R ON S.id_sucursal = R.id_sucursal
GROUP BY S.id_sucursal, S.nombre;

-- 4. Encontrar el cliente con más alquileres realizados
SELECT C.id_cliente, C.nombre, COUNT(A.id_alquiler) AS total_alquileres
FROM ClientePLSQL C
LEFT JOIN AlquilerPLSQL A ON C.id_cliente = A.id_cliente
GROUP BY C.id_cliente, C.nombre
ORDER BY total_alquileres DESC
FETCH FIRST 1 ROW ONLY;

-- 5. Calcular el promedio de años de los autos
SELECT AVG(ano) AS promedio_anos
FROM AutoPLSQL;

---------------SUBCONSULTAS----------------

-- 1. Clientes que han realizado al menos una reserva
SELECT DISTINCT C.*
FROM ClientePLSQL C
JOIN ReservaPLSQL R ON C.id_cliente = R.id_cliente;

-- 2. Autos que no han sido alquilados aún
SELECT A.*
FROM AutoPLSQL A
LEFT JOIN AlquilerPLSQL ALQ ON A.id_auto = ALQ.id_auto
WHERE ALQ.id_auto IS NULL;

-- 3. Clientes que han alquilado el mismo auto más de una vez (puede que no haya casos de clientes que hayan alquilado el mismo auto más de una vez)
SELECT C.id_cliente, C.nombre, A.id_auto, COUNT(ALQ.id_alquiler) AS total_alquileres
FROM ClientePLSQL C
JOIN AlquilerPLSQL ALQ ON C.id_cliente = ALQ.id_cliente
JOIN AutoPLSQL A ON ALQ.id_auto = A.id_auto
GROUP BY C.id_cliente, C.nombre, A.id_auto
HAVING COUNT(ALQ.id_alquiler) > 1;

-- 4. Clientes que han realizado alquileres en la misma ciudad donde viven (depende de la estructura de las tablas; puede arrojar un error si la tabla ClientePLSQL no contiene el campo Ciudad)
SELECT C.id_cliente, C.nombre, S.ciudad AS ciudad_vivienda, ALQ.ciudad AS ciudad_alquiler
FROM ClientePLSQL C
JOIN AlquilerPLSQL ALQ ON C.id_cliente = ALQ.id_cliente
JOIN SucursalPLSQL S ON C.ciudad = S.ciudad;

-- 5. Autos que han sido alquilados en la misma sucursal donde se realizó una reserva
SELECT R.id_reserva, A.id_auto, A.marca, A.modelo, S.nombre AS sucursal_reserva
FROM ReservaPLSQL R
JOIN AlquilerPLSQL ALQ ON R.id_reserva = ALQ.id_reserva
JOIN AutoPLSQL A ON ALQ.id_auto = A.id_auto
JOIN SucursalPLSQL S ON R.id_sucursal = S.id_sucursal;



------------------------UPDATES----------------------
-- 1. Actualiza la dirección de un cliente específico.
UPDATE ClientePLSQL
SET direccion = 'Avenida Central 123'
WHERE id_cliente = 789;

-- 2. Elimina un auto de la tabla "Auto"
DELETE FROM AutoPLSQL
WHERE id_auto = 7;

-- 3. Marca una reserva como completada actualizando la fecha de fin
UPDATE ReservaPLSQL
SET fecha_fin = '2023-05-15'
WHERE id_reserva = '42/2023'; -- Se debe usar el formato de fecha adecuado

-- 4. Elimina todas las reservas realizadas por un cliente específico.
DELETE FROM ReservaPLSQL
WHERE id_cliente = 15;

-- 5. Actualiza el año de un auto en la tabla "Auto"
UPDATE AutoPLSQL
SET ano = 2022
WHERE id_auto = 11;


