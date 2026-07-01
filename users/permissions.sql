
CREATE TABLE permissions (
    id UUID DEFAULT gen_random_uuid(),
    code VARCHAR(50) NOT NULL,       -- 'TRAMITE_CREAR', 'USUARIO_CREAR'
    description VARCHAR(200) NOT NULL,       -- 'Crear nuevo trámite', 'Crear usuarios'
    module VARCHAR(50) NOT NULL,            -- 'TRAMITES', 'USUARIOS', 'REPORTES', 'AUDITORIA'
    
    CONSTRAINT pk_permission_id PRIMARY KEY (id),
    CONSTRAINT uk_permission_code UNIQUE (code)
);

CREATE TABLE role_permissions (
    role_name VARCHAR(30) NOT NULL,
    permission_id UUID NOT NULL,
    
    CONSTRAINT pk_role_permission PRIMARY KEY (role_name, permission_id),
    CONSTRAINT fk_role_permission_role FOREIGN KEY (role_name) 
        REFERENCES roles(name) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_role_permission_permission FOREIGN KEY (permission_id) 
        REFERENCES permissions(id) ON DELETE CASCADE
);

-- Índices
CREATE INDEX idx_role_permissions_role ON role_permissions(role_name);