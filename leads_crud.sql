-- =========================
-- Leads Tracker CRUD SQL
-- =========================

-- 1️⃣ Crear base de datos
CREATE DATABASE IF NOT EXISTS leads_db;
USE leads_db;

-- 2️⃣ Crear tabla de leads
CREATE TABLE IF NOT EXISTS leads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    interes_servicio VARCHAR(50),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3️⃣ INSERT (Agregar algunos ejemplos)
INSERT INTO leads (nombre_completo, correo, telefono, interes_servicio)
VALUES ('Juan Pérez', 'juan@example.com', '987654321', 'Servicio A');

INSERT INTO leads (nombre_completo, correo, telefono, interes_servicio)
VALUES ('María López', 'maria@example.com', '912345678', 'Servicio B');

-- 4️⃣ SELECT (Consultar datos)
-- Seleccionar todos los leads
SELECT * FROM leads;

-- Seleccionar un lead específico por correo
SELECT * FROM leads
WHERE correo = 'juan@example.com';

-- 5️⃣ UPDATE (Modificar datos existentes)
-- Cambiar teléfono de un lead
UPDATE leads
SET telefono = '999888777'
WHERE correo = 'juan@example.com';

-- Cambiar interés/servicio de un lead
UPDATE leads
SET interes_servicio = 'Servicio C'
WHERE id = 2;

-- 6️⃣ DELETE (Eliminar registros)
-- Eliminar un lead por correo
DELETE FROM leads
WHERE correo = 'maria@example.com';

-- Eliminar todos los leads (usar con cuidado)
-- DELETE FROM leads;
