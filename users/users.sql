CREATE TABLE users (
    id UUID DEFAULT gen_random_uuid(),
    
    -- Datos de identificación
    user_name VARCHAR(100) NOT NULL,     -- 'Juan Pérez Mamani'
    user_ci VARCHAR(15) UNIQUE NOT NULL,            -- Cédula de Identidad (clave para el sector público)
    user_email VARCHAR(100) UNIQUE,   -- 'juan.perez@municipio.gob.bo'
    user_phone VARCHAR(20) UNIQUE,   -- '+591 71234567'
    
    -- Dónde trabaja
    department_id UUID NOT NULL,
    charge VARCHAR(100),                        -- 'Técnico de Soporte', 'Director', 'Secretario'
    
    -- Datos de autenticación
    user_nick VARCHAR(30) UNIQUE NOT NULL, -- 'jperez' (para login)
    password_hash VARCHAR(255) NOT NULL,        -- Hash de bcrypt o argon2id, NUNCA texto plano
    
    -- Control de acceso y seguridad
    user_principal_role VARCHAR(30) NOT NULL,         -- 'ADMIN', 'DIRECTOR', 'VENTANILLA', 'TECNICO' (simplifica la gestión)
    active BOOLEAN DEFAULT true,
    requires_password_change BOOLEAN DEFAULT true, -- Forzar cambio en primer login
    
    -- Trazabilidad del propio usuario
    created_at TIMESTAMPTZ DEFAULT NOW(),
    last_access TIMESTAMPTZ,
    failed_attempts SMALLINT DEFAULT 0,
    locked_until TIMESTAMPTZ,
    
    CONSTRAINT pk_user_id PRIMARY KEY (id),
    CONSTRAINT uk_user_nick UNIQUE (user_nick),
    CONSTRAINT uk_user_ci UNIQUE (user_ci),
    CONSTRAINT uk_user_email UNIQUE (user_email),
    CONSTRAINT uk_user_phone UNIQUE (user_phone),
    CONSTRAINT fk_department_id FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE RESTRICT,
    CONSTRAINT fk_user_principal_role FOREIGN KEY (user_principal_role) REFERENCES roles(name) ON DELETE RESTRICT ON UPDATE CASCADE
);
