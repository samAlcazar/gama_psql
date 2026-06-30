CREATE EXTENSION IF NOT EXISTS pgcrypto;

DROP TABLE IF EXISTS departments CASCADE;

CREATE TABLE departments (
    id UUID DEFAULT gen_random_uuid(),
    name VARCHAR(150) NOT NULL,
    sigla VARCHAR(20) UNIQUE,
    parent_department_id UUID,
    level SMALLINT NOT NULL DEFAULT 1,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    
    CONSTRAINT pk_department_id PRIMARY KEY (id),
    CONSTRAINT uk_department_sigla UNIQUE (sigla),
    CONSTRAINT fk_parent_department FOREIGN KEY (parent_department_id) 
        REFERENCES departments(id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
);