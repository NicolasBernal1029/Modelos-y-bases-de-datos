-- PRUEBAS DisparadoresOK

-- Inserción inicial válida
INSERT INTO Contratos VALUES (100, '2 años', 5000000, 'Profesional', 10, 'Contrato inicial');

-- Actualización válida que solo modifica el detalle (trigger trg_modificar_solo_detalle lo permite)
UPDATE Contratos SET detalle = 'Contrato modificado' WHERE id = 100;


-- Insertar gerente primero
INSERT INTO Gerentes VALUES (4010000001, 'Juan Pérez', 3101234567, 10, 'Santa Fe');


-- Insertar 19 jugadores primero (para probar el límite de 20)
BEGIN
  FOR i IN 1..19 LOOP
    INSERT INTO Jugadores VALUES (1040000000+i, 'Jugador '||i, 'DEF', 1, 1000000, 'Santa Fe');
  END LOOP;
END;
/

-- Inserción válida del jugador 20 (trigger trg_limite_jugadores_por_equipo lo permite)
INSERT INTO Jugadores VALUES (1040000020, 'Último Jugador', 'DEL', 1, 5000000, 'Santa Fe');


-- Primero crear jugador, representante y contrato
INSERT INTO Jugadores VALUES (1100012122, 'Radamel Falcao', 'DEL', 1, 10000000, 'Millonarios');
INSERT INTO Representantes VALUES (50100001231, 'Repre Falcao', 3112345678, 10, 1100012122);
INSERT INTO Contratos VALUES (102212, '3 años', 8000000, 'Profesional', 15, 'Contrato estrella');

-- Transferencia válida (pasa todas las validaciones)
INSERT INTO Transferencias VALUES (1002, 20000000, 'Traspaso completo', 'Atletico Nacional', 102212, 1, 1100012122);


-- Préstamo válido por 6 meses (menos del máximo de 1 año)
INSERT INTO Prestamos VALUES (1001, TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-07-15', 'YYYY-MM-DD'),2000000100 , 'Santa Fe');


-- Actualización válida del nombre (único campo modificable según el trigger)
UPDATE Estadios 
SET nombre = 'Estadio Nemesio Camacho El Campín' 
WHERE nombre = 'El Campín';


-- Inserciones válidas (no activan límite de abonados)
INSERT INTO Hinchas VALUES (1110000001, 'Fan 1', 0, 'Millonarios');
INSERT INTO Hinchas VALUES (1110000002, 'Fan 2', 0, 'Millonarios');
INSERT INTO Hinchas VALUES (1110000003, 'Fan 3', 0, 'Millonarios');

-- Actualización permitida por el trigger
INSERT INTO Contratos VALUES (102, '1 año', 5000000, 'Profesional', 5, 'Contrato con bonos');
UPDATE Contratos 
SET detalle = 'Contrato con bonos por rendimiento' 
WHERE id = 102;


-- Jugador base
INSERT INTO Jugadores VALUES (1100000003, 'Kevin Mier', 'POR', 1, 5000000, 'Nacional');

-- Registro como canterano válido (añosEnCantera >= 1)
INSERT INTO Canteranos VALUES (1100000003, 4, 'Juvenil', TO_DATE('2020-03-15', 'YYYY-MM-DD'));


-- Jugador base
INSERT INTO Jugadores VALUES (1100000005, 'Juanfer Quintero', 'MED', 1, 12000000, 'Cucuta');

-- Registro como extranjero válido (documento de 10 dígitos)
INSERT INTO Extranjeros VALUES (1100000005, 'Argentina', 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'));


-- Correos únicos para representantes (validados por trigger)
INSERT INTO CorreosPorRepresentantes VALUES (50100001231, 'repre1@agencia.com');



-- Documentación con fecha emisión < vencimiento
INSERT INTO Documentaciones VALUES (102, 'Pasaporte', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2028-01-01', 'YYYY-MM-DD'), 'Migración Colombia', 102);


-- Partido válido (fecha futura)
INSERT INTO Partidos VALUES (1001, 
    TO_TIMESTAMP('2025-12-25 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
    'Bogotá');


-- Resultado válido
INSERT INTO TieneResultadosDe VALUES ('Cucuta', 1001, 2, 1, 3);
