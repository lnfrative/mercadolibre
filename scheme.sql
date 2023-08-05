create table usuario(
cedula char(10),
username varchar(50),
email varchar(50),
nombre varchar(100));

create table vendedor(
id int,
cedula char(10),
nombre_tienda varchar(100)
);

create table categoria (
    id int,
    nombre varchar(25),
    descripcion varchar(50)
);

create table producto(
	id int,
    nombre varchar(100),
    descripcion text,
    categoria_id int,
precio_venta decimal(10,
2),
    stock int,
    descuento decimal(10,
2),
    vendedor_id int
);

create table compra(
	id int,
    producto_id int,
    fecha datetime,
    precio_compra decimal(10,
2),
    desc_aplicado decimal(10,
2),
    cantidad int,
    comprador_id int,
    met_pado_id int
);

create table comprador(
id int,
cedula char(10));

create table metodoPago(
id int,
tarjeta_id int,
comprador_id int,
predeterminado boolean
);

create table review(
id int,
compra_id int,
puntaje int,
comentario text
);

create table provincias(
    id int,
    nombre varchar(100)
);

create table ciudades(
    id int,
    nombre varchar(100),
    provincia_id int
);

create table codigo_postal(
    id int,
    codigo char(6)
);

create table calles(
    id int,
    codigo_postal_id int,
    ciudad_id int,
    nombre varchar(100)
);

create table direccion(
	id int,
    usuario_id char(10),
    calle_id int
);

create table tarjeta(
	id int,
    num_tarjeta BIGINT,
nombre varchar(100),
    clave int,
    fecha_exp date
);

create table envio(
id int,
compra_id int,
direccion_id int,
estado varchar(25));

-- constraints
alter table tarjeta add constraint Pk1 primary key(id);
alter table tarjeta add constraint unique_numtarjeta unique (num_tarjeta);

alter table usuario add constraint Pk2 primary key(cedula);
alter table usuario add constraint usuario_unique unique (username);
alter table usuario add constraint email_unique unique (email);

alter table comprador add constraint Pk3 primary key auto_increment(id);
alter table comprador add constraint Fk1 foreign key(cedula) references usuario(cedula);
alter table comprador add constraint cedula_unique unique (cedula);

alter table metodopago add constraint Pk4 primary key auto_increment(id);
alter table metodopago add constraint Fk2 foreign key(tarjeta_id) references tarjeta(id);
alter table metodopago add constraint Fk3 foreign key(comprador_id) references comprador(id);
alter table metodopago add constraint unique_tarjeta_id_comprador_id unique (tarjeta_id, comprador_id);

alter table vendedor add constraint Pk5 primary key auto_increment (id);
alter table vendedor add constraint fk_vendedor_usuario foreign key(cedula) references usuario(cedula);
alter table vendedor add constraint cedula_unique unique (cedula);

alter table categoria add constraint pk_id primary key auto_increment(id);
alter table categoria add constraint unique_nombre unique (nombre);

alter table producto add constraint Pk6 primary key auto_increment (id);
alter table producto add constraint Fk4 foreign key(vendedor_id) references vendedor(id);
alter table producto add constraint fk_producto_categoria foreign key (categoria_id) references categoria(id);

alter table compra add constraint Pk7 primary key auto_increment (id);
alter table compra add constraint Fk5 foreign key(producto_id) references producto(id);
alter table compra add constraint Fk6 foreign key(comprador_id) references comprador(id);
alter table compra add constraint Fk7 foreign key( met_pado_id) references metodopago(id);

alter table review add constraint Pk8 primary key auto_increment (id);
alter table review add constraint Fk8 foreign key(compra_id) references compra(id);

alter table provincias add constraint pk_id primary key auto_increment (id);
alter table provincias add constraint unique_nombre unique (nombre);

alter table ciudades add constraint pk_id primary key auto_increment (id);
alter table ciudades add constraint fk_provincia foreign key (provincia_id) references provincias(id);

alter table codigo_postal add constraint pk_id primary key auto_increment (id);
alter table codigo_postal add constraint unique_codigo unique (codigo);

alter table calles add constraint pk_id primary key auto_increment (id);
alter table calles add constraint fk_codigo_postal foreign key (codigo_postal_id) references codigo_postal(id);
alter table calles add constraint fk_ciudad foreign key (ciudad_id) references ciudades(id);
alter table calles add constraint unique_codigo_nombre unique (codigo_postal_id, nombre);

alter table direccion add constraint Pk9 primary key auto_increment (id);
alter table direccion add constraint Fk9 foreign key(usuario_id) references usuario(cedula);
alter table direccion add constraint fk_direccion_calle foreign key (calle_id) references calles(id);
alter table direccion add constraint unique_calle_usuario unique (calle_id, usuario_id);

-- inserts
INSERT INTO usuario (cedula, username, email, nombre) VALUES
('1234567890', 'user1', 'user1@example.com', 'User One'),
('9876543210', 'user2', 'user2@example.com', 'User Two'),
('5432167890', 'user3', 'user3@example.com', 'User Three'),
('0123456789', 'user4', 'user4@example.com', 'User Four'),
('4567890123', 'user5', 'user5@example.com', 'User Five');

INSERT INTO vendedor (id, cedula, nombre_tienda) VALUES
(1, '9876543210', 'Tienda A'),
(2, '0123456789', 'Tienda B'),
(3, '4567890123', 'Tienda C'),
(4, '5432167890', 'Tienda D'),
(5, '1234567890', 'Tienda E');

INSERT INTO categoria (id, nombre, descripcion) VALUES
(1, 'Electrónicos', 'Productos electrónicos y gadgets'),
(2, 'Ropa', 'Ropa para hombres y mujeres'),
(3, 'Hogar', 'Artículos para el hogar'),
(4, 'Deportes', 'Artículos deportivos'),
(5, 'Juguetes', 'Juguetes para niños');


INSERT INTO producto (id, nombre, descripcion, categoria_id, precio_venta, stock, descuento, vendedor_id) VALUES
(1, 'Laptop', 'Potente laptop para trabajo', 1, 800.00, 50, 0.05, 1),
(2, 'Camiseta', 'Camiseta de algodón para hombres', 2, 25.00, 100, 0.10, 2),
(3, 'Olla eléctrica', 'Olla eléctrica programable para cocinar', 3, 60.00, 30, 0.00, 3),
(4, 'Balón de fútbol', 'Balón oficial de la liga', 4, 35.00, 20, 0.15, 4),
(5, 'Set de Lego', 'Set de construcción con piezas variadas', 5, 50.00, 15, 0.20, 5);

INSERT INTO comprador (id, cedula) VALUES
(1, '1234567890'),
(2, '9876543210'),
(3, '5432167890'),
(4, '0123456789'),
(5, '4567890123');

INSERT INTO provincias (id, nombre) VALUES
(1, 'Provincia A'),
(2, 'Provincia B'),
(3, 'Provincia C'),
(4, 'Provincia D'),
(5, 'Provincia E');

INSERT INTO ciudades (id, nombre, provincia_id) VALUES
(1, 'Ciudad X', 1),
(2, 'Ciudad Y', 1),
(3, 'Ciudad Z', 2),
(4, 'Ciudad W', 3),
(5, 'Ciudad V', 4);

INSERT INTO codigo_postal (id, codigo) VALUES
(1, '12345'),
(2, '54321'),
(3, '98765'),
(4, '45678'),
(5, '87654');

INSERT INTO calles (id, codigo_postal_id, ciudad_id, nombre) VALUES
(1, 1, 1, 'Calle Principal 1'),
(2, 2, 2, 'Calle Secundaria 2'),
(3, 3, 3, 'Avenida Central 3'),
(4, 4, 4, 'Plaza Mayor 4'),
(5, 5, 5, 'Callejón Estrecho 5');

INSERT INTO direccion (id, usuario_id, calle_id) VALUES
(1, '1234567890', 1),
(2, '9876543210', 2),
(3, '5432167890', 3),
(4, '0123456789', 4),
(5, '4567890123', 5);


INSERT INTO tarjeta (id, num_tarjeta, nombre, clave, fecha_exp) VALUES
(1, 1111111111111111, 'John Doe', 1234, '2025-12-31'),
(2, 2222222222222222, 'Jane Smith', 5678, '2024-10-30'),
(3, 3333333333333333, 'Bob Johnson', 9012, '2026-08-15'),
(4, 4444444444444444, 'Alice Brown', 3456, '2023-06-22'),
(5, 5555555555555555, 'Eva Davis', 7890, '2025-04-18');



INSERT INTO metodoPago (id, tarjeta_id, comprador_id, predeterminado) VALUES
(1, 1, 1, true),
(2, 2, 2, false),
(3, 3, 3, false),
(4, 4, 4, false),
(5, 5, 5, false);


INSERT INTO compra (id, producto_id, fecha, precio_compra, desc_aplicado, cantidad, comprador_id, met_pado_id) VALUES
(1, 1, '2023-08-03 10:15:00', 750.00, 0.05, 1, 1, 1),
(2, 3, '2023-08-03 11:30:00', 60.00, 0.00, 2, 2, 2),
(3, 5, '2023-08-03 13:45:00', 40.00, 0.10, 1, 3, 3),
(4, 2, '2023-08-03 14:20:00', 22.50, 0.05, 3, 4, 4),
(5, 4, '2023-08-03 15:00:00', 29.75, 0.15, 1, 5, 5);

INSERT INTO review (id, compra_id, puntaje, comentario) VALUES
(1, 1, 4, 'Buen producto, entrega rápida.'),
(2, 2, 5, 'Excelente servicio al cliente.'),
(3, 3, 3, 'Producto cumplió con mis expectativas.'),
(4, 4, 2, 'El producto llegó dañado.'),
(5, 5, 4, 'Buena calidad, lo recomiendo.');

INSERT INTO envio (id, compra_id, direccion_id, estado) VALUES
(1, 1, 1, 'En camino'),
(2, 2, 2, 'Entregado'),
(3, 3, 3, 'En proceso'),
(4, 4, 4, 'Retrasado'),
(5, 5, 5, 'Entregado');