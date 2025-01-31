/* CREACIÓN DE BASE DE DATOS */
DROP DATABASE IF EXISTS dbGamarraMarket;
CREATE DATABASE dbGamarraMarket
DEFAULT CHARACTER SET utf8;

/*PONER EN USO LA BASE DE DATOS CREADA*/
USE dbGamarraMarket;

CREATE TABLE CLIENTE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_documento CHAR(3) NOT NULL,
    numero_documento CHAR(15) NOT NULL UNIQUE,
    nombres VARCHAR(60) NOT NULL,
    apellidos VARCHAR(90) NOT NULL,
    email VARCHAR(80),
    celular CHAR(9),
    fecha_nacimiento DATE,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE VENDEDOR (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_documento CHAR(3) NOT NULL,
    numero_documento CHAR(15) NOT NULL UNIQUE,
    nombres VARCHAR(60) NOT NULL,
    apellidos VARCHAR(90) NOT NULL,
    salario DECIMAL(8,2) NOT NULL,
    celular CHAR(9),
    email VARCHAR(80),
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE PRENDA (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(90) NOT NULL,
    marca VARCHAR(60) NOT NULL,
    cantidad INT NOT NULL,
    talla VARCHAR(10) NOT NULL,
    precio DECIMAL(8,2) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE VENTA (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    cliente_id INT NOT NULL,
    vendedor_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES CLIENTE(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (vendedor_id) REFERENCES VENDEDOR(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE VENTA_DETALLE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cantidad INT NOT NULL,
    venta_id INT NOT NULL,
    prenda_id INT NOT NULL,
    FOREIGN KEY (venta_id) REFERENCES VENTA(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (prenda_id) REFERENCES PRENDA(id) ON DELETE CASCADE ON UPDATE CASCADE
);


ALTER TABLE VENTA
ADD CONSTRAINT fk_cliente_venta
FOREIGN KEY (cliente_id) REFERENCES CLIENTE(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE VENTA
ADD CONSTRAINT fk_vendedor_venta
FOREIGN KEY (vendedor_id) REFERENCES VENDEDOR(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE VENTA_DETALLE
ADD CONSTRAINT fk_venta_venta_detalle
FOREIGN KEY (venta_id) REFERENCES VENTA(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE VENTA_DETALLE
ADD CONSTRAINT fk_prenda_venta_detalle
FOREIGN KEY (prenda_id) REFERENCES PRENDA(id) ON DELETE CASCADE ON UPDATE CASCADE;


SELECT 
    kcu.CONSTRAINT_NAME AS 'Nombre de Relación',
    kcu.REFERENCED_TABLE_NAME AS 'Tabla Padre',
    kcu.REFERENCED_COLUMN_NAME AS 'Primary Key',
    kcu.TABLE_NAME AS 'Tabla Hija',
    kcu.COLUMN_NAME AS 'Foreign Key'
FROM 
    information_schema.KEY_COLUMN_USAGE AS kcu
WHERE 
    kcu.TABLE_SCHEMA = 'dbGamarraMarket' 
    AND kcu.REFERENCED_TABLE_NAME IS NOT NULL;
    
SHOW TABLES;

DESCRIBE CLIENTE;
DESCRIBE VENDEDOR;
DESCRIBE PRENDA;
DESCRIBE VENTA;
