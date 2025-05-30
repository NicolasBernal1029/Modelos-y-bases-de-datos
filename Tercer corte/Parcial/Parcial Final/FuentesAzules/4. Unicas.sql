--CLAVES UNICAS

ALTER TABLE CorreosPorGerentes
ADD CONSTRAINT uk_correoG UNIQUE (correo);

ALTER TABLE CorreosPorRepresentantes
ADD CONSTRAINT uk_correoR UNIQUE (correo);

ALTER TABLE Notificaciones
ADD CONSTRAINT uk_notificaciones UNIQUE (descripcion);

COMMIT;