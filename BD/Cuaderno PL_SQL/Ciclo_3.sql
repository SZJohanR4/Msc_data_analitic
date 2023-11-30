-- Ejercicio 1: Vista que lista los clientes que han alquilado en la sucursal "Sucursal Central".
CREATE VIEW vista_clientes_alquilados_sucursal AS 
SELECT c.nombre, a.marca, a.modelo 
FROM ClientePLSQL c 
JOIN AlquilerPLSQL a ON c.id_cliente = a.id_cliente 
JOIN SucursalPLSQL s ON a.id_sucursal = s.id_sucursal 
WHERE s.nombre = 'Sucursal Central';

-- Ejercicio 2: Vista que muestra los autos alquilados por un cliente específico en una fecha específica.
CREATE VIEW vista_autos_alquilados_cliente_fecha AS 
SELECT a.marca, a.modelo 
FROM AutoPLSQL a 
JOIN AlquilerPLSQL al ON a.id_auto = al.id_auto 
WHERE al.id_cliente = 1 AND al.fecha_inicio = '2023-09-27';

-- Ejercicio 3: Vista que muestra los alquileres con una duración superior a 7 días.
CREATE VIEW vista_alquileres_mas_7dias AS 
SELECT * FROM AlquilerPLSQL 
WHERE fecha_fin - fecha_inicio > 7;

-- Ejercicio 4: Vista que muestra los clientes con la cantidad de alquileres realizados, ordenados por el número de alquileres de forma descendente.
CREATE VIEW vista_clientes_mas_alquileres AS 
SELECT c.nombre, COUNT(*) AS numero_alquileres 
FROM ClientePLSQL c 
JOIN AlquilerPLSQL a ON c.id_cliente = a.id_cliente 
GROUP BY c.nombre 
ORDER BY numero_alquileres DESC;

-- Ejercicio 5: Vista que muestra los autos con la cantidad de alquileres que han tenido, ordenados por el número de alquileres de forma descendente.
CREATE VIEW vista_autos_mas_alquileres AS 
SELECT a.marca, a.modelo, COUNT(*) AS numero_alquileres 
FROM AutoPLSQL a 
JOIN AlquilerPLSQL al ON a.id_auto = al.id_auto 
GROUP BY a.marca, a.modelo 
ORDER BY numero_alquileres DESC;

-- Ejercicio 6: Vista que muestra las sucursales con la cantidad de alquileres que han tenido, ordenadas por el número de alquileres de forma descendente.
CREATE VIEW vista_sucursales_mas_alquileres AS 
SELECT s.nombre, COUNT(*) AS numero_alquileres 
FROM SucursalPLSQL s 
JOIN AlquilerPLSQL al ON s.id_sucursal = al.id_sucursal 
GROUP BY s.nombre 
ORDER BY numero_alquileres DESC;

-- Ejercicio 7: Vista que muestra los meses con la cantidad de alquileres que han tenido, ordenados por el número de alquileres de forma descendente.
CREATE VIEW vista_meses_mas_alquileres AS 
SELECT EXTRACT(MONTH FROM fecha_inicio) AS mes, COUNT(*) AS numero_alquileres 
FROM AlquilerPLSQL 
GROUP BY EXTRACT(MONTH FROM fecha_inicio) 
ORDER BY numero_alquileres DESC;

-- Ejercicio 8: Vista que muestra los días de la semana con la cantidad de alquileres que han tenido, ordenados por el número de alquileres de forma descendente.
CREATE VIEW vista_dias_semana_mas_alquileres AS 
SELECT EXTRACT(DAYOFWEEK FROM fecha_inicio) AS dia_semana, COUNT(*) AS numero_alquileres 
FROM AlquilerPLSQL 
GROUP BY EXTRACT(DAYOFWEEK FROM fecha_inicio) 
ORDER BY numero_alquileres DESC;

-- Ejercicio 9: Vista que muestra los alquileres ordenados por precio de forma descendente.
CREATE VIEW vista_alquileres_mas_caros AS 
SELECT * FROM AlquilerPLSQL 
ORDER BY precio DESC;

-- Ejercicio 10: Vista que muestra los alquileres ordenados por precio de forma ascendente.
CREATE VIEW vista_alquileres_mas_baratos AS 
SELECT * FROM AlquilerPLSQL 
ORDER BY precio ASC;