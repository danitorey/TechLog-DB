-- TechLog DB — Indices

CREATE INDEX IF NOT EXISTS idx_manuales_area_id     ON manuales(area_id);
CREATE INDEX IF NOT EXISTS idx_manuales_fecha       ON manuales(fecha_actividad);
CREATE INDEX IF NOT EXISTS idx_manuales_estado      ON manuales(estado);
CREATE INDEX IF NOT EXISTS idx_manuales_uuid        ON manuales(uuid);
CREATE INDEX IF NOT EXISTS idx_manuales_area_fecha  ON manuales(area_id, fecha_actividad);
CREATE INDEX IF NOT EXISTS idx_manuales_titulo_trgm ON manuales USING gin(titulo gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_manuales_tags        ON manuales USING gin(tags);

CREATE TABLE IF NOT EXISTS actividades (
  id               SERIAL PRIMARY KEY,
  carpeta          TEXT,
  titulo           TEXT,
  objetivo         TEXT,
  pasos            TEXT,
  conclusion       TEXT,
  fecha_actividad  DATE,
  archivo          TEXT,
  created_at       TIMESTAMP DEFAULT NOW()
);
