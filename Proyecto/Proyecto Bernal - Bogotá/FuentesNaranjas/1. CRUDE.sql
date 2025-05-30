-- Paquete para gestión de contratos
CREATE OR REPLACE PACKAGE PA_CONTRATO 
IS
PROCEDURE AD_contrato(id IN INT, duracion IN VARCHAR, sueldo IN NUMBER, rol IN VARCHAR, bono IN NUMBER, detalle IN VARCHAR);
PROCEDURE DE_contrato(id IN INT);
PROCEDURE CO_contrato (C_CONTRATO OUT SYS_REFCURSOR);
END PA_CONTRATO;
/

-- Paquete para gestión de jugadores
CREATE OR REPLACE PACKAGE PA_JUGADOR IS
PROCEDURE AD_jugador(documento IN INT, nombre IN VARCHAR, posicion IN VARCHAR, estado IN NUMBER, valorMercado IN NUMBER, nombreEquipo IN VARCHAR);
PROCEDURE DE_jugador(documento IN INT);
PROCEDURE CO_jugador(C_JUGADOR OUT SYS_REFCURSOR);
END PA_JUGADOR;
/

-- Paquete para gestión de gerentes
CREATE OR REPLACE PACKAGE PA_GERENTE 
IS
PROCEDURE AD_gerente(documento IN INT, nombre IN VARCHAR, telefono IN INT, experiencia IN INT, nombreEquipo IN VARCHAR);
PROCEDURE DE_gerente(documento IN INT);
PROCEDURE CO_gerente(C_GERENTE OUT SYS_REFCURSOR);
END PA_GERENTE;
/

-- Paquete para gestión de equipos
CREATE OR REPLACE PACKAGE PA_EQUIPO 
IS
PROCEDURE AD_equipo(nombre IN VARCHAR, color IN VARCHAR, ciudad IN VARCHAR, posicion IN INT, estado IN NUMBER, presupuesto IN NUMBER, mision IN VARCHAR);
PROCEDURE DE_equipo(nombre IN VARCHAR);
PROCEDURE CO_equipo (C_EQUIPO OUT SYS_REFCURSOR);
END PA_EQUIPO;
/

-- Paquete para gestión de hinchIS
CREATE OR REPLACE PACKAGE PA_HINCHA 
IS
PROCEDURE AD_hincha(cedula IN INT, nombre IN VARCHAR, abonado IN NUMBER, nombreEquipo IN VARCHAR);
PROCEDURE DE_hincha(cedula IN INT);
PROCEDURE CO_hincha(C_HINCHA OUT SYS_REFCURSOR);
END PA_HINCHA;
/

-- Paquete para gestión de préstamos
CREATE OR REPLACE PACKAGE PA_PRESTAMO 
IS
PROCEDURE AD_prestamo(id IN INT, fechaInicio IN DATE, fechaFinal IN DATE, documentoJugador IN INT, nombreEquipo IN VARCHAR);
PROCEDURE DE_prestamo(id IN INT);
PROCEDURE CO_prestamo (C_PRESTAMO OUT SYS_REFCURSOR);
END PA_PRESTAMO;
/