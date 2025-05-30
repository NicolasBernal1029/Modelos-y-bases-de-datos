-- 1. Registro de usuarios con roles adecuados
DECLARE
    v_username VARCHAR2(30) := 'EQUIPOS';
    v_password VARCHAR2(30) := 'password';
    v_role VARCHAR2(30) := 'EQUIPOS';
BEGIN
    EXECUTE IMMEDIATE 'CREATE USER ' || v_username || ' IDENTIFIED BY ' || v_password;
    EXECUTE IMMEDIATE 'GRANT ' || v_role || ' TO ' || v_username;
END;
/
-- 2. Registro de usuarios con roles adecuados
DECLARE
    v_username VARCHAR2(30) := 'GERENTE_DEPORTIVO';
    v_password VARCHAR2(30) := 'password';
    v_role VARCHAR2(30) := 'GERENTE_DEPORTIVO';
BEGIN
    EXECUTE IMMEDIATE 'CREATE USER ' || v_username || ' IDENTIFIED BY ' || v_password;
    EXECUTE IMMEDIATE 'GRANT ' || v_role || ' TO ' || v_username;
END;
/
-- 3. Registro de usuarios con roles adecuados
DECLARE
    v_username VARCHAR2(30) := 'GERENTE_DEPORTIVO';
    v_password VARCHAR2(30) := 'password';
    v_role VARCHAR2(30) := 'GERENTE_DEPORTIVO';
BEGIN
    EXECUTE IMMEDIATE 'CREATE USER ' || v_username || ' IDENTIFIED BY ' || v_password;
    EXECUTE IMMEDIATE 'GRANT ' || v_role || ' TO ' || v_username;
END;
/
-- 4. Registro de usuarios con roles adecuados
DECLARE
    v_username VARCHAR2(30) := 'GERENTE_DEPORTIVO';
    v_password VARCHAR2(30) := 'password';
    v_role VARCHAR2(30) := 'GERENTE_DEPORTIVO';
BEGIN
    EXECUTE IMMEDIATE 'CREATE USER ' || v_username || ' IDENTIFIED BY ' || v_password;
    EXECUTE IMMEDIATE 'GRANT ' || v_role || ' TO ' || v_username;
END;
/
