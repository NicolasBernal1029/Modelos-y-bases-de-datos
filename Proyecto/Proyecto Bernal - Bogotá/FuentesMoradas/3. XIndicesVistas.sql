-- XIndicesVistas

-- Eliminación de Vistas

DROP VIEW Vista_Jugadores_Activos;
DROP VIEW Vista_Jugadores_Inactivos;
DROP VIEW Vista_Transferencias_Recientes;
DROP VIEW Vista_Contratos_Verano;
DROP VIEW Vista_Partidos_Equipo;
DROP VIEW Vista_Resultados_Partidos;
DROP VIEW Vista_Lugar_Partidos;

COMMIT;

-- Eliminación de Índices


DROP INDEX idx_Equipos_ciudad;
DROP INDEX idx_Equipos_presupuesto;
DROP INDEX idx_Hinchas_nombreEquipo;
DROP INDEX idx_Partidos_fecha;
DROP INDEX idx_Partidos_ciudad;
DROP INDEX idx_Estadios_nombreEquipo;
DROP INDEX idx_Resultado_golesAFavor;
DROP INDEX idx_Resultado_puntos;
DROP INDEX idx_Jugadores_posicion;
DROP INDEX idx_Jugadores_valorMercado;
DROP INDEX idx_Canteranos_categoriaFormacion;
DROP INDEX idx_Extranjeros_paisOrigen;
DROP INDEX idx_Representantes_documentoJugador;
DROP INDEX idx_Prestamos_fechaInicio;
DROP INDEX idx_Contratos_duracion;
DROP INDEX idx_Transferencias_valor;
DROP INDEX idx_Documentaciones_fechaVencimiento;
DROP INDEX idx_Gerentes_nombreEquipo;
DROP INDEX idx_CorreosPorGerentes_documentoGerente;
DROP INDEX idx_Financieros_cantidadPatrocinadores;
DROP INDEX idx_Deportivos_rendimiento;

COMMIT;