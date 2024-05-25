Create DATABASE Hospital1;
Use Hospital1;

Create Table Pacientes (
    IdPaciente int primary key,
    Nombre varchar(50),
    Apellido varchar(50),
    Edad int,
    Dirección varchar(100)
);

Create Table Medicos (
    IdMedico int primary key,
    Nombre varchar(50),
    Apellido varchar(50),
    Especialidad varchar(50),
    Teléfono varchar(20)
);

Create Table Admisionistas (
    IdAdmisionista int primary key,
    Nombre varchar(50),
    Apellido varchar(50),
    Turno_Trabajo varchar(50),
    Teléfono varchar(20)
);

Create Table Turnos (
    IdTurno int primary key,
    Fecha date,
    Hora time,
    IdPaciente int,
    IdMedico int,
    IdAdmisionista int,
    Foreign key (IdPaciente) references Pacientes(IdPaciente),
    Foreign key (IdMedico) references Medicos(IdMedico),
    Foreign key (IdAdmisionista) references Admisionistas(IdAdmisionista)
);

Create Table Tratamientos (
    IdTratamiento int primary key,
    Descripción varchar(100),
    IdTurno int,
    Foreign key (IdTurno) references Turnos(IdTurno)
);

Create Table Estudios (
    IdEstudio int primary key,
    Tipo varchar(50),
    Resultado varchar(100),
    IdTurno int,
    Foreign key (IdTurno) references Turnos(IdTurno)
);

Insert into Pacientes (IdPaciente, Nombre, Apellido, Edad, Dirección) values
(1, 'Juan', 'Pérez', 45, 'Libano 452'),
(2, 'Ana', 'García', 34, 'Av. Salta 2341'),
(3, 'Luis', 'Martínez', 50, 'Av. Corrientes 1243');

Insert into Medicos (IdMedico, Nombre, Apellido, Especialidad, Teléfono) values
(1, 'Carlos', 'De la Torre', 'Cardiología', '5551234'),
(2, 'María', 'López', 'Neurología', '5555678');

Insert into Admisionistas (IdAdmisionista, Nombre, Apellido, Turno_Trabajo, Teléfono) values
(12, 'Lucía', 'Fernández', 'Mañana', '5554321'),
(13, 'Pedro', 'Ramírez', 'Tarde', '5558765');

Insert into Turnos (IdTurno, Fecha, Hora, IdPaciente, IdMedico, IdAdmisionista) values
(1, '2024-08-01', '08:00:00', 1, 1, 12),
(2, '2024-08-15', '10:00:00', 2, 1, 12),
(3, '2024-05-10', '09:00:00', 3, 2, 13),
(4, '2023-01-27', '15:00:00', 1, 1, 12);

Insert into Tratamientos (IdTratamiento, Descripción, IdTurno) values
(1, 'Tratamiento A', 1),
(2, 'Tratamiento B', 2),
(3, 'Tratamiento C', 3);

Insert into Estudios (IdEstudio, Tipo, Resultado, IdTurno) values
(1, 'Radiografía', 'Normal', 1),
(2, 'Análisis de Sangre', 'Alterado', 2),
(3, 'Electrocardiograma', 'Normal', 4);

Select count(*) as TotalTurnos
From Turnos
Where IdAdmisionista = 12
And Fecha between '2024-08-01' and '2024-08-31';

Select Pacientes.Nombre, Pacientes.Edad
From Turnos
Join Pacientes on Turnos.IdPaciente = Pacientes.IdPaciente
Where Turnos.IdAdmisionista = 12;

Select *
From Turnos
Where month(Fecha) in (6, 7, 8)
Order by Fecha asc;

Select Pacientes.Nombre, Medicos.Nombre as NombreMedico, Medicos.Apellido as ApellidoMedico, Turnos.IdTurno
From Turnos
Join Pacientes on Turnos.IdPaciente = Pacientes.IdPaciente
Join Medicos on Turnos.IdMedico = Medicos.IdMedico
Where month(Turnos.Fecha) = 5 and year(Turnos.Fecha) = 2024
Group by Pacientes.Nombre, Turnos.IdTurno
Order by Pacientes.Nombre DESC
Limit 5;

Select Pacientes.Nombre, Estudios.Tipo, Estudios.Resultado
From Turnos
Join Pacientes on Turnos.IdPaciente = Pacientes.IdPaciente
Join Medicos on Turnos.IdMedico = Medicos.IdMedico
Join Estudios on Turnos.IdTurno = Estudios.IdTurno
Where Medicos.Apellido = 'De la Torre' and Turnos.Fecha = '2023-01-27';