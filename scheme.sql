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
    nombre varchar(25) --unique
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
cedula char(10)); -- unique

create table metodoPago(
id int ,
tarjeta_id int,
comprador_id int,
predeterminado boolean

-- unique tarjta_id y comprador_id
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

create table calles(
    id int,
    codigo_postal_id int,
    ciudad_id int,
    nombre varchar(100)
    
    -- unique entre ciudad_id y nombre
);

create table direccion(
	id int ,
    usuario_id char(10),
    calle_id varchar(50)

    -- unique usuareio y calle
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
alter table tarjeta add constraint unique_numtarjeta unique (num_tarjeta);

alter table usuario add constraint Pk2 primary key(cedula);
alter table usuario add constraint usuario_unique unique (username);
alter table usuario add constraint email_unique unique (email);

alter table comprador add constraint Pk3 primary key(id);
alter table comprador add constraint Fk1 foreign key(cedula) references usuario(cedula);
alter table comprador add constraint cedula_unique unique (cedula);

alter table metodopago add constraint Pk4 primary key(id);
alter table metodopago add constraint Fk2 foreign key(tarjeta_id) references tarjeta(id);
alter table metodopago add constraint Fk3 foreign key(comprador_id) references comprador(id);
alter table metodopago add constraint unique_tarjeta_id_comprador_id unique (tarjeta_id, comprador_id);

alter table vendedor add constraint Pk5 primary key(id);
alter table vendedor add constraint  foreign key(cedula) references usuario(cedula);
alter table vendedor add constraint cedula_unique unique (cedula);

alter table categoria add constraint pk_id primary key (id);
alter table categoria add constraint unique_nombre unique (nombre);

alter table producto add constraint Pk6 primary key(id);
alter table producto add constraint Fk4 foreign key(vendedor_id) references vendedor(id);
alter table producto add constraint fk_producto_categoria foreign key (categoria_id) references categoria(id);

alter table compra add constraint Pk7 primary key(id);
alter table compra add constraint Fk5 foreign key(producto_id) references producto(id);
alter table compra add constraint Fk6 foreign key(comprador_id) references comprador(id);
alter table compra add constraint Fk7 foreign key( met_pado_id) references metodopago(id);

alter table review add constraint Pk8 primary key(id);
alter table review add constraint Fk8 foreign key(compra_id) references compra(id);

alter table direccion add constraint Pk9 primary key(id);
alter table direccion add constraint Fk9 foreign key(usuario_id) references usuario(cedula);
alter table direccion add constraint fk_calle foreign key (calle_id) references calles(id);
alter table direccion add constraint unique_calle_usuario unique (calle_id, usuario_id);

alter table provincias add constraint pk_id primary key (id);
alter table provincias add constraint unique_nombre unique (nombre);

alter table ciudades add constraint pk_id primary key (id);
alter table ciudades add constraint fk_provincia foreign key (provincia_id) references provincias(id);

alter table codigo_postal add constraint pk_id primary key (id);
alter table codigo_postal add constraint unique_codigo unique (codigo);

alter table calles add constraint pk_id primary key (id);
alter table calles add constraint fk_codigo_postal foreign key (codigo_postal_id) references codigo_postal(id);
alter table calles add constraint fk_ciudad foreign key (ciudad_id) references ciudades(id);
alter table calles add constraint unique_codigo_nombre unique (codigo_postal_id, nombre);

-- Llenando las tablas con datos 

