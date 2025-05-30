-- PRUEBAS TuplasNoOK (Datos inválidos según restricciones de tuplas)

-- Nombre vacío (viola NOT NULL)
INSERT INTO Equipos VALUES ('', 'Rojo', 'Cali', 2, 1, 3000000000, 'Objetivo vacío');

-- Presupuesto negativo (viola chk_presupuesto)
INSERT INTO Equipos VALUES ('Cali FC', 'Rojo', 'Cali', 2, 1, -500000, 'Objetivo inválido');

-- Estado inválido (viola chk_estado_valido)
INSERT INTO Jugadores VALUES (1010000001, 'Juan Perez', 'DEL', 2, 1000000, 'Millonarios');

-- Valor de mercado negativo (viola chk_jugador_valorMercado)
INSERT INTO Jugadores VALUES (1010000002, 'Carlos Sanchez', 'MED', 1, -500000, 'Nacional');

-- Años en cantera menor a 1 (viola chk_añosEnCantera)
INSERT INTO Canteranos VALUES (1010000001, 0, 'Juvenil', TO_DATE('2024-02-10', 'YYYY-MM-DD'));

-- Jugador no existente (viola FK)
INSERT INTO Canteranos VALUES (9999999999, 3, 'Sub-20', TO_DATE('2023-06-15', 'YYYY-MM-DD'));


-- Documento con longitud incorrecta (viola chk_documento)
INSERT INTO Extranjeros VALUES (101000000, 'Argentina', 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'));

-- Jugador no existente (viola FK)
INSERT INTO Extranjeros VALUES (9999999999, 'Brasil', 1, TO_DATE('2023-03-20', 'YYYY-MM-DD'));


-- Teléfono con longitud incorrecta (viola chk_telefono_representante)
INSERT INTO Representantes VALUES (2010000001, 'Pedro Gomez', 12345, 10, 1010000001);

-- Experiencia negativa (viola chk_experiencia)
INSERT INTO Representantes VALUES (2010000002, 'Maria Lopez', 3209876543, -2, 1010000002);


-- Correo duplicado (viola uk_correoR)
INSERT INTO CorreosPorRepresentantes VALUES (2010000001, 'pedro.gomez@agencia.com');
INSERT INTO CorreosPorRepresentantes VALUES (2010000002, 'pedro.gomez@agencia.com');

-- Correo inválido (viola chk_correo)
INSERT INTO CorreosPorRepresentantes VALUES (2010000003, 'correo invalido.com');


-- Duración con formato inválido (viola chk_duracion_valida)
INSERT INTO Contratos VALUES (1, '2 meses años', 5000000, 'Profesional', 10, 'Contrato inválido');

-- Bono fuera de rango (viola chk_contrato_bono_porcentaje)
INSERT INTO Contratos VALUES (2, '1 año', 3000000, 'Cantera', 150, 'Bono inválido');


-- Valor de transferencia negativo (viola chk_transferencia_valor)
INSERT INTO Transferencias VALUES (1, -5000000, 'Traspaso inválido', 'Nacional', 1);

-- Contrato no existente (viola FK)
INSERT INTO Transferencias VALUES (2, 15000000, 'Cesión con opción', 'Millonarios', 999);


-- Fechas invertidas (viola chk_fechaPrestamo)
INSERT INTO Prestamos VALUES (1, TO_DATE('2024-12-15', 'YYYY-MM-DD'), TO_DATE('2024-01-15', 'YYYY-MM-DD'), 1010000001, 'Nacional');

-- Jugador no existente (viola FK)
INSERT INTO Prestamos VALUES (2, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 9999999999, 'Millonarios');

-- Fechas invertidas (viola chk_fechaDoc)
INSERT INTO Documentaciones VALUES (1, 'Pasaporte', TO_DATE('2028-01-10', 'YYYY-MM-DD'), TO_DATE('2023-01-10', 'YYYY-MM-DD'), 'Migración Colombia', 1);

-- Contrato no existente (viola FK)
INSERT INTO Documentaciones VALUES (2, 'Permiso trabajo', TO_DATE('2023-05-15', 'YYYY-MM-DD'), TO_DATE('2025-05-15', 'YYYY-MM-DD'), 'Ministerio Trabajo', 999);


-- Fecha pasada (violaría trigger de fecha futura)
INSERT INTO Partidos VALUES (1, TO_TIMESTAMP('2020-05-20 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Bogotá');

-- ID duplicado (viola PK)
INSERT INTO Partidos VALUES (1, TO_TIMESTAMP('2024-05-25 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Medellín');


-- Equipo no existente (viola FK)
INSERT INTO TieneResultadosDe VALUES ('EquipoFalso', 1, 2, 1, 3);

-- Partido no existente (viola FK)
INSERT INTO TieneResultadosDe VALUES ('Millonarios', 999, 3, 0, 3);

-- Experiencia negativa (viola chk_experienciaGerente)
INSERT INTO Gerentes VALUES (3010000001, 'Luis Diaz', 3112345678, -5, 'Millonarios');

-- Equipo no existente (viola FK)
INSERT INTO Gerentes VALUES (3010000002, 'Ana Torres', 3223456789, 12, 'EquipoInexistente');


-- Correo duplicado (viola uk_correoG)
INSERT INTO CorreosPorGerentes VALUES (3010000001, 'gerente@millonarios.com');
INSERT INTO CorreosPorGerentes VALUES (3010000002, 'gerente@millonarios.com');

-- Gerente no existente (viola FK)
INSERT INTO CorreosPorGerentes VALUES (9999999999, 'correo@invalido.com');


-- Rendimiento fuera de rango (viola chk_rendimientoDeportivo)
INSERT INTO Deportivos VALUES (3010000001, 150, 'Ofensivo');

-- Gerente no existente (viola FK)
INSERT INTO Deportivos VALUES (9999999999, 90, 'Defensivo');

-- Gerente no existente (viola FK)
INSERT INTO Financieros VALUES (9999999999, 5);

-- Patrocinadores negativos (violaría restricción no definida)
INSERT INTO Financieros VALUES (3010000001, -2);


-- Capacidad negativa (violaría restricción no definida)
INSERT INTO Estadios VALUES ('Estadio Inválido', -1000, 'Millonarios');

-- Equipo no existente (viola FK)
INSERT INTO Estadios VALUES ('Estadio Fantasma', 20000, 'EquipoInexistente');

-- Cédula con longitud incorrecta (viola chk_cedula)
INSERT INTO Hinchas VALUES (12345, 'Roberto Rodriguez', 1, 'Millonarios');

-- Equipo no existente (viola FK)
INSERT INTO Hinchas VALUES (1020000002, 'Laura Martinez', 0, 'EquipoInexistente');



