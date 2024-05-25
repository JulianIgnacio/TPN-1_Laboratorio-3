CREATE DATABASE db_banco;

USE db_banco;

create table Clientes (
id_Clientes int primary key auto_increment,
NombreC varchar(50) not null,
ApellidoC varchar(50) not null,
DNIC int,
CuilC varchar(50),
DireccionC varchar(250),
TelefonoC int
);
create table Empleados(
id_Empleado int primary key auto_increment,
id_Sucursales int,
NombreE varchar(50) not null,
ApellidoE varchar(50) not null,
DNIE int,
CuilE varchar(50),
DireccionE varchar(250),
TelefonoE int,
foreign key (id_Sucursales)references Sucursales(id_Sucursales)
);
create table Sucursales (
id_Sucursales int primary key auto_increment,
id_Cuentas int,
NombreS varchar(50),
DireccionS varchar(250),
HorarioAtencion time,
foreign key (id_Cuentas) references Cuentas(id_Cuentas)
);
alter table Sucursales
add constraint id_Prestamo
foreign key (id_Prestamo) references Prestamo(id_Prestamo);
create table Cuentas (
id_Cuentas int primary key auto_increment,
id_Clientes int,
id_Sucursales int,
TitularC varchar(50),
Saldo double,
Tipo varchar(50),
Moneda varchar(50),
foreign key (id_Clientes)references Clientes(id_Clientes)
);
alter table Cuentas
ADD constraint id_Sucursales
foreign key (id_Sucursales)references Sucursales(id_Sucursales);

create table Prestamos (
id_Prestamos int primary key auto_increment,
id_Transacciones int,
id_Clientes int,
id_Sucursales int,
id_Empleado int,
Monto double,
Fechainicio date,
Interes double,
foreign key (id_Transacciones)references Transacciones(id_Transacciones),
foreign key (id_Clientes)references Clientes(id_Clientes),
foreign key (id_Sucursales)references Sucursales(id_Sucursales),
foreign key (id_Empleado) references Empleados(id_Empleado),
TotalPrestado double
);

create table Transacciones (
id_Transacciones int primary key auto_increment,
id_Cuentas int,
id_empleado int,
id_Prestamos int,
FechaYHora datetime,
TipoDeTransaccion varchar(50),
foreign key (id_Cuentas) references Cuentas(id_Cuentas),
foreign key (id_Empleado) references Empleados(id_Empleado)
);
alter table Transacciones 
ADD constraint id_Prestamo
foreign key (id_Prestamos) references Prestamos(id_Prestamos)