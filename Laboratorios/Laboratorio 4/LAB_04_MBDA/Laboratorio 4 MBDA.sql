--Laboratorio 4 MBDA 2025
--Ejercicio C.Construccion Creando
--Hecho por: Nicolas Felipe Bernal Gallo y Juan Daniel Bogota Fuentes
--Fecha de creacion: 2025-03-25

CREATE TABLE Producto(
    nombre VARCHAR(5),
    precio VARCHAR(9)  --TMoneda agregado con el Alter Table
)

CREATE TABLE Desayuno(
    decoracion VARCHAR (10) CHECK (decoracion IN ('0', '1')),
    personas VARCHAR (3)  --Tpositivo agregado con el Alter Table
)

CREATE TABLE Basico(
    descripcion VARCHAR (10) CHECK (descripcion IN ('0', '1'))
)
CREATE TABLE Estilo (
    nombre VARCHAR (5),  --Tposicion agregado con el Alter Table
    descripcion VARCHAR (100)
)

CREATE TABLE Factura(
    numero INTEGER,   --LISTO EL TIPO LLAVE
    fecha DATE,
    entrega DATE,
    unidades VARCHAR(3),  --Tpositivo agregado con el Alter Table
    hora VARCHAR(5), --THora agregarlo con el Alter Table
    detalle VARCHAR (1000),
    total VARCHAR(9),  --TMoneda agregado con el Alter Table
    estado VARCHAR (10) NOT NULL, --Modificarle el TEstado con el Alter Table
    boleta VARCHAR (5)  --TBoleta agregado con el Alter Table /LISTO EL TIPO LLAVE
)
CREATE TABLE Cliente(
    cedula INTEGER,
    nombre VARCHAR (20),
    descuento INT(3) CHECK (descuento >= 0 AND descuento <= 100),
    direccion VARCHAR (100),
    telefono VARCHAR (10),
    correo VARCHAR (50),
    fecha DATE
);

CREATE TABLE SePiden (
    factura_numero INT(5),
    producto_nombre VARCHAR(5),
    unidades INT,
    CHECK (unidades > 0)--Nueva tabla creada
);
CREATE TABLE SeVendeEn (
    estilo_nombre VARCHAR(5),
    producto_nombre VARCHAR(5),
    precio DECIMAL(10,2)
);      --Nueva tabla creada

CREATE TABLE Campanas (
    ID INT,
    nombre VARCHAR(50),
    descripcion TEXT,
    presupuesto DECIMAL(10,2),
    fecha_inicio DATE,
    duracion INT
);      --Nueva tabla creada

CREATE TABLE Anuncios (
    identificador INT,
    nombreCampana VARCHAR(50),
    tituloDescripcion VARCHAR(255),
    fechaInicio DATE,
    fechaFin DATE,
    costoAsociado DECIMAL(10,2),
    estado TINYINT(1),
    campana_id INT
);    --Nueva tabla creada

CREATE TABLE Fisicos(
    direccion VARCHAR(20) CHECK (direccion IN ('0', '1')),
    dimensiones INTEGER,
);

CREATE TABLE Digitales(
    URL VARCHAR(100) CHECK (URL IN ('0', '1')),
    especificaciones TEspecificas VARCHAR(100) CHECK (especificaciones IN ('0', '1')),  --No lo tengo especificado en el Astah
    ListaRutasArchivos: TArchivos VARCHAR(100) CHECK (ListaRutasArchivos IN ('0', '1')),       --No lo tengo especificado en el Astah
);

CREATE TABLE PuedenSer(
    cantidad INT CHECK (cantidad > 0),
);


--Parte D Construccion Poblando
--INSERCIONES VALIDAS
INSERT INTO Producto (nombre, precio) VALUES ('Papas', '5000.00');
INSERT INTO Producto (nombre, precio) VALUES ('Jugo', '2000.00');
INSERT INTO Producto (nombre, precio) VALUES ('Cafe', '3000.00');
INSERT INTO Cliente (cedula,nombre,descuento,direccion,telefono,correo,fecha)   VALUES ()--Falta de datos
INSERT INTO Desayuno (decoracion, personas) VALUES ('1', '2');
INSERT INTO Desayuno (decoracion, personas) VALUES ('0', '1');
INSERT INTO Estilo (nombre, descripcion) VALUES ('E1', 'Estilo 1');
INSERT INTO Estilo (nombre, descripcion) VALUES ('E2', 'Estilo 2');
INSERT INTO Basico (descripcion) VALUES ('0');
INSERT INTO Basico (descripcion) VALUES ('1');
INSERT INTO Factura (numero, fecha, entrega, unidades, hora, detalle, total, estado, boleta) VALUES (1, '2025-03-06', '2025-03-06', '1', '10:00', 'Detalle', '10000', 'Pendiente', 'B1');
INSERT INTO Factura (numero, fecha, entrega, unidades, hora, detalle, total, estado, boleta) VALUES (2, '2025-03-06', '2025-03-07', '2', '12:00', 'Compra con error', '15000', 'Pendiente', 'B2');
INSERT INTO Producto VALUES ('P1', '10000');
INSERT INTO Producto VALUES ('P2', '20000');
INSERT INTO Factura VALUES (1, '2025-03-06', '2025-03-06', '1', '10:00', 'Detalle', '10000', 'Pendiente', 'B1');


--Eliminacion de datos en las tablas
DELETE FROM Producto WHERE nombre = 'Papas';
DELETE FROM Producto WHERE nombre = 'Jugo';
DELETE FROM Desayuno WHERE decoracion = '1' AND personas = '2';
DELETE FROM Estilo WHERE nombre = 'E1';
DELETE FROM Basico WHERE descripcion = '0';
DELETE FROM Factura WHERE numero = 1 AND fecha = '2025-03-06' AND entrega = '2025-03-06' AND unidades = '1' AND hora = '10:00' AND detalle = 'Detalle' AND total = '10000' AND estado = 'Pendiente' AND boleta = 'B1';

--INSERCIONES NO VALIDAS
--INSERT INTO Producto VALUES ('P1', '10000');  -- ERROR: Producto duplicado
--INSERT INTO Factura VALUES (1, '2025-03-06', '2025-03-06', '1', '10:00', 'Detalle', '10000', 'Pendiente', 'B1');  -- ERROR: Factura duplicada
--INSERT INTO Producto VALUES ('P3', '-5000');  -- ERROR: Precio debe ser positivo y multiplo de 100
--INSERT INTO Factura VALUES (2, '2025-03-06', '2025-03-07', -2, '12:00', 'Compra con error', 15000, 'Pendiente', 'B2');  -- ERROR: Unidades deben ser mayores que 0
--INSERT INTO Factura VALUES (3, '2025-03-06', '2025-03-07', 1, '14:00', 'Duplicado', 10000, 'Pendiente', 'B1');  -- ERROR: La boleta 'B1' ya existe


--Parte D Protegiendo
ALTER TABLE Producto ADD CONSTRAINT PK_Producto PRIMARY KEY (nombre);
ALTER TABLE Producto ADD CONSTRAINT CHK_Producto CHECK (precio > 0 AND MOD(precio, 100) = 0);--
ALTER TABLE Cliente ADD PRIMARY KEY (cedula);
ALTER TABLE Basico ADD PRIMARY KEY (nombre), ADD FOREIGN KEY (nombre) REFERENCES Producto(nombre);
ALTER TABLE Desayuno ADD PRIMARY KEY (nombre), ADD FOREIGN KEY (nombre) REFERENCES Producto(nombre);
ALTER TABLE Desayuno ADD CONSTRAINT CHK_Desayuno CHECK (personas > 0);
ALTER TABLE Estilo ADD CONSTRAINT PK_Estilo PRIMARY KEY (nombre);
ALTER TABLE Factura ADD CONSTRAINT PK_Factura PRIMARY KEY (numero);
ALTER TABLE Factura ADD CONSTRAINT CHK_Factura_Total CHECK (total > 0 AND MOD(total, 100) = 0);--
ALTER TABLE Factura ADD CONSTRAINT CHK_Factura_Unidades CHECK (unidades > 0);
ALTER TABLE Factura ADD CONSTRAINT UK_Factura UNIQUE (boleta);
ALTER TABLE SeVendeEn ADD PRIMARY KEY (estilo_nombre, producto_nombre), ADD FOREIGN KEY (estilo_nombre) REFERENCES Estilo(nombre), ADD FOREIGN KEY (producto_nombre) REFERENCES Producto(nombre);
ALTER TABLE SePiden ADD PRIMARY KEY (factura_numero, producto_nombre), ADD FOREIGN KEY (factura_numero) REFERENCES Factura(numero), ADD FOREIGN KEY (producto_nombre) REFERENCES Producto(nombre);
ALTER TABLE Campanas ADD PRIMARY KEY (ID);
ALTER TABLE Anuncios ADD PRIMARY KEY (identificador), ADD FOREIGN KEY (campana_id) REFERENCES Campanas(ID);


--Hacer las consultas Gerenciales como Operativas
--Administrador: Consultar Productos más vendidos
SELECT p.nombre, SUM(sp.unidades) AS total_vendido
FROM Producto p
JOIN SePiden sp ON p.nombre = sp.producto_nombre
GROUP BY p.nombre
ORDER BY total_vendido DESC;
--Administrador: Consultar Productos más solicitados
SELECT p.nombre, SUM(sp.unidades) AS total_solicitado
FROM Producto p
JOIN SePiden sp ON p.nombre = sp.producto_nombre
GROUP BY p.nombre
ORDER BY total_solicitado DESC;

--Vendedor: Consultar la historia de mis compras
SELECT f.numero, f.fecha, f.unidades, f.hora, f.detalle, f.total, f.estado, c.nombre AS cliente_nombre
FROM Factura f
JOIN Cliente c ON f.cedula = c.cedula
WHERE f.cedula = 'C1';  -- Cambiar 'C1' por el ID del vendedor actual
--Publicista: Consultar reportes de campañas activas
SELECT c.nombre, c.descripcion, c.presupuesto, c.fecha_inicio, c.duracion
FROM Campanas c
WHERE c.fecha_inicio <= CURDATE() AND c.fecha_inicio + INTERVAL c.duracion DAY >= CURDATE();

--Marketing: Consultar estrategias nuevas para ventas
SELECT e.nombre, e.descripcion, e.precio
FROM Estilo e
JOIN SeVendeEn se ON e.nombre = se.estilo_nombre
JOIN Producto p ON se.producto_nombre = p.nombre
WHERE e.precio < 10000;  -- Cambiar el precio según la estrategia deseada

--Hacer las funciones


--Consulta para Responsable de Diseño: Consultar desayunos
SELECT * FROM Desayuno;
--Mantener Desayunos
INSERT INTO Desayuno (decoracion, personas) VALUES ('1', '3');
UPDATE Desayuno SET decoracion = '1' WHERE personas = '2';
DELETE FROM Desayuno WHERE personas = '1';
--Mantener Estilos
INSERT INTO Estilo (nombre, descripcion) VALUES ('E3', 'Estilo 3');
UPDATE Estilo SET descripcion = 'Estilo 1 Modificado' WHERE nombre = 'E1';
DELETE FROM Estilo WHERE nombre = 'E2';
--Mantener Unidades
INSERT INTO Unidad (nombre, descripcion) VALUES ('U1', 'Unidad 1');
INSERT INTO Unidad (nombre, descripcion) VALUES ('U2', 'Unidad 2');
UPDATE Unidad SET descripcion = 'Unidad 1 Modificada' WHERE nombre = 'U1';
DELETE FROM Unidad WHERE nombre = 'U2';

--Consulta para vendedor: Mantener Cliente
INSERT INTO Cliente (cedula, nombre, telefono) VALUES ('C1', 'Juan', '1234567890');
INSERT INTO Cliente (cedula, nombre, telefono) VALUES ('C2', 'Maria', '0987654321');
UPDATE Cliente SET telefono = '1111111111' WHERE cedula = 'C1';
DELETE FROM Cliente WHERE cedula = 'C2';
--Registrar Venta
INSERT INTO Factura (numero, fecha, fecha_pago, unidades, hora, descripcion, total, estado, boleta) VALUES (1, '2025-03-06', '2025-03-06', 1, '10:00', 'Venta de Producto', 10000, 'Pendiente', 'B1');
INSERT INTO Factura (numero, fecha, fecha_pago, unidades, hora, descripcion, total, estado, boleta) VALUES (2, '2025-03-06', '2025-03-07', 2, '12:00', 'Venta de Producto con error', 15000, 'Pendiente', 'B2');

--Consulta Logistica: Registrar inventario
INSERT INTO SePiden (factura_numero, producto_nombre, unidades) VALUES (1, 'P1', 2);
INSERT INTO SePiden (factura_numero, producto_nombre, unidades) VALUES (2, 'P2', 3);

--Cociner consultas: Registrar inventario
INSERT INTO SePiden (factura_numero, producto_nombre, unidades) VALUES (1, 'P1', 2);
INSERT INTO SePiden (factura_numero, producto_nombre, unidades) VALUES (2, 'P2', 3);
--Mantener Productos
INSERT INTO Producto (nombre, precio) VALUES ('P1', '10000');
INSERT INTO Producto (nombre, precio) VALUES ('P2', '20000');
UPDATE Producto SET precio = '15000' WHERE nombre = 'P1';
DELETE FROM Producto WHERE nombre = 'P2';


--Punto Dos. Uso de disparadores

--Caso de Uso 1: Registrar venta
--Trigger para validar el estado de la factura
CREATE TRIGGER EST_FACTURA
BEFORE INSERT ON Factura
FOR EACH ROW
BEGIN
    IF NEW.estado NOT IN ('normal', 'entregado') THEN
        SET MESSAGE = 'Estado no válido. Debe ser normal o entregado.';
    END IF;
END;

--Trigger para asegurar que el pago se realiza contraentrega
CREATE TRIGGER PAGO_CONTRAENTREGA
BEFORE INSERT ON Factura
FOR EACH ROW
BEGIN
    IF NEW.estado = 'entregado' AND NEW.fecha_pago IS NULL THEN
        SET MESSAGE = 'El pago debe ser contraentrega.';
    END IF;
END;

--Trigger para evitar eliminacion de las ventas
CREATE TRIGGER NO_ELIMINAR_VENTA
BEFORE DELETE ON Factura
FOR EACH ROW
BEGIN
    SET MESSAGE = 'No se puede eliminar una venta.';
END;

-- Caso de Uso 2: Registrar anuncio (Hecho en el Astah)
