-- ACCIONES DE REFERENCIA


/*ALTER TABLE Hinchas 
DROP CONSTRAINT fk_Hinchas_Equipos;

ALTER TABLE Estadios
DROP CONSTRAINT fk_Estadios_Equipos;

ALTER TABLE TieneResultadosDe
DROP CONSTRAINT fk_TRD_Equipos;

ALTER TABLE TieneResultadosDe
DROP CONSTRAINT fk_TRD_Partidos;

ALTER TABLE Jugadores 
DROP CONSTRAINT fk_Jugadores_Equipos;

ALTER TABLE Canteranos 
DROP CONSTRAINT fk_Canteranos_Jugadores;

ALTER TABLE Extranjeros 
DROP CONSTRAINT fk_Extranjeros_Jugadores;

ALTER TABLE Representantes 
DROP CONSTRAINT fk_Representantes_Jugadores;

ALTER TABLE CorreosPorRepresentantes 
DROP CONSTRAINT fk_CPR_Representantes;

ALTER TABLE Prestamos 
DROP CONSTRAINT fk_Prestamos_Jugadores;

ALTER TABLE Prestamos 
DROP CONSTRAINT fk_Prestamos_Equipos;

ALTER TABLE Transferencias 
DROP CONSTRAINT fk_Transferencias_Equipos;

ALTER TABLE Transferencias 
DROP CONSTRAINT fk_Transferencias_Contratos;

ALTER TABLE Transferencias 
DROP CONSTRAINT fk_Transferencias_Jugadores;

ALTER TABLE Documentaciones 
DROP CONSTRAINT fk_Documentaciones_Contratos;

ALTER TABLE Gerentes 
DROP CONSTRAINT fk_Gerentes_Equipos;

ALTER TABLE CorreosPorGerentes 
DROP CONSTRAINT fk_CPG_Gerentes;

ALTER TABLE Financieros 
DROP CONSTRAINT fk_Financieros_Gerentes;

ALTER TABLE Deportivos 
DROP CONSTRAINT fk_Deportivos_Gerentes;

COMMIT;
*/


-- Al eliminar el jugador su representante debe ser eliminado.

ALTER TABLE Representantes 
ADD CONSTRAINT fk_Representantes_Jugadores
FOREIGN KEY (documentoJugador) REFERENCES Jugadores(documento)
ON DELETE CASCADE;

--  Al eliminar el contrato, se deben eliminar las documentaciones asociadas.

ALTER TABLE Documentaciones 
ADD CONSTRAINT fk_Documentaciones_Contratos
FOREIGN KEY (idContrato) REFERENCES Contratos(id)
ON DELETE CASCADE;

-- ON DELETE CASCADE para representantes y sus correos
ALTER TABLE CorreosPorRepresentantes
ADD CONSTRAINT fk_CPR_Representantes
FOREIGN KEY (documentoRepresentante) REFERENCES Representantes(documento)
ON DELETE CASCADE;

COMMIT;
