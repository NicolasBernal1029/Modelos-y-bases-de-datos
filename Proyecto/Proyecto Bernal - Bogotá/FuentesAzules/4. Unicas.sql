--CLAVES UNICAS

ALTER TABLE CorreosPorGerentes
ADD CONSTRAINT uk_correoG UNIQUE (correo);

ALTER TABLE CorreosPorRepresentantes
ADD CONSTRAINT uk_correoR UNIQUE (correo);

COMMIT;