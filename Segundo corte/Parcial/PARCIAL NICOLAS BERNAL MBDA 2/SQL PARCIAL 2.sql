CREATE TABLE VUELOS(
    id NUMBER NOT NULL PRIMARY KEY,
    lugarOrigen VARCHAR(30) NOT NULL,
    lugarDestino VARCHAR(30) NOT NULL
)

CREATE TABLE ITINERARIOS(
    id INTEGER NOT NULL PRIMARY KEY,
    fecha DATE NOT NULL,
    precioPorPasajero NUMBER NOT NULL
)
CREATE TABLE TIENES(
    id NUMBER NOT NULL PRIMARY KEY,
    id INTEGER NOT NULL PRIMARY KEY,
    escala BOOLEAN NOT NULL
)

CREATE TABLE ALOJAMIENTOS(
    id NUMBER NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    capacidad INTEGER NOT NULL,
    precioPorPasajero NUMBER NOT NULL
)

CREATE TABLE PAQUETES(
    id NUMBER NOT NULL PRIMARY KEY,
    observacion VARCHAR(30) NOT NULL,
    idItinerario INTEGER NOT NULL,
    idAlojamiento INTEGER NOT NULL
)


CREATE TABLE PERSONAS(
    id NUMBER NOT NULL PRIMARY KEY,
    numeroDocumento NUMBER NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    telefono VARCHAR(15),
    fechaNacimiento DATE NOT NULL,
    correo VARCHAR(30) NOT NULL
)

CREATE TABLE USUARIOS(
    id NUMBER NOT NULL PRIMARY KEY,
    numeroDocumento NUMBER NOT NULL PRIMARY KEY,
    contraseña NUMBER NOT NULL
)

CREATE TABLE PASAJEROS(
    id NUMBER NOT NULL PRIMARY KEY,
    numeroDocumento NUMBER NOT NULL PRIMARY KEY,
    lider BOOLEAN NOT NULL
)

CREATE TABLE RESERVAS(
    numero VARCHAR(30) NOT NULL PRIMARY KEY,
    fechaInicial DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fechaFinal DATE NOT NULL
)

CREATE TABLE PAGOS(
    id NUMBER NOT NULL PRIMARY KEY,
    fecha DATE NOT NULL,
    total INT NOT NULL,
    numeroReservas INTEGER NOT NULL
)


ALTER TABLE ALOJAMIENTOS ADD CONSTRAINT uk_nombre_alojamiento
UNIQUE(nombre);

ALTER TABLE ITINERARIOSVUELO ADD CONSTRAINT uk_nombre_alojamiento
UNIQUE(nombre);

ALTER TABLE ALOJAMIENTOS ADD CONSTRAINT uk_nombre_alojamiento
UNIQUE(nombre);
ALTER TABLE ALOJAMIENTOS ADD CONSTRAINT uk_nombre_alojamiento
UNIQUE(nombre);
ALTER TABLE ALOJAMIENTOS ADD CONSTRAINT uk_nombre_alojamiento
UNIQUE(nombre);

ALTER TABLE Evaluaciones ADD CONSTRAINT fk_evaluaciones_herramientas 

FOREING KEY (idHerramientas) REFERENCE herramientas(id) 

ON DELETE CASCADE; 



--2 Implementar las restricciones declarativas correspondientes al CRUD

CREATE DOMAIN TEstadoPago AS VARCHAR(15) CONSTRAINT 
CHECK (VALUE IN ("EP", "AP", "RC")) 

CREATE DOMAIN TConsecutivo AS INT CONSTRAINT 
CHECK (VALUE IN (TConsecutivo>=1))

ALTER TABLE Pagos 
ADD CONSTRAINT d_fecha_pago 
CHECK (NOT (fecha_pago > SYSDATA)) 

ALTER TABLE Reservas 
ADD CONSTRAINT d_fecha_inicial 
CHECK (NOT (fecha_inicial < fecha_final)) 

CREATE ASSERTION Herencia 
CHECK (NOT EXIST (SELECT COUNT(Pe.persona))) 
FROM Persona Pe 
JOIN Pasajeros p ON p.tipoDocumento = pe.tipoDocumento 
JOIN Usuarios u ON u.tipoDocumento = pe.tipoDocumento 
WHERE p.tipoDocumento = u.tipoDocumento 
AND COUNT((u.tipoDocumento>0))

--3 Implementar las restricciones procedimentales correspondientes a Registrar pago
CREATE OR REPLACE TRIGGER trg_insert_pago
BEFORE INSERT ON Pago
FOR EACH ROW
DECLARE
    v_estado_existente VARCHAR2(2);
    v_total_reserva NUMBER;
BEGIN
    :NEW.estado := 'EP';
    :NEW.fecha_pago := SYSDATE;
    SELECT estado INTO v_estado_existente
    FROM Pago
    WHERE id_reserva = :NEW.id_reserva AND estado = 'AP'
    FETCH FIRST 1 ROWS ONLY;
    IF v_estado_existente = 'AP' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Ya existe un pago aprobado para esta reserva.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; 
END;



CREATE OR REPLACE TRIGGER trg_update_reserva
BEFORE UPDATE ON Reserva
FOR EACH ROW
BEGIN
    IF :OLD.fecha_inicio >= TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede modificar una reserva con fecha igual o posterior a hoy.');
    END IF;
END;

CREATE OR REPLACE TRIGGER trg_no_update_pago
BEFORE UPDATE ON Pago
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20003, 'No se permite modificar un pago.');
END;

CREATE OR REPLACE TRIGGER trg_no_delete_pago
BEFORE DELETE ON Pago
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20004, 'No se permite eliminar un pago.');
END;

CREATE OR REPLACE TRIGGER trg_delete_reserva
BEFORE DELETE ON Reserva
FOR EACH ROW
BEGIN
    UPDATE Pago
    SET id_reserva = 0
    WHERE id_reserva = :OLD.id_reserva;
END;


