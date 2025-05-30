-- DISPARADORES PARA AUTOMATIZACIÓN



-- Registar nuevo jugador
/*
ALTER TABLE Jugadores ADD fechaNacimiento DATE;
ALTER TABLE Jugadores ADD edad INT;

CREATE OR REPLACE TRIGGER trg_insert_jugador
BEFORE INSERT ON Jugadores
FOR EACH ROW
DECLARE
    v_edad INT;
BEGIN

    IF :NEW.documento IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'El documento es obligatorio.');
    ELSIF :NEW.nombre IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'El nombre es obligatorio.');
    ELSIF :NEW.posicion IS NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'La posición es obligatoria.');
    ELSIF :NEW.valorMercado IS NULL THEN
        RAISE_APPLICATION_ERROR(-20004, 'El valor de mercado es obligatorio.');
    ELSIF :NEW.nombreEquipo IS NULL THEN
        RAISE_APPLICATION_ERROR(-20005, 'El nombre del equipo es obligatorio.');
    END IF;

    IF :NEW.estado IS NULL THEN
        :NEW.estado := 1;
    END IF;

    -- Calcular edad si se proporciona fecha de nacimiento
    IF :NEW.fechaNacimiento IS NOT NULL THEN
        v_edad := FLOOR(MONTHS_BETWEEN(SYSDATE, :NEW.fechaNacimiento) / 12);
        :NEW.edad := v_edad;
    ELSE
        :NEW.edad := NULL; -- por si no se proporciona la fecha
    END IF;
END;
/
*/

-- Mantener contrato de jugador

CREATE OR REPLACE TRIGGER trg_modificar_solo_detalle
BEFORE UPDATE ON Contratos
FOR EACH ROW
BEGIN
    IF     :NEW.duracion      != :OLD.duracion
        OR :NEW.sueldo        != :OLD.sueldo
        OR :NEW.rol           != :OLD.rol
        OR :NEW.bono          != :OLD.bono
        OR :NEW.id            != :OLD.id THEN
        RAISE_APPLICATION_ERROR(-20020, 'Solo se permite modificar el campo "detalle" del contrato.');
    END IF;
END;
/

-- Registrar numero de abonos por temporada

CREATE OR REPLACE TRIGGER trg_control_abonos
BEFORE INSERT ON Hinchas
FOR EACH ROW
DECLARE
    v_capacidad INT;
    v_abonados_actuales INT;
BEGIN
    IF :NEW.abonado = 1 THEN
        SELECT e.capacidad INTO v_capacidad
        FROM Estadios e
        WHERE e.nombreEquipo = :NEW.nombreEquipo;

        SELECT COUNT(*) INTO v_abonados_actuales
        FROM Hinchas
        WHERE nombreEquipo = :NEW.nombreEquipo AND abonado = 1;

        IF v_abonados_actuales >= v_capacidad THEN
            RAISE_APPLICATION_ERROR(-20030, 'No se pueden registrar más abonados: capacidad del estadio alcanzada.');
        END IF;
    END IF;
END;
/

-- Mantener información del estadio local

CREATE OR REPLACE TRIGGER trg_solo_modificar_nombre_estadio
BEFORE UPDATE ON Estadios
FOR EACH ROW
BEGIN
    IF     :NEW.capacidad    != :OLD.capacidad
        OR :NEW.nombreEquipo != :OLD.nombreEquipo THEN
        RAISE_APPLICATION_ERROR(-20040, 'Solo se permite modificar el nombre del estadio.');
    END IF;
END;
/

-- Registrar nuevo director técnico

CREATE OR REPLACE TRIGGER trg_un_solo_dt_por_equipo
BEFORE INSERT ON Deportivos
FOR EACH ROW
DECLARE
    v_equipo VARCHAR(50);
    v_count INT;
BEGIN
    
    SELECT nombreEquipo INTO v_equipo
    FROM Gerentes
    WHERE documento = :NEW.documento;

    SELECT COUNT(*) INTO v_count
    FROM Deportivos d
    JOIN Gerentes g ON d.documento = g.documento
    WHERE g.nombreEquipo = v_equipo;

    IF v_count >= 1 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Ya existe un director técnico para este equipo.');
    END IF;
END;
/

-- Mantener plantilla de jugadores

CREATE OR REPLACE TRIGGER trg_limite_jugadores_por_equipo
BEFORE INSERT ON Jugadores
FOR EACH ROW
DECLARE
    v_total_jugadores INT;
BEGIN
    SELECT COUNT(*) INTO v_total_jugadores
    FROM Jugadores
    WHERE nombreEquipo = :NEW.nombreEquipo;

    IF v_total_jugadores >= 20 THEN
        RAISE_APPLICATION_ERROR(-20050, 'No se pueden registrar más de 20 jugadores en un equipo.');
    END IF;
END;
/

-- Registrar  solicitud de transferencia

CREATE OR REPLACE TRIGGER trg_validar_estado_jugador_transferencia
BEFORE INSERT ON Transferencias
FOR EACH ROW
DECLARE
    v_estado NUMBER;
BEGIN
    SELECT estado INTO v_estado
    FROM Jugadores
    WHERE documento = :NEW.documentoJugador;

    IF v_estado != 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede realizar la transferencia: el jugador no está activo.');
    END IF;
END;
/


-- Trigger para validar documento de identidad
CREATE OR REPLACE TRIGGER trg_valida_documento_jugador
BEFORE INSERT OR UPDATE ON Jugadores
FOR EACH ROW
BEGIN
    IF LENGTH(TO_CHAR(:NEW.documento)) != 10 THEN
        RAISE_APPLICATION_ERROR(-20500, 'RN1.1: El documento debe tener 10 dígitos');
    END IF;
END;
/

-- Trigger para validar valor de mercado
CREATE OR REPLACE TRIGGER trg_valida_valor_mercado
BEFORE INSERT OR UPDATE ON Jugadores
FOR EACH ROW
BEGIN
    IF :NEW.valorMercado NOT BETWEEN 1 AND 1000000000 THEN
        RAISE_APPLICATION_ERROR(-20501, 'RN1.2: El valor de mercado debe estar entre 1 y 1,000,000,000');
    END IF;
END;
/

--Trigger para validar el estado del jugador
CREATE OR REPLACE TRIGGER trg_valida_estado_jugador
BEFORE INSERT OR UPDATE OF estado ON Jugadores
FOR EACH ROW
BEGIN
    IF :NEW.estado NOT IN (0, 1) THEN
        RAISE_APPLICATION_ERROR(-20503, 'RN1.3: El estado del jugador solo puede ser 0 (inactivo) o 1 (activo)');
    END IF;
END;
/

--Trigger para validar asociacion del jugador
CREATE OR REPLACE TRIGGER trg_valida_equipo_jugador
BEFORE INSERT OR UPDATE OF nombreEquipo ON Jugadores
FOR EACH ROW
DECLARE
    v_equipo_existe NUMBER;
BEGIN
    -- Verificar si el equipo existe en la tabla Equipos
    SELECT COUNT(*) INTO v_equipo_existe 
    FROM Equipos 
    WHERE nombre = :NEW.nombreEquipo;
    
    IF v_equipo_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20504, 'RN1.4: El equipo especificado no existe en la base de datos');
    END IF;
END;
/


-- Trigger para validar valor de transferencia
CREATE OR REPLACE TRIGGER trg_valida_valor_transferencia
BEFORE INSERT OR UPDATE ON Transferencias
FOR EACH ROW
BEGIN
    IF :NEW.valor <= 0 THEN
        RAISE_APPLICATION_ERROR(-20505, 'RN2.1: El valor de transferencia debe ser mayor a 0');
    END IF;
END;
/

--Trigger para validar transferencia con contrato asociado
CREATE OR REPLACE TRIGGER trg_valida_contrato_transferencia
BEFORE INSERT ON Transferencias
FOR EACH ROW
DECLARE
    v_contrato_existente NUMBER;
BEGIN
    -- Verificar si existe un contrato asociado
    SELECT COUNT(*) INTO v_contrato_existente
    FROM Contratos
    WHERE id = :NEW.idContrato;
    
    IF v_contrato_existente = 0 THEN
        RAISE_APPLICATION_ERROR(-20507, 'RN2.2: Toda transferencia debe tener un contrato asociado válido');
    END IF;
END;
/


-- Trigger para validar fecha del partido
CREATE OR REPLACE TRIGGER trg_valida_fecha_partido
BEFORE INSERT ON Partidos
FOR EACH ROW
BEGIN
    IF :NEW.fecha <= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20050, 'RN4.1: La fecha del partido debe ser futura');
    END IF;
END;
/


-- Trigger para validar fechas de préstamo
CREATE OR REPLACE TRIGGER trg_valida_fechas_prestamo
BEFORE INSERT OR UPDATE ON Prestamos
FOR EACH ROW
BEGIN
    IF :NEW.fechaInicio >= :NEW.fechaFinal THEN
        RAISE_APPLICATION_ERROR(-20052, 'RN6.1: La fecha de inicio debe ser anterior a la fecha final');
    END IF;
    
    IF MONTHS_BETWEEN(:NEW.fechaFinal, :NEW.fechaInicio) > 12 THEN
        RAISE_APPLICATION_ERROR(-20053, 'RN6.2: La duración máxima de préstamo es 1 año');
    END IF;
END;
/

-- Trigger para verificar préstamos activos
CREATE OR REPLACE TRIGGER trg_verifica_prestamos_activos
BEFORE INSERT ON Prestamos
FOR EACH ROW
DECLARE
    v_prestamos_activos NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_prestamos_activos FROM Prestamos 
    WHERE documentoJugador = :NEW.documentoJugador 
    AND fechaFinal > SYSDATE;
    
    IF v_prestamos_activos > 0 THEN
        RAISE_APPLICATION_ERROR(-20054, 'RN6.4: El jugador ya tiene un préstamo activo');
    END IF;
END;
/

COMMIT;