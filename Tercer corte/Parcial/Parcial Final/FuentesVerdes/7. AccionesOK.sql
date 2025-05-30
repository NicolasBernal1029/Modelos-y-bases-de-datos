-- PRUEBAS AccionesOK

-- ================================

-- 1. CASO: Al eliminar un jugador, su representante debe ser eliminado

-- Insertar jugador
INSERT INTO Jugadores VALUES (2000000000, 'Marcos Torres', 'DEL', 1, 632646, 'Millonarios');

-- Insertar representante vinculado
INSERT INTO Representantes VALUES (2000010000, 'María Hernández', 3908362211, 9, 2000000000);

-- Verificar inserciones
SELECT * FROM Jugadores WHERE documento = 2000000000;
SELECT * FROM Representantes WHERE documentoJugador = 2000000000;

-- Eliminar el jugador
DELETE FROM Jugadores WHERE documento = 2000000000;

-- Verificar que el representante fue eliminado automáticamente
SELECT * FROM Representantes WHERE documentoJugador = 2000000000;



-- ================================

-- 2. CASO: Al eliminar un contrato, se deben eliminar las documentaciones asociadas

-- Insertar contrato
INSERT INTO Contratos VALUES (800, '3 años', 43227, 'Importante', 0.73, 'Contrato_800');

-- Insertar documentación asociada
INSERT INTO Documentaciones VALUES (1000, 'Contrato Laboral', TO_DATE('2021-11-18', 'YYYY-MM-DD'), TO_DATE('2024-11-17', 'YYYY-MM-DD'), 'Autoridad_4', 800);

-- Verificar inserciones
SELECT * FROM Contratos WHERE id = 800;
SELECT * FROM Documentaciones WHERE idContrato = 800;

-- Eliminar el contrato
DELETE FROM Contratos WHERE id = 800;

-- Verificar que la documentación fue eliminada automáticamente
SELECT * FROM Documentaciones WHERE idContrato = 800;




-- ================================

-- 3. ON DELETE CASCADE (CorreosPorRepresentantes → Representantes)

-- Crear un representante con correos
INSERT INTO Representantes VALUES (2000010000, 'María Hernández', 3908362211, 9, 2000000000);

INSERT INTO CorreosPorRepresentantes VALUES (2000010000, 'maría.hernández@agencia.com');

-- Verificar inserciones
SELECT * FROM Representantes WHERE documento = 2000010000;
SELECT * FROM CorreosPorRepresentantes WHERE documentoRepresentante = 2000010000;

-- Eliminar el representante
DELETE FROM Representantes WHERE documento = 2000010000;

-- Verificar que los correos fueron eliminados automáticamente
SELECT * FROM CorreosPorRepresentantes WHERE documentoRepresentante = 2000010000;