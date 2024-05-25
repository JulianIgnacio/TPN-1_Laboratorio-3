Create DATABASE Inmobiliario;
Use Inmobiliario;

Create Table Propiedades (
    IdPropiedad int primary key auto_increment,
    Direccion varchar(150) not null,
    Ciudad varchar(100) not null,
    Precio varchar(50) not null,
    Tipo varchar(50) not null
);

Create Table Clientes (
    IdCliente int primary key auto_increment,
    Nombre varchar(100) not null,
    Apellido varchar(100) not null,
    Email varchar(100) not null,
    Telefono varchar(15) not null
);

Create Table Agentes (
    IdAgente int primary key auto_increment,
    Nombre varchar(100) not null,
    Apellido varchar(100) not null,
    Email varchar(100) not null,
    Telefono varchar(15) not null
);

Create Table Transacciones (
    IdTransaccion int primary key auto_increment,
    Fecha date not null,
    PrecioTotal varchar(50) not null,
    IdPropiedad int,
    IdCliente int,
    IdAgente int,
    foreign key (IdPropiedad) references Propiedades(IdPropiedad),
    foreign key (IdCliente) references Clientes(IdCliente),
    foreign key (IdAgente) references Agentes(IdAgente)
);

Insert into Propiedades (Direccion, Ciudad, Precio, Tipo) values
('25 de Mayo 250', 'San Miguel de Tucuman', 10000000, 'Casa'),
('Republica del Libano 1054', 'Tafi Viejo', 500000, 'Departamento'),
('Brigido Teran 846', 'San Pedro de Colalao', 20000000, 'Departamento'),
('San Martin 1348', 'Burruyacu', 2500000, 'Casa'),
('Laprida 543', 'Famailla', 3000000, 'Casa');

Insert into Clientes (Nombre, Apellido, Email, Telefono) values
('Juan', 'Perez', 'juan.perez@example.com', '123456789'),
('Maria', 'Gomez', 'maria.gomez@example.com', '987654321'),
('Carlos', 'Lopez', 'carlos.lopez@example.com', '123123123'),
('Ana', 'Martinez', 'ana.martinez@example.com', '321321321'),
('Luis', 'Garcia', 'luis.garcia@example.com', '456456456');

Insert into Agentes (Nombre, Apellido, Email, Telefono) values
('Federico', 'Diaz', 'federico.diaz@example.com', '3814567812'),
('Pepita', 'Lolita', 'pepitadiaz@example.com', '3811237498'),
('Corriente', 'Mendoza', 'corriente@example.com', '381789134'),
('Sicario', 'Roaming', 'sicario@example.com', '3814567891'),
('Marta', 'Powell', 'martapow@example.com', '3811234564');

Insert into Transacciones (Fecha, PrecioTotal, IdPropiedad, IdCliente, IdAgente) values
('2024-06-05', '1500000', 1, 1, 1),
('2024-06-15', '2000000', 2, 2, 1), 
('2024-01-10', '3000000', 3, 3, 2), 
('2024-02-20', '2500000', 4, 4, 3), 
('2024-03-15', '3500000', 5, 5, 1), 
('2024-04-10', '4000000', 1, 2, 2),
('2024-05-25', '5000000', 4, 3, 1), 
('2024-04-15', '6000000', 5, 1, 1), 
('2024-04-20', '5500000', 3, 4, 2), 
('2024-04-25', '7000000', 2, 5, 3); 

Select T.IdTransaccion, T.Fecha, T.PrecioTotal 
From Transacciones T
Join Agentes A on T.IdAgente = A.IdAgente
Where A.Nombre = 'Federico' and A.Apellido = 'Diaz' and month(T.Fecha) = 6 and year(T.Fecha) = 2024
Order by T.Fecha desc;

Select A.Nombre, A.Apellido, count(T.IdTransaccion) as NumeroDeVentas
From Transacciones T
Join Agentes A on T.IdAgente = A.IdAgente
Where year(T.Fecha) = year(curdate())
GROUP BY A.IdAgente
ORDER BY NumeroDeVentas desc
Limit 1;

Select C.Nombre, C.Apellido, T.PrecioTotal, T.Fecha 
From Transacciones T
Join Clientes C on T.IdCliente = C.IdCliente
Join Propiedades P on T.IdPropiedad = P.IdPropiedad
Where P.Tipo = 'Casa'
Order by cast(T.PrecioTotal as decimal(10,2)) desc
Limit 1;

Select A.Nombre as AgenteNombre, A.Apellido as AgenteApellido 
From Transacciones T
Join Agentes A on T.IdAgente = A.IdAgente
Join Propiedades P on T.IdPropiedad = P.IdPropiedad
Where P.Tipo = 'Casa'
Order by cast(T.PrecioTotal as decimal(10,2)) desc
Limit 1;

Select P.Direccion as Propiedad, A.Nombre as AgenteNombre, A.Apellido as AgenteApellido, C.Nombre as ClienteNombre, C.Apellido as ClienteApellido, T.PrecioTotal, T.Fecha 
From Transacciones T
Join Propiedades P on T.IdPropiedad = P.IdPropiedad
Join Agentes A on T.IdAgente = A.IdAgente
Join Clientes C on T.IdCliente = C.IdCliente
Where T.Fecha >= date_sub(curdate(), interval 1 month)
Order by cast(T.PrecioTotal as decimal(10,2)) desc
Limit 3;