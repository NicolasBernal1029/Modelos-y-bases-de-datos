/**
    * @file FuentesVerdes.sql
    * @brief Script de creación de base de datos para Liga BetPlay Stats (versión corregida)
    * @version 1.1
    * @date 2025-04-13
    * @creator Nicolas Bernal y Juan Bogotá
    * @modifier [Correcciones realizadas]
    */

-- RESTRICCIONES DE TUPLAS

ALTER TABLE Documentaciones 
ADD CONSTRAINT chk_fechaDoc CHECK (fechaEmision < fechaVencimiento);

ALTER TABLE Prestamos 
ADD CONSTRAINT chk_fechaPrestamo CHECK (fechaInicio < fechaFinal);

ALTER TABLE Jugadores
ADD CONSTRAINT chk_jugadores_posicion
CHECK (REGEXP_LIKE(posicion, '^[A-Z]{3}$')); -- Validar que la posición tenga formato correcto (por ejemplo: 3 letras como "DEL", "MED", "DEF")

ALTER TABLE Equipos
ADD CONSTRAINT chk_nombre_equipo
CHECK (REGEXP_LIKE(nombre, '^[A-Z]')); -- Validar que el nombre del equipo comience con una letra mayúscula

ALTER TABLE Representantes
ADD CONSTRAINT chk_telefono_representante
CHECK (LENGTH(telefono) = 10);          -- Validar que el teléfono tenga 10 dígitos

ALTER TABLE Equipos 
ADD CONSTRAINT chk_presupuesto CHECK (presupuesto > 0);  -- Validar que el presupuesto sea mayor a 0

ALTER TABLE Hinchas 
ADD CONSTRAINT chk_cedula CHECK (LENGTH(cedula) = 10);       -- Validar que la cédula tenga 10 dígitos

ALTER TABLE Jugadores 
ADD CONSTRAINT chk_valorMercado CHECK (valorMercado > 0);

ALTER TABLE Canteranos 
ADD CONSTRAINT chk_añosEnCantera CHECK (añosEnCantera >= 1);

ALTER TABLE Extranjeros 
ADD CONSTRAINT chk_documento CHECK (LENGTH(documento) = 10);

ALTER TABLE Representantes 
ADD CONSTRAINT chk_experiencia CHECK (experiencia >= 0);

ALTER TABLE Transferencias 
ADD CONSTRAINT chk_valorTransferencia CHECK (valor > 0);

ALTER TABLE Contratos 
ADD CONSTRAINT chk_sueldo CHECK (sueldo > 0);

ALTER TABLE Gerentes 
ADD CONSTRAINT chk_experienciaGerente CHECK (experiencia >= 0);

ALTER TABLE Deportivos 
ADD CONSTRAINT chk_rendimientoDeportivo CHECK (rendimineto BETWEEN 0 AND 100);

COMMIT;