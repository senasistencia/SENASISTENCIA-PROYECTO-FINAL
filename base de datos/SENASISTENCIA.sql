--Query Base de datos SENASISTENCIA 22/05/2018
USE master
CREATE DATABASE senasistencia
USE senasistencia

--Tabla fuerte
CREATE TABLE programa_formacion(
ID_Programa BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
Nombre_Programa VARCHAR(100) NOT NULL,
Estado_Programa BIT NOT NULL, 
FechaDeCreacion_Programa DATE NOT NULL,
FechaDeInactivacion_Programa DATE
                               )
--Tabla fuerte
CREATE TABLE tipo_de_documento(
ID_TipoDeDocumento BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
Nombre_TipoDeDocumento VARCHAR(30) NOT NULL,
Estado_TipoDeDocumento BIT NOT NULL,
FechaDeCreacion_TipoDeDocumento DATE NOT NULL,
FechaDeInactivacion_TipoDeDocumento DATE
                             )
--Tabla fuerte
CREATE TABLE rol(
ID_Rol BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
Tipo_Rol VARCHAR(30) NOT NULL,
Estado_Rol BIT NOT NULL,
FechaDeCreacion_Rol DATE NOT NULL,
FechaDeInactivacion_Rol DATE
                 )
--Tabla fuerte
CREATE TABLE perfil(
ID_Perfil BIGINT  PRIMARY KEY NOT NULL IDENTITY(1,1),
Tipo_Perfil VARCHAR(40) NOT NULL,
Estado_Perfil BIT NOT NULL, 
FechaDeCreacion_Perfil DATE NOT NULL,
FechaDeInactivacion_Perfil DATE
                   )
				   
--Tabla fuerte
CREATE TABLE excusa(
ID_Excusa BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
FechaInicio_Excusa DATE NOT NULL,
FechaFin_Excusa DATE NOT NULL,
Comentario_Excusa VARCHAR(600) NOT NULL,
Url_Excusa VARCHAR(500)
            )

CREATE TABLE notificacion(
ID_Notificacion INT PRIMARY KEY NOT NULL,
Asunto_Notificacion VARCHAR(100) NOT NULL,
Mensaje_Notificacion VARCHAR(3000) NOT NULL
)

--Tabla debil
CREATE TABLE cliente(
FK_TipoDeDocumento BIGINT FOREIGN KEY REFERENCES tipo_de_documento(ID_TipoDeDocumento),
Documento_Cliente BIGINT PRIMARY KEY NOT NULL,
PrimerNombre_Cliente VARCHAR(60) NOT NULL,
SegundoNombre_Cliente VARCHAR(60),
PrimerApellido_Cliente VARCHAR(60) NOT NULL,
SegundoApellido_Cliente VARCHAR(60),
Correo_Cliente VARCHAR(60) NOT NULL,
Telefono_Cliente VARCHAR(10),
FK_Perfil BIGINT FOREIGN KEY REFERENCES perfil(ID_Perfil),
Estado_Cliente BIT NOT NULL,
FechaDeCreacion_Cliente DATE NOT NULL,
FechaDeInactivacion_Cliente DATE
)

--Tabla debil
CREATE TABLE ficha(
ID_Ficha BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
FK_Programa BIGINT FOREIGN KEY REFERENCES programa_formacion (ID_Programa),
Num_Ficha VARCHAR(20) NOT NULL,
Grupo_Ficha INT NOT NULL,
Jornada_Ficha VARCHAR (20) NOT NULL,
Trimestre_Ficha INT NOT NULL,
Estado_Ficha BIT NOT NULL,
FechaDeCreacion_Ficha DATE NOT NULL,
FechaDeInactivacion_Ficha DATE 
                  )

--Tabla debil
CREATE TABLE aprendiz(
FK_TipoDeDocumento BIGINT FOREIGN KEY REFERENCES tipo_de_documento(ID_TipoDeDocumento),
Documento_Aprendiz BIGINT PRIMARY KEY NOT NULL,
PrimerNombre_Aprendiz VARCHAR(60) NOT NULL,
SegundoNombre_Aprendiz VARCHAR(60),
PrimerApellido_Aprendiz VARCHAR(60) NOT NULL,
SegundoApellido_Aprendiz VARCHAR(60),
Correo_Aprendiz VARCHAR(60) NOT NULL,
Telefono_Aprendiz VARCHAR(10),
FK_Ficha BIGINT FOREIGN KEY REFERENCES ficha(ID_Ficha),
Estado_Aprendiz BIT NOT NULL,
FechaDeCreacion_Aprendiz DATE NOT NULL,
FechaDeInactivacion_Aprendiz DATE
)
--Tabla debil
CREATE TABLE usuario(
ID_Usuario BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
FK_DocCliente BIGINT FOREIGN KEY REFERENCES cliente(Documento_Cliente),
Password_Usuario VARCHAR(100) NOT NULL,
Estado_Usuario BIT NOT NULL,
FechaDeCreacion_Usuario  DATE NOT NULL,
FechaDeInactivacion_Usuario DATE
                   )

--Tabla debil
CREATE TABLE asistencia(
ID_Asistencia BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
FK_DocAprendiz BIGINT FOREIGN KEY REFERENCES aprendiz(Documento_Aprendiz),
Estado_Asistencia BIT NOT NULL,
Fecha_Asistencia DATE NOT NULL 
                       )

--Tabla debil
CREATE TABLE registro_notificacion (
ID_Registro BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1),
Fecha_Registro DATE NOT NULL,
FK_DocAprendiz BIGINT FOREIGN KEY REFERENCES aprendiz(Documento_Aprendiz),
FK_Asistencia BIGINT FOREIGN KEY REFERENCES asistencia(ID_Asistencia),
FK_DocCliente BIGINT FOREIGN KEY REFERENCES cliente(Documento_Cliente),
FK_Notificacion INT FOREIGN KEY REFERENCES notificacion(ID_Notificacion)
)

--Tablas intermedias de las relaciones muchos a muchos

--Relacion entre la tabla cliente y Ficha
CREATE TABLE cliente_ficha(
FK_DocCliente BIGINT FOREIGN KEY REFERENCES cliente(Documento_Cliente),
FK_Ficha BIGINT FOREIGN KEY REFERENCES ficha(ID_Ficha)
)
--Relacion entre la tabla Cliente y Rol
CREATE TABLE cliente_rol(
FK_DocCliente BIGINT FOREIGN KEY REFERENCES cliente(Documento_Cliente),
FK_Rol BIGINT FOREIGN KEY REFERENCES rol(ID_Rol)
)
--Relacion entre la tabla Excusa y asistencia
CREATE TABLE excusa_asistencia(
FK_Excusa BIGINT FOREIGN KEY REFERENCES excusa(ID_Excusa),
FK_Asistencia BIGINT FOREIGN KEY REFERENCES asistencia(ID_Asistencia)
)

