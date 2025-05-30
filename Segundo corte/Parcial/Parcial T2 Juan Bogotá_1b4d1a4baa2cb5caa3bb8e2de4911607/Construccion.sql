/*
nombre: Juan Daniel Bogotá Fuentes
*/

--- 3. Construccion


CREATE TABLE Vuelos(
    id CHAR(4) NOT NULL PRIMARY KEY,
    lugarOrigen VARCHAR(30) NOT NULL,
    lugarDestino VARCHAR(30) NOT NULL
);

CREATE TABLE Itinerarios(
    id  INTEGER NOT NULL PRIMARY KEY,
    fecha DATE  NOT NULL,
    percioPorPasajero DECIMAL(8,2) NOT NULL
);

CREATE TABLE itinerariosTienenVuelos(
    idVuelo CHAR(4) NOT NULL PRIMARY KEY,
    idItinerario  INTEGER NOT NULL PRIMARY KEY,
    escala NUMBER(1) NOT NULL
);

--2 FK ok

CREATE TABLE Alojamientos(
    id INTEGER NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    capacidad INTEGER NOT NULL,
    percioPorPasajero DECIMAL(8,2) NOT NULL
);

-- 1 UK ok

CREATE TABLE Paquetes(
    id  INTEGER NOT NULL PRIMARY KEY,
    observacion VARCHAR(30),
    idItinerario INTEGER NOT NULL,
    idAlojamiento INTEGER NOT NULL
);

--2 FK ok

CREATE TABLE Personas(
    tipoDocumento CHAR(2) NOT NULL PRIMARY KEY,
    numeroDocumento VARCHAR(15) NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    telefono VARCHAR(15),
    fechaNacimiento DATE NOT NULL
);

CREATE TABLE CorreosPorPersonas(
    correo VARCHAR(30) NOT NULL PRIMARY KEY,
    tipoDocumento CHAR(2) NOT NULL PRIMARY KEY,
    numeroDocumento VARCHAR(15) NOT NULL PRIMARY KEY
);

-- 2 FK ok

CREATE TABLE Usuarios(
    tipoDocumento CHAR(2) NOT NULL PRIMARY KEY,
    numeroDocumento VARCHAR(15) NOT NULL PRIMARY KEY,
    contrasena CHAR(60) NOT NULL
);

-- 2 FK ok

CREATE TABLE Reservas(
    numero INTEGER NOT NULL PRIMARY KEY,
    fechaInicial DATE NOT NULL,
    estado CHAR(2) NOT NULL,
    idPaquete INTEGER NOT NULL,
    tipoDocumentoUsuario CHAR(2) NOT NULL,
    numeroDocumentoUsuario VARCHAR(15) NOT NULL
);

-- 3 FK ok

CREATE TABLE Pasajeros(
    tipoDocumento CHAR(2) NOT NULL PRIMARY KEY,
    numeroDocumento VARCHAR(15) NOT NULL PRIMARY KEY,
    numeroReserva INTEGER NOT NULL PRIMARY KEY,
    lider NUMBER(1) NOT NULL
);

-- 3 FK  ok

CREATE TABLE Pagos(
    id INTEGER NOT NULL PRIMARY KEY,
    fecha DATE NOT NULL,
    total DECIMAL(8,2) NOT NULL,
    estado CHAR(2) NOT NULL,
    numeroReserva INTEGER NOT NULL
);

-- 1 FK ok





-- UK's

ALTER TABLE Alojamientos ADD CONSTRAINT uk_nombre_alojamiento
UNIQUE KEY(nombre);

-- FK's

ALTER TABLE itinerariosTienenVuelos ADD CONSTRAINT fk_itinerario_vuelo
FOREIGN KEY(idVuelo) REFERENCES Vuelos(id);

ALTER TABLE itinerariosTienenVuelos ADD CONSTRAINT fk_itinerario_itinerario
FOREIGN KEY(idItinerario) REFERENCES Itinerarios(id);

ALTER TABLE Paquetes ADD CONSTRAINT fk_paquetes_itinerario
FOREIGN KEY(idItinerario) REFERENCES Itinerarios(id);

ALTER TABLE Paquetes ADD CONSTRAINT fk_paquetes_alojamiento
FOREIGN KEY(idAlojamiento) REFERENCES Alojamientos(id);

ALTER TABLE CorreosPorPersonas ADD CONSTRAINT fk_correo_tipo
FOREIGN KEY(tipoDocumento) REFERENCES Personas(tipoDocumento);

ALTER TABLE CorreosPorPersonas ADD CONSTRAINT fk_correo_numero
FOREIGN KEY(numeroDocumento) REFERENCES Personas(numeroDocumento);

ALTER TABLE Usuarios ADD CONSTRAINT fk_usuarios_tipo
FOREIGN KEY(tipoDocumento) REFERENCES Personas(tipoDocumento);

ALTER TABLE Usuarios ADD CONSTRAINT fk_usuarios_numero
FOREIGN KEY(numeroDocumento) REFERENCES Personas(numeroDocumento);

ALTER TABLE Reservas ADD CONSTRAINT fk_reservas_paquete
FOREIGN KEY(idPaquete) REFERENCES Paquetes(id);

ALTER TABLE Reservas ADD CONSTRAINT fk_reservas_tipo
FOREIGN KEY(tipoDocumentoUsuario) REFERENCES Personas(tipoDocumento);

ALTER TABLE Reservas ADD CONSTRAINT fk_reservas_numero
FOREIGN KEY(numeroDocumentoUsuario) REFERENCES Personas(numeroDocumento);

ALTER TABLE Pasajeros ADD CONSTRAINT fk_pasajeros_tipo
FOREIGN KEY(tipoDocumento) REFERENCES Personas(tipoDocumento);

ALTER TABLE Pasajeros ADD CONSTRAINT fk_pasajeros_numero
FOREIGN KEY(numeroDocumento) REFERENCES Personas(numeroDocumento);

ALTER TABLE Pasajeros ADD CONSTRAINT fk_pasajeros_reserva
FOREIGN KEY(numeroReserva) REFERENCES Reservas(numero);

ALTER TABLE Pagos ADD CONSTRAINT fk_pago_reserva
FOREIGN KEY(numeroReserva) REFERENCES Reservas(numero);

-- 2. Implementar restricciones de integridad declarativa
CREATE DOMAIN TEstado AS VARCHAR(2) CONSTRAINT
CHECK (VALUE IN('EP','AP', 'RC'));

CREATE DOMAIN TConsecutivo AS INT CONSTRAINT
CHECK(VALUE IN( TConsecutivo >= 1));

ALTER TABLE Pagos
ADD CONSTRAINT ck_fecha_pago
CHECK (NOT ( fecha_pago > SYSDATA));

ALTER TABLE Reservas
ADD CONSTRAINT ck_fecha_final_inicial
CHECK ( fecha_incial < fecha_final);

CREATE ASSERTION Herencia
CHECK ( NOT EXIST( SELECT COUNT(p.numeroDocumento)
FROM Personas p
JOIN Usuarios u ON u.numeroDocumento = p.numeroDocumento
JOIN Pasajeros a ON a.numeroDocumento = p.numeroDocumento
WHERE a.numeroDocumento = u.numeroDocumento)
AND COUNT > 0);

-- 3. Implementar integridad procedimental
CREATE TRIGGER Adicionar
BEFORE INSERT INTO Pagos
DECLARE costoTotal = 0
BEGIN
    IF( :NEW.pagoId IS NOT NULL THEN :NEW.pagoEstado = 'EP' AND :NEW.pagoFecha = CURRENT_DATA)
    END IF;

    IF(:NEW.pagoTotal = :NEW.costoTotal)
    END IF;

    IF(:NEW.pagoEstado = 'AP') REALICE_APPLICATION_ERROR(-20002, "No se puede adicionar el pago porque ya existe uno aprobado");

END Adicionar;

CREATE TRIGGER Modificar
BEFORE UPDATE INTO Pagos
DECLARE
BEGIN
    REALICE_APPLICATION_ERROR(-20001, "No se pueden modificar los pagos ") 
END Modificar;






