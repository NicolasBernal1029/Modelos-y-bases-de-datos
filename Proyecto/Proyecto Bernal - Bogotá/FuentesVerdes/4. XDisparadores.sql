-- Eliminar todos los disparadores definidos

--DROP TRIGGER trg_insert_jugador;
DROP TRIGGER trg_modificar_solo_detalle;
DROP TRIGGER trg_control_abonos;
DROP TRIGGER trg_solo_modificar_nombre_estadio;
DROP TRIGGER trg_un_solo_dt_por_equipo;
DROP TRIGGER trg_limite_jugadores_por_equipo;
DROP TRIGGER trg_validar_estado_jugador_transferencia;
DROP TRIGGER trg_valida_documento_jugador;
DROP TRIGGER trg_valida_valor_mercado;
DROP TRIGGER trg_valida_estado_jugador;
DROP TRIGGER trg_valida_equipo_jugador;
DROP TRIGGER trg_valida_valor_transferencia;
DROP TRIGGER trg_valida_contrato_transferencia;
DROP TRIGGER trg_valida_fecha_partido;
DROP TRIGGER trg_valida_fechas_prestamo;
DROP TRIGGER trg_verifica_prestamos_activos;

COMMIT;

