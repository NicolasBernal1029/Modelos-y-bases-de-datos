--PA_CONTRATO
DECLARE
    v_cursor SYS_REFCURSOR;
    v_contrato CONTRATOS%ROWTYPE;
    v_resultado VARCHAR2(100);
BEGIN
    -- 1. Insertar nuevo contrato
    PA_CONTRATO.AD_contrato(
        1001, 
        '3 años', 
        5000000, 
        'Director Técnico', 
        2000000, 
        'Contrato para DT principal'
    );
    v_resultado := 'Contrato insertado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
    
    -- 2. Consultar contratos
    v_cursor := PA_CONTRATO.CO_contrato();
    DBMS_OUTPUT.PUT_LINE('--- LISTADO DE CONTRATOS ---');
    LOOP
        FETCH v_cursor INTO v_contrato;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_contrato.id || 
                           ' | Rol: ' || v_contrato.rol || 
                           ' | Sueldo: $' || v_contrato.sueldo);
    END LOOP;
    CLOSE v_cursor;
    
    -- 3. Eliminar contrato
    PA_CONTRATO.DE_contrato(1001);
    v_resultado := 'Contrato eliminado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
    
    -- 4. Verificar eliminación
    BEGIN
        v_cursor := PA_CONTRATO.CO_contrato();
        FETCH v_cursor INTO v_contrato;
        IF v_cursor%NOTFOUND THEN
            DBMS_OUTPUT.PUT_LINE('Verificación: El contrato fue eliminado correctamente');
        END IF;
        CLOSE v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error en verificación: ' || SQLERRM);
    END;
END;
/



--PA_JUGADOR
DECLARE
    v_cursor SYS_REFCURSOR;
    v_jugador JUGADORES%ROWTYPE;
    v_resultado VARCHAR2(100);
BEGIN
    -- 1. Insertar nuevo jugador
    PA_JUGADOR.AD_jugador(
        987654321, 
        'James Rodríguez', 
        'Mediocampista', 
        1, 
        15000000, 
        'Millonarios'
    );
    v_resultado := 'Jugador registrado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
    
    -- 2. Consultar jugadores
    v_cursor := PA_JUGADOR.CO_jugador();
    DBMS_OUTPUT.PUT_LINE('--- LISTADO DE JUGADORES ---');
    LOOP
        FETCH v_cursor INTO v_jugador;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Doc: ' || v_jugador.documento || 
                           ' | Nombre: ' || v_jugador.nombre || 
                           ' | Valor: $' || v_jugador.valorMercado);
    END LOOP;
    CLOSE v_cursor;
    
    -- 3. Actualizar información (simulando actualización)
    -- Primero eliminamos
    PA_JUGADOR.DE_jugador(987654321);
    -- Luego insertamos versión actualizada
    PA_JUGADOR.AD_jugador(
        987654321, 
        'James Rodríguez', 
        'Mediocampista', 
        1, 
        18000000,  -- Nuevo valor
        'Millonarios'
    );
    v_resultado := 'Información del jugador actualizada';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
    
    -- 4. Eliminar jugador
    PA_JUGADOR.DE_jugador(987654321);
    v_resultado := 'Jugador eliminado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
END;
/


--PA_EQUIPO
DECLARE
    v_cursor SYS_REFCURSOR;
    v_equipo EQUIPOS%ROWTYPE;
    v_resultado VARCHAR2(100);
BEGIN
    -- 1. Insertar nuevo equipo
    PA_EQUIPO.AD_equipo(
        'América de Cali', 
        'Rojo', 
        'Cali', 
        2, 
        1, 
        2500000000, 
        'Ganar la liga 2025'
    );
    v_resultado := 'Equipo registrado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
    
    -- 2. Consultar equipos
    v_cursor := PA_EQUIPO.CO_equipo();
    DBMS_OUTPUT.PUT_LINE('--- LISTADO DE EQUIPOS ---');
    LOOP
        FETCH v_cursor INTO v_equipo;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_equipo.nombre || 
                           ' | Ciudad: ' || v_equipo.ciudad || 
                           ' | Presupuesto: $' || v_equipo.presupuesto);
    END LOOP;
    CLOSE v_cursor;
    
    -- 3. Actualizar información (simulando actualización)
    -- Primero eliminamos
    PA_EQUIPO.DE_equipo('América de Cali');
    -- Luego insertamos versión actualizada
    PA_EQUIPO.AD_equipo(
        'América de Cali', 
        'Rojo', 
        'Cali', 
        1,  -- Nueva posición
        1, 
        3000000000,  -- Nuevo presupuesto
        'Ganar la liga y copa 2025'  -- Nueva misión
    );
    v_resultado := 'Información del equipo actualizada';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
    
    -- 4. Eliminar equipo
    PA_EQUIPO.DE_equipo('América de Cali');
    v_resultado := 'Equipo eliminado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
END;
/

--PA_GERENTE
DECLARE
    v_cursor SYS_REFCURSOR;
    v_gerente GERENTES%ROWTYPE;
    v_resultado VARCHAR2(100);
BEGIN
    -- 1. Insertar nuevo gerente
    PA_GERENTE.AD_gerente(
        1122334455, 
        'Juan Carlos Osorio', 
        8000000, 
        15, 
        'Nacional'
    );
    v_resultado := 'Gerente registrado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
    
    -- 2. Consultar gerentes
    v_cursor := PA_GERENTE.CO_gerente();
    DBMS_OUTPUT.PUT_LINE('--- LISTADO DE GERENTES ---');
    LOOP
        FETCH v_cursor INTO v_gerente;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Doc: ' || v_gerente.documento || 
                           ' | Nombre: ' || v_gerente.nombre || 
                           ' | Equipo: ' || v_gerente.nombreEquipo);
    END LOOP;
    CLOSE v_cursor;
    
    -- 3. Eliminar gerente
    PA_GERENTE.DE_gerente(1122334455);
    v_resultado := 'Gerente eliminado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
END;
/

--PA_HINCHA
DECLARE
    v_cursor SYS_REFCURSOR;
    v_hincha HINCHAS%ROWTYPE;
    v_resultado VARCHAR2(100);
BEGIN
    -- 1. Insertar nuevo hincha
    PA_HINCHA.AD_hincha(
        1234567890, 
        'Pedro Pérez', 
        1, 
        'Millonarios'
    );
    v_resultado := 'Hincha registrado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
    
    -- 2. Consultar hinchas
    v_cursor := PA_HINCHA.CO_hincha();
    DBMS_OUTPUT.PUT_LINE('--- LISTADO DE HINCHAS ---');
    LOOP
        FETCH v_cursor INTO v_hincha;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Cédula: ' || v_hincha.cedula || 
                           ' | Nombre: ' || v_hincha.nombre || 
                           ' | Equipo: ' || v_hincha.nombreEquipo);
    END LOOP;
    CLOSE v_cursor;
    
    -- 3. Eliminar hincha
    PA_HINCHA.DE_hincha(1234567890);
    v_resultado := 'Hincha eliminado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
END;
/



--PA_PRESTAMO
DECLARE
    v_cursor SYS_REFCURSOR;
    v_prestamo PRESTAMOS%ROWTYPE;
    v_resultado VARCHAR2(100);
BEGIN
    -- 1. Primero necesitamos un jugador y equipo existentes
    -- (Simulamos que ya existen en la base de datos)
    
    -- 2. Insertar nuevo préstamo
    PA_PRESTAMO.AD_prestamo(
        5001, 
        TO_DATE('2025-01-15', 'YYYY-MM-DD'), 
        TO_DATE('2025-12-31', 'YYYY-MM-DD'), 
        987654321,  -- Documento jugador existente
        'Santa Fe'  -- Equipo existente
    );
    v_resultado := 'Préstamo registrado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
    
    -- 3. Consultar préstamos
    v_cursor := PA_PRESTAMO.CO_prestamo();
    DBMS_OUTPUT.PUT_LINE('--- LISTADO DE PRÉSTAMOS ---');
    LOOP
        FETCH v_cursor INTO v_prestamo;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_prestamo.id || 
                           ' | Jugador: ' || v_prestamo.documentoJugador || 
                           ' | Equipo: ' || v_prestamo.nombreEquipo);
    END LOOP;
    CLOSE v_cursor;
    
    -- 4. Eliminar préstamo
    PA_PRESTAMO.DE_prestamo(5001);
    v_resultado := 'Préstamo eliminado correctamente';
    DBMS_OUTPUT.PUT_LINE(v_resultado);
END;
/