-- Prueba realizada por: Juan Daniel Bogota Fuentes
-- Fecha: 17/05/2025

DECLARE
    v_resultado NUMBER;
    v_id_entrenamiento NUMBER;
    v_cursor SYS_REFCURSOR;
    v_entrenamiento ENTRENAMIENTOS%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBA GESTIÓN DE ENTRENAMIENTOS ===');
    DBMS_OUTPUT.PUT_LINE('1. Programar nuevo entrenamiento');
    
    -- 1. Programar entrenamiento
    v_id_entrenamiento := SEQ_ENTRENAMIENTOS.NEXTVAL;
    
    PA_ENTRENAMIENTO.AD_entrenamiento(
        v_id_entrenamiento,
        'Preparación partido vs Nacional',
        TO_DATE('25/05/2024 09:00', 'DD/MM/YYYY HH24:MI'),
        TO_DATE('25/05/2024 11:00', 'DD/MM/YYYY HH24:MI'),
        'Cancha Principal',
        'Millonarios',
        v_resultado
    );
    
    IF v_resultado = 1 THEN
        DBMS_OUTPUT.PUT_LINE('✔ Entrenamiento programado correctamente (ID: ' || v_id_entrenamiento || ')');
        
        -- 2. Verificar programación
        v_cursor := PA_ENTRENAMIENTO.CO_entrenamientos_equipo('Millonarios');
        DBMS_OUTPUT.PUT_LINE('2. Listado de entrenamientos:');
        LOOP
            FETCH v_cursor INTO v_entrenamiento;
            EXIT WHEN v_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('   ID: ' || v_entrenamiento.id || 
                               ' | Fecha: ' || TO_CHAR(v_entrenamiento.fecha_inicio, 'DD/MM/YYYY HH24:MI') ||
                               ' | Descripción: ' || v_entrenamiento.descripcion);
            IF v_entrenamiento.id = v_id_entrenamiento THEN
                DBMS_OUTPUT.PUT_LINE('   ✔ Entrenamiento encontrado en listado');
            END IF;
        END LOOP;
        CLOSE v_cursor;
        
        -- 3. Cancelar entrenamiento
        DBMS_OUTPUT.PUT_LINE('3. Cancelar entrenamiento programado');
        PA_ENTRENAMIENTO.DE_entrenamiento(
            v_id_entrenamiento,
            v_resultado
        );
        
        IF v_resultado = 1 THEN
            DBMS_OUTPUT.PUT_LINE('✔ Entrenamiento cancelado correctamente');
            
            -- 4. Verificar cancelación
            BEGIN
                SELECT * INTO v_entrenamiento 
                FROM ENTRENAMIENTOS 
                WHERE id = v_id_entrenamiento;
                
                DBMS_OUTPUT.PUT_LINE('✖ Error: Entrenamiento no fue eliminado');
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    DBMS_OUTPUT.PUT_LINE('✔ Verificación: Entrenamiento ya no existe en BD');
            END;
        ELSE
            DBMS_OUTPUT.PUT_LINE('✖ Error al cancelar entrenamiento');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('✖ Error al programar entrenamiento');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('=== FIN PRUEBA ===');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('✖ Error inesperado: ' || SQLERRM);
        ROLLBACK;
END;
/