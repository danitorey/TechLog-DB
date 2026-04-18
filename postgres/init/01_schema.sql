-- TechLog DB — Esquema principal

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

CREATE TABLE IF NOT EXISTS areas (
    id             SERIAL       PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL UNIQUE,
    descripcion    TEXT,
    ruta_onedrive  TEXT,
    activo         BOOLEAN      NOT NULL DEFAULT TRUE,
    creado_en      TIMESTAMP    NOT NULL DEFAULT NOW(),
    actualizado_en TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS manuales (
    id              SERIAL       PRIMARY KEY,
    uuid            UUID         NOT NULL DEFAULT uuid_generate_v4(),
    area_id         INT          REFERENCES areas(id) ON DELETE SET NULL,
    titulo          VARCHAR(200) NOT NULL,
    objetivo        TEXT,
    prerrequisitos  TEXT,
    pasos           TEXT         NOT NULL,
    notas           TEXT,
    version         VARCHAR(20)  NOT NULL DEFAULT '1.0',
    tags            TEXT[],
    fecha_actividad DATE         NOT NULL DEFAULT CURRENT_DATE,
    creado_en       TIMESTAMP    NOT NULL DEFAULT NOW(),
    actualizado_en  TIMESTAMP    NOT NULL DEFAULT NOW(),
    estado          VARCHAR(50)  NOT NULL DEFAULT 'borrador'
                    CHECK (estado IN ('borrador','revisado','aprobado','archivado'))
);

CREATE TABLE IF NOT EXISTS entregables_mensuales (
    id                SERIAL     PRIMARY KEY,
    area_id           INT        REFERENCES areas(id) ON DELETE SET NULL,
    mes               SMALLINT   NOT NULL CHECK (mes BETWEEN 1 AND 12),
    anio              SMALLINT   NOT NULL,
    resumen           TEXT,
    total_actividades INT        NOT NULL DEFAULT 0,
    ruta_onedrive     TEXT,
    generado_en       TIMESTAMP  NOT NULL DEFAULT NOW(),
    subido_en         TIMESTAMP,
    estado            VARCHAR(50) NOT NULL DEFAULT 'pendiente'
                      CHECK (estado IN ('pendiente','generado','subido','error')),
    UNIQUE (area_id, mes, anio)
);
