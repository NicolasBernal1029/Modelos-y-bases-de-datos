-- ATRIBUTOS

--TCorreo
ALTER TABLE CorreosPorRepresentantes 
ADD CONSTRAINT chk_correo 
CHECK (correo LIKE '%_@__%.__%' AND correo NOT LIKE '% %');

ALTER TABLE CorreosPorGerentes 
ADD CONSTRAINT chk_correo_gerente 
CHECK (correo LIKE '%_@__%.__%' AND correo NOT LIKE '% %');

--TDuracion
ALTER TABLE Contratos
ADD CONSTRAINT chk_duracion_valida
CHECK (
    REGEXP_LIKE(TRIM(duracion), '^[0-9]+ (años|año|meses|mes)$')
    AND TO_NUMBER(REGEXP_SUBSTR(duracion, '^[0-9]+')) > 0
);

--TEstado
ALTER TABLE Jugadores
ADD CONSTRAINT chk_estado_valido
CHECK (estado IN (0, 1));

ALTER TABLE Transferencias
ADD CONSTRAINT chk_estado_valido_transferencias
CHECK (epocaDeTransferencias IN (0, 1));


--TMoneda
ALTER TABLE Contratos
ADD CONSTRAINT chk_contrato_sueldo
CHECK (
    sueldo >= 0
    AND sueldo <= 1000000000  -- Límite de 1 billón
);

ALTER TABLE Equipos
ADD CONSTRAINT chk_equipo_presupuesto
CHECK (
    presupuesto >= 0
    AND presupuesto <= 1000000000  -- Límite de 1 billón
);

ALTER TABLE Jugadores
ADD CONSTRAINT chk_jugador_valorMercado
CHECK (
    valorMercado >= 0
    AND valorMercado <= 1000000000  -- Límite de 1 billón
);

ALTER TABLE Transferencias
ADD CONSTRAINT chk_transferencia_valor
CHECK (
    valor >= 0
    AND valor <= 1000000000  -- Límite de 1 billón
);


--TPorcentaje
ALTER TABLE CONTRATOS
ADD CONSTRAINT chk_contrato_bono_porcentaje
CHECK (
    TO_NUMBER(bono) BETWEEN 0 AND 100
);


COMMIT;