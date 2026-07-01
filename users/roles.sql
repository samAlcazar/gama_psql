CREATE TABLE roles (
    name VARCHAR(30),                       -- 'ADMIN', 'DIRECTOR', 'VENTANILLA', 'TECNICO'
    description VARCHAR(200) NOT NULL,       -- 'Superusuario del sistema', 'Director de secretaría'
    
    CONSTRAINT pk_role_name PRIMARY KEY (name)
);
