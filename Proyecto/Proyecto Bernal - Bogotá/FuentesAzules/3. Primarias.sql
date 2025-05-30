-- CLAVES PRIMARIAS

ALTER TABLE Equipos 
ADD CONSTRAINT pk_Equipos PRIMARY KEY (nombre);

ALTER TABLE Hinchas 
ADD CONSTRAINT pk_Hinchas PRIMARY KEY (cedula);

ALTER TABLE Partidos 
ADD CONSTRAINT pk_Partidos PRIMARY KEY (idPartido);

ALTER TABLE Estadios
ADD CONSTRAINT pk_Estadios PRIMARY KEY (nombre);

ALTER TABLE TieneResultadosDe
ADD CONSTRAINT pk_TRD PRIMARY KEY (nombreEquipo, idPartido);

ALTER TABLE Jugadores 
ADD CONSTRAINT pk_Jugadores PRIMARY KEY (documento);

ALTER TABLE Canteranos 
ADD CONSTRAINT pk_Canteranos PRIMARY KEY (documento);

ALTER TABLE Extranjeros 
ADD CONSTRAINT pk_Extranjeros PRIMARY KEY (documento);

ALTER TABLE Representantes 
ADD CONSTRAINT pk_Representantes PRIMARY KEY (documento);

ALTER TABLE CorreosPorRepresentantes 
ADD CONSTRAINT pk_CorreosPorRepresentantes PRIMARY KEY (correo, documentoRepresentante);

ALTER TABLE Prestamos 
ADD CONSTRAINT pk_Prestamos PRIMARY KEY (id);

ALTER TABLE Contratos 
ADD CONSTRAINT pk_Contratos PRIMARY KEY (id);

ALTER TABLE Transferencias 
ADD CONSTRAINT pk_Transferencias PRIMARY KEY (numero);

ALTER TABLE Documentaciones 
ADD CONSTRAINT pk_Documentaciones PRIMARY KEY (id, idContrato);

ALTER TABLE Gerentes 
ADD CONSTRAINT pk_Gerentes PRIMARY KEY (documento);

ALTER TABLE CorreosPorGerentes 
ADD CONSTRAINT pk_CorreosPorGerentes PRIMARY KEY (correo, documentoGerente);

ALTER TABLE Financieros 
ADD CONSTRAINT pk_Financieros PRIMARY KEY (documento);

ALTER TABLE Deportivos 
ADD CONSTRAINT pk_Deportivos PRIMARY KEY (documento);

COMMIT;