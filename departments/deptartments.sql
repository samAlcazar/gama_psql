CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE dependencias (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(150) NOT NULL,              -- 'Secretaría Técnica'
    sigla VARCHAR(20) UNIQUE,                  -- 'SEC-TEC' (para códigos y referencias rápidas)
    dependencia_padre_id UUID REFERENCES dependencias(id), -- Jerarquía (Secretaría Técnica contiene a Soporte Técnico)
    nivel SMALLINT NOT NULL DEFAULT 1,         -- 1: Secretaría, 2: Dirección, 3: Unidad/Oficina
    activo BOOLEAN DEFAULT true,               -- Para bajas lógicas, nunca eliminar
    fecha_creacion TIMESTAMPTZ DEFAULT NOW()
);