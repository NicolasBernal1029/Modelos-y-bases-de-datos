-- CLAVES FORANEAS

ALTER TABLE Hinchas 
ADD CONSTRAINT fk_Hinchas_Equipos 
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE Estadios
ADD CONSTRAINT fk_Estadios_Equipos
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE TieneResultadosDe
ADD CONSTRAINT fk_TRD_Equipos
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE TieneResultadosDe
ADD CONSTRAINT fk_TRD_Partidos
FOREIGN KEY (idPartido) REFERENCES Partidos(idPartido);

ALTER TABLE Jugadores 
ADD CONSTRAINT fk_Jugadores_Equipos 
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE Canteranos 
ADD CONSTRAINT fk_Canteranos_Jugadores 
FOREIGN KEY (documento) REFERENCES Jugadores(documento);

ALTER TABLE Extranjeros 
ADD CONSTRAINT fk_Extranjeros_Jugadores 
FOREIGN KEY (documento) REFERENCES Jugadores(documento);

ALTER TABLE Representantes 
ADD CONSTRAINT fk_Representantes_Jugadores 
FOREIGN KEY (documentoJugador) REFERENCES Jugadores(documento);

ALTER TABLE CorreosPorRepresentantes 
ADD CONSTRAINT fk_CPR_Representantes 
FOREIGN KEY (documentoRepresentante) REFERENCES Representantes(documento);

ALTER TABLE Prestamos 
ADD CONSTRAINT fk_Prestamos_Jugadores 
FOREIGN KEY (documentoJugador) REFERENCES Jugadores(documento);

ALTER TABLE Prestamos 
ADD CONSTRAINT fk_Prestamos_Equipos 
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE Transferencias 
ADD CONSTRAINT fk_Transferencias_Equipos 
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE Transferencias 
ADD CONSTRAINT fk_Transferencias_Contratos 
FOREIGN KEY (idContrato) REFERENCES Contratos(id);

ALTER TABLE Transferencias 
ADD CONSTRAINT fk_Transferencias_Jugadores
FOREIGN KEY (documentoJugador) REFERENCES Jugadores(documento);

ALTER TABLE Documentaciones 
ADD CONSTRAINT fk_Documentaciones_Contratos 
FOREIGN KEY (idContrato) REFERENCES Contratos(id);

ALTER TABLE Gerentes 
ADD CONSTRAINT fk_Gerentes_Equipos 
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE CorreosPorGerentes 
ADD CONSTRAINT fk_CPG_Gerentes 
FOREIGN KEY (documentoGerente) REFERENCES Gerentes(documento);

ALTER TABLE Financieros 
ADD CONSTRAINT fk_Financieros_Gerentes 
FOREIGN KEY (documento) REFERENCES Gerentes(documento);

ALTER TABLE Deportivos 
ADD CONSTRAINT fk_Deportivos_Gerentes 
FOREIGN KEY (documento) REFERENCES Gerentes(documento);

COMMIT;