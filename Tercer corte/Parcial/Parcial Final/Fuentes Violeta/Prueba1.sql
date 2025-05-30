-- Prueba realizada por: Nicolas Felipe Bernal Gallo
-- Fecha: 17/05/2025

DECLARE
    v_resultado NUMBER;
    v_cursor SYS_REFCURSOR;
    v_jugador JUGADORES%ROWTYPE;
    v_transferencia TRANSFERENCIAS%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBA GESTIÓN DE JUGADORES ===');
    DBMS_OUTPUT.PUT_LINE('1. Registrar nuevo jugador en Millonarios');
    
    -- 1. Registrar jugador
    PA_JUGADOR.AD_jugador(
        1022334455, 
        'Luis Díaz', 
        'Delantero', 
        1,  -- Activo
        20000000, -- Valor de mercado
        'Millonarios',
        v_resultado
    );
    
    IF v_resultado = 1 THEN
        DBMS_OUTPUT.PUT_LINE('✔ Jugador registrado correctamente');
        
        -- 2. Verificar registro
        v_cursor := PA_JUGADOR.CO_jugador_equipo('Millonarios');
        LOOP
            FETCH v_cursor INTO v_jugador;
            EXIT WHEN v_cursor%NOTFOUND;
            IF v_jugador.documento = 1022334455 THEN
                DBMS_OUTPUT.PUT_LINE('✔ Jugador encontrado en Millonarios');
                DBMS_OUTPUT.PUT_LINE('   Nombre: ' || v_jugador.nombre);
                DBMS_OUTPUT.PUT_LINE('   Valor: $' || v_jugador.valorMercado);
            END IF;
        END LOOP;
        CLOSE v_cursor;
        
        -- 3. Transferir jugador a otro equipo
        DBMS_OUTPUT.PUT_LINE('2. Transferir jugador a Liverpool FC');
        PA_JUGADOR.transferir_jugador(
            1022334455, 
            'Liverpool FC', 
            25000000, -- Valor transferencia
            v_resultado
        );
        
        IF v_resultado = 1 THEN
            DBMS_OUTPUT.PUT_LINE('✔ Transferencia realizada con éxito');
            
            -- 4. Verificar transferencia
            BEGIN
                SELECT * INTO v_transferencia 
                FROM TRANSFERENCIAS 
                WHERE documentoJugador = 1022334455
                AND ROWNUM = 1;
                
                DBMS_OUTPUT.PUT_LINE('✔ Transferencia registrada:');
                DBMS_OUTPUT.PUT_LINE('   Equipo destino: ' || v_transferencia.nombreEquipo);
                DBMS_OUTPUT.PUT_LINE('   Valor: $' || v_transferencia.valor);
                
                -- 5. Verificar que el jugador ya no está en Millonarios
                v_cursor := PA_JUGADOR.CO_jugador_equipo('Millonarios');
                LOOP
                    FETCH v_cursor INTO v_jugador;
                    EXIT WHEN v_cursor%NOTFOUND;
                    IF v_jugador.documento = 1022334455 THEN
                        DBMS_OUTPUT.PUT_LINE('✖ Error: Jugador sigue en Millonarios');
                    END IF;
                END LOOP;
                CLOSE v_cursor;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    DBMS_OUTPUT.PUT_LINE('✖ Error: No se registró la transferencia');
            END;
        ELSE
            DBMS_OUTPUT.PUT_LINE('✖ Error en transferencia');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('✖ Error al registrar jugador');
    END IF;
    
    -- Limpieza (solo si es ambiente de pruebas)
    PA_JUGADOR.DE_jugador(1022334455, v_resultado);
    DBMS_OUTPUT.PUT_LINE('=== FIN PRUEBA ===');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('✖ Error inesperado: ' || SQLERRM);
        ROLLBACK;
END;
/