CREATE TABLE usuarios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Datos de identificación
    nombre_completo VARCHAR(100) NOT NULL,     -- 'Juan Pérez Mamani'
    ci VARCHAR(15) UNIQUE NOT NULL,            -- Cédula de Identidad (clave para el sector público)
    email VARCHAR(100) UNIQUE,   -- 'juan.perez@municipio.gob.bo'
    telefono VARCHAR(20),
    
    -- Dónde trabaja
    dependencia_id UUID NOT NULL,
    cargo VARCHAR(100),                        -- 'Técnico de Soporte', 'Director', 'Secretario'
    
    -- Datos de autenticación
    nombre_usuario VARCHAR(30) UNIQUE NOT NULL, -- 'jperez' (para login)
    password_hash VARCHAR(255) NOT NULL,        -- Hash de bcrypt o argon2id, NUNCA texto plano
    
    -- Control de acceso y seguridad
    rol_principal VARCHAR(30) NOT NULL,         -- 'ADMIN', 'DIRECTOR', 'VENTANILLA', 'TECNICO' (simplifica la gestión)
    activo BOOLEAN DEFAULT true,
    requiere_cambio_password BOOLEAN DEFAULT true, -- Forzar cambio en primer login
    
    -- Trazabilidad del propio usuario
    fecha_creacion TIMESTAMPTZ DEFAULT NOW(),
    ultimo_acceso TIMESTAMPTZ,
    intentos_fallidos SMALLINT DEFAULT 0,
    bloqueado_hasta TIMESTAMPTZ,
    
    FOREIGN KEY (dependencia_id) REFERENCES dependencias(id) ON DELETE RESTRICT
);