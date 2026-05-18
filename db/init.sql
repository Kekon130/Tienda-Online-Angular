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
-- TABLA PRODUCTOS
--------------------------------------------------
CREATE TABLE IF NOT EXISTS shop.products (
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price NUMERIC(10, 2) NOT NULL,
  stock INTEGER NOT NULL,
  image VARCHAR(500),
  category_id INTEGER NOT NULL,
  CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES shop.categories(id) ON DELETE RESTRICT
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
  ('Hogar');
--------------------------------------------------
-- PRODUCTOS - ROPA
--------------------------------------------------
INSERT INTO shop.products (
    code,
    name,
    description,
    price,
    stock,
    image,
    category_id
  )
VALUES (
    'ROP-001',
    'Camiseta Blanca',
    'Camiseta básica blanca de algodón',
    9.99,
    100,
    'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
    1
  ),
  (
    'ROP-002',
    'Pantalón Vaquero',
    'Vaquero azul clásico',
    39.99,
    50,
    'https://images.unsplash.com/photo-1542272604-787c3835535d',
    1
  ),
  (
    'ROP-003',
    'Sudadera Negra',
    'Sudadera con capucha negra',
    29.99,
    40,
    'https://images.unsplash.com/photo-1503341504253-dff4815485f1',
    1
  ),
  (
    'ROP-004',
    'Chaqueta Denim',
    'Chaqueta vaquera unisex',
    49.99,
    25,
    'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
    1
  ),
  (
    'ROP-005',
    'Camisa Formal',
    'Camisa elegante azul claro',
    34.99,
    35,
    'https://images.unsplash.com/photo-1603252109303-2751441dd157',
    1
  ),
  (
    'ROP-006',
    'Short Deportivo',
    'Short transpirable para deporte',
    19.99,
    60,
    'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f',
    1
  ),
  (
    'ROP-007',
    'Abrigo Invierno',
    'Abrigo largo impermeable',
    89.99,
    15,
    'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543',
    1
  );
--------------------------------------------------
-- PRODUCTOS - CALZADO
--------------------------------------------------
INSERT INTO shop.products (
    code,
    name,
    description,
    price,
    stock,
    image,
    category_id
  )
VALUES (
    'CAL-001',
    'Zapatillas Deportivas',
    'Zapatillas running ligeras',
    59.99,
    30,
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
    2
  ),
  (
    'CAL-002',
    'Botas Montaña',
    'Botas resistentes al agua',
    89.99,
    20,
    'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77',
    2
  ),
  (
    'CAL-003',
    'Zapatos Formales',
    'Zapatos negros de cuero',
    69.99,
    18,
    'https://images.unsplash.com/photo-1614252235316-8c857d38b5f4',
    2
  ),
  (
    'CAL-004',
    'Sandalias Verano',
    'Sandalias cómodas y frescas',
    24.99,
    45,
    'https://images.unsplash.com/photo-1603487742131-4160ec999306',
    2
  ),
  (
    'CAL-005',
    'Zapatillas Urbanas',
    'Sneakers casuales modernas',
    54.99,
    28,
    'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519',
    2
  ),
  (
    'CAL-006',
    'Chanclas Playa',
    'Chanclas resistentes al agua',
    14.99,
    70,
    'https://images.unsplash.com/photo-1621961458348-f013d219b50c',
    2
  );
--------------------------------------------------
-- PRODUCTOS - ACCESORIOS
--------------------------------------------------
INSERT INTO shop.products (
    code,
    name,
    description,
    price,
    stock,
    image,
    category_id
  )
VALUES (
    'ACC-001',
    'Gorra Negra',
    'Gorra ajustable negra',
    12.99,
    80,
    'https://images.unsplash.com/photo-1521369909029-2afed882baee',
    3
  ),
  (
    'ACC-002',
    'Mochila Urbana',
    'Mochila impermeable para portátil',
    44.99,
    32,
    'https://images.unsplash.com/photo-1553062407-98eeb64c6a62',
    3
  ),
  (
    'ACC-003',
    'Cinturón Cuero',
    'Cinturón marrón de cuero',
    22.99,
    40,
    'https://images.unsplash.com/photo-1624222247344-550fb60583dc',
    3
  ),
  (
    'ACC-004',
    'Gafas de Sol',
    'Gafas polarizadas UV400',
    29.99,
    27,
    'https://images.unsplash.com/photo-1511499767150-a48a237f0083',
    3
  ),
  (
    'ACC-005',
    'Reloj Deportivo',
    'Reloj resistente al agua',
    79.99,
    12,
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
    3
  ),
  (
    'ACC-006',
    'Bufanda Lana',
    'Bufanda suave de invierno',
    18.99,
    33,
    'https://images.unsplash.com/photo-1601924994987-69e26d50dc26',
    3
  ),
  (
    'ACC-007',
    'Cartera Compacta',
    'Cartera minimalista RFID',
    25.99,
    26,
    'https://images.unsplash.com/photo-1627123424574-724758594e93',
    3
  ),
  (
    'ACC-008',
    'Pulsera Acero',
    'Pulsera de acero inoxidable',
    15.99,
    50,
    'https://images.unsplash.com/photo-1617038220319-276d3cfab638',
    3
  );
--------------------------------------------------
-- PRODUCTOS - ELECTRÓNICA
--------------------------------------------------
INSERT INTO shop.products (
    code,
    name,
    description,
    price,
    stock,
    image,
    category_id
  )
VALUES (
    'ELE-001',
    'Auriculares Bluetooth',
    'Auriculares inalámbricos',
    49.99,
    35,
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
    4
  ),
  (
    'ELE-002',
    'Teclado Mecánico',
    'Teclado RGB mecánico',
    79.99,
    22,
    'https://images.unsplash.com/photo-1511467687858-23d96c32e4ae',
    4
  ),
  (
    'ELE-003',
    'Ratón Gaming',
    'Ratón ergonómico para gaming',
    39.99,
    31,
    'https://images.unsplash.com/photo-1527814050087-3793815479db',
    4
  ),
  (
    'ELE-004',
    'Monitor 24 pulgadas',
    'Monitor Full HD de 24 pulgadas',
    149.99,
    14,
    'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf',
    4
  ),
  (
    'ELE-005',
    'Altavoz Portátil',
    'Altavoz bluetooth portátil',
    34.99,
    38,
    'https://images.unsplash.com/photo-1589003077984-894e133dabab',
    4
  ),
  (
    'ELE-006',
    'Webcam HD',
    'Webcam Full HD para streaming',
    59.99,
    19,
    'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04',
    4
  );
--------------------------------------------------
-- PRODUCTOS - HOGAR
--------------------------------------------------
INSERT INTO shop.products (
    code,
    name,
    description,
    price,
    stock,
    image,
    category_id
  )
VALUES (
    'HOG-001',
    'Lámpara Escritorio',
    'Lámpara LED regulable',
    27.99,
    24,
    'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85',
    5
  ),
  (
    'HOG-002',
    'Silla Oficina',
    'Silla ergonómica ajustable',
    129.99,
    10,
    'https://images.unsplash.com/photo-1505843513577-22bb7d21e455',
    5
  ),
  (
    'HOG-003',
    'Mesa Auxiliar',
    'Mesa de madera moderna',
    59.99,
    16,
    'https://images.unsplash.com/photo-1499933374294-4584851497cc',
    5
  ),
  (
    'HOG-004',
    'Juego Sábanas',
    'Sábanas de algodón 150 hilos',
    34.99,
    42,
    'https://images.unsplash.com/photo-1513694203232-719a280e022f',
    5
  ),
  (
    'HOG-005',
    'Cafetera',
    'Cafetera automática compacta',
    89.99,
    13,
    'https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6',
    5
  ),
  (
    'HOG-006',
    'Estantería Modular',
    'Estantería metálica modular',
    74.99,
    9,
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7',
    5
  ),
  (
    'HOG-007',
    'Alfombra Salón',
    'Alfombra decorativa grande',
    49.99,
    18,
    'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85',
    5
  );
--------------------------------------------------
-- ROLES
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