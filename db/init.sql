-- Crear esquema
CREATE SCHEMA IF NOT EXISTS shop;

--------------------------------------------------
-- TABLA CATEGORIA
--------------------------------------------------
CREATE TABLE IF NOT EXISTS shop.categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL
);

--------------------------------------------------
-- TABLA PRODUCTOS (Sin la columna única de imagen)
--------------------------------------------------
CREATE TABLE IF NOT EXISTS shop.products (
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price NUMERIC(10, 2) NOT NULL,
  stock INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES shop.categories(id) ON DELETE RESTRICT
);

--------------------------------------------------
-- TABLA IMÁGENES DE PRODUCTOS (Relación 1 a Muchos)
--------------------------------------------------
CREATE TABLE IF NOT EXISTS shop.product_images (
  id SERIAL PRIMARY KEY,
  product_id INTEGER NOT NULL,
  image_url VARCHAR(500) NOT NULL,
  is_primary BOOLEAN DEFAULT false, -- Útil para saber cuál mostrar por defecto
  CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES shop.products(id) ON DELETE CASCADE
);

--------------------------------------------------
-- DATOS DE EJEMPLO
--------------------------------------------------
-- Insertar categorías
INSERT INTO shop.categories (name)
VALUES ('Ropa'),
  ('Calzado'),
  ('Accesorios'),
  ('Electrónica'),
  ('Hogares');

--------------------------------------------------
-- INSERCIÓN DE PRODUCTOS
--------------------------------------------------
-- ROPA
INSERT INTO shop.products (id, code, name, description, price, stock, category_id) VALUES
(1, 'ROP-001', 'Camiseta Blanca', 'Camiseta básica blanca de algodón', 9.99, 100, 1),
(2, 'ROP-002', 'Pantalón Vaquero', 'Vaquero azul clásico', 39.99, 50, 1),
(3, 'ROP-003', 'Sudadera Negra', 'Sudadera con capucha negra', 29.99, 40, 1),
(4, 'ROP-004', 'Chaqueta Denim', 'Chaqueta vaquera unisex', 49.99, 25, 1),
(5, 'ROP-005', 'Camisa Formal', 'Camisa elegante azul claro', 34.99, 35, 1),
(6, 'ROP-006', 'Short Deportivo', 'Short transpirable para deporte', 19.99, 60, 1),
(7, 'ROP-007', 'Abrigo Invierno', 'Abrigo largo impermeable', 89.99, 15, 1);

-- CALZADO
INSERT INTO shop.products (id, code, name, description, price, stock, category_id) VALUES
(8, 'CAL-001', 'Zapatillas Deportivas', 'Zapatillas running ligeras', 59.99, 30, 2),
(9, 'CAL-002', 'Botas Montaña', 'Botas resistentes al agua', 89.99, 20, 2),
(10, 'CAL-003', 'Zapatos Formales', 'Zapatos negros de cuero', 69.99, 18, 2),
(11, 'CAL-004', 'Sandalias Verano', 'Sandalias cómodas y frescas', 24.99, 45, 2),
(12, 'CAL-005', 'Zapatillas Urbanas', 'Sneakers casuales modernas', 54.99, 28, 2),
(13, 'CAL-006', 'Chanclas Playa', 'Chanclas resistentes al agua', 14.99, 70, 2);

-- ACCESORIOS
INSERT INTO shop.products (id, code, name, description, price, stock, category_id) VALUES
(14, 'ACC-001', 'Gorra Negra', 'Gorra ajustable negra', 12.99, 80, 3),
(15, 'ACC-002', 'Mochila Urbana', 'Mochila impermeable para portátil', 44.99, 32, 3),
(16, 'ACC-003', 'Cinturón Cuero', 'Cinturón marrón de cuero', 22.99, 40, 3),
(17, 'ACC-004', 'Gafas de Sol', 'Gafas polarizadas UV400', 29.99, 27, 3),
(18, 'ACC-005', 'Reloj Deportivo', 'Reloj resistente al agua', 79.99, 12, 3),
(19, 'ACC-006', 'Bufanda Lana', 'Bufanda suave de invierno', 18.99, 33, 3),
(20, 'ACC-007', 'Cartera Compacta', 'Cartera minimalista RFID', 25.99, 26, 3),
(21, 'ACC-008', 'Pulsera Acero', 'Pulsera de acero inoxidable', 15.99, 50, 3);

-- ELECTRÓNICA
INSERT INTO shop.products (id, code, name, description, price, stock, category_id) VALUES
(22, 'ELE-001', 'Auriculares Bluetooth', 'Auriculares inalámbricos', 49.99, 35, 4),
(23, 'ELE-002', 'Teclado Mecánico', 'Teclado RGB mecánico', 79.99, 22, 4),
(24, 'ELE-003', 'Ratón Gaming', 'Ratón ergonómico para gaming', 39.99, 31, 4),
(25, 'ELE-004', 'Monitor 24 pulgadas', 'Monitor Full HD de 24 pulgadas', 149.99, 14, 4),
(26, 'ELE-005', 'Altavoz Portátil', 'Altavoz bluetooth portátil', 34.99, 38, 4),
(27, 'ELE-006', 'Webcam HD', 'Webcam Full HD para streaming', 59.99, 19, 4);

-- HOGAR
INSERT INTO shop.products (id, code, name, description, price, stock, category_id) VALUES
(28, 'HOG-001', 'Lámpara Escritorio', 'Lámpara LED regulable', 27.99, 24, 5),
(29, 'HOG-002', 'Silla Oficina', 'Silla ergonómica ajustable', 129.99, 10, 5),
(30, 'HOG-003', 'Mesa Auxiliar', 'Mesa de madera moderna', 59.99, 16, 5),
(31, 'HOG-004', 'Juego Sábanas', 'Sábanas de algodón 150 hilos', 34.99, 42, 5),
(32, 'HOG-005', 'Cafetera', 'Cafetera automática compacta', 89.99, 13, 5),
(33, 'HOG-006', 'Estantería Modular', 'Estantería metálica modular', 74.99, 9, 5),
(34, 'HOG-007', 'Alfombra Salón', 'Alfombra decorativa grande', 49.99, 18, 5);

-- Ajustar las secuencias de ID de productos debido a las inserciones manuales con ID fijo
SELECT setval('shop.products_id_seq', (SELECT MAX(id) FROM shop.products));

--------------------------------------------------
-- IMÁGENES ASOCIADAS (Múltiples imágenes por producto)
--------------------------------------------------
INSERT INTO shop.product_images (product_id, image_url, is_primary) VALUES
-- ROP-001: Camiseta Blanca
(1, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab', true),
(1, 'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a', false),
-- ROP-002: Pantalón Vaquero
(2, 'https://images.unsplash.com/photo-1542272604-787c3835535d', true),
(2, 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246', false),
-- ROP-003: Sudadera Negra
(3, 'https://images.unsplash.com/photo-1503341504253-dff4815485f1', true),
(3, 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2', false),
-- ROP-004: Chaqueta Denim
(4, 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f', true),
(4, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0', false),
-- ROP-005: Camisa Formal
(5, 'https://images.unsplash.com/photo-1603252109303-2751441dd157', true),
(5, 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c', false),
-- ROP-006: Short Deportivo
(6, 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f', true),
(6, 'https://images.unsplash.com/photo-1539185441755-769473a23570', false),
-- ROP-007: Abrigo Invierno
(7, 'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543', true),
(7, 'https://images.unsplash.com/photo-1544923246-77307dd654cb', false),

-- CAL-001: Zapatillas Deportivas
(8, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff', true),
(8, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5', false),
-- CAL-002: Botas Montaña
(9, 'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77', true),
(9, 'https://images.unsplash.com/photo-1520639888713-7851133b1ed0', false),
-- CAL-003: Zapatos Formales
(10, 'https://images.unsplash.com/photo-1614252235316-8c857d38b5f4', true),
(10, 'https://images.unsplash.com/photo-1533867617858-e7b97e060509', false),
-- CAL-004: Sandalias Verano
(11, 'https://images.unsplash.com/photo-1603487742131-4160ec999306', true),
(11, 'https://images.unsplash.com/photo-1562273138-f46be4ebdf33', false),
-- CAL-005: Zapatillas Urbanas
(12, 'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519', true),
(12, 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a', false),
-- CAL-006: Chanclas Playa
(13, 'https://images.unsplash.com/photo-1621961458348-f013d219b50c', true),
(13, 'https://images.unsplash.com/photo-1595341595378-fcab058b76fc', false),

-- ACC-001: Gorra Negra
(14, 'https://images.unsplash.com/photo-1521369909029-2afed882baee', true),
(14, 'https://images.unsplash.com/photo-1534215754734-18e55d13ce35', false),
-- ACC-002: Mochila Urbana
(15, 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62', true),
(15, 'https://images.unsplash.com/photo-1575844621280-577e4120ec04', false),
-- ACC-003: Cinturón Cuero
(16, 'https://images.unsplash.com/photo-1624222247344-550fb60583dc', true),
(16, 'https://images.unsplash.com/photo-1614030424754-24d1f2e46e8c', false),
-- ACC-004: Gafas de Sol
(17, 'https://images.unsplash.com/photo-1511499767150-a48a237f0083', true),
(17, 'https://images.unsplash.com/photo-1572635196237-14b3f281503f', false),
-- ACC-005: Reloj Deportivo
(18, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30', true),
(18, 'https://images.unsplash.com/photo-1542496658-e33a6d0d50f6', false),
-- ACC-006: Bufanda Lana
(19, 'https://images.unsplash.com/photo-1601924994987-69e26d50dc26', true),
(19, 'https://images.unsplash.com/photo-1520903928343-0604c514754f', false),
-- ACC-007: Cartera Compacta
(20, 'https://images.unsplash.com/photo-1627123424574-724758594e93', true),
(20, 'https://images.unsplash.com/photo-1588444837495-c6cfeb53f32d', false),
-- ACC-008: Pulsera Acero
(21, 'https://images.unsplash.com/photo-1617038220319-276d3cfab638', true),
(21, 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f', false),

-- ELE-001: Auriculares Bluetooth
(22, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e', true),
(22, 'https://images.unsplash.com/photo-1484704849700-f032a568e944', false),
-- ELE-002: Teclado Mecánico
(23, 'https://images.unsplash.com/photo-1511467687858-23d96c32e4ae', true),
(23, 'https://images.unsplash.com/photo-1618384887929-16ec33fab9ef', false),
-- ELE-003: Ratón Gaming
(24, 'https://images.unsplash.com/photo-1527814050087-3793815479db', true),
(24, 'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7', false),
-- ELE-004: Monitor 24 pulgadas
(25, 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf', true),
(25, 'https://images.unsplash.com/photo-1547119957-637f8679db1e', false),
-- ELE-005: Altavoz Portátil
(26, 'https://images.unsplash.com/photo-1589003077984-894e133dabab', true),
(26, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1', false),
-- ELE-006: Webcam HD
(27, 'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04', true),
(27, 'https://images.unsplash.com/photo-1601524909162-be87252be298', false),

-- HOG-001: Lámpara Escritorio
(28, 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85', true),
(28, 'https://images.unsplash.com/photo-1532372320572-cda25653a26d', false),
-- HOG-002: Silla Oficina
(29, 'https://images.unsplash.com/photo-1505843513577-22bb7d21e455', true),
(29, 'https://images.unsplash.com/photo-1580481072645-022f9a6dbf27', false),
-- HOG-003: Mesa Auxiliar
(30, 'https://images.unsplash.com/photo-1499933374294-4584851497cc', true),
(30, 'https://images.unsplash.com/photo-1530018607912-eff2df11a7be', false),
-- HOG-004: Juego Sábanas
(31, 'https://images.unsplash.com/photo-1513694203232-719a280e022f', true),
(31, 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af', false),
-- HOG-005: Cafetera
(32, 'https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6', true),
(32, 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085', false),
-- HOG-006: Estantería Modular
(33, 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7', true),
(33, 'https://images.unsplash.com/photo-1540518614846-7eded433c457', false),
-- HOG-007: Alfombra Salón
(34, 'https://images.unsplash.com/photo-1600121848594-d8644e57abab', true),
(34, 'https://images.unsplash.com/photo-1575414554096-01502424cf37', false);

--------------------------------------------------
-- ROLES Y PERMISOS
--------------------------------------------------
-- Rol sin login
CREATE ROLE web_anon;
-- Permisos
GRANT USAGE ON SCHEMA shop TO web_anon;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA shop TO web_anon;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA shop TO web_anon;
-- Usuario con login
CREATE ROLE authenticator WITH LOGIN PASSWORD 'mysecretpassword';
-- Puede asumir el rol
GRANT web_anon TO authenticator;