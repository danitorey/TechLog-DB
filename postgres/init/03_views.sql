-- TechLog DB — Vistas y triggers

CREATE OR REPLACE FUNCTION fn_set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.actualizado_en = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_areas_updated_at
    BEFORE UPDATE ON areas
    FOR EACH ROW EXECUTE FUNCTION fn_set_updated_at();

CREATE TRIGGER trg_manuales_updated_at
    BEFORE UPDATE ON manuales
    FOR EACH ROW EXECUTE FUNCTION fn_set_updated_at();

CREATE OR REPLACE VIEW vw_manuales_detalle AS
SELECT
    m.id, m.uuid,
    a.nombre        AS area,
    a.ruta_onedrive AS onedrive_destino,
    m.titulo, m.objetivo, m.prerrequisitos,
    m.pasos, m.notas, m.version, m.tags,
    m.fecha_actividad, m.estado, m.creado_en
FROM manuales m
LEFT JOIN areas a ON a.id = m.area_id
ORDER BY m.fecha_actividad DESC;

CREATE OR REPLACE VIEW vw_resumen_mensual AS
SELECT
    a.nombre                                       AS area,
    a.ruta_onedrive,
    EXTRACT(YEAR  FROM m.fecha_actividad)::INT     AS anio,
    EXTRACT(MONTH FROM m.fecha_actividad)::INT     AS mes,
    COUNT(*)                                       AS total_actividades,
    ARRAY_AGG(m.titulo ORDER BY m.fecha_actividad) AS titulos,
    MIN(m.fecha_actividad)                         AS primera_actividad,
    MAX(m.fecha_actividad)                         AS ultima_actividad
FROM manuales m
JOIN areas a ON a.id = m.area_id
WHERE m.estado != 'archivado'
GROUP BY a.nombre, a.ruta_onedrive,
         EXTRACT(YEAR FROM m.fecha_actividad),
         EXTRACT(MONTH FROM m.fecha_actividad)
ORDER BY anio DESC, mes DESC, area;
