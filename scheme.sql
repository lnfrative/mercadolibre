create database mercadoLibre;
use mercadoLibre;
-- drop database mercadoLibre;
-- Creando las Estructuras
create table usuario(
cedula char(10),
username varchar(50), -- unique
email varchar(50), -- unique
nombre varchar(100));


create table vendedor(
id int ,
cedula char(10), -- unique
nombre_tienda varchar(100)
);

create table categoria {
    id int,
    nombre varchar(25)
    descripcion varchar(50)
}

create table producto(
	id int ,
    nombre char(10),
    descripcion text,
    categoria_id int, -- fk
    precio_venta decimal(10,2),
    stock int,
    descuento decimal(10,2),
    vendedor_id int
);

create table compra(
	id int,
    producto_id int,
    fecha datetime,
    precio_compra decimal(10,2),
    desc_aplicado decimal(10,2),
    cantidad int,
    comprador_id int,
    met_pado_id int
);

create table comprador(
id int ,
cedula char(10));

create table metodoPago(
id int ,
tarjeta_id int,
comprador_id int,
predeterminado boolean
);

create table review(
id int ,
compra_id int,
puntaje int,
comentario text
);

create table provincias(
    id int,
    nombre varchar(100) -- unique
);

create table ciudades(
    id int,
    nombre varchar(100),
    provincia_id int
);

create table codigo_postal(
    id int,
    codigo char(6) -- unique
);

crete table calles(
    id int,
    codigo_postal_id int,
    ciudad_id int,
    nombre varchar(100)
    
    -- unique entre ciudad_id y nombre
);

create table direccion(
	id int ,
    usuario_id char(10),
    ciudad_id int,
    calle varchar(50)
    
    -- unique usuario - ciudad - calle
);
    
create table tarjeta(
	id int ,
    num_tarjeta int, -- unique
    nombre char(10),
    clave int,
    fecha_exp date
);

create table envio(
id int,
compra_id int,
direccion_id int,
estado varchar(25));

-- Creando los contraints con las claves necesarias
alter table tarjeta add constraint Pk1 primary key(id);

alter table usuario add constraint Pk2 primary key(cedula);

alter table comprador add constraint Pk3 primary key(id);
alter table comprador add constraint Fk1 foreign key(cedula) references usuario(cedula);

alter table metodopago add constraint Pk4 primary key(id);
alter table metodopago add constraint Fk2 foreign key(tarjeta_id) references tarjeta(id);
alter table metodopago add constraint Fk3 foreign key(comprador_id) references comprador(id);

alter table vendedor add constraint Pk5 primary key(id);
alter table vendedor add constraint  foreign key(cedula) references usuario(cedula);

alter table producto add constraint Pk6 primary key(id);
alter table producto add constraint Fk4 foreign key(vendedor_id) references vendedor(id);

alter table compra add constraint Pk7 primary key(id);
alter table compra add constraint Fk5 foreign key(producto_id) references producto(id);
alter table compra add constraint Fk6 foreign key(comprador_id) references comprador(id);
alter table compra add constraint Fk7 foreign key( met_pado_id) references metodopago(id) ;

alter table review add constraint Pk8 primary key(id);
alter table review add constraint Fk8 foreign key(compra_id) references compra(id);

alter table direccion add constraint Pk9 primary key(id);
alter table direccion add constraint Fk9 foreign key(usuario_id) references usuario(cedula);

-- Llenando las tablas con datos 

