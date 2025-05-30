-- PRUEBAS TuplasOK (Datos válidos según restricciones de tuplas)

-- Equipo válido
INSERT INTO Equipos VALUES ('Cucuta', 'Rojo', 'Cucuta', 3, 1, 5000000, 'Ser campeón en los próximos 3 años');

-- Equipo válido
INSERT INTO Equipos VALUES ('Nacional', 'Verde', 'Medellín', 1, 1, 45000000, 'Mantener el primer puesto');

-- Jugador válido
INSERT INTO Jugadores VALUES (1010000001, 'Juan Perez', 'DEL', 1, 1000000, 'Cucuta');

-- Jugador válido
INSERT INTO Jugadores VALUES (1010000002, 'Carlos Sanchez', 'MED', 1, 2500000, 'Nacional');

-- Canterano válido (no extranjero)
INSERT INTO Canteranos VALUES (1010000001, 5, 'Juvenil', TO_DATE('2024-02-10', 'YYYY-MM-DD'));

-- Canterano válido
INSERT INTO Canteranos VALUES (1010000002, 3, 'Sub-20', TO_DATE('2023-06-15', 'YYYY-MM-DD'));

-- Extranjero válido
INSERT INTO Extranjeros VALUES (1010000002, 'Argentina', 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));

-- Representante válido
INSERT INTO Representantes VALUES (2010000001, 'Pedro Gomez', 3101234567, 10, 1010000001);

-- Representante válido
INSERT INTO Representantes VALUES (2010000002, 'Maria Lopez', 3209876543, 8, 1010000002);

-- Correo válido
INSERT INTO CorreosPorRepresentantes VALUES (2010000001, 'pedro.gomez@agencia.com');

-- Correo válido
INSERT INTO CorreosPorRepresentantes VALUES (2010000002, 'maria.lopez@agencia.com');

-- Contrato válido
INSERT INTO Contratos VALUES (1, '2 años', 5000000, 'Profesional', 10, 'Contrato profesional');

-- Contrato válido
INSERT INTO Contratos VALUES (2, '1 año', 3000000, 'Cantera', 5, 'Contrato juvenil');


-- Transferencia válida
INSERT INTO Transferencias VALUES (100000, 20000000, 'Traspaso completo', 'Nacional', 1, 1, 1010000001);

-- Transferencia válida
INSERT INTO Transferencias VALUES (100001, 15000000, 'Cesión con opción', 'Cucuta', 2, 1, 1010000002);


-- Préstamo válido
INSERT INTO Prestamos VALUES (1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-12-15', 'YYYY-MM-DD'), 1010000001, 'Nacional');

-- Préstamo válido
INSERT INTO Prestamos VALUES (2, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 1010000002, 'Cucuta');


-- Documentación válida
INSERT INTO Documentaciones VALUES (1, 'Pasaporte', TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2028-01-10', 'YYYY-MM-DD'), 'Migración Colombia', 1);

-- Documentación válida
INSERT INTO Documentaciones VALUES (2, 'Permiso trabajo', TO_DATE('2023-05-15', 'YYYY-MM-DD'), TO_DATE('2025-05-15', 'YYYY-MM-DD'), 'Ministerio Trabajo', 2);

-- Partido válido
INSERT INTO Partidos VALUES (10000, TO_TIMESTAMP('2025-06-20 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Bogotá');

-- Partido válido
INSERT INTO Partidos VALUES (2000, TO_TIMESTAMP('2025-06-25 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Medellín');


-- Resultado válido
INSERT INTO TieneResultadosDe VALUES ('Cucuta', 1, 2, 1, 3);

-- Resultado válido
INSERT INTO TieneResultadosDe VALUES ('Nacional', 2, 3, 0, 3);


-- Gerente válido
INSERT INTO Gerentes VALUES (3010000001, 'Luis Diaz', 3112345678, 15, 'Cucuta');

-- Gerente válido
INSERT INTO Gerentes VALUES (3010000002, 'Ana Torres', 3223456789, 12, 'Nacional');


-- Correo gerente válido
INSERT INTO CorreosPorGerentes VALUES (3010000001, 'luis.diaz@cucuta.com');

-- Correo gerente válido
INSERT INTO CorreosPorGerentes VALUES (3010000002, 'ana.torres@nacional.com');


-- Gerente deportivo válido
INSERT INTO Deportivos VALUES (3010000001, 85, 'Ofensivo');

-- Gerente deportivo válido
INSERT INTO Deportivos VALUES (3010000002, 90, 'Defensivo');


-- Gerente financiero válido
INSERT INTO Financieros VALUES (3010000001, 5);

-- Gerente financiero válido
INSERT INTO Financieros VALUES (3010000002, 8);


-- Estadio válido
INSERT INTO Estadios VALUES ('El Campín', 36000, 'Cucuta');

-- Estadio válido
INSERT INTO Estadios VALUES ('Atanasio Girardota', 45000, 'Nacional');


-- Hincha válido
INSERT INTO Hinchas VALUES (1020000001, 'Roberto Rodriguez', 1, 'Cucuta');

-- Hincha válido
INSERT INTO Hinchas VALUES (1020000002, 'Laura Martinez', 0, 'Nacional');

