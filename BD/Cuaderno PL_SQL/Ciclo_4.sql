-- Disparador que se activa antes de insertar un nuevo auto.
-- Actualiza la cantidad de autos disponibles.
CREATE TRIGGER trg_insert_auto
BEFORE INSERT ON AutoPLSQL
FOR EACH ROW
BEGIN
  UPDATE AutoPLSQL
    SET numero_disponibles = numero_disponibles + 1
  WHERE id_auto = NEW.id_auto;
END;

-- Disparador que se activa antes de eliminar un auto.
-- Actualiza la cantidad de autos disponibles.
CREATE TRIGGER trg_delete_auto
BEFORE DELETE ON AutoPLSQL
FOR EACH ROW
BEGIN
  UPDATE AutoPLSQL
    SET numero_disponibles = numero_disponibles - 1
  WHERE id_auto = OLD.id_auto;
END;

-- Disparador que se activa antes de actualizar un auto.
-- Actualiza la cantidad de autos disponibles si el valor ha cambiado.
CREATE TRIGGER trg_update_auto
BEFORE UPDATE ON AutoPLSQL
FOR EACH ROW
BEGIN
  IF NEW.numero_disponibles != OLD.numero_disponibles THEN
    UPDATE AutoPLSQL
      SET numero_disponibles = NEW.numero_disponibles
      WHERE id_auto = NEW.id_auto;
  END IF;
END;

-- Disparadores para la tabla ClientePLSQL

-- Disparador que se activa antes de insertar un nuevo cliente.
-- Actualiza el total de clientes.
CREATE TRIGGER trg_insert_cliente
BEFORE INSERT ON ClientePLSQL
FOR EACH ROW
BEGIN
  UPDATE ClientePLSQL
    SET numero_clientes = numero_clientes + 1;
END;

-- Disparador que se activa antes de eliminar un cliente.
-- Actualiza el total de clientes.
CREATE TRIGGER trg_delete_cliente
BEFORE DELETE ON ClientePLSQL
FOR EACH ROW
BEGIN
  UPDATE ClientePLSQL
    SET numero_clientes = numero_clientes - 1;
END;

-- Disparador que se activa antes de actualizar un cliente.
-- Actualiza el número de alquileres si hay cambios en el valor.
CREATE TRIGGER trg_update_cliente
BEFORE UPDATE ON ClientePLSQL
FOR EACH ROW
BEGIN
  IF NEW.numero_alquileres != OLD.numero_alquileres THEN
    UPDATE ClientePLSQL
      SET numero_alquileres = NEW.numero_alquileres
      WHERE id_cliente = NEW.id_cliente;
  END IF;
END;

-- Procedimientos almacenados

-- Procedimiento que calcula el precio del alquiler según id_alquiler, id_auto, fecha_inicio y fecha_fin.
CREATE PROCEDURE proc_calcular_precio_alquiler
(
  IN id_alquiler INT,
  IN id_auto INT,
  IN fecha_inicio DATE,
  IN fecha_fin DATE
)
AS
BEGIN
  DECLARE precio_base NUMERIC(10, 2);
  DECLARE dias_alquiler INT;
  
  -- Obtiene el precio base del auto
  SELECT precio INTO precio_base FROM AutoPLSQL WHERE id_auto = id_auto;
  
  -- Calcula la duración del alquiler en días
  SET dias_alquiler := (fecha_fin - fecha_inicio) + 1;
  
  -- Actualiza el precio del alquiler
  UPDATE AlquilerPLSQL
    SET precio = precio_base * dias_alquiler
  WHERE id_alquiler = id_alquiler;
END;

-- Procedimiento que lista los alquileres de un cliente mediante su id_cliente.
CREATE PROCEDURE proc_listar_alquileres_cliente
(
  IN id_cliente INT
)
AS
BEGIN
  SELECT *
  FROM AlquilerPLSQL
  WHERE id_cliente = id_cliente;
END;

-- Procedimiento que lista los autos de una sucursal usando su id_sucursal.
CREATE PROCEDURE proc_listar_autos_sucursal
(
  IN id_sucursal INT
)
AS
BEGIN
  SELECT *
  FROM AutoPLSQL
  WHERE id_sucursal = id_sucursal;
END;

-- Procedimiento que agrega un nuevo auto con los datos proporcionados.
CREATE PROCEDURE proc_agregar_auto
(
  IN marca VARCHAR(255),
  IN modelo VARCHAR(255),
  IN ano INT,
  IN numero_disponibles INT
)
AS
BEGIN
  INSERT INTO AutoPLSQL (marca, modelo, ano, numero_disponibles)
  VALUES (marca, modelo, ano, numero_disponibles);
END;

-- Procedimiento que elimina un auto con su id_auto.
CREATE PROCEDURE proc_eliminar_auto
(
  IN id_auto INT
)
AS
BEGIN
  DELETE FROM AutoPLSQL
  WHERE id_auto = id_auto;
END;