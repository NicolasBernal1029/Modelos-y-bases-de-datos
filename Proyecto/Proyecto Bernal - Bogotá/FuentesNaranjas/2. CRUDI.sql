-- Implementación de PA_CONTRATO
CREATE OR REPLACE PACKAGE BODY PA_CONTRATO 
AS
    PROCEDURE AD_contrato(id INT, duracion VARCHAR, sueldo NUMBER, rol VARCHAR, bono NUMBER, detalle VARCHAR) IS
    BEGIN
    INSERT INTO Contratos VALUES (id, duracion, sueldo, rol, bono, detalle);
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20050, 'SQLERRM');
    END AD_contrato;
    
    PROCEDURE DE_contrato(id INT) IS
    BEGIN
    DELETE FROM CONTRATOS WHERE id = id;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20051, 'SQLERRM');
    END DE_contrato;
    
    PROCEDURE CO_contrato(C_CONTRATO OUT SYS_REFCURSOR) IS
    BEGIN
    OPEN cursor FOR SELECT * FROM CONTRATOS;
    END CO_contrato;
    
END PA_CONTRATO;  
/

-- Implementación de PA_JUGADOR
CREATE OR REPLACE PACKAGE BODY PA_JUGADOR 
IS
    PROCEDURE AD_jugador(documento INT, nombre VARCHAR, posicion VARCHAR, estado NUMBER, valorMercado NUMBER, nombreEquipo VARCHAR) IS
    BEGIN
    INSERT INTO Jugadores VALUES (documento, nombre, posicion, estado, valorMercado, nombreEquipo);
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20052, 'SQLERRM');
    END AD_jugador;
        
    PROCEDURE DE_jugador(documento INT) IS
    BEGIN
    DELETE FROM JUGADORES WHERE documento = documento;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20053, 'SQLERRM');
    END DE_jugador;
        
    PROCEDURE CO_jugador(C_JUGADOR OUT SYS_REFCURSOR) IS
    BEGIN
    OPEN C_JUGADOR FOR SELECT * FROM JUGADORES;
    END CO_jugador;

END PA_JUGADOR;  
/
    

-- Implementación de PA_GERENTE
CREATE OR REPLACE PACKAGE BODY PA_GERENTE AS
    PROCEDURE AD_gerente(documento INT, nombre VARCHAR, sueldo INT, experiencia INT, nombreEquipo VARCHAR) IS
    BEGIN
    INSERT INTO GERENTES VALUES (documento, nombre, sueldo, experiencia, nombreEquipo);
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20054, 'SQLERRM');
    END AD_gerente;


    PROCEDURE DE_gerente(documento IN INT) IS
    BEGIN
    DELETE FROM GERENTES WHERE documento = documento;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20055, 'SQLERRM');
    END DE_gerente;
        
    PROCEDURE CO_gerente(C_GERENTE OUT SYS_REFCURSOR) IS
    BEGIN
    OPEN C_GERENTE FOR SELECT * FROM GERENTES;
    END CO_gerente;
    
END PA_GERENTE;
/

-- Implementación de PA_EQUIPO
CREATE OR REPLACE PACKAGE BODY PA_EQUIPO 
IS
    PROCEDURE AD_equipo(nombre VARCHAR, color VARCHAR, ciudad VARCHAR, posicion INT, estado IN NUMBER, presupuesto IN NUMBER, mision IN VARCHAR)IS
    BEGIN
    INSERT INTO Equipos VALUES (nombre, color, ciudad, posicion, estado, presupuesto, mision);
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20056, 'SQLERRM');
    END AD_equipo;
    
    PROCEDURE DE_equipo(nombre IN VARCHAR) IS
    BEGIN
    DELETE FROM EQUIPOS WHERE nombre = nombre;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20057, 'SQLERRM');
    END DE_equipo;
    
    PROCEDURE CO_equipo(C_EQUIPO OUT SYS_REFCURSOR) IS
    BEGIN
    OPEN C_EQUIPO FOR SELECT * FROM EQUIPOS;
    END CO_equipo;

END PA_EQUIPO;
/


CREATE OR REPLACE PACKAGE BODY PA_HINCHA
IS
    PROCEDURE AD_hincha(cedula INT, nombre VARCHAR, abonado NUMBER, nombreEquipo VARCHAR) IS
    BEGIN
    INSERT INTO HINCHAS VALUES (cedula, nombre, abonado, nombreEquipo);
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20058, 'SQLERRM');
    END AD_hincha;
    
    PROCEDURE DE_hincha(cedula INT) IS
    BEGIN
    DELETE FROM HINCHAS WHERE cedula = cedula;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20059, 'SQLERM');
    END DE_hincha;

    PROCEDURE CO_hincha(C_HINCHA OUT SYS_REFCURSOR) IS
    BEGIN
    OPEN C_HINCHA FOR SELECT * FROM HINCHAS;
    END CO_hincha;

END PA_HINCHA;
/

CREATE OR REPLACE PACKAGE BODY PA_PRESTAMO
IS
    PROCEDURE AD_prestamo(id INT, fechaInicio DATE, fechaFinal DATE, documentoJugador INT, nombreEquipo VARCHAR) IS
    BEGIN
    INSERT INTO PRESTAMOS VALUES (id, fechaInicio, fechaFinal, documentoJugador, nombreEquipo);
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20060, 'SQLERRM');
    END AD_prestamo;

    PROCEDURE DE_prestamo(id INT) 
    IS
    BEGIN
    DELETE FROM PRESTAMOS WHERE id = id;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20061, 'SQLERM');
    END DE_prestamo;
    
    PROCEDURE CO_prestamo(C_PRESTAMO OUT SYS_REFCURSOR) IS
    BEGIN
    OPEN C_PRESTAMO FOR SELECT * FROM PRESTAMOS;
    END CO_prestamo;
    

END PA_HINCHA;
/
