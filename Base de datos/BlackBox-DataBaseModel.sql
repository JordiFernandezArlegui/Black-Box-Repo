-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS BlackBoxDatabase 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE BlackBoxDatabase;

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS BBUser (
    id INT AUTO_INCREMENT PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    nickname VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    permissions VARCHAR(50) DEFAULT 'user',
    bio TEXT,
    mail VARCHAR(255) UNIQUE NOT NULL
);

-- Tabla de vehículos
CREATE TABLE IF NOT EXISTS Vehicle (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    favourite BOOLEAN DEFAULT FALSE,
    purchase_date DATE,
    width DECIMAL(6,2),
    height DECIMAL(6,2),
    depth DECIMAL(6,2),
    weight DECIMAL(7,2),
    engine_fuel VARCHAR(50),
    engine_horse_power INT,
    model VARCHAR(100),
    description TEXT,
    type VARCHAR(50),
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES BBUser(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabla de rutas
CREATE TABLE IF NOT EXISTS Route (
    id INT AUTO_INCREMENT PRIMARY KEY,
    csv TEXT, -- se asume que almacena contenido o path del archivo
    date DATE,
    category VARCHAR(100),
    favourite BOOLEAN DEFAULT FALSE,
    description TEXT,
    vehicle_id INT,
    user_id INT,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES BBUser(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabla de direcciones
CREATE TABLE IF NOT EXISTS Address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    street VARCHAR(150),
    city VARCHAR(100),
    province VARCHAR(100),
    zip_code VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES BBUser(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_vehicle_user_id ON Vehicle(user_id);
CREATE INDEX IF NOT EXISTS idx_route_user_id ON Route(user_id);
CREATE INDEX IF NOT EXISTS idx_route_vehicle_id ON Route(vehicle_id);
CREATE INDEX IF NOT EXISTS idx_address_user_id ON Address(user_id);
