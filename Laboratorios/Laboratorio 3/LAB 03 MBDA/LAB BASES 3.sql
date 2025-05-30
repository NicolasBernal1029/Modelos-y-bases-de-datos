--Laboratorio 3 MBDA 2025
--Ejercicio C.Construccion Creando
--Hecho por: Nicolas Felipe Bernal Gallo y Juan Daniel Bogota Fuentes
--Fecha de creacion: 2025-03-06

CREATE TABLE Producto(
    nombre VARCHAR(5),
    precio DECIMAL(9, 2)  --TMoneda agregado con el Alter Table 
);

CREATE TABLE Desayuno(
    decoracion VARCHAR (10) CHECK (decoracion IN ('0', '1')),
    personas INTEGER  --Tpositivo agregado con el Alter Table
);

CREATE TABLE Basico(
    descripcion VARCHAR (10) CHECK (descripcion IN ('0', '1'))  --Hecho con el Alter table
);

CREATE TABLE Estilo (
    nombre VARCHAR (5),  --Tposicion agregado con el Alter Table
    descripcion VARCHAR (100)
);

CREATE TABLE Factura(
    numero INTEGER,   --LISTO EL TIPO LLAVE
    fecha DATE,
    entrega DATE,
    unidades INTEGER,  --Tpositivo agregado con el Alter Table
    hora VARCHAR(5), --THora agregarlo con el Alter Table
    detalle VARCHAR (1000),
    total DECIMAL(9, 2),  --TMoneda agregado con el Alter Table
    estado VARCHAR (10) NOT NULL, --Modificarle el TEstado con el Alter Table
    boleta VARCHAR (5)  --TBoleta agregado con el Alter Table /LISTO EL TIPO LLAVE
);

CREATE TABLE Cliente(
    cedula INTEGER,
    nombre VARCHAR (20),
    descuento DECIMAL(5, 2),
    direccion VARCHAR (100),
    telefono VARCHAR (10),
    correo VARCHAR (50),
    fecha DATE
);

CREATE TABLE Campaña(
    Id VARCHAR(50),
    nombre VARCHAR(30),
    descripcion VARCHAR (100),
    presupuesto VARCHAR(20),
    fechaInicio fecha,
    duracion  INT
);

CREATE TABLE Anuncio(
    Id VARCHAR(10),
    tituloDescriptivo VARCHAR(30),
    fechaInicio fecha,
    fechaFin fecha,
    costo VARCHAR(500),
    estado VARCHAR(20)
);
    



ALTER TABLE Producto ADD CONSTRAINT PK_Producto PRIMARY KEY (nombre);
ALTER TABLE Producto ADD CONSTRAINT CHK_Producto CHECK (precio > 0 AND MOD(precio, 100) = 0);
ALTER TABLE Desayuno ADD CONSTRAINT CHK_Desayuno CHECK (personas > 0);
ALTER TABLE Estilo ADD CONSTRAINT PK_Estilo PRIMARY KEY (nombre);
ALTER TABLE Factura ADD CONSTRAINT PK_Factura PRIMARY KEY (numero);
ALTER TABLE Factura ADD CONSTRAINT CHK_Factura_Total CHECK (total > 0 AND MOD(total, 100) = 0);
ALTER TABLE Factura ADD CONSTRAINT CHK_Factura_Unidades CHECK (unidades > 0);
ALTER TABLE Factura ADD CONSTRAINT UK_Factura UNIQUE (boleta);


-- D
INSERT INTO Producto VALUES ('P1', '10000');
INSERT INTO Producto VALUES ('P2', '20000');
INSERT INTO Factura VALUES (1, '2025-03-06', '2025-03-06', '1', '10:00', 'Detalle', '10000', 'Pendiente', 'B1');

INSERT INTO Producto VALUES ('P3', '-5000');  -- ERROR: Precio debe ser positivo y multiplo de 100
INSERT INTO Factura VALUES (2, '2025-03-06', '2025-03-07', -2, '12:00', 'Compra con error', 15000, 'Pendiente', 'B2');  -- ERROR: Unidades deben ser mayores que 0
INSERT INTO Factura VALUES (3, '2025-03-06', '2025-03-07', 1, '14:00', 'Duplicado', 10000, 'Pendiente', 'B1');  -- ERROR: La boleta 'B1' ya existe

INSERT INTO Cliente (cedula, nombre, descuento, direccion, telefono, correo, fecha)
VALUES (12345, '', 10.0, 'Calle 123', '3001234567', 'cliente@email.com', '2025-03-06');  

INSERT INTO Cliente (cedula, nombre, descuento, direccion, telefono, correo, fecha)
VALUES (54321, 'Carlos Rojas', 5.0, 'Avenida 456', '1234', 'carlos@email.com', '2025-03-06');

INSERT INTO Factura VALUES (4, '2025-03-06', '2025-03-07', 1, '16:00', 'Estado inválido', 5000, 'En proceso', 'B3');  



