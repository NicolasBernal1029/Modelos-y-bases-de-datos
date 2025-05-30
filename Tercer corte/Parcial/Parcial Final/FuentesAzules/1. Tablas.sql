/**
    * @file FuentesAzules.sql
    * @brief Script de creacion de base de datos para Liga BetPlay Stats
    * @version 1.0
    * @date 2025-03-22
    * @creator Nicolas Bernal y Juan Bogotá
    */

CREATE TABLE Equipos (
    nombre VARCHAR(50) NOT NULL,
    color VARCHAR(50)NOT NULL,
    ciudad VARCHAR(50)NOT NULL,
    posicion INT NOT NULL,
    estado NUMBER(1) NOT NULL,
    presupuesto NUMBER NOT NULL,
    mision VARCHAR(200) NOT NULL
);

CREATE TABLE Hinchas (
    cedula INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    abonado NUMBER(1) NOT NULL,
    nombreEquipo VARCHAR(50) NOT NULL
);

CREATE TABLE Partidos(
    idPartido INT NOT NULL, 
    fecha TIMESTAMP NOT NULL,
    ciudad VARCHAR(50) NOT NULL
);

CREATE TABLE Estadios (
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    nombreEquipo VARCHAR(50) NOT NULL
    );

CREATE TABLE TieneResultadosDe(
    nombreEquipo VARCHAR(50) NOT NULL,
    idPartido INT NOT NULL,
    golesAFavor INT NOT NULL,
    golesEnContra INT NOT NULL,
    puntos INT NOT NULL
);

CREATE TABLE Jugadores (
    documento INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    posicion VARCHAR(3) NOT NULL,
    estado NUMBER(1) NOT NULL,
    valorMercado NUMBER NOT NULL,
    nombreEquipo VARCHAR(50) NOT NULL  
);

CREATE TABLE Canteranos (
    documento INT NOT NULL,
    añosEnCantera INT NOT NULL,
    categoriaFormacion VARCHAR(10) NOT NULL,
    primerContrato DATE NOT NULL
);

CREATE TABLE Extranjeros (
    documento INT NOT NULL,
    paisOrigen VARCHAR(100)NOT NULL,
    permisoTrabajo NUMBER(1) NOT NULL,
    fechaLlegada DATE NOT NULL
);

CREATE TABLE Representantes(
    documento INT NOT NULL,
    nombre VARCHAR(100)NOT NULL,
    telefono INT,
    experiencia INT NOT NULL,
    documentoJugador INT NOT NULL
);

CREATE TABLE CorreosPorRepresentantes(
    documentoRepresentante INT NOT NULL,
    correo VARCHAR(50) NOT NULL
);

CREATE TABLE Prestamos(
    id INT NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFinal DATE NOT NULL,
    documentoJugador INT NOT NULL,
    nombreEquipo VARCHAR(50) NOT NULL
);

CREATE TABLE Contratos(
    id INT NOT NULL,
    duracion VARCHAR(20) NOT NULL,
    sueldo NUMBER NOT NULL,
    rol VARCHAR(20) NOT NULL,
    bono NUMBER NOT NULL,
    detalle VARCHAR(50) NOT NULL
);

CREATE TABLE Transferencias(
    numero INT NOT NULL,
    valor NUMBER NOT NULL,
    detalle VARCHAR(100) NOT NULL,
    nombreEquipo VARCHAR(50) NOT NULL,
    idContrato INT NOT NULL,
    epocaDeTransferencias NUMBER(1) NOT NULL,
    documentoJugador INT NOT NULL
);

CREATE TABLE Documentaciones(
    id INT NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    fechaEmision DATE NOT NULL,
    fechaVencimiento DATE NOT NULL,
    autoridadEmisora VARCHAR(50) NOT NULL,
    idContrato INT NOT NULL
);

CREATE TABLE Gerentes(
    documento INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    telefono INT,
    experiencia INT NOT NULL,
    nombreEquipo VARCHAR(50) NOT NULL
);

CREATE TABLE CorreosPorGerentes(
    documentoGerente INT NOT NULL,
    correo VARCHAR(50) NOT NULL
);

CREATE TABLE Financieros(
    documento INT NOT NULL,
    cantidadDePatrocinadoresConseguidos INT NOT NULL 
);

CREATE TABLE Deportivos(
    documento INT NOT NULL,
    rendimineto INT NOT NULL,
    estilo VARCHAR(20) NOT NULL
);

CREATE TABLE Errores(
    id VARCHAR(400) NOT NULL,
    mensaje VARCHAR(250) NOT NULL,
    fechaYHora TIMESTAMP NOT NULL,
    operacion VARCHAR(7) NOT NULL,
    severidad VARCHAR(30) NOT NULL,
    granConcepto VARCHAR(100) NOT NULL,
    actorResponsable VARCHAR(100) NOT NULL,
    nombreEquipo VARCHAR(50)
)

CREATE TABLE Evidencias(
    id INT NOT NULL,
    idError VARCHAR(400) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    rutaAsociada VARCHAR(20),
    fecha DATE NOT NULL
)

CREATE TABLE Notificaciones(
    id INT NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    correoInstitucional VARCHAR(50) NOT NULL,
    fechaYHora TIMESTAMP NOT NULL,
    idError VARCHAR(400) NOT NULL
)

COMMIT;