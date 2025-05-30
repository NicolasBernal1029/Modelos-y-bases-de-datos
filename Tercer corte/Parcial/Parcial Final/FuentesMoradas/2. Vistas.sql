-- Definición de vistas


-- Vista para mostrar los jugadores activos

CREATE VIEW Vista_Jugadores_Activos AS
SELECT documento, nombre, posicion, valorMercado, nombreEquipo
FROM Jugadores
WHERE estado = 1;

-- Vista para mostrar los jugadores inactivos
CREATE VIEW Vista_Jugadores_Inactivos AS
SELECT documento, nombre, posicion, valorMercado, nombreEquipo
FROM Jugadores
WHERE estado = 0;

--  Vista de Transferencias recientes
CREATE VIEW Vista_Transferencias_Recientes AS
SELECT numero, valor, nombreEquipo, documentoJugador
FROM Transferencias
WHERE epocaDeTransferencias = 1;


-- Vista para Consultar Contratos en Temporada de Fichajes de Verano
CREATE VIEW Vista_Contratos_Verano AS
SELECT c.id, c.duracion, c.sueldo, c.rol, c.bono, c.detalle, t.numero AS transferencia, t.valor, j.nombre AS jugador, j.nombreEquipo 
FROM Contratos c
JOIN Transferencias t ON c.id = t.idContrato
JOIN Jugadores j ON t.documentoJugador = j.documento
WHERE t.epocaDeTransferencias = 1;


-- Vista para Consultar Partidos de un Equipo
CREATE OR REPLACE VIEW Vista_Partidos_Equipo AS
SELECT 
    tr.nombreEquipo,
    p.idPartido,
    p.fecha,
    p.ciudad,
    tr.golesAFavor,
    tr.golesEnContra,
    tr.puntos
FROM TieneResultadosDe tr
JOIN Partidos p ON tr.idPartido = p.idPartido;

-- Vista para Consultar Resultados de Partidos por Equipo
CREATE VIEW Vista_Resultados_Partidos AS
SELECT 
    tr.nombreEquipo,
    p.idPartido,
    p.fecha,
    p.ciudad,
    tr.golesAFavor,
    tr.golesEnContra,
    CASE 
        WHEN tr.golesAFavor > tr.golesEnContra THEN 'Victoria'
        WHEN tr.golesAFavor < tr.golesEnContra THEN 'Derrota'
        ELSE 'Empate'
    END AS resultado
FROM TieneResultadosDe tr
JOIN Partidos p ON tr.idPartido = p.idPartido;

-- Vista para Consultar Lugar de los Partidos por Equipo
CREATE OR REPLACE VIEW Vista_Lugar_Partidos AS
SELECT 
    tr.nombreEquipo,
    p.idPartido,
    p.fecha,
    p.ciudad,
    e.nombre AS estadio
FROM TieneResultadosDe tr
JOIN Partidos p ON tr.idPartido = p.idPartido
JOIN Equipos eq ON tr.nombreEquipo = eq.nombre
JOIN Estadios e ON eq.nombre = e.nombreEquipo;
