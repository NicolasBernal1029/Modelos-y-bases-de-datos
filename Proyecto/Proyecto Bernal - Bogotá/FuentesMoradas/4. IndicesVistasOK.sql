-- Consultas que aprovechan índices y vistas

--Utiliza índices

-- 1. Consulta de equipos por ciudad 
SELECT nombre, color, presupuesto 
FROM Equipos 
WHERE ciudad = 'Bogota';

-- 2. Consulta de equipos por rango de presupuesto 
SELECT nombre, ciudad, presupuesto 
FROM Equipos 
WHERE presupuesto BETWEEN 0 AND 123123123
ORDER BY presupuesto DESC;

-- 3. Consulta de hinchas por equipo 
SELECT cedula, nombre 
FROM Hinchas 
WHERE nombreEquipo = 'Millonarios';

-- 4. Consulta de partidos por fecha 
SELECT idPartido, ciudad 
FROM Partidos 
WHERE fecha BETWEEN TO_DATE('2025-06-01', 'YYYY-MM-DD') AND TO_DATE('2025-12-31', 'YYYY-MM-DD');

-- 5. Consulta de jugadores por posición 
SELECT nombre, valorMercado, nombreEquipo 
FROM Jugadores 
WHERE posicion = 'DEL' AND estado = 1
ORDER BY valorMercado DESC;

-- 6. Consulta de jugadores por valor de mercado 
SELECT nombre, posicion, nombreEquipo, valorMercado 
FROM Jugadores 
WHERE valorMercado > 10000
ORDER BY valorMercado DESC;

-- 7. Consulta de canteranos por categoría 
SELECT j.nombre, c.añosEnCantera, c.categoriaFormacion
FROM Jugadores j
JOIN Canteranos c ON j.documento = c.documento
WHERE c.categoriaFormacion = 'Juvenil';

-- 8. Consulta de extranjeros por país 
SELECT j.nombre, e.paisOrigen, e.fechaLlegada 
FROM Jugadores j
JOIN Extranjeros e ON j.documento = e.documento
WHERE e.paisOrigen = 'Argentina';

-- 9. Consulta de transferencias por valor 
SELECT t.numero, t.valor, j.nombre AS jugador, t.nombreEquipo AS equipo_destino
FROM Transferencias t
JOIN Jugadores j ON t.documentoJugador = j.documento
WHERE t.valor > 100
ORDER BY t.valor DESC;

-- 10. Consulta de documentos próximos a vencer 
SELECT d.id, d.tipo, d.fechaVencimiento, j.nombre AS jugador
FROM Documentaciones d
JOIN Contratos c ON d.idContrato = c.id
JOIN Transferencias t ON c.id = t.idContrato
JOIN Jugadores j ON t.documentoJugador = j.documento
WHERE d.fechaVencimiento BETWEEN SYSDATE AND ADD_MONTHS(SYSDATE, 3);


--Utilizan vistas


-- 11. Consulta de jugadores activos 
SELECT * FROM Vista_Jugadores_Activos 
WHERE nombreEquipo = 'Atletico Nacional'
ORDER BY valorMercado DESC;

-- 12. Consulta de jugadores inactivos 
SELECT * FROM Vista_Jugadores_Inactivos 
WHERE posicion = 'MED';

-- 13. Consulta de transferencias recientes 
SELECT v.numero, v.valor, e.ciudad AS ciudad_equipo, j.nombre AS jugador
FROM Vista_Transferencias_Recientes v
JOIN Equipos e ON v.nombreEquipo = e.nombre
JOIN Jugadores j ON v.documentoJugador = j.documento;

-- 14. Consulta de contratos de verano 
SELECT jugador, duracion, sueldo, valor AS valor_transferencia, nombreEquipo
FROM Vista_Contratos_Verano
WHERE sueldo > 20000;

-- 15. Consulta de partidos por equipo 
SELECT idPartido, fecha, ciudad, golesAFavor, golesEnContra, puntos
FROM Vista_Partidos_Equipo
WHERE nombreEquipo = 'Millonarios'
ORDER BY fecha DESC;

-- 16. Consulta de resultados por equipo 
SELECT idPartido, fecha, resultado, golesAFavor, golesEnContra
FROM Vista_Resultados_Partidos
WHERE nombreEquipo = 'Millonarios' AND resultado = 'Victoria';

-- 17. Consulta de lugares de partido 
SELECT idPartido, fecha, ciudad
FROM Vista_Lugar_Partidos
WHERE nombreEquipo = 'Millonarios';

-- 18. Consulta combinada de vista e índice 
SELECT documento, nombre, valorMercado
FROM Vista_Jugadores_Activos
WHERE valorMercado > (SELECT AVG(valorMercado) FROM Vista_Jugadores_Activos)
ORDER BY valorMercado DESC;

-- 19. Consulta de rendimiento del gerente deportivo 
SELECT g.nombreEquipo, d.rendimineto, d.estilo, COUNT(v.documento) AS jugadores_activos
FROM Gerentes g
JOIN Deportivos d ON g.documento = d.documento
JOIN Equipos e ON g.nombreEquipo = e.nombre
JOIN Vista_Jugadores_Activos v ON e.nombre = v.nombreEquipo
GROUP BY g.nombreEquipo, d.rendimineto, d.estilo
ORDER BY d.rendimineto DESC;

-- 20. Consulta de presupuesto vs. rendimiento  del gerente deportivo 
SELECT e.nombre, e.presupuesto, d.rendimineto AS rendimiento_deportivo
FROM Equipos e
JOIN Gerentes g ON e.nombre = g.nombreEquipo
JOIN Deportivos d ON g.documento = d.documento
ORDER BY e.presupuesto DESC;