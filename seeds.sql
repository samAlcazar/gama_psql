-- =============================================
-- ÍNDICES ADICIONALES
-- =============================================
CREATE INDEX idx_users_department ON users(department_id);
CREATE INDEX idx_users_user_nick ON users(user_nick);
CREATE INDEX idx_users_active ON users(active);
CREATE INDEX idx_departments_parent ON departments(parent_department_id);

-- =============================================
-- DATOS SEMILLA
-- =============================================

-- =============================================
-- 1. ROLES
-- =============================================
INSERT INTO roles (name, description) VALUES
('ADMIN', 'Superusuario con acceso total al sistema'),
('ALCALDE', 'Máxima autoridad municipal. Firma hojas de ruta. Supervisión total.'),
('SECRETARIO_GENERAL', 'Segundo al mando. Reemplaza al Alcalde en su ausencia.'),
('SECRETARIO_MUNICIPAL', 'Cabeza de una Secretaría. Supervisa, deriva y resuelve.'),
('DIRECTOR', 'Director de área bajo un Secretario Municipal. Supervisa, deriva y resuelve.'),
('SECRETARIO', 'Gestiona hojas de ruta. Registra y distribuye documentos.'),
('ASISTENTE', 'Recepciona documentos en ventanilla y distribuye físicamente.'),
('TECNICO', 'Funcionario operativo. Ejecuta acciones y elabora informes.');

-- =============================================
-- 2. PERMISOS
-- =============================================
INSERT INTO permissions (id, code, description, module) VALUES
-- Módulo: Trámites
('c1c2c3d4-0001-4000-8000-000000000001', 'TRAMITE_CREAR', 'Registrar nuevo trámite', 'TRAMITES'),
('c1c2c3d4-0001-4000-8000-000000000002', 'TRAMITE_VER_BANDEJA', 'Ver trámites asignados a su dependencia', 'TRAMITES'),
('c1c2c3d4-0001-4000-8000-000000000003', 'TRAMITE_VER_TODOS', 'Ver todos los trámites del municipio', 'TRAMITES'),
('c1c2c3d4-0001-4000-8000-000000000004', 'TRAMITE_DERIVAR', 'Derivar trámite a otra dependencia', 'TRAMITES'),
('c1c2c3d4-0001-4000-8000-000000000005', 'TRAMITE_RESOLVER', 'Resolver y cerrar trámite (elaborar informe)', 'TRAMITES'),
('c1c2c3d4-0001-4000-8000-000000000006', 'TRAMITE_ARCHIVAR', 'Archivar trámite', 'TRAMITES'),
('c1c2c3d4-0001-4000-8000-000000000007', 'TRAMITE_FIRMAR', 'Firmar hoja de ruta (Proveído)', 'TRAMITES'),

-- Módulo: Usuarios
('c1c2c3d4-0002-4000-8000-000000000001', 'USUARIO_CREAR', 'Crear nuevos usuarios', 'USUARIOS'),
('c1c2c3d4-0002-4000-8000-000000000002', 'USUARIO_EDITAR', 'Modificar datos de usuarios', 'USUARIOS'),
('c1c2c3d4-0002-4000-8000-000000000003', 'USUARIO_DESACTIVAR', 'Dar de baja usuarios', 'USUARIOS'),
('c1c2c3d4-0002-4000-8000-000000000004', 'USUARIO_VER', 'Ver listado de usuarios', 'USUARIOS'),

-- Módulo: Reportes
('c1c2c3d4-0003-4000-8000-000000000001', 'REPORTE_VER', 'Ver reportes y estadísticas', 'REPORTES'),
('c1c2c3d4-0003-4000-8000-000000000002', 'REPORTE_EXPORTAR', 'Exportar reportes a Excel/PDF', 'REPORTES'),

-- Módulo: Auditoría
('c1c2c3d4-0004-4000-8000-000000000001', 'AUDITORIA_VER', 'Ver logs de auditoría', 'AUDITORIA');

-- =============================================
-- 3. ASIGNACIÓN ROL → PERMISOS
-- =============================================

-- ADMIN: Todos los permisos
INSERT INTO role_permissions (role_name, permission_id)
SELECT 'ADMIN', id FROM permissions;

-- ALCALDE: Supervisión total + firma de hojas de ruta
INSERT INTO role_permissions (role_name, permission_id) VALUES
('ALCALDE', 'c1c2c3d4-0001-4000-8000-000000000003'), -- TRAMITE_VER_TODOS
('ALCALDE', 'c1c2c3d4-0001-4000-8000-000000000007'), -- TRAMITE_FIRMAR
('ALCALDE', 'c1c2c3d4-0003-4000-8000-000000000001'), -- REPORTE_VER
('ALCALDE', 'c1c2c3d4-0003-4000-8000-000000000002'), -- REPORTE_EXPORTAR
('ALCALDE', 'c1c2c3d4-0004-4000-8000-000000000001'); -- AUDITORIA_VER

-- SECRETARIO_GENERAL: Igual que Alcalde
INSERT INTO role_permissions (role_name, permission_id) VALUES
('SECRETARIO_GENERAL', 'c1c2c3d4-0001-4000-8000-000000000003'), -- TRAMITE_VER_TODOS
('SECRETARIO_GENERAL', 'c1c2c3d4-0001-4000-8000-000000000007'), -- TRAMITE_FIRMAR
('SECRETARIO_GENERAL', 'c1c2c3d4-0003-4000-8000-000000000001'), -- REPORTE_VER
('SECRETARIO_GENERAL', 'c1c2c3d4-0003-4000-8000-000000000002'), -- REPORTE_EXPORTAR
('SECRETARIO_GENERAL', 'c1c2c3d4-0004-4000-8000-000000000001'); -- AUDITORIA_VER

-- SECRETARIO_MUNICIPAL: Crea, supervisa, deriva, resuelve
INSERT INTO role_permissions (role_name, permission_id) VALUES
('SECRETARIO_MUNICIPAL', 'c1c2c3d4-0001-4000-8000-000000000001'), -- TRAMITE_CREAR
('SECRETARIO_MUNICIPAL', 'c1c2c3d4-0001-4000-8000-000000000002'), -- TRAMITE_VER_BANDEJA
('SECRETARIO_MUNICIPAL', 'c1c2c3d4-0001-4000-8000-000000000003'), -- TRAMITE_VER_TODOS
('SECRETARIO_MUNICIPAL', 'c1c2c3d4-0001-4000-8000-000000000004'), -- TRAMITE_DERIVAR
('SECRETARIO_MUNICIPAL', 'c1c2c3d4-0001-4000-8000-000000000005'), -- TRAMITE_RESOLVER
('SECRETARIO_MUNICIPAL', 'c1c2c3d4-0001-4000-8000-000000000006'), -- TRAMITE_ARCHIVAR
('SECRETARIO_MUNICIPAL', 'c1c2c3d4-0003-4000-8000-000000000001'), -- REPORTE_VER
('SECRETARIO_MUNICIPAL', 'c1c2c3d4-0003-4000-8000-000000000002'), -- REPORTE_EXPORTAR
('SECRETARIO_MUNICIPAL', 'c1c2c3d4-0002-4000-8000-000000000004'); -- USUARIO_VER

-- DIRECTOR: Crea, supervisa, deriva, resuelve
INSERT INTO role_permissions (role_name, permission_id) VALUES
('DIRECTOR', 'c1c2c3d4-0001-4000-8000-000000000001'), -- TRAMITE_CREAR
('DIRECTOR', 'c1c2c3d4-0001-4000-8000-000000000002'), -- TRAMITE_VER_BANDEJA
('DIRECTOR', 'c1c2c3d4-0001-4000-8000-000000000003'), -- TRAMITE_VER_TODOS
('DIRECTOR', 'c1c2c3d4-0001-4000-8000-000000000004'), -- TRAMITE_DERIVAR
('DIRECTOR', 'c1c2c3d4-0001-4000-8000-000000000005'), -- TRAMITE_RESOLVER
('DIRECTOR', 'c1c2c3d4-0001-4000-8000-000000000006'), -- TRAMITE_ARCHIVAR
('DIRECTOR', 'c1c2c3d4-0003-4000-8000-000000000001'), -- REPORTE_VER
('DIRECTOR', 'c1c2c3d4-0003-4000-8000-000000000002'), -- REPORTE_EXPORTAR
('DIRECTOR', 'c1c2c3d4-0002-4000-8000-000000000004'); -- USUARIO_VER

-- SECRETARIO: Gestiona hojas de ruta, registra, distribuye
INSERT INTO role_permissions (role_name, permission_id) VALUES
('SECRETARIO', 'c1c2c3d4-0001-4000-8000-000000000001'), -- TRAMITE_CREAR
('SECRETARIO', 'c1c2c3d4-0001-4000-8000-000000000002'), -- TRAMITE_VER_BANDEJA
('SECRETARIO', 'c1c2c3d4-0001-4000-8000-000000000003'), -- TRAMITE_VER_TODOS
('SECRETARIO', 'c1c2c3d4-0001-4000-8000-000000000004'), -- TRAMITE_DERIVAR
('SECRETARIO', 'c1c2c3d4-0002-4000-8000-000000000004'); -- USUARIO_VER

-- ASISTENTE: Recepciona, distribuye físicamente
INSERT INTO role_permissions (role_name, permission_id) VALUES
('ASISTENTE', 'c1c2c3d4-0001-4000-8000-000000000001'), -- TRAMITE_CREAR
('ASISTENTE', 'c1c2c3d4-0001-4000-8000-000000000002'), -- TRAMITE_VER_BANDEJA
('ASISTENTE', 'c1c2c3d4-0001-4000-8000-000000000004'), -- TRAMITE_DERIVAR
('ASISTENTE', 'c1c2c3d4-0002-4000-8000-000000000004'); -- USUARIO_VER

-- TECNICO: Crea, ejecuta, deriva, resuelve (Opcion A)
INSERT INTO role_permissions (role_name, permission_id) VALUES
('TECNICO', 'c1c2c3d4-0001-4000-8000-000000000001'), -- TRAMITE_CREAR
('TECNICO', 'c1c2c3d4-0001-4000-8000-000000000002'), -- TRAMITE_VER_BANDEJA
('TECNICO', 'c1c2c3d4-0001-4000-8000-000000000004'), -- TRAMITE_DERIVAR
('TECNICO', 'c1c2c3d4-0001-4000-8000-000000000005'); -- TRAMITE_RESOLVER

-- =============================================
-- 4. DEPARTAMENTOS
-- =============================================

-- Nivel 1: Despacho Alcalde Municipal
INSERT INTO departments (id, name, sigla, level) VALUES
('d0000000-0001-4000-8000-000000000001', 'Despacho Alcalde Municipal', 'DAM', 1);

-- Nivel 2: Dependencias directas del Despacho
INSERT INTO departments (id, name, sigla, parent_department_id, level) VALUES
('d0000000-0002-4000-8000-000000000001', 'Coordinador General', 'CG', 'd0000000-0001-4000-8000-000000000001', 2),
('d0000000-0002-4000-8000-000000000002', 'Coordinador de Despacho', 'CD', 'd0000000-0001-4000-8000-000000000001', 2),
('d0000000-0002-4000-8000-000000000003', 'Secretaría Municipal General', 'SMG', 'd0000000-0001-4000-8000-000000000001', 2),
('d0000000-0002-4000-8000-000000000004', 'Subalcaldía Distrito MPAL. Corpauto', 'SD-COR', 'd0000000-0001-4000-8000-000000000001', 2),
('d0000000-0002-4000-8000-000000000005', 'Subalcaldía Distrito MPAL. Ajllata', 'SD-AJL', 'd0000000-0001-4000-8000-000000000001', 2),
('d0000000-0002-4000-8000-000000000006', 'Subalcaldía Distrito MPAL. Cocotoni', 'SD-COC', 'd0000000-0001-4000-8000-000000000001', 2),
('d0000000-0002-4000-8000-000000000007', 'Subalcaldía Distrito MPAL. Jancko Amaya', 'SD-JA', 'd0000000-0001-4000-8000-000000000001', 2),
('d0000000-0002-4000-8000-000000000008', 'Subalcaldía Distrito MPAL. Tacmara', 'SD-TAC', 'd0000000-0001-4000-8000-000000000001', 2),
('d0000000-0002-4000-8000-000000000009', 'Subalcaldía Distrito MPAL. Franz Tamayo', 'SD-FT', 'd0000000-0001-4000-8000-000000000001', 2);

-- Nivel 3: Dependencias de Secretaría Municipal General
INSERT INTO departments (id, name, sigla, parent_department_id, level) VALUES
('d0000000-0003-4000-8000-000000000001', 'Dirección Jurídica', 'DJ', 'd0000000-0002-4000-8000-000000000003', 3),
('d0000000-0003-4000-8000-000000000002', 'Unidad de Auditoría Interna', 'UAI', 'd0000000-0002-4000-8000-000000000003', 3),
('d0000000-0003-4000-8000-000000000003', 'Transparencia y Lucha Contra la Corrupción', 'TLCC', 'd0000000-0002-4000-8000-000000000003', 3),
('d0000000-0003-4000-8000-000000000004', 'Unidad de Planificación', 'UP', 'd0000000-0002-4000-8000-000000000003', 3),
('d0000000-0003-4000-8000-000000000005', 'Comunicación', 'COM', 'd0000000-0002-4000-8000-000000000003', 3),
('d0000000-0003-4000-8000-000000000006', 'Secretaría Municipal Administrativa Financiera', 'SMAF', 'd0000000-0002-4000-8000-000000000003', 3),
('d0000000-0003-4000-8000-000000000007', 'Secretaría Municipal Técnica y Desarrollo Productivo', 'SMTYDP', 'd0000000-0002-4000-8000-000000000003', 3),
('d0000000-0003-4000-8000-000000000008', 'Secretaría Municipal de Desarrollo Humano', 'SMDH', 'd0000000-0002-4000-8000-000000000003', 3);

-- Nivel 4: SMAF
INSERT INTO departments (id, name, sigla, parent_department_id, level) VALUES
('d0000000-0004-4000-8000-000000000001', 'Asistente SMAF', 'AS-SMAF', 'd0000000-0003-4000-8000-000000000006', 4),
('d0000000-0004-4000-8000-000000000002', 'Dirección Administrativa Financiera', 'DAF', 'd0000000-0003-4000-8000-000000000006', 4);

-- Nivel 4: SMTYDP
INSERT INTO departments (id, name, sigla, parent_department_id, level) VALUES
('d0000000-0004-4000-8000-000000000003', 'Asistente SMTYDP', 'AS-SMTYDP', 'd0000000-0003-4000-8000-000000000007', 4),
('d0000000-0004-4000-8000-000000000004', 'Dirección Técnica y Desarrollo Productivo', 'DTDP', 'd0000000-0003-4000-8000-000000000007', 4);

-- Nivel 4: SMDH
INSERT INTO departments (id, name, sigla, parent_department_id, level) VALUES
('d0000000-0004-4000-8000-000000000005', 'Asistente SMDH', 'AS-SMDH', 'd0000000-0003-4000-8000-000000000008', 4),
('d0000000-0004-4000-8000-000000000006', 'Dirección de Desarrollo Humano', 'DDH', 'd0000000-0003-4000-8000-000000000008', 4);

-- Nivel 5: Dirección Administrativa Financiera
INSERT INTO departments (id, name, sigla, parent_department_id, level) VALUES
('d0000000-0005-4000-8000-000000000001', 'Recursos Humanos', 'RRHH', 'd0000000-0004-4000-8000-000000000002', 5),
('d0000000-0005-4000-8000-000000000002', 'Soporte Técnico', 'SOP-TEC', 'd0000000-0004-4000-8000-000000000002', 5),
('d0000000-0005-4000-8000-000000000003', 'Archivo', 'ARCH', 'd0000000-0004-4000-8000-000000000002', 5),
('d0000000-0005-4000-8000-000000000004', 'Unidad Financiera', 'UF', 'd0000000-0004-4000-8000-000000000002', 5),
('d0000000-0005-4000-8000-000000000005', 'Unidad Administrativa y Contrataciones', 'UAC', 'd0000000-0004-4000-8000-000000000002', 5),
('d0000000-0005-4000-8000-000000000006', 'Unidad de Recaudaciones', 'UR', 'd0000000-0004-4000-8000-000000000002', 5);

-- Nivel 5: Dirección Técnica y Desarrollo Productivo
INSERT INTO departments (id, name, sigla, parent_department_id, level) VALUES
('d0000000-0005-4000-8000-000000000007', 'Unidad Técnica y de Proyectos', 'UTP', 'd0000000-0004-4000-8000-000000000004', 5),
('d0000000-0005-4000-8000-000000000008', 'Unidad de Gestión de Riesgos y Medio Ambiente', 'UGRMA', 'd0000000-0004-4000-8000-000000000004', 5),
('d0000000-0005-4000-8000-000000000009', 'Unidad Catastro Municipal', 'UCM', 'd0000000-0004-4000-8000-000000000004', 5),
('d0000000-0005-4000-8000-000000000010', 'Unidad Desarrollo Agropecuario', 'UDA', 'd0000000-0004-4000-8000-000000000004', 5),
('d0000000-0005-4000-8000-000000000011', 'Transporte y Maquinaria Pesada', 'TMP', 'd0000000-0004-4000-8000-000000000004', 5);

-- Nivel 5: Dirección de Desarrollo Humano
INSERT INTO departments (id, name, sigla, parent_department_id, level) VALUES
('d0000000-0005-4000-8000-000000000012', 'Unidad de Atención Integral', 'UAI-DH', 'd0000000-0004-4000-8000-000000000006', 5),
('d0000000-0005-4000-8000-000000000013', 'Seguridad Ciudadana', 'SC', 'd0000000-0004-4000-8000-000000000006', 5),
('d0000000-0005-4000-8000-000000000014', 'Intendencia Municipal', 'IM', 'd0000000-0004-4000-8000-000000000006', 5);

-- Nivel 6: Subdependencias
INSERT INTO departments (id, name, sigla, parent_department_id, level) VALUES
('d0000000-0006-4000-8000-000000000001', 'Presupuestos', 'PRES', 'd0000000-0005-4000-8000-000000000004', 6),
('d0000000-0006-4000-8000-000000000002', 'Contabilidad y Tesorería', 'CONT', 'd0000000-0005-4000-8000-000000000004', 6),
('d0000000-0006-4000-8000-000000000003', 'Contrataciones', 'CONTR', 'd0000000-0005-4000-8000-000000000005', 6),
('d0000000-0006-4000-8000-000000000004', 'Almacenes y Activos Fijos', 'AAF', 'd0000000-0005-4000-8000-000000000005', 6),
('d0000000-0006-4000-8000-000000000005', 'SIIM', 'SIIM', 'd0000000-0005-4000-8000-000000000006', 6),
('d0000000-0006-4000-8000-000000000006', 'RUAT', 'RUAT', 'd0000000-0005-4000-8000-000000000006', 6),
('d0000000-0006-4000-8000-000000000007', 'Agua y Recursos Hídricos', 'ARH', 'd0000000-0005-4000-8000-000000000008', 6),
('d0000000-0006-4000-8000-000000000008', 'Prevención y Gestión de Riesgos', 'PGR', 'd0000000-0005-4000-8000-000000000008', 6),
('d0000000-0006-4000-8000-000000000009', 'Gestión de Residuos y C. Ambiental', 'GRCA', 'd0000000-0005-4000-8000-000000000008', 6),
('d0000000-0006-4000-8000-000000000010', 'Aseo Urbano', 'AU', 'd0000000-0005-4000-8000-000000000008', 6),
('d0000000-0006-4000-8000-000000000011', 'Defensoría de la Niñez y Adolescencia', 'DNA', 'd0000000-0005-4000-8000-000000000012', 6),
('d0000000-0006-4000-8000-000000000012', 'Servicio Legal Integral Municipal', 'SLIM', 'd0000000-0005-4000-8000-000000000012', 6),
('d0000000-0006-4000-8000-000000000013', 'Adulto Mayor y Personas con Discapacidad', 'AMPD', 'd0000000-0005-4000-8000-000000000012', 6),
('d0000000-0006-4000-8000-000000000014', 'Guardia Municipal', 'GM', 'd0000000-0005-4000-8000-000000000014', 6);

-- =============================================
-- 5. USUARIOS
-- =============================================
-- Contraseña para todos: "password123"
-- Hash bcrypt: $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy

-- ADMIN (Samuel Alejandro Alcazar - Soporte Técnico)
INSERT INTO users (id, user_name, user_ci, user_email, user_phone, department_id, charge, user_nick, password_hash, user_principal_role) VALUES
('b1b2c3d4-0001-4000-8000-000000000001', 
 'Samuel Alejandro Alcazar', '6189020', 'alcazar.samuel@gmail.com', '+591 71208298',
 'd0000000-0005-4000-8000-000000000002', 'Técnico de Soporte / Administrador TI', 'saalcazar',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'ADMIN');

-- ALCALDE
INSERT INTO users (id, user_name, user_ci, user_email, user_phone, department_id, charge, user_nick, password_hash, user_principal_role) VALUES
('b1b2c3d4-0001-4000-8000-000000000002', 
 'Lic. [Nombre del Alcalde]', 'ALC001', 'alcalde@municipio.gob.bo', '+591 71234500',
 'd0000000-0001-4000-8000-000000000001', 'Alcalde Municipal', 'alcalde',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'ALCALDE');

-- SECRETARIO GENERAL
INSERT INTO users (id, user_name, user_ci, user_email, user_phone, department_id, charge, user_nick, password_hash, user_principal_role) VALUES
('b1b2c3d4-0001-4000-8000-000000000010', 
 'Lic. [Secretario General]', 'SG001', 'sec.general@municipio.gob.bo', '+591 71234510',
 'd0000000-0002-4000-8000-000000000003', 'Secretario Municipal General', 'secgeneral',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'SECRETARIO_GENERAL');

-- SECRETARIO (hojas de ruta)
INSERT INTO users (id, user_name, user_ci, user_email, user_phone, department_id, charge, user_nick, password_hash, user_principal_role) VALUES
('b1b2c3d4-0001-4000-8000-000000000006', 
 'Lic. Carlos Mendoza', '4567890', 'carlos.mendoza@municipio.gob.bo', '+591 71234505',
 'd0000000-0002-4000-8000-000000000002', 'Secretario de Despacho', 'cmendoza',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'SECRETARIO');

-- ASISTENTE (Ventanilla Única)
INSERT INTO users (id, user_name, user_ci, user_email, user_phone, department_id, charge, user_nick, password_hash, user_principal_role) VALUES
('b1b2c3d4-0001-4000-8000-000000000003', 
 'María Condori Flores', '1234567', 'maria.condori@municipio.gob.bo', '+591 71234501',
 'd0000000-0002-4000-8000-000000000003', 'Asistente de Ventanilla Única', 'mcondori',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'ASISTENTE');

-- SECRETARIO MUNICIPAL SMAF
INSERT INTO users (id, user_name, user_ci, user_email, user_phone, department_id, charge, user_nick, password_hash, user_principal_role) VALUES
('b1b2c3d4-0001-4000-8000-000000000011', 
 'Lic. [Secretario Municipal Financiero]', 'SMF001', 'sec.financiero@municipio.gob.bo', '+591 71234511',
 'd0000000-0003-4000-8000-000000000006', 'Secretario Municipal Administrativo Financiero', 'secfin',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'SECRETARIO_MUNICIPAL');

-- DIRECTOR Administrativo Financiero
INSERT INTO users (id, user_name, user_ci, user_email, user_phone, department_id, charge, user_nick, password_hash, user_principal_role) VALUES
('b1b2c3d4-0001-4000-8000-000000000012', 
 'Lic. [Director Financiero]', 'DF001', 'dir.financiero@municipio.gob.bo', '+591 71234512',
 'd0000000-0004-4000-8000-000000000002', 'Director Administrativo Financiero', 'dirfin',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'DIRECTOR');