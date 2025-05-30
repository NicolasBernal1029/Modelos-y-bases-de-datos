--Consultas
 -- CONSULTAS GERENCIALES

 --Consultar gasto en sueldo de jugadores por Temporada (1 año)

SELECT 
    j.nombreEquipo AS Equipo,
    SUM(c.sueldo) AS GastoTotalSueldo
FROM 
    Jugadores j
JOIN 
    Contratos c ON j.documento = c.id
WHERE 
    c.duracion LIKE '%año%'  -- Filtra los contratos por un año
GROUP BY 
    j.nombreEquipo
ORDER BY 
    GastoTotalSueldo DESC;

 --Consultar gasto en Fichajes por Temporada (1 Año)

SELECT 
    EXTRACT(YEAR FROM D.fechaEmision) AS temporada,
    SUM(T.valor) AS gasto_total_fichajes
FROM 
    Transferencias T
JOIN 
    Contratos C ON T.idContrato = C.id
JOIN 
    Documentaciones D ON D.idContrato = C.id
GROUP BY 
    EXTRACT(YEAR FROM D.fechaEmision)
ORDER BY 
    temporada DESC;



 --Consulta la mison deportiva del club por Temporada (1 Año)
 
SELECT 
    E.nombre AS equipo,
    E.mision AS mision_deportiva,
    EXTRACT(YEAR FROM D.fechaEmision) AS temporada
FROM 
    Equipos E
JOIN 
    Transferencias T ON T.nombreEquipo = E.nombre
JOIN 
    Contratos C ON T.idContrato = C.id
JOIN 
    Documentaciones D ON C.id = D.idContrato
GROUP BY 
    E.nombre, E.mision, EXTRACT(YEAR FROM D.fechaEmision)
ORDER BY 
    temporada DESC;


 -- CONSULTAS OPERATIVAS

-- Consultar contrato de jugador en temporada de fichajes de verano (3 meses)

SELECT 
    j.nombre AS NombreJugador,
    j.posicion AS Posicion,
    j.nombreEquipo AS EquipoActual,
    c.id AS IdContrato,
    c.duracion AS Duracion,
    c.sueldo AS Sueldo,
    c.rol AS Rol,
    c.bono AS Bono,
    c.detalle AS Detalle
FROM Jugadores j
JOIN Transferencias t ON j.nombreEquipo = t.nombreEquipo
JOIN Contratos c ON t.idContrato = c.id
WHERE t.epocaDeTransferencias = 1;

-- Consultar cuando juega el equipo 

SELECT 
    p.idPartido AS ID_Partido,
    p.fecha AS Fecha,
    p.ciudad AS Ciudad,
    t.golesAFavor AS GolesAFavor,
    t.golesEnContra AS GolesEnContra,
    t.puntos AS Puntos
FROM Partidos p
JOIN TieneResultadosDe t ON p.idPartido = t.idPartido
WHERE t.nombreEquipo = 'Millonarios'
ORDER BY p.fecha ASC;


-- Consultar el resultado del partido del equipo

SELECT 
    p.idPartido AS ID_Partido,
    p.fecha AS Fecha,
    p.ciudad AS Ciudad,
    t.golesAFavor AS GolesAFavor,
    t.golesEnContra AS GolesEnContra,
    CASE 
        WHEN t.golesAFavor > t.golesEnContra THEN 'Victoria'
        WHEN t.golesAFavor < t.golesEnContra THEN 'Derrota'
        ELSE 'Empate'
    END AS Resultado
FROM Partidos p
JOIN TieneResultadosDe t ON p.idPartido = t.idPartido
WHERE t.nombreEquipo = 'NOMBRE_DEL_EQUIPO'
ORDER BY p.fecha DESC;


-- Consultar donde juega el partido el equipo

SELECT 
    p.idPartido AS ID_Partido,
    p.fecha AS Fecha,
    p.ciudad AS Ciudad
FROM Partidos p
JOIN TieneResultadosDe t ON p.idPartido = t.idPartido
WHERE t.nombreEquipo = 'NOMBRE_DEL_EQUIPO'
ORDER BY p.fecha ASC;


SELECT * FROM Equipos;