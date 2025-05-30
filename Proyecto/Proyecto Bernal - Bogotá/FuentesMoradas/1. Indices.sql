/**
    * @file FuentesMoradas
    * @brief Script de creacion de base de datos para Liga BetPlay Stats
    * @version 1.0
    * @date 2025-05-17
    * @creator Nicolas Bernal y Juan Bogotá
    */
    
-- Índices

-- Equipos
CREATE INDEX idx_Equipos_ciudad ON Equipos(ciudad);
CREATE INDEX idx_Equipos_presupuesto ON Equipos(presupuesto);

-- Hinchas
CREATE INDEX idx_Hinchas_nombreEquipo ON Hinchas(nombreEquipo);

-- Partidos
CREATE INDEX idx_Partidos_fecha ON Partidos(fecha);
CREATE INDEX idx_Partidos_ciudad ON Partidos(ciudad);

-- Estadios
CREATE INDEX idx_Estadios_nombreEquipo ON Estadios(nombreEquipo);

-- TieneResultadosDe
CREATE INDEX idx_Resultado_golesAFavor ON TieneResultadosDe(golesAFavor);
CREATE INDEX idx_Resultado_puntos ON TieneResultadosDe(puntos);

-- Jugadores
CREATE INDEX idx_Jugadores_posicion ON Jugadores(posicion);
CREATE INDEX idx_Jugadores_valorMercado ON Jugadores(valorMercado);

-- Canteranos
CREATE INDEX idx_Canteranos_categoriaFormacion ON Canteranos(categoriaFormacion);

-- Extranjeros
CREATE INDEX idx_Extranjeros_paisOrigen ON Extranjeros(paisOrigen);

-- Representantes
CREATE INDEX idx_Representantes_documentoJugador ON Representantes(documentoJugador);

-- Prestamos
CREATE INDEX idx_Prestamos_fechaInicio ON Prestamos(fechaInicio);

-- Contratos
CREATE INDEX idx_Contratos_duracion ON Contratos(duracion);

-- Transferencias
CREATE INDEX idx_Transferencias_valor ON Transferencias(valor);

-- Documentaciones
CREATE INDEX idx_Documentaciones_fechaVencimiento ON Documentaciones(fechaVencimiento);

-- Gerentes
CREATE INDEX idx_Gerentes_nombreEquipo ON Gerentes(nombreEquipo);

-- CorreosPorGerentes
CREATE INDEX idx_CorreosPorGerentes_documentoGerente ON CorreosPorGerentes(documentoGerente);

-- Financieros
CREATE INDEX idx_Financieros_cantidadPatrocinadores ON Financieros(cantidadDePatrocinadoresConseguidos);

-- Deportivos
CREATE INDEX idx_Deportivos_rendimiento ON Deportivos(rendimineto);

COMMIT;