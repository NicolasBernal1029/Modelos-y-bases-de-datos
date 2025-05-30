-- PoblarNoOk.sql

-- Equipos
INSERT INTO Equipos VALUES ('Millonarios', 'Azul', 'Bogota', 1, 1, 500000, 'Ganar la liga');
INSERT INTO Equipos VALUES ('NuevoEquipo', NULL, 'Cartagena', 21, 1, 1000000, 'Objetivo');
INSERT INTO Equipos VALUES ('EquipoX', 'Morado', 'Cúcuta', 5, 1, -1000, 'Descenso');
INSERT INTO Equipos VALUES ('EquipoY', 'Rojo', 'Pasto', 1000, 1, 300000, NULL);
INSERT INTO Equipos VALUES ('EquipoZMuyLargoNombreDemasiadoasdasdsadasdasdsadadasdadadsadasdadasdadadasdsadadaasdasdsasdadadasdasdadadasdasdsa', 'Verde', 'Medellín', 3, 1, 200000, 'OK');

-- Hinchas
INSERT INTO Hinchas VALUES ('1234567890', 'Pedro Ramirez', 1, 'Millonarios');
INSERT INTO Hinchas VALUES ('abc', 'Ana Pérez', 1, 'Santa Fe');
INSERT INTO Hinchas VALUES (1001, 'Luis Gómez', 1, 'EquipoFantasma');
INSERT INTO Hinchas VALUES (1002, 'María López', 2, 'Bunior');
INSERT INTO Hinchas VALUES (1003, NULL, 1, 'Tolima');

-- Partidos
INSERT INTO Partidos VALUES (1, TIMESTAMP '2025-07-03 25:00:00', 'Santa Marta');
INSERT INTO Partidos VALUES (2, TIMESTAMP '2025-07-05 18:30:00', 'Cali');
INSERT INTO Partidos VALUES (3, TIMESTAMP '2025-07-07 17:00:00', NULL);
INSERT INTO Partidos VALUES (4, TIMESTAMP '07/09/2025 20:00:00', 'Barranquilla');
INSERT INTO Partidos VALUES (5, NULL, 'Pasto');

-- Estadios
INSERT INTO Estadios VALUES (NULL, 36000, 'Millonarios', 1);
INSERT INTO Estadios VALUES ('Nuevo Estadio', -1000, 'Cali', 6);
INSERT INTO Estadios VALUES ('EstadioX', 20000, 'EquipoFantasma', 7);
INSERT INTO Estadios VALUES ('Atanasio Girardot', 40000, 'Atletico Nacional', 2);
INSERT INTO Estadios VALUES ('EstadioZ', 'veinte mil', 'Bucaramanga', 12);

-- TieneResultadosDe
INSERT INTO TieneResultadosDe VALUES ('EquipoX', 1, 1, 1, 1);
INSERT INTO TieneResultadosDe VALUES ('Millonarios', -1, 2, 3, 4);
INSERT INTO TieneResultadosDe VALUES ('Santa Fecito', 2, 2, 2, 10);
INSERT INTO TieneResultadosDe VALUES ('Junior', 15, 2, 2, 1);
INSERT INTO TieneResultadosDe VALUES (NULL, 0, 0, 0, 0);

-- Jugadores
INSERT INTO Jugadores VALUES (2000000000, 'Juan Perez', 'DEL', 1, 1000000, 'Millonarios');
INSERT INTO Jugadores VALUES (2000000500, 'Pedro Díaz', 'XYZ', 1, 500000, 'Santa Fecito');
INSERT INTO Jugadores VALUES (2000000600, 'Ana Gómez', 'MED', NULL, 300000, 'Tolima');
INSERT INTO Jugadores VALUES (2000000700, 'Luis Ruiz', 'DEF', 1, 'quinientos', 'Cali');
INSERT INTO Jugadores VALUES (2000000800, 'Marta Castro', 'DEL', 1, 400000, 'EquipoX');

-- Canteranos
INSERT INTO Canteranos VALUES (2000000000, 2, 'Sub-30', TO_DATE('2025-01-01','YYYY-MM-DD'));
INSERT INTO Canteranos VALUES (2000001000, -3, 'Sub-18', TO_DATE('2020-01-01','YYYY-MM-DD'));
INSERT INTO Canteranos VALUES (2000002000, 2, 'Veterano', TO_DATE('2022-05-05','YYYY-MM-DD'));
INSERT INTO Canteranos VALUES (2000003000, 1, 'Sub-20', TO_DATE('2030-01-01','YYYY-MM-DD'));
INSERT INTO Canteranos VALUES (NULL, 1, 'Sub-16', TO_DATE('2021-01-01','YYYY-MM-DD'));

-- Extranjeros
INSERT INTO Extranjeros VALUES (2000000100, 'Brasil', 1, TO_DATE('2019-01-01','YYYY-MM-DD'));
INSERT INTO Extranjeros VALUES (2000010000, 'Argentina', NULL, TO_DATE('2020-01-01','YYYY-MM-DD'));
INSERT INTO Extranjeros VALUES (2000020000, 'España', 1, TO_DATE('2021-01-01','YYYY-MM-DD'));
INSERT INTO Extranjeros VALUES (2000030000, 'Chile', 1, TO_DATE('2010-01-01','YYYY-MM-DD'));
INSERT INTO Extranjeros VALUES (NULL, 'Uruguay', 1, TO_DATE('2022-01-01','YYYY-MM-DD'));

-- Representantes
INSERT INTO Representantes VALUES (2000010000, 'María Hernández', 3908362211, 9, 2000000000);
INSERT INTO Representantes VALUES (2000110000, 'Luis Gómez', 999, 5, 2000000001);
INSERT INTO Representantes VALUES (2000210000, 'Ana Pérez', 3123456789, -2, 2000000002);
INSERT INTO Representantes VALUES (2000310000, 'Juan Díaz', 3123456789, 3, 9999999999);
INSERT INTO Representantes VALUES (2000410000, NULL, 3123456789, 3, 2000000003);

-- CorreosPorRepresentantes
INSERT INTO CorreosPorRepresentantes VALUES (2000010000, 'maria.hernandezagencia.com');
INSERT INTO CorreosPorRepresentantes VALUES (2000510000, 'luis-at-email.com');
INSERT INTO CorreosPorRepresentantes VALUES (9999999999, 'ana@agencia.com');
INSERT INTO CorreosPorRepresentantes VALUES (2000710000, NULL);
INSERT INTO CorreosPorRepresentantes VALUES (NULL, 'juan@agencia.com');

-- Prestamos
INSERT INTO Prestamos VALUES (600, TIMESTAMP '2024-01-01 10:00:00', TIMESTAMP '2025-01-01 10:00:00', 2000000000, 'Millonarios');
INSERT INTO Prestamos VALUES (601, TIMESTAMP '2024-05-01 10:00:00', TIMESTAMP '2024-01-01 10:00:00', 2000000001, 'Santa Fe');
INSERT INTO Prestamos VALUES (602, TIMESTAMP '2024-02-01 10:00:00', TIMESTAMP '2025-02-01 10:00:00', 9999999999, 'Cali');
INSERT INTO Prestamos VALUES (603, NULL, TIMESTAMP '2025-03-01 10:00:00', 2000000002, 'Junior');
INSERT INTO Prestamos VALUES (604, TIMESTAMP '2024-03-01 10:00:00', TIMESTAMP '2025-03-01 10:00:00', 2000000003, NULL);

-- Contratos
INSERT INTO Contratos VALUES (800, '1 año', 50000, 'Titular', 0.5, 'Contrato_800');
INSERT INTO Contratos VALUES (801, '2 años', -100, 'Suplente', 0.3, 'Contrato_801');
INSERT INTO Contratos VALUES (802, '3 años', 30000, 'Importante', 1.5, 'Contrato_802');
INSERT INTO Contratos VALUES (803, '6 meses', 20000, 'Estrella', 0.2, 'Contrato_803');
INSERT INTO Contratos VALUES (804, '1 año', 40000, 'Titular', 0.1, NULL);

-- Transferencias
INSERT INTO Transferencias VALUES (900, 100000, 'Comprado', 'Millonarios', 800);
INSERT INTO Transferencias VALUES (901, -50000, 'Venta', 'Santa Fe', 801);
INSERT INTO Transferencias VALUES (902, 200000, 'Alquiler', 'Cali', 802);
INSERT INTO Transferencias VALUES (903, 150000, 'Donacion', NULL, 803);
INSERT INTO Transferencias VALUES (904, 120000, 'Venta', 'Junior', 9999);

-- Documentaciones
INSERT INTO Documentaciones VALUES (1000, 'Pasaporte', TIMESTAMP '2021-01-01 00:00:00', TIMESTAMP '2024-01-01 00:00:00', 'Autoridad_1', 800);
INSERT INTO Documentaciones VALUES (1001, 'Visa', TIMESTAMP '2022-01-01 00:00:00', TIMESTAMP '2021-01-01 00:00:00', 'Autoridad_2', 801);
INSERT INTO Documentaciones VALUES (1002, 'Certificado', TIMESTAMP '2023-01-01 00:00:00', TIMESTAMP '2026-01-01 00:00:00', 'Autoridad_3', 802);
INSERT INTO Documentaciones VALUES (1003, 'Cédula', NULL, TIMESTAMP '2025-01-01 00:00:00', 'Autoridad_4', 803);
INSERT INTO Documentaciones VALUES (1004, 'Pasaporte', TIMESTAMP '2022-01-01 00:00:00', TIMESTAMP '2025-01-01 00:00:00', 'Autoridad_5', NULL);

-- Gerentes
INSERT INTO Gerentes VALUES (2000020000, 'Manuel García', 3622498058, 7, 'Millonarioss');
INSERT INTO Gerentes VALUES (2000120000, 'Ana Ruiz', 12345, 10, 'santa Fe');
INSERT INTO Gerentes VALUES (2000220000, 'Luis Pérez', 3123456789, -1, 'Cali');
INSERT INTO Gerentes VALUES (2000320000, 'Marta Gómez', 3123456789, 5, NULL);
INSERT INTO Gerentes VALUES (2000420000, 'Juan Díaz', 3123456789, 3, 'EquipoX');

-- CorreosPorGerentes
INSERT INTO CorreosPorGerentes VALUES (2000020000, 'manuel.garcia@empresa.com');
INSERT INTO CorreosPorGerentes VALUES (2000020000, 'manuel.garcia@empresa.com');
INSERT INTO CorreosPorGerentes VALUES (2000120000, 'ana.ruiz[at]empresa.com');
INSERT INTO CorreosPorGerentes VALUES (9999999999, 'luis.perezempresa.com');


-- Financieros
INSERT INTO Financieros VALUES (2000020, 10);
INSERT INTO Financieros VALUES (2000120, 5);
INSERT INTO Financieros VALUES (NULL, 3);
INSERT INTO Financieros VALUES (2000320000, NULL);
INSERT INTO Financieros VALUES (2000420000, 7);

-- Deportivos
INSERT INTO Deportivos VALUES (2000020, 50, 'Ofensivo');
INSERT INTO Deportivos VALUES (2000120, 200, 'Defensivo');
INSERT INTO Deportivos VALUES (2000220000, 30, 'Táctico');
INSERT INTO Deportivos VALUES (2000320000, NULL, 'Equilibrado');
INSERT INTO Deportivos VALUES (NULL, 70, 'Ofensivo');
