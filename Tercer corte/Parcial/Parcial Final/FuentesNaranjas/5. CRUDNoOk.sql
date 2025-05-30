-- 1. Ejemplo completo de PA_CONTRATO
DECLARE
BEGIN
    -- Intentar insertar contrato sin rol (violación NOT NULL)
    PA_CONTRATO.AD_contrato(
        102, 
        '1 año', 
        2500000, 
        NULL,  -- Rol nulo
        500000, 
        'Contrato inválido'
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PA_CONTRATO: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Código error: ' || SQLCODE);
        
        -- Intentar eliminar contrato inexistente
        BEGIN
            PA_CONTRATO.DE_contrato(9999);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR eliminación: ' || SQLERRM);
        END;
END;
/

-- 2. Ejemplo completo de PA_JUGADOR
DECLARE
BEGIN
    -- Intentar insertar jugador con valor de mercado negativo
    PA_JUGADOR.AD_jugador(
        87654321, 
        'Jugador Inválido', 
        'Defensa', 
        1, 
        -500000,  -- Valor negativo
        'Millonarios'
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PA_JUGADOR: ' || SQLERRM);
        
        -- Intentar eliminar jugador inexistente
        BEGIN
            PA_JUGADOR.DE_jugador(99999999);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR eliminación: ' || SQLERRM);
        END;
END;
/

-- 3. Ejemplo completo de PA_EQUIPO
DECLARE
BEGIN
    -- Intentar insertar equipo sin nombre (violación PK)
    PA_EQUIPO.AD_equipo(
        NULL,  -- Nombre nulo
        'Rojo', 
        'Medellín', 
        5, 
        1, 
        1000000000, 
        'Misión inválida'
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PA_EQUIPO: ' || SQLERRM);
        
        -- Intentar eliminar equipo inexistente
        BEGIN
            PA_EQUIPO.DE_equipo('Equipo Fantasma');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR eliminación: ' || SQLERRM);
        END;
END;
/

-- 4. Ejemplo completo de PA_PRESTAMO
DECLARE
BEGIN
    -- Intentar crear préstamo con fechas inconsistentes
    PA_PRESTAMO.AD_prestamo(
        1001, 
        TO_DATE('2025-06-01', 'YYYY-MM-DD'),  -- Fecha inicio
        TO_DATE('2025-05-01', 'YYYY-MM-DD'),  -- Fecha final anterior a inicio
        10234567, 
        'Nacional'
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR PA_PRESTAMO: ' || SQLERRM);
        
        -- Mostrar ejemplo de violación de FK
        BEGIN
            PA_PRESTAMO.AD_prestamo(
                1002, 
                SYSDATE, 
                SYSDATE+30, 
                99999999,  -- Jugador inexistente
                'Millonarios'
            );
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR FK: ' || SQLERRM);
        END;
END;
/