-- PRUEBAS DisparadoresNoOK

-- Intento de inserción sin documento (trigger trg_insert_jugador lo bloquea)
INSERT INTO Jugadores (nombre, posicion, valorMercado, nombreEquipo)
VALUES ('Jugador Inválido', 'MED', 1000000, 'Millonarios');

-- Intento de modificar sueldo en contrato (trigger trg_modificar_solo_detalle lo bloquea)
UPDATE Contratos SET sueldo = 6000000 WHERE id = 100;

-- Insertar estadio pequeño
INSERT INTO Estadios VALUES ('Estadio Pequeño', 1, 'Millonarios');

-- Primer abonado (válido)
INSERT INTO Hinchas VALUES (1050000001, 'Abonado 1', 1, 'Millonarios');

-- Segundo abonado (trigger trg_control_abonos lo bloquea por exceder capacidad)
INSERT INTO Hinchas VALUES (1050000002, 'Abonado 2', 1, 'Millonarios');

-- Intento de registrar segundo DT (trigger trg_un_solo_dt_por_equipo lo bloquea)
INSERT INTO Gerentes VALUES (4010000002, 'Carlos Bianchi', 3209876543, 15, 'Santa Fe');
INSERT INTO Deportivos VALUES (4010000002, 90, 'Defensivo');


-- Intento de insertar jugador 21 (trigger trg_limite_jugadores_por_equipo lo bloquea)
INSERT INTO Jugadores VALUES (1040000021, 'Jugador Extra', 'MED', 1, 2000000, 'Santa Fe');

-- Insertar jugador inactivo
INSERT INTO Jugadores VALUES (1060000001, 'Jugador Inactivo', 'DEF', 0, 1000000, 'Millonarios');
INSERT INTO Representantes VALUES (5010000001, 'Repre Inactivo', 3112345678, 5, 1060000001);


-- Intento de transferencia (trigger trg_validar_estado_jugador_transferencia lo bloquea)
INSERT INTO Transferencias VALUES (1001, 5000000, 'Transferencia inválida', 'Nacional', 101);

-- Intento con documento de 9 dígitos (trigger trg_valida_documento_jugador lo bloquea)
INSERT INTO Jugadores VALUES (123456789, 'Jugador Inválido', 'DEL', 1, 1000000, 'Millonarios');

-- Intento con valor negativo (trigger trg_valida_valor_mercado lo bloquea)
INSERT INTO Jugadores VALUES (1070000001, 'Jugador Inválido', 'MED', 1, -500000, 'Nacional');

-- Intento con estado=2 (trigger trg_valida_estado_jugador lo bloquea)
INSERT INTO Jugadores VALUES (1080000001, 'Jugador Inválido', 'DEF', 2, 1000000, 'Millonarios');

-- Intento con equipo que no existe (trigger trg_valida_equipo_jugador lo bloquea)
INSERT INTO Jugadores VALUES (1090000001, 'Jugador Inválido', 'DEL', 1, 1000000, 'EquipoFantasma');

-- Fecha de nacimiento en el futuro (no calcularía bien la edad)
INSERT INTO Jugadores (documento, nombre, posicion, valorMercado, nombreEquipo, fechaNacimiento)
VALUES (1200000001, 'Jugador Futuro', 'DEL', 1000000, 'Millonarios', TO_DATE('2030-01-01', 'YYYY-MM-DD'));

-- Ya existe un DT para Santa Fe (4010000001)
INSERT INTO Gerentes VALUES (4010000003, 'Otro DT', 3155555555, 8, 'Santa Fe');
INSERT INTO Deportivos VALUES (4010000003, 75, 'Mixto'); -- Será bloqueado

-- Transferencia con ID de contrato inexistente
INSERT INTO Transferencias VALUES (1003, 15000000, 'Transferencia inválida', 'Millonarios', 9999);

-- Fecha final antes que la de inicio
INSERT INTO Prestamos VALUES (1002, 
    TO_DATE('2024-06-01', 'YYYY-MM-DD'), 
    TO_DATE('2024-05-01', 'YYYY-MM-DD'), 
    1100000002, 
    'Santa Fe');

-- Posición con formato incorrecto (debe ser 2-3 letras mayúsculas)
INSERT INTO Jugadores VALUES (1200000002, 'Jugador Inválido', 'delantero', 1, 1000000, 'Millonarios');

-- Intentar cambiar tipo de contrato (solo se permite modificar detalle)
UPDATE Contratos SET rol = 'Cantera' WHERE id = 102;

-- Equipo que no existe en la tabla Equipos
INSERT INTO Hinchas VALUES (1210000001, 'Hincha Fantasma', 0, 'EquipoInexistente');

-- Documento que ya existe (1100000001 es James Rodríguez)
INSERT INTO Jugadores VALUES (1100000001, 'Jugador Duplicado', 'DEF', 1, 2000000, 'Millonarios');

-- Partido con fecha en el pasado
INSERT INTO Partidos VALUES (1002, 
    TO_TIMESTAMP('2020-01-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
    'Medellín');