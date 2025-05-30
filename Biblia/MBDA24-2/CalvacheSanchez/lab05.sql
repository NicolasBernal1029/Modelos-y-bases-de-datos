-- EXTENDIENDO USUARIOS

-- 1.
SELECT *
FROM mbda.data

-- 2.
INSERT INTO mbda.data VALUES('felipe.calvache-g@mail.escuelaing.edu.co', '323-391-9837', null, '1000092366', 'Felipe Calvache', null);
INSERT INTO mbda.data VALUES('jeisson.sanchez-g@mail.escuelaing.edu.co', '318-411-5195', null, '1000092301', 'Jeisson Sanchez', null);

-- 3.
DELETE FROM mbda.data
WHERE razon = 'Escuela Colombiana de Ingenieria' AND numero = '1000092301';

DELETE FROM mbda.data
WHERE razon = 'Escuela Colombiana de Ingenieria' AND numero = '1000092366';

-- 4.
GRANT UPDATE, DELETE 
ON mbda.data
TO bd1000092366;

GRANT UPDATE, DELETE 
ON mbda.data
TO '1000092301';

-- 5.
CREATE TRIGGER trg_usuarios
BEFORE INSERT ON USUARIOS
FOR EACH ROW
BEGIN
    :NEW.id := 'LT' || DBMS_RANDOM.STRING('U', 3);
    :NEW.fechaRegistro := SYSDATE;
END;


CREATE TRIGGER trg_personas
BEFORE INSERT ON PERSONA_NATURAL
FOR EACH ROW
BEGIN
    :NEW.tipoDocumento := 'CC';
    :NEW.nacionalidad := 'Colombiana';
END;


CREATE TRIGGER trg_empresas
BEFORE INSERT OR UPDATE ON EMPRESA
FOR EACH ROW
BEGIN
    IF SUBSTR(:NEW.nit, -2) != '-1' THEN
        RAISE_APPLICATION_ERROR(-20001, 'El NIT debe terminar en -1.');
    END IF;
END;


INSERT INTO USUARIOS(id, fechaRegistro, correo_electronico)
SELECT 'LT' || DMBS_RANDOM.STRING('U', 3) AS id, SYSDATE AS fechaRegistro, correoe_electronico
FROM (
    SELECT DISTINCT id, correo_electronico
    FROM mbda.data
)
WHERE NOMBRES IS NOT NULL OR RAZON IS NULL;


INSERT INTO PERSONA_NATURAL(tipoDocumento, numeroDocumento, nombres, nacionalidad, idUsuario)
SELECT 'CC' AS tipoDocumento, numeroDocumento, nombres, 'Colombiana' AS nacionalidad, idUsuario
FROM USUARIOS


INSERT INTO EMPRESA(nit, razonSocial, idUsuario, idPersonaNatural)
SELECT (nit LIKE '&-1') AS nit
FROM USUARIOS

  
  
  -- CRUDE
  
CREATE OR REPLACE PACKAGE PC_OFERTAS IS
    PROCEDURE AD_OFERTA(Xdireccion IN varchar, Xtipo_vivienda IN char,Xcosto IN number,Xanexos IN char,Xcodigo_ubicacion IN varchar,Xid_usuario IN varchar);
    PROCEDURE AD_FOTOGRAFIA(Xnombre IN varchar,Xruta IN varchar, Xdescripcion IN varchar);
    PROCEDURE MOD_OFERTA(Xanexos IN char,xNumero IN number);
    PROCEDURE CONS_FOTOGRAFIA(Xnombre IN VARCHAR);
    PROCEDURE MOD_FOTOGRAFIA(Xnombre IN varchar,Xruta IN varchar, Xdescripcion IN varchar);
    PROCEDURE MOD_OPCIONCREDITO(Xplazo IN int , Xvalormensual IN number, Xnumero_oferta IN number);
    PROCEDURE EL_OFERTA(Xnumero IN number);
    PROCEDURE EL_FOTOGRAFIA(Xnombre IN varchar);


END PC_OFERTAS;

--CRUDI

CREATE OR REPLACE PACKAGE BODY PC_OFERTAS IS

        --ad_oferta

        PROCEDURE AD_OFERTA(Xdireccion IN varchar, Xtipo_vivienda IN char,Xcosto IN number,Xanexos IN char,Xcodigo_ubicacion IN varchar,Xid_usuario IN varchar) 
        IS
        BEGIN
            --BEGIN TRANSACTION
            INSERT INTO OFERTA(direccion,tipo_vivienda, costo, anexos,codigo_ubicacion,id_usuario) 
            VALUES (Xdireccion,Xtipo_vivienda,Xcosto,Xanexos,Xcodigo_ubicacion,Xid_usuario );
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20001,'Error al insertar en oferta');
        END;
        
        
        --ad_fotografia
    
        PROCEDURE AD_FOTOGRAFIA(Xnombre IN varchar,Xruta IN varchar, Xdescripcion IN varchar)
        IS
        BEGIN
            --BEGIN TRANSACTION
            INSERT INTO FOTOGRAFIA(nombre,ruta,descripcion) 
            VALUES (Xnombre,Xruta,Xdescripcion);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                raise_application_error(-20002,'Error al insertar en fotografia');
        END;
        
        --mod_oferta
        
        PROCEDURE MOD_OFERTA(Xanexos IN char,Xnumero IN number)
        IS
        BEGIN
            --BEGIN TRANSACTION
            UPDATE OFERTA 
            SET anexos = Xanexos
            WHERE numero = Xnumero;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                    raise_application_error(-20003,'Error al modificar en oferta');
        END;
        
        
        
        
        -- cons fotografia
        
        PROCEDURE CONS_FOTOGRAFIA(Xnombre IN VARCHAR2) 
        IS
            foto VARCHAR(15);
        BEGIN
            -- BEGIN TRANSACTION
            SELECT nombre
            INTO foto
            FROM FOTOGRAFIA
            WHERE nombre = Xnombre;
        
        EXCEPTION
            WHEN OTHERS THEN
                    ROLLBACK;
                    raise_application_error(-20003,'Error al consultar fotografia');
        END;
        

        
        
        -- mod fotografia
        
        PROCEDURE MOD_FOTOGRAFIA(Xnombre IN varchar,Xruta IN varchar, Xdescripcion IN varchar)
        IS
        BEGIN
            --BEGIN TRANSACTION
            UPDATE FOTOGRAFIA
            SET ruta = Xruta, descripcion = Xdescripcion 
            WHERE nombre = Xnombre;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                    ROLLBACK;
                    raise_application_error(-20005,'Error al modificar en fotografia');
        END;   
        
        -- mod opcion_credito
        
        PROCEDURE  MOD_OPCIONCREDITO(Xplazo IN int , Xvalormensual IN number, Xnumero_oferta IN number)
        IS
        BEGIN
            --BEGIN TRANSACTION
            UPDATE OPCIONCREDITO
            SET plazo = Xplazo, valor_mensual = Xvalormensual
            WHERE numero_oferta = Xnumero_oferta;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                    ROLLBACK;
                    raise_application_error(-20006,'Error al modificar en opcion de credito');
        END;  
        
        -- el oferta
        
        PROCEDURE EL_OFERTA(Xnumero IN number)
        IS
        BEGIN
            DELETE FROM OFERTA
            WHERE numero = Xnumero;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                    ROLLBACK;
                    raise_application_error(-20007,'Error al eliminar en oferta');
        END;  
        
        
        -- el fotografia
        
        PROCEDURE EL_FOTOGRAFIA(Xnombre IN varchar)
        IS
        BEGIN
            DELETE FROM FOTOGRAFIA
            WHERE nombre = Xnombre;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                    ROLLBACK;
                    raise_application_error(-20008,'Error al eliminar en fotografia');
        END;  
        
        
         
END PC_OFERTAS;


--XCRUD

DROP PACKAGE PC_OFERTAS;

--CRUDOK
--1
BEGIN
    PC_OFERTAS.AD_OFERTA('Avenida 5 #12-34','B',10000,1,'UB002','U003');
END;
--2
BEGIN
    PC_OFERTAS.MOD_OFERTA(1, 1003); 
END;      

--3
DECLARE
    Xnombre VARCHAR2(100) := 'foto2'; 
    Xruta   VARCHAR2(255) := 'nueva_ruta/imagen.jpg'; 
    Xdescripcion VARCHAR2(255) := 'Descripción actualizada de la fotografía'; 
BEGIN
    PC_OFERTAS.MOD_FOTOGRAFIA(Xnombre, Xruta, Xdescripcion);
END;

--4
DECLARE
    Xnombre VARCHAR2(100) := 'foto3'; 
BEGIN
    PC_OFERTAS.EL_FOTOGRAFIA('Xnombre');
END;


--5

DECLARE
    Xnombre VARCHAR2(100) := 'foto123';  
    Xruta VARCHAR2(100) := 'ruta/foto123.jpg';  
    Xdescripcion VARCHAR2(255) := 'Descripción de la foto';  
BEGIN

    PC_OFERTAS.AD_FOTOGRAFIA(Xnombre, Xruta, Xdescripcion);
END;


--CRUDNoOK

--1
DECLARE
    v_foto VARCHAR(15);
BEGIN
    PC_OFERTAS.CONS_FOTOGRAFIA('foto_123');
END;

--2

DECLARE
    Xplazo INT := 10;  
    Xvalormensual NUMBER := 35000; 
    Xnumero_oferta NUMBER := 1001; 
BEGIN
    PC_OFERTAS.MOD_OPCIONCREDITO(Xplazo, Xvalormensual, Xnumero_oferta);
END;

--3

DECLARE
    Xnumero NUMBER := 1001;  
BEGIN
    PC_OFERTAS.EL_OFERTA(Xnumero);
END;
/




-- ActoresE

CREATE OR REPLACE PACKAGE PA_USUARIO AS
    PROCEDURE AD_oferta(p_numero IN NUMBER, p_fecha IN DATE, p_costo IN NUMBER);
    PROCEDURE DE_oferta(p_numero IN NUMBER, p_estado IN CHAR);
    FUNCTION CO_oferta RETURN SYS_REFCURSOR;
    PROCEDURE AD_demanda(p_numero IN NUMBER, p_tipoVivienda IN CHAR);
    PROCEDURE DE_demanda(p_numero IN NUMBER, p_valor IN NUMBER);
    FUNCTION CO_demanda RETURN SYS_REFCURSOR;
    FUNCTION CO_interesEn RETURN SYS_REFCURSOR;
END PA_USUARIO;


CREATE OR REPLACE PACKAGE PA_ANALISTA AS
    PROCEDURE AD_ubicacion(p_codigo IN VARCHAR2, p_ciudad IN VARCHAR2, p_zona IN CHAR);
    PROCEDURE DE_ubicacion(p_codigo IN VARCHAR2);
    FUNCTION CO_oferta RETURN SYS_REFCURSOR;
    FUNCTION CO_demanda RETURN SYS_REFCURSOR;
    FUNCTION CO_usuario RETURN SYS_REFCURSOR;
END PA_ANALISTA;
            
            
-- ActoresI


-- 2. 

CREATE ROLE PA_USUARIO;
GRANT SELECT, INSERT, UPDATE ON oferta TO PA_USUARIO;
GRANT SELECT, INSERT, UPDATE, DELETE ON demanda TO PA_USUARIO;
GRANT SELECT ON interesEn TO PA_USUARIO;

CREATE ROLE PA_ANALISTA;
GRANT SELECT ON ubicacion TO PA_ANALISTA;
GRANT SELECT, UPDATE, DELETE ON oferta TO PA_ANALISTA;
GRANT SELECT, UPDATE, DELETE ON demanda TO PA_ANALISTA;
GRANT SELECT ON usuario TO PA_ANALISTA; 


-- Seguridad

GRANT ALL ON oferta TO bd1000092301; 
GRANT ALL ON demanda TO bd1000092301; 
GRANT ALL ON usuario TO bd1000092301; 

GRANT ALL ON oferta TO bd1000093264; 
GRANT ALL ON demanda TO bd1000093264; 
GRANT ALL ON usuario TO bd1000093264;


-- xSeguridad

DROP ROLE PA_USUARIO;
DROP ROLE PA_ANALISTA;


-- SeguridadOK

-- SeguridadNoOK

-- Pruebas
-- Como administrador del sistema, quiero gestionar las ofertas y demandas en el sistema ...
-- ... para asegurar que los datos se almacenan y consultan correctamente. De hecho está implemetado como una función en el Astah
-- Con el procedimiento que creamos podemos verificar que la oferta se haya añadido a la base de datos
-- En este ejemplo la oferta con ID 1 debe estar presente en la tabla oferta. 
BEGIN
    PA_OFERTAS.AD_Oferta(1, SYSDATE, 900000000);
    COMMIT;
    -- Validar inserción
    SELECT * FROM OFERTAS WHERE id = 1;
END;

-- Ahora vamos a verificar que se pueda añadir un nuevo usuario al sistema desde los paquetes
-- 

BEGIN
    PA_USUARIOS.AD_Usuario('egraysmark0@craigslist.org', '221-394-3822', null);
    COMMIT;
    -- Validar inserción
    SELECT * FROM USUARIOS WHERE email = 'egraysmark0@craigslist.org';
END;











         
