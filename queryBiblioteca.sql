-- creación de la base de datos biblioteca
create database BD_Biblioteca;
-- usar biblioteca
use BD_Biblioteca;

-- ----------------------  creación de la tabla users
create table Users(
idUsers int primary key auto_increment,
firstName varchar(25) not null,
secondName varchar(25) null,
firstsurname varchar(25) not null,
secondsurname varchar(25) null,
email varchar(75) not null,
unique (email)
);
-- ----------------------- insert para la tabla users con 3 registros
insert into Users values(0,'Carolina','','Restrepo','','caro123@gmail.com');
insert into Users values(0,'Johana','Valentina','Orlas','Pachon','valentina123@gmail.com'),
(0,'Adrian','','Ortiz','Flores','ortiz67@gmail.com');

-- creación de la tabla Personal
create table Personal(
idPersonal int primary key auto_increment,
firstName varchar(25) not null,
secondName varchar(25) null,
firstsurname varchar(25) not null,
secondsurname varchar(25) null,
email varchar(75) not null,
unique (email)
);

-- insert para la tabla Personal
insert into Personal values(0,'Sara','Sofia','Orlas','','sofi@gmail.com'),
(0,'Angie','','Martinez','','angie98@gmail.com'),
(0,'Lucelly','','Pachon','Vizcaya','nany231@gmail.com');

-- creación de la tabla telefonos
create table Phones(
idPhone int primary key auto_increment,
numPhone varchar(15) not null,
typePhone enum("Móvil","Fijo") not null,
idUser int null,
idPersonal int null,
foreign key(idUser) references Users(idUsers) ,
foreign key(idPersonal) references Personal(idPersonal) 
);

-- insert en la tabla phones
insert into Phones(idPhone,numPhone,typePhone,idUser) values(0,'+57 3054432448','Móvil',2);
insert into Phones(idPhone,numPhone,typePhone,idPersonal) values(0,'+57 3146396096','Móvil',3);
insert into Phones(idPhone,numPhone,typePhone,idPersonal) values(0,'+57 3024974017','Móvil',1);

-- creación de la tabla prestamos

create table Prestamos(
idPrestamo int primary key auto_increment,
idUser int,
idPersonal int,
foreign key(idUser) references Users(idUsers),
foreign key(idPersonal) references Personal(idPersonal) 
);

-- insert en la tabla prestamos con 3 registros
insert into Prestamos values(0,2,3),(0,1,3),(0,3,2);

-- Creación de la tabla Historial Prestamos
create table HistorialPrestamos(
idHistorialPrestamos int auto_increment primary key,
fecha_inicio date not null,
fecha_fin date not null,
cantidad varchar(12) not null,
estado enum("Pendiente","Culminado"),
idPrestamo int,
foreign key (idPrestamo) references Prestamos(idPrestamo)
);
alter table historialPrestamos
add column idMulta int;
alter table historialPrestamos
add foreign key (idMulta) references Multa(idMulta);
alter table historialPrestamos
add column idEjemplar int;
alter table historialPrestamos
add foreign key (idEjemplar) references Ejemplares(idEjemplar);

-- insert de la tabla historialPrestamos
insert into HistorialPrestamos (fecha_inicio, fecha_fin, cantidad, estado, idPrestamo, idMulta, idEjemplar) values
('2023-01-01', '2023-01-15', '1', 'Culminado', 1, 2, 19),
('2023-02-01', '2023-02-15', '2', 'Pendiente', 3, 2, 17),
('2023-03-01', '2023-03-15', '3', 'Pendiente', 3, 1, 18);

select idEjemplar from Ejemplares;

-- Creación de la tabla Multa
create table Multa(
idMulta int auto_increment primary key,
fecha date not null,
valor varchar(25) not null,
estado enum("Debe","Pagado")	
);
insert into Multa (fecha, valor, estado) values('2023-01-01', '50.00', 'Debe'),
('2023-02-15', '30.00', 'Pagado'),
('2023-03-20', '25.00', 'Debe');

-- Creación de la tabla libros
create table Libros(
idLibro int auto_increment primary key,
titulo varchar(25) not null,
autor varchar(25) not null,
editorial varchar(25) null
);
-- insert para la tabla Libros
insert into Libros values(0, 'El nombre del viento', 'Patrick Rothfuss', 'Penguin Random House'),
(0, 'Cien años de soledad', 'Gabriel García Márquez', 'Editorial Sudamericana'),
(0, 'Harry Potter y la piedra', 'J.K. Rowling', 'Bloomsbury Publishing');

-- Creación de la tabla Revistas
create table Revistas(
idRevista int auto_increment primary key,
titulo varchar(25) not null,
nombreRevista varchar(25) not null,
editorial varchar(25) null
);
-- insert para la tabla Revistas
insert into Revistas values(0, 'National Geographic', 'NatGeo', 'NatGeo Partners'),
(0, 'Time', 'Time Magazine', 'Time LLC'),
(0, 'Scientific American', 'SciAm', 'Springer Nature');

-- creación de la tabla Ejemplares
create table Ejemplares(
idEjemplar int auto_increment primary key,
titulo varchar(25) not null,
autor varchar(25) not null,
tipo enum("Libro","Revista") not null,
idLibro int null,
idRevista int null,
foreign key (idLibro) references Libros(idLibro),
foreign key (idRevista) references Revistas(idRevista)
); 

-- insert de la tabla Ejemplares
insert into Ejemplares (titulo, autor, tipo, idLibro, idRevista) values('El nombre del viento', 'Patrick Rothfuss', 'Libro', 4, NULL),
('Cien años de soledad', 'Gabriel García Márquez', 'Libro', 5, NULL),
('SciAm - Febrero 2022',  'SciAm', 'Revista', NULL, 3);

-- creación de la tabla reservas
create table Reservas(
idReserva int auto_increment primary key,
fecha date not null,
estado enum("Pendiente","Cerrado") not null
);
-- insert para la tabla Reservas
insert into Reservas (fecha, estado) values('2023-01-01', 'Pendiente'),
('2023-02-15', 'Cerrado'),
('2023-03-20', 'Pendiente');
select idReserva from Reservas;
create table EjemplaresReservas(
idEjemeplarReserva int auto_increment primary key,
idEjemplar int,
idReserva int,
foreign key(idEjemplar) references Ejemplares(idEjemplar),
foreign key(idReserva) references Reservas(idReserva)
);
-- inser para la tabla EjemplaresReservas
insert into EjemplaresReservas (idEjemplar, idReserva) values
(17, 1),
(19, 2),
(18, 3);