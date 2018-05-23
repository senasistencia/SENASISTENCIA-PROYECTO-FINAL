USE master
CREATE DATABASE senasistencia
USE senasistencia
CREATE TABLE centro_formacion(
ID_Centro BIGINT PRIMARY KEY  NOT NULL IDENTITY(1,1),		
Nombre_Centro VARCHAR(60) NOT NULL,
Direccion_Centro VARCHAR(60),
Telefono_Centro VARCHAR(10),
Estado_Centro BIT NOT NULL,
FechaDeCreacion_Centro DATE NOT NULL,
FechaDeInactivacion_Centro DATE
                             )

CREATE TABLE programa_formacion(
ID_Programa BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
Nombre_ProgramaFormacion VARCHAR(100) NOT NULL,
Estado_ProgramaFormacion BIT NOT NULL, 
FechaDeCreacion_Programa DATE NOT NULL,
FechaDeInactivacion_Programa DATE
                               )

CREATE TABLE tipo_de_documento(
ID_TipoDeDocumento BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
Nombre_TipoDeDocumento VARCHAR(30) NOT NULL,
Estado_TipoDeDocumento BIT NOT NULL,
FechaDeCreacion_TipoDeDocumento DATE NOT NULL,
FechaDeInactivacion_TipoDeDocumento DATE
                             )

CREATE TABLE rol(
ID_Rol BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
Tipo_Rol VARCHAR(40) NOT NULL,
Estado_Rol BIT NOT NULL,
FechaDeCreacion_Rol DATE NOT NULL,
FechaDeInactivacion_Rol DATE
                 )

CREATE TABLE perfil(
ID_Perfil BIGINT  PRIMARY KEY NOT NULL IDENTITY(1,1),
Tipo_De_Perfil VARCHAR(40) NOT NULL,
Estado_Perfil BIT NOT NULL, 
FechaDeCreacion_Perfil DATE NOT NULL,
FechaDeInactivacion_Perfil DATE
                   )

CREATE TABLE sede(
ID_Sede BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
Nombre_Sede VARCHAR(60) NOT NULL,
Direccion_Sede VARCHAR (60),
Telefono_Sede VARCHAR(10),
centro_formacion_ID_Centro BIGINT FOREIGN KEY REFERENCES centro_formacion (ID_Centro),
Estado_Sede BIT NOT NULL,
FechaDeCreacion_Sede DATE NOT NULL,
FechaDeInactivacion_Sede DATE
                  )


CREATE TABLE cliente(
tipo_de_documento_ID_TipoDeDocumento BIGINT FOREIGN KEY REFERENCES tipo_de_documento(ID_TipoDeDocumento),
Documento_Cliente BIGINT PRIMARY KEY NOT NULL,
PrimerNombre_Cliente VARCHAR(60) NOT NULL,
SegundoNombre_Cliente VARCHAR(60),
PrimerApellido_Cliente VARCHAR(60) NOT NULL,
SegundoApellido_Cliente VARCHAR(60),
perfil_ID_Perfil BIGINT FOREIGN KEY REFERENCES perfil(ID_Perfil),
Correo_Cliente VARCHAR(60) NOT NULL,
Telefono_Cliente VARCHAR(10),
Estado_Cliente BIT NOT NULL,
FechaDeCreacion_Cliente DATETIME NOT NULL,
FechaDeInactivacion_Cliente DATETIME
)

CREATE TABLE cliente_has_sede(
cliente_Documento_Cliente BIGINT FOREIGN KEY REFERENCES cliente(Documento_Cliente),
perfil_ID_Perfil BIGINT FOREIGN KEY REFERENCES perfil(ID_Perfil),
sede_ID_Sede BIGINT FOREIGN KEY REFERENCES sede(ID_Sede)
                             )

CREATE TABLE rol_has_cliente(
rol_ID_Rol BIGINT FOREIGN KEY REFERENCES rol(ID_Rol),
cliente_Documento_Cliente  BIGINT FOREIGN KEY REFERENCES cliente(Documento_Cliente),
perfil_ID_perfil BIGINT FOREIGN KEY REFERENCES perfil(ID_Perfil)
                           )

CREATE TABLE ambiente_formacion(
ID_Ambiente BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
Num_Ambiente BIGINT NOT NULL,
sede_ID_Sede BIGINT FOREIGN KEY REFERENCES sede(ID_Sede),	
Estado_Ambiente BIT NOT NULL,
FechaDeCreacion_AmbienteFormacion DATE NOT NULL,
FechaDeInactivacion_AmbienteFormacion DATE                              
							  )

CREATE TABLE ficha(
ID_Ficha BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
programa_formacion_ID_Programa BIGINT FOREIGN KEY REFERENCES programa_formacion (ID_Programa),
Num_Ficha VARCHAR(20) NOT NULL,
Grupo_Ficha INT NOT NULL,
Jornada_Ficha VARCHAR (15) NOT NULL,
Trimestre_Ficha INT NOT NULL,
ambiente_formacion_ID_Ambiente BIGINT FOREIGN KEY REFERENCES ambiente_formacion (ID_Ambiente),
Estado_Ficha BIT NOT NULL,
FechaDeCreacion_Ficha DATE NOT NULL,
FechaDeInactivacion_Ficha DATE 
                  )

CREATE TABLE aprendiz(
tipo_de_documento_ID_TipoDeDocumento BIGINT FOREIGN KEY REFERENCES tipo_de_documento(ID_TipoDeDocumento),
Documento_Aprendiz BIGINT PRIMARY KEY NOT NULL,
PrimerNombre_Aprendiz VARCHAR(60) NOT NULL,
SegundoNombre_Aprendiz VARCHAR(60),
PrimerApellido_Aprendiz VARCHAR(60) NOT NULL,
SegundoApellido_Aprendiz VARCHAR(60),
Correo_Aprendiz VARCHAR(60) NOT NULL,
Telefono_Aprendiz VARCHAR(10),
ficha_ID_Ficha BIGINT FOREIGN KEY REFERENCES ficha(ID_Ficha),
Estado_Aprendiz BIT NOT NULL,
FechaDeCreacion_Aprendiz DATE NOT NULL,
FechaDeInactivacion_Aprendiz DATE
                     )

CREATE TABLE excusa(
ID_Excusa BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
aprendiz_Documento_Aprendiz BIGINT FOREIGN KEY REFERENCES aprendiz(Documento_Aprendiz),
FechaInicio_Excusa DATE NOT NULL,
FechaFin_Excusa DATE NOT NULL,
Comentario_Excusa VARCHAR(600) NOT NULL,
Url_Excusa VARCHAR(500)
            )

CREATE TABLE asistencia(
ID_Asistencia BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
aprendiz_Documento_Aprendiz BIGINT FOREIGN KEY REFERENCES aprendiz(Documento_Aprendiz),
Asistencia BIT NOT NULL,
Fecha_Asistencia DATE NOT NULL 
                       )

CREATE TABLE asistencia_has_excusa(
asistencia_ID_Asistencia BIGINT FOREIGN KEY REFERENCES asistencia(ID_Asistencia),
excusa_ID_Excusa BIGINT FOREIGN KEY REFERENCES excusa(ID_Excusa)
                                  )

CREATE TABLE formato_ftp(
ID_Formato BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
Nombre_Formato VARCHAR(60) NOT NULL,
Url_Ftp VARCHAR(500),
asistencia_ID_Asistencia BIGINT FOREIGN KEY REFERENCES asistencia(ID_Asistencia),
Estado_Formato BIT NOT NULL  
                        )

CREATE TABLE notificacion(
ID_Notificacion BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
Mensaje_Notificacion VARCHAR(600) NOT NULL,
formato_ftp_ID_Formato BIGINT FOREIGN KEY REFERENCES formato_ftp(ID_Formato),
Fecha_Notificacion DATE NOT NULL,
cliente_Documento_Cliente BIGINT FOREIGN KEY REFERENCES cliente(Documento_Cliente), 
aprendiz_Documento_Aprendiz BIGINT FOREIGN KEY REFERENCES aprendiz(Documento_Aprendiz)
                         )

CREATE TABLE usuario(
ID_Usuario BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
cliente_Documento_Cliente BIGINT FOREIGN KEY REFERENCES cliente(Documento_Cliente),
Password_Hash VARCHAR(100) NOT NULL,
Estado_Usuario BIT NOT NULL,
FechaDeCreacion_Usuario  DATE NOT NULL,
FechaDeInactivacion_Usuario DATE
                   )

CREATE TABLE password_token(
ID_Token  BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
usuario_ID_Usuario BIGINT FOREIGN KEY REFERENCES usuario(ID_Usuario),
Token_Hash VARCHAR(60) NOT NULL
                           )

INSERT INTO  centro_formacion(Nombre_Centro,Direccion_Centro,Telefono_Centro,Estado_Centro,FechaDeCreacion_Centro,FechaDeInactivacion_Centro)
VALUES ('Centro de Electricidad Electronica y Telecomunicaciones','Carrera 30 # 17b-25 Sur','5960050',1,'2018-04-29','2018-04-29')
INSERT INTO  centro_formacion(Nombre_Centro,Direccion_Centro,Telefono_Centro,Estado_Centro,FechaDeCreacion_Centro,FechaDeInactivacion_Centro)
VALUES ('Centro de Formación de Talento Humano en Salud','Carrera 6 # 45-42','3215911379',1,'2018-04-29','2018-04-29')
INSERT INTO  centro_formacion(Nombre_Centro,Direccion_Centro,Telefono_Centro,Estado_Centro,FechaDeCreacion_Centro,FechaDeInactivacion_Centro)
VALUES ('Centro de Gestión Administrativa','Avenida Caracas # 13-80 centro','5461500',1,'2018-04-29','2018-04-29')
INSERT INTO  centro_formacion(Nombre_Centro,Direccion_Centro,Telefono_Centro,Estado_Centro,FechaDeCreacion_Centro,FechaDeInactivacion_Centro)
VALUES ('Centro de Gestión Industrial','Calle 15 # 31-42 paloquemao','5925555',1,'2018-04-29','2018-04-29')
INSERT INTO  centro_formacion(Nombre_Centro,Direccion_Centro,Telefono_Centro,Estado_Centro,FechaDeCreacion_Centro,FechaDeInactivacion_Centro)
VALUES ('Centro de Manufacturas en textiles y Cuero','Carrera 30 # 17b-25 Sur','5960050',1,'2018-04-29','2018-04-29')
INSERT INTO  centro_formacion(Nombre_Centro,Direccion_Centro,Telefono_Centro,Estado_Centro,FechaDeCreacion_Centro,FechaDeInactivacion_Centro)
VALUES ('Centro de Servicios Financieros','Carrera 13 # 65-10 chapinero','5461600',1,'2018-04-29','2018-04-29')
INSERT INTO  centro_formacion(Nombre_Centro,Direccion_Centro,Telefono_Centro,Estado_Centro,FechaDeCreacion_Centro,FechaDeInactivacion_Centro)
VALUES ('Centro de Tecnologías de Transporte','Carrera 79 # 40a-51','3217746981',1,'2018-04-29','2018-04-29')
INSERT INTO  centro_formacion(Nombre_Centro,Direccion_Centro,Telefono_Centro,Estado_Centro,FechaDeCreacion_Centro,FechaDeInactivacion_Centro)
VALUES ('Centro Metalmecánico','Carrera 30 # 17b-25 Sur','5960050',1,'2018-04-29','2018-04-29')
INSERT INTO  centro_formacion(Nombre_Centro,Direccion_Centro,Telefono_Centro,Estado_Centro,FechaDeCreacion_Centro,FechaDeInactivacion_Centro)
VALUES ('Centro para la Industria de la Comunicación Gráfica','Calle 15 # 31-42','5960100',1,'2018-04-29','2018-04-29')
INSERT INTO  centro_formacion(Nombre_Centro,Direccion_Centro,Telefono_Centro,Estado_Centro,FechaDeCreacion_Centro,FechaDeInactivacion_Centro)
VALUES ('Centro Nacional de Hotelería, Turismo y Alimentos','Ak 30 # 15-53 paloquemao','5925555',1,'2018-04-29','2018-04-29')

select * from centro_formacion

INSERT INTO sede(Nombre_Sede,Direccion_Sede,Telefono_Sede,centro_formacion_ID_Centro,Estado_Sede,FechaDeCreacion_Sede,FechaDeInactivacion_Sede)
VALUES ('COMPLEJO SUR BOGOTÁ','Avenida 30 No 17 B Sur','5960050',2,1,'2018-04-29','2018-04-29')
INSERT INTO sede(Nombre_Sede,Direccion_Sede,Telefono_Sede,centro_formacion_ID_Centro,Estado_Sede,FechaDeCreacion_Sede,FechaDeInactivacion_Sede)
VALUES ('COMPLEJO PALOQUEMAO','Carrera 31 No. 14 - 20','5925555',1,1,'2018-04-29','2018-04-29')
INSERT INTO sede(Nombre_Sede,Direccion_Sede,Telefono_Sede,centro_formacion_ID_Centro,Estado_Sede,FechaDeCreacion_Sede,FechaDeInactivacion_Sede)
VALUES ('SUBSEDE - SUBA','Carrera 116 A No. 133 B - 33','8654210',3,1,'2018-04-29','2018-04-29')
INSERT INTO sede(Nombre_Sede,Direccion_Sede,Telefono_Sede,centro_formacion_ID_Centro,Estado_Sede,FechaDeCreacion_Sede,FechaDeInactivacion_Sede)
VALUES ('SUBSEDE USAQUÉN','Carrera 7 No. 153 A 05/07','6252255',4,1,'2018-04-29','2018-04-29')
INSERT INTO sede(Nombre_Sede,Direccion_Sede,Telefono_Sede,centro_formacion_ID_Centro,Estado_Sede,FechaDeCreacion_Sede,FechaDeInactivacion_Sede)
VALUES ('SUBSEDE - USME','Calle 91 Sur No. 01 B - 10 Este','3799882',7,1,'2018-04-29','2018-04-29')
INSERT INTO sede(Nombre_Sede,Direccion_Sede,Telefono_Sede,centro_formacion_ID_Centro,Estado_Sede,FechaDeCreacion_Sede,FechaDeInactivacion_Sede)
VALUES ('SENA INDUSTRIAL','CALLE 30 # 3E-164','8349027',2,1,'2018-04-29','2018-04-29')
INSERT INTO sede(Nombre_Sede,Direccion_Sede,Telefono_Sede,centro_formacion_ID_Centro,Estado_Sede,FechaDeCreacion_Sede,FechaDeInactivacion_Sede)
VALUES ('SUBSEDE ALAMOS','Carrera 89 No. 62 - 35','3780405',9,1,'2018-04-29','2018-04-29')
INSERT INTO sede(Nombre_Sede,Direccion_Sede,Telefono_Sede,centro_formacion_ID_Centro,Estado_Sede,FechaDeCreacion_Sede,FechaDeInactivacion_Sede)
VALUES ('SUBSEDE - SUBA','Carrera 116 A No. 133 B - 33','3481010',1,1,'2018-04-29','2018-04-29')
INSERT INTO sede(Nombre_Sede,Direccion_Sede,Telefono_Sede,centro_formacion_ID_Centro,Estado_Sede,FechaDeCreacion_Sede,FechaDeInactivacion_Sede)
VALUES ('SUBSEDE - FONTIBON','Calle 19 A No. 96 C 32','3576620',1,1,'2018-04-29','2018-04-29')
INSERT INTO sede(Nombre_Sede,Direccion_Sede,Telefono_Sede,centro_formacion_ID_Centro,Estado_Sede,FechaDeCreacion_Sede,FechaDeInactivacion_Sede)
VALUES ('SUBSEDE - UBATÉ','CALLE 3 No 4-59 CASA DE LA CULTURA','3565109',2,1,'2018-04-29','2018-04-29')

Select * from sede

INSERT INTO ambiente_formacion(Num_Ambiente,sede_ID_Sede,Estado_Ambiente,FechaDeCreacion_AmbienteFormacion,FechaDeInactivacion_AmbienteFormacion)
VALUES (105,4,1,'2018-04-29','2018-04-29')
INSERT INTO ambiente_formacion(Num_Ambiente,sede_ID_Sede,Estado_Ambiente,FechaDeCreacion_AmbienteFormacion,FechaDeInactivacion_AmbienteFormacion)
VALUES (106,2,1,'2018-04-29','2018-04-29')
INSERT INTO ambiente_formacion(Num_Ambiente,sede_ID_Sede,Estado_Ambiente,FechaDeCreacion_AmbienteFormacion,FechaDeInactivacion_AmbienteFormacion)
VALUES (107,1,1,'2018-04-29','2018-04-29')
INSERT INTO ambiente_formacion(Num_Ambiente,sede_ID_Sede,Estado_Ambiente,FechaDeCreacion_AmbienteFormacion,FechaDeInactivacion_AmbienteFormacion)
VALUES (108,9,1,'2018-04-29','2018-04-29')
INSERT INTO ambiente_formacion(Num_Ambiente,sede_ID_Sede,Estado_Ambiente,FechaDeCreacion_AmbienteFormacion,FechaDeInactivacion_AmbienteFormacion)
VALUES (201,7,1,'2018-04-29','2018-04-29')
INSERT INTO ambiente_formacion(Num_Ambiente,sede_ID_Sede,Estado_Ambiente,FechaDeCreacion_AmbienteFormacion,FechaDeInactivacion_AmbienteFormacion)
VALUES (202,2,1,'2018-04-29','2018-04-29')
INSERT INTO ambiente_formacion(Num_Ambiente,sede_ID_Sede,Estado_Ambiente,FechaDeCreacion_AmbienteFormacion,FechaDeInactivacion_AmbienteFormacion)
VALUES (203,1,1,'2018-04-29','2018-04-29')
INSERT INTO ambiente_formacion(Num_Ambiente,sede_ID_Sede,Estado_Ambiente,FechaDeCreacion_AmbienteFormacion,FechaDeInactivacion_AmbienteFormacion)
VALUES (204,8,1,'2018-04-29','2018-04-29')
INSERT INTO ambiente_formacion(Num_Ambiente,sede_ID_Sede,Estado_Ambiente,FechaDeCreacion_AmbienteFormacion,FechaDeInactivacion_AmbienteFormacion)
VALUES (301,5,1,'2018-04-29','2018-04-29')
INSERT INTO ambiente_formacion(Num_Ambiente,sede_ID_Sede,Estado_Ambiente,FechaDeCreacion_AmbienteFormacion,FechaDeInactivacion_AmbienteFormacion)
VALUES (302,6,1,'2018-04-29','2018-04-29')

select * from ambiente_formacion

INSERT INTO programa_formacion(Nombre_ProgramaFormacion,Estado_ProgramaFormacion,FechaDeCreacion_Programa,FechaDeInactivacion_Programa)
VALUES ('Mantenimiento de Motocicletas',1,'2018-04-29','2018-04-29')
INSERT INTO programa_formacion(Nombre_ProgramaFormacion,Estado_ProgramaFormacion,FechaDeCreacion_Programa,FechaDeInactivacion_Programa)
VALUES ('Apoyo Administrativo en Salud',1,'2018-04-29','2018-04-29')
INSERT INTO programa_formacion(Nombre_ProgramaFormacion,Estado_ProgramaFormacion,FechaDeCreacion_Programa,FechaDeInactivacion_Programa)
VALUES ('Asistencia Administrativa',1,'2018-04-29','2018-04-29')
INSERT INTO programa_formacion(Nombre_ProgramaFormacion,Estado_ProgramaFormacion,FechaDeCreacion_Programa,FechaDeInactivacion_Programa)
VALUES ('Asistencia en Organización de Archivos',1,'2018-04-29','2018-04-29')
INSERT INTO programa_formacion(Nombre_ProgramaFormacion,Estado_ProgramaFormacion,FechaDeCreacion_Programa,FechaDeInactivacion_Programa)
VALUES ('Inspección y Ensayos con Procesos no Destructivos',1,'2018-04-29','2018-04-29')
INSERT INTO programa_formacion(Nombre_ProgramaFormacion,Estado_ProgramaFormacion,FechaDeCreacion_Programa,FechaDeInactivacion_Programa)
VALUES ('Instalación de Infraestructura para Redes Móviles',1,'2018-04-29','2018-04-29')
INSERT INTO programa_formacion(Nombre_ProgramaFormacion,Estado_ProgramaFormacion,FechaDeCreacion_Programa,FechaDeInactivacion_Programa)
VALUES ('Instalación de Redes de Computadores',1,'2018-04-29','2018-04-29')
INSERT INTO programa_formacion(Nombre_ProgramaFormacion,Estado_ProgramaFormacion,FechaDeCreacion_Programa,FechaDeInactivacion_Programa)
VALUES ('Instalaciones de Redes Híbridas de Fibra Optica y Coaxial',1,'2018-04-29','2018-04-29')
INSERT INTO programa_formacion(Nombre_ProgramaFormacion,Estado_ProgramaFormacion,FechaDeCreacion_Programa,FechaDeInactivacion_Programa)
VALUES ('Diseño e Integración de Multimedia',1,'2018-04-29','2018-04-29')
INSERT INTO programa_formacion(Nombre_ProgramaFormacion,Estado_ProgramaFormacion,FechaDeCreacion_Programa,FechaDeInactivacion_Programa)
VALUES ('Mantenimiento de Equipos Electrónicos de Consumo Masivo en A',1,'2018-04-29','2018-04-29')

select * from programa_formacion

INSERT INTO tipo_de_documento(Nombre_TipoDeDocumento,Estado_TipoDeDocumento,FechaDeCreacion_TipoDeDocumento,FechaDeInactivacion_TipoDeDocumento)
VALUES ('Cedula de Ciudadania',1,'2018-04-29','2018-04-29')
INSERT INTO tipo_de_documento(Nombre_TipoDeDocumento,Estado_TipoDeDocumento,FechaDeCreacion_TipoDeDocumento,FechaDeInactivacion_TipoDeDocumento)
VALUES ('Tarjeta de Identidad',1,'2018-04-29','2018-04-29')
INSERT INTO tipo_de_documento(Nombre_TipoDeDocumento,Estado_TipoDeDocumento,FechaDeCreacion_TipoDeDocumento,FechaDeInactivacion_TipoDeDocumento)
VALUES ('Cedula de Extranjería',1,'2018-04-29','2018-04-29')

select * from tipo_de_documento

INSERT INTO perfil(Tipo_De_Perfil,Estado_Perfil,FechaDeCreacion_Perfil,FechaDeInactivacion_Perfil)
VALUES ('Administrador',1,'2018-04-29','2018-04-29')
INSERT INTO perfil(Tipo_De_Perfil,Estado_Perfil,FechaDeCreacion_Perfil,FechaDeInactivacion_Perfil)
VALUES ('Usuario',1,'2018-04-29','2018-04-29')

select * from perfil

INSERT INTO rol(Tipo_Rol,Estado_Rol,FechaDeCreacion_Rol,FechaDeInactivacion_Rol)
VALUES ('Psicologo',1,'2018-05-05','2018-05-05')
INSERT INTO rol(Tipo_Rol,Estado_Rol,FechaDeCreacion_Rol,FechaDeInactivacion_Rol)
VALUES ('Coordinador',1,'2018-05-05','2018-05-05')
INSERT INTO rol(Tipo_Rol,Estado_Rol,FechaDeCreacion_Rol,FechaDeInactivacion_Rol)
VALUES ('Instructor',1,'2018-05-05','2018-05-05') 

select * from rol


INSERT INTO ficha(programa_formacion_ID_Programa,Num_Ficha,Grupo_Ficha,Jornada_Ficha,Trimestre_Ficha,ambiente_formacion_ID_Ambiente,Estado_Ficha,FechaDeCreacion_Ficha,FechaDeInactivacion_Ficha)
VALUES (8,'1193334',1,'Diurna',1,7,1,'2018-04-29','2018-04-29')
INSERT INTO ficha(programa_formacion_ID_Programa,Num_Ficha,Grupo_Ficha,Jornada_Ficha,Trimestre_Ficha,ambiente_formacion_ID_Ambiente,Estado_Ficha,FechaDeCreacion_Ficha,FechaDeInactivacion_Ficha)
VALUES (1,'1193335',2,'Nocturna',2,2,1,'2018-04-29','2018-04-29')
INSERT INTO ficha(programa_formacion_ID_Programa,Num_Ficha,Grupo_Ficha,Jornada_Ficha,Trimestre_Ficha,ambiente_formacion_ID_Ambiente,Estado_Ficha,FechaDeCreacion_Ficha,FechaDeInactivacion_Ficha)
VALUES (4,'1193336',3,'Madrugada',3,4,1,'2018-04-29','2018-04-29')
INSERT INTO ficha(programa_formacion_ID_Programa,Num_Ficha,Grupo_Ficha,Jornada_Ficha,Trimestre_Ficha,ambiente_formacion_ID_Ambiente,Estado_Ficha,FechaDeCreacion_Ficha,FechaDeInactivacion_Ficha)
VALUES (7,'1193337',4,'Fines de Semana',4,3,1,'2018-04-29','2018-04-29')
INSERT INTO ficha(programa_formacion_ID_Programa,Num_Ficha,Grupo_Ficha,Jornada_Ficha,Trimestre_Ficha,ambiente_formacion_ID_Ambiente,Estado_Ficha,FechaDeCreacion_Ficha,FechaDeInactivacion_Ficha)
VALUES (9,'1193338',1,'Nocturna',5,10,1,'2018-04-29','2018-04-29')
INSERT INTO ficha(programa_formacion_ID_Programa,Num_Ficha,Grupo_Ficha,Jornada_Ficha,Trimestre_Ficha,ambiente_formacion_ID_Ambiente,Estado_Ficha,FechaDeCreacion_Ficha,FechaDeInactivacion_Ficha)
VALUES (10,'1184442',3,'Diurna',6,8,1,'2018-04-29','2018-04-29')
INSERT INTO ficha(programa_formacion_ID_Programa,Num_Ficha,Grupo_Ficha,Jornada_Ficha,Trimestre_Ficha,ambiente_formacion_ID_Ambiente,Estado_Ficha,FechaDeCreacion_Ficha,FechaDeInactivacion_Ficha)
VALUES (3,'1184443',2,'Fines de Semana',7,6,1,'2018-04-29','2018-04-29')
INSERT INTO ficha(programa_formacion_ID_Programa,Num_Ficha,Grupo_Ficha,Jornada_Ficha,Trimestre_Ficha,ambiente_formacion_ID_Ambiente,Estado_Ficha,FechaDeCreacion_Ficha,FechaDeInactivacion_Ficha)
VALUES (6,'1184444',1,'Diurna',8,5,1,'2018-04-29','2018-04-29')
INSERT INTO ficha(programa_formacion_ID_Programa,Num_Ficha,Grupo_Ficha,Jornada_Ficha,Trimestre_Ficha,ambiente_formacion_ID_Ambiente,Estado_Ficha,FechaDeCreacion_Ficha,FechaDeInactivacion_Ficha)
VALUES (1,'1184445',4,'Nocturna',4,2,1,'2018-04-29','2018-04-29')
INSERT INTO ficha(programa_formacion_ID_Programa,Num_Ficha,Grupo_Ficha,Jornada_Ficha,Trimestre_Ficha,ambiente_formacion_ID_Ambiente,Estado_Ficha,FechaDeCreacion_Ficha,FechaDeInactivacion_Ficha)
VALUES (2,'1184446',2,'Diurna',5,1,1,'2018-04-29','2018-04-29')

select * from ficha
 
INSERT INTO aprendiz(tipo_de_documento_ID_TipoDeDocumento,Documento_Aprendiz,PrimerNombre_Aprendiz,SegundoNombre_Aprendiz,PrimerApellido_Aprendiz,SegundoApellido_Aprendiz,Correo_Aprendiz,Telefono_Aprendiz,ficha_ID_Ficha,Estado_Aprendiz,FechaDeCreacion_Aprendiz,FechaDeInactivacion_Aprendiz)
VALUES (1,80807041,'Luis','Antonio','Forero','Torres','laforero1@misena.edu.co','3187809716',1,1,'2018-04-29','2018-04-29')
INSERT INTO aprendiz(tipo_de_documento_ID_TipoDeDocumento,Documento_Aprendiz,PrimerNombre_Aprendiz,SegundoNombre_Aprendiz,PrimerApellido_Aprendiz,SegundoApellido_Aprendiz,Correo_Aprendiz,Telefono_Aprendiz,ficha_ID_Ficha,Estado_Aprendiz,FechaDeCreacion_Aprendiz,FechaDeInactivacion_Aprendiz)
VALUES (2,104001261,'Alma','Marcela','Silva','','almarsilva@misena.edu.co','3112843650',2,1,'2018-04-29','2018-04-29')
INSERT INTO aprendiz(tipo_de_documento_ID_TipoDeDocumento,Documento_Aprendiz,PrimerNombre_Aprendiz,SegundoNombre_Aprendiz,PrimerApellido_Aprendiz,SegundoApellido_Aprendiz,Correo_Aprendiz,Telefono_Aprendiz,ficha_ID_Ficha,Estado_Aprendiz,FechaDeCreacion_Aprendiz,FechaDeInactivacion_Aprendiz)
VALUES (3,79966296,'Robert','Smith','Duque','Morales','rsmithd7@misena.edu.co','3014002169',3,1,'2018-04-29','2018-04-29')
INSERT INTO aprendiz(tipo_de_documento_ID_TipoDeDocumento,Documento_Aprendiz,PrimerNombre_Aprendiz,SegundoNombre_Aprendiz,PrimerApellido_Aprendiz,SegundoApellido_Aprendiz,Correo_Aprendiz,Telefono_Aprendiz,ficha_ID_Ficha,Estado_Aprendiz,FechaDeCreacion_Aprendiz,FechaDeInactivacion_Aprendiz)
VALUES (3,52809251,'Johanna','Milena','Jamaica','Rojas','jmjamaica@misena.edu.co','3214049197',4,1,'2018-04-29','2018-04-29')
INSERT INTO aprendiz(tipo_de_documento_ID_TipoDeDocumento,Documento_Aprendiz,PrimerNombre_Aprendiz,SegundoNombre_Aprendiz,PrimerApellido_Aprendiz,SegundoApellido_Aprendiz,Correo_Aprendiz,Telefono_Aprendiz,ficha_ID_Ficha,Estado_Aprendiz,FechaDeCreacion_Aprendiz,FechaDeInactivacion_Aprendiz)
VALUES (2,1019120468,'Nataly','Stefania','Medina','Poveda','stefa142396@gmail.com','3134595081',2,1,'2018-04-29','2018-04-29')
INSERT INTO aprendiz(tipo_de_documento_ID_TipoDeDocumento,Documento_Aprendiz,PrimerNombre_Aprendiz,SegundoNombre_Aprendiz,PrimerApellido_Aprendiz,SegundoApellido_Aprendiz,Correo_Aprendiz,Telefono_Aprendiz,ficha_ID_Ficha,Estado_Aprendiz,FechaDeCreacion_Aprendiz,FechaDeInactivacion_Aprendiz)
VALUES (1,1020800497,'Tatiana','','Paez','','ltpaez7@misena.edu.co','3224385002',1,1,'2018-04-29','2018-04-29')
INSERT INTO aprendiz(tipo_de_documento_ID_TipoDeDocumento,Documento_Aprendiz,PrimerNombre_Aprendiz,SegundoNombre_Aprendiz,PrimerApellido_Aprendiz,SegundoApellido_Aprendiz,Correo_Aprendiz,Telefono_Aprendiz,ficha_ID_Ficha,Estado_Aprendiz,FechaDeCreacion_Aprendiz,FechaDeInactivacion_Aprendiz)
VALUES (2,80740814,'Harold','Andres','Pietro','Fernandez','haprieto41@misena.edu.co','3212141572',3,1,'2018-04-29','2018-04-29')
INSERT INTO aprendiz(tipo_de_documento_ID_TipoDeDocumento,Documento_Aprendiz,PrimerNombre_Aprendiz,SegundoNombre_Aprendiz,PrimerApellido_Aprendiz,SegundoApellido_Aprendiz,Correo_Aprendiz,Telefono_Aprendiz,ficha_ID_Ficha,Estado_Aprendiz,FechaDeCreacion_Aprendiz,FechaDeInactivacion_Aprendiz)
VALUES (1,1073160640,'Orlando','','Echeverry','Velez','oecheverry0@misena.edu.co','3143326357',1,1,'2018-04-29','2018-04-29')
INSERT INTO aprendiz(tipo_de_documento_ID_TipoDeDocumento,Documento_Aprendiz,PrimerNombre_Aprendiz,SegundoNombre_Aprendiz,PrimerApellido_Aprendiz,SegundoApellido_Aprendiz,Correo_Aprendiz,Telefono_Aprendiz,ficha_ID_Ficha,Estado_Aprendiz,FechaDeCreacion_Aprendiz,FechaDeInactivacion_Aprendiz)
VALUES (1,1018502967,'Deivis','Andres','Naranjo','Perez','danaranjo06@misena.edu.co','3103009547',2,1,'2018-04-29','2018-04-29')
INSERT INTO	aprendiz(tipo_de_documento_ID_TipoDeDocumento,Documento_Aprendiz,PrimerNombre_Aprendiz,SegundoNombre_Aprendiz,PrimerApellido_Aprendiz,SegundoApellido_Aprendiz,Correo_Aprendiz,Telefono_Aprendiz,ficha_ID_Ficha,Estado_Aprendiz,FechaDeCreacion_Aprendiz,FechaDeInactivacion_Aprendiz)
VALUES (2,1457824552,'David','Stiwen','Rugeles','','dsrugeles5@misena.edu.co','3157254152',3,1,'2018-04-29','2018-04-29')
INSERT INTO aprendiz(tipo_de_documento_ID_TipoDeDocumento,Documento_Aprendiz,PrimerNombre_Aprendiz,SegundoNombre_Aprendiz,PrimerApellido_Aprendiz,SegundoApellido_Aprendiz,Correo_Aprendiz,Telefono_Aprendiz,ficha_ID_Ficha,Estado_Aprendiz,FechaDeCreacion_Aprendiz,FechaDeInactivacion_Aprendiz)
VALUES (1,1024587455,'Deisy','Johanna','Forero','','djforero08@misena.edu.co','3215487985',4,1,'2018-04-29','2018-04-29')

select * from aprendiz

INSERT INTO cliente(tipo_de_documento_ID_TipoDeDocumento,Documento_Cliente,PrimerNombre_Cliente,SegundoNombre_Cliente,PrimerApellido_Cliente,SegundoApellido_Cliente,perfil_ID_Perfil,Correo_Cliente,Telefono_Cliente,Estado_Cliente,FechaDeCreacion_Cliente,FechaDeInactivacion_Cliente)
VALUES (1,1578425455,'Carlos','Julio','Camargo','Cuellar',2,'carlosc12@hotmail.com','3157854254',1,'2018-05-04','2018-05-04')
INSERT INTO cliente(tipo_de_documento_ID_TipoDeDocumento,Documento_Cliente,PrimerNombre_Cliente,SegundoNombre_Cliente,PrimerApellido_Cliente,SegundoApellido_Cliente,perfil_ID_Perfil,Correo_Cliente,Telefono_Cliente,Estado_Cliente,FechaDeCreacion_Cliente,FechaDeInactivacion_Cliente)
VALUES (2,54875425,'Luisa','Maria','Pulido','Garzon',1,'lmpulido548@outlook.com','3115489754',1,'2018-05-04','2018-05-04')
INSERT INTO cliente(tipo_de_documento_ID_TipoDeDocumento,Documento_Cliente,PrimerNombre_Cliente,SegundoNombre_Cliente,PrimerApellido_Cliente,SegundoApellido_Cliente,perfil_ID_Perfil,Correo_Cliente,Telefono_Cliente,Estado_Cliente,FechaDeCreacion_Cliente,FechaDeInactivacion_Cliente)
VALUES (3,768745122,'Ivan','David','Mora','Morales',2,'ivanmm@hotmail.com','3178897897',1,'2018-05-04','2018-05-04')
INSERT INTO cliente(tipo_de_documento_ID_TipoDeDocumento,Documento_Cliente,PrimerNombre_Cliente,SegundoNombre_Cliente,PrimerApellido_Cliente,SegundoApellido_Cliente,perfil_ID_Perfil,Correo_Cliente,Telefono_Cliente,Estado_Cliente,FechaDeCreacion_Cliente,FechaDeInactivacion_Cliente)
VALUES (1,15598745,'Jeam','Carolina','Rodriguez','Roa',1,'jrodriguez@gmail.com','3225487910',1,'2018-05-04','2018-05-04')
INSERT INTO cliente(tipo_de_documento_ID_TipoDeDocumento,Documento_Cliente,PrimerNombre_Cliente,SegundoNombre_Cliente,PrimerApellido_Cliente,SegundoApellido_Cliente,perfil_ID_Perfil,Correo_Cliente,Telefono_Cliente,Estado_Cliente,FechaDeCreacion_Cliente,FechaDeInactivacion_Cliente)
VALUES (1,45785425,'Lina','','Valderrama','Tovar',2,'ltovar2@hotmail.com','3001548750',1,'2018-05-04','2018-05-04')
INSERT INTO cliente(tipo_de_documento_ID_TipoDeDocumento,Documento_Cliente,PrimerNombre_Cliente,SegundoNombre_Cliente,PrimerApellido_Cliente,SegundoApellido_Cliente,perfil_ID_Perfil,Correo_Cliente,Telefono_Cliente,Estado_Cliente,FechaDeCreacion_Cliente,FechaDeInactivacion_Cliente)
VALUES (3,8954787542,'Diana','Marcela','Trujillo','Perdomo',2,'Dmarcela89@gmail.com','3012548790',1,'2018-05-04','2018-05-04')
INSERT INTO cliente(tipo_de_documento_ID_TipoDeDocumento,Documento_Cliente,PrimerNombre_Cliente,SegundoNombre_Cliente,PrimerApellido_Cliente,SegundoApellido_Cliente,perfil_ID_Perfil,Correo_Cliente,Telefono_Cliente,Estado_Cliente,FechaDeCreacion_Cliente,FechaDeInactivacion_Cliente)
VALUES (2,187548755,'Luis','Felipe','Rojas','Amezquita',2,'luisf61@hotmail.com','3502124488',1,'2018-05-04','2018-05-04')

select * from cliente

INSERT INTO usuario(cliente_Documento_Cliente,Password_Hash,Estado_Usuario,FechaDeCreacion_Usuario,FechaDeInactivacion_Usuario)
VALUES (1578425455,'5454548',1,'2018-05-04','2018-05-04')
INSERT INTO usuario(cliente_Documento_Cliente,Password_Hash,Estado_Usuario,FechaDeCreacion_Usuario,FechaDeInactivacion_Usuario)
VALUES (54875425,'fgsdf4',1,'2018-05-04','2018-05-04')
INSERT INTO usuario(cliente_Documento_Cliente,Password_Hash,Estado_Usuario,FechaDeCreacion_Usuario,FechaDeInactivacion_Usuario)
VALUES (768745122,'sd548',1,'2018-05-04','2018-05-04')
INSERT INTO usuario(cliente_Documento_Cliente,Password_Hash,Estado_Usuario,FechaDeCreacion_Usuario,FechaDeInactivacion_Usuario)
VALUES (15598745, '5464',1,'2018-05-04','2018-05-04')
INSERT INTO usuario(cliente_Documento_Cliente,Password_Hash,Estado_Usuario,FechaDeCreacion_Usuario,FechaDeInactivacion_Usuario)
VALUES (45785425,'lk89547',1,'2018-05-04','2018-05-04')
INSERT INTO usuario(cliente_Documento_Cliente,Password_Hash,Estado_Usuario,FechaDeCreacion_Usuario,FechaDeInactivacion_Usuario)
VALUES (8954787542,'587loi5',1,'2018-05-04','2018-05-04')
INSERT INTO usuario(cliente_Documento_Cliente,Password_Hash,Estado_Usuario,FechaDeCreacion_Usuario,FechaDeInactivacion_Usuario)
VALUES (187548755,'per4587j',1,'2018-05-04','2018-05-04')

select * from  usuario

INSERT INTO excusa(aprendiz_Documento_Aprendiz,FechaInicio_Excusa,FechaFin_Excusa)
VALUES (80807041,'2018-05-03','2018-06-01')
INSERT INTO excusa(aprendiz_Documento_Aprendiz,FechaInicio_Excusa,FechaFin_Excusa)
VALUES (52809251,'2018-03-04','2018-04-02')
INSERT INTO excusa(aprendiz_Documento_Aprendiz,FechaInicio_Excusa,FechaFin_Excusa)
VALUES (1073160640,'2018-03-05','2018-04-03')
INSERT INTO excusa(aprendiz_Documento_Aprendiz,FechaInicio_Excusa,FechaFin_Excusa)
VALUES (80740814,'2018-03-06','2018-04-04')
INSERT INTO excusa(aprendiz_Documento_Aprendiz,FechaInicio_Excusa,FechaFin_Excusa)
VALUES (52809251,'2018-03-07','2018-04-05')
INSERT INTO excusa(aprendiz_Documento_Aprendiz,FechaInicio_Excusa,FechaFin_Excusa)
VALUES (1018502967,'2018-03-08','2018-04-06')
INSERT INTO excusa(aprendiz_Documento_Aprendiz,FechaInicio_Excusa,FechaFin_Excusa)
VALUES (1024587455,'2018-03-09','2018-04-07')

INSERT INTO asistencia(aprendiz_Documento_Aprendiz,Asistencia,Fecha_Asistencia)
VALUES (1024587455,1,'2018-05-03')
INSERT INTO asistencia(aprendiz_Documento_Aprendiz,Asistencia,Fecha_Asistencia)
VALUES (1018502967,0,'2018-05-04')
INSERT INTO asistencia(aprendiz_Documento_Aprendiz,Asistencia,Fecha_Asistencia)
VALUES (52809251,1,'2018-05-07')
INSERT INTO asistencia(aprendiz_Documento_Aprendiz,Asistencia,Fecha_Asistencia)
VALUES (80740814,1,'2018-05-08')
INSERT INTO asistencia(aprendiz_Documento_Aprendiz,Asistencia,Fecha_Asistencia)
VALUES (79966296,1,'2018-05-09')
INSERT INTO asistencia(aprendiz_Documento_Aprendiz,Asistencia,Fecha_Asistencia)
VALUES (1073160640,0,'2018-05-10')
INSERT INTO asistencia(aprendiz_Documento_Aprendiz,Asistencia,Fecha_Asistencia)
VALUES (1024587455,0,'2018-05-11')
INSERT INTO asistencia(aprendiz_Documento_Aprendiz,Asistencia,Fecha_Asistencia)
VALUES (1019120468,1,'2018-05-14')
INSERT INTO asistencia(ID_Asistencia,aprendiz_Documento_Aprendiz,Asistencia,Fecha_Asistencia)
VALUES (9,1024587455,1,'2018-05-15') 

INSERT INTO formato_ftp(Nombre_Formato,Url_Ftp,asistencia_ID_Asistencia,Estado_Formato)
VALUES ('Notificación de aviso','https://www.senasistencia.edu.co/formatos/compromiso.doc',1,1)
INSERT INTO formato_ftp(Nombre_Formato,Url_Ftp,asistencia_ID_Asistencia,Estado_Formato)
VALUES ('Notificación de advertencia','',2,1)
INSERT INTO formato_ftp(Nombre_Formato,Url_Ftp,asistencia_ID_Asistencia,Estado_Formato)
VALUES ('Notificación de compromiso','https://www.senasistencia.edu.co/formatos/compromiso.doc',2,1)
INSERT INTO formato_ftp(Nombre_Formato,Url_Ftp,asistencia_ID_Asistencia,Estado_Formato)
VALUES ('Notificación de inhabilidad','https://www.senasistencia.edu.co/formatos/compromiso.doc',5,1)
INSERT INTO formato_ftp(Nombre_Formato,Url_Ftp,asistencia_ID_Asistencia,Estado_Formato)
VALUES ('Notificación de deserción','',3,1)

INSERT INTO notificacion(Mensaje_Notificacion,formato_ftp_ID_Formato,Fecha_Notificacion,cliente_Documento_Cliente,aprendiz_Documento_Aprendiz)
VALUES ('Notificación por inasistencia sin previo aviso; por tanto se espera que el aprendiz facilite formato de excusa lo mas pronto posible. NOTA: la tercer inasistencia sera causal de inhabilidad en el sistema; de no presentarse ninguna excusa el aprendiz sera remitido a comité con formato de deserción del programa de formación.',1,'2018-05-03',1578425455,1073160640)





INSERT INTO password_token(usuario_ID_Usuario,Token_Hash)
VALUES (1,'ad5f4')
INSERT INTO password_token(usuario_ID_Usuario,Token_Hash)
VALUES (6,'ls8f5')
INSERT INTO password_token(usuario_ID_Usuario,Token_Hash)
VALUES (3,'6d84h')
INSERT INTO password_token(usuario_ID_Usuario,Token_Hash)
VALUES (2,'cvb54')
INSERT INTO password_token(usuario_ID_Usuario,Token_Hash)
VALUES (5,'be3f8')
INSERT INTO password_token(usuario_ID_Usuario,Token_Hash)
VALUES (7,'5f4po')
INSERT INTO password_token(usuario_ID_Usuario,Token_Hash)
VALUES (4,'mk58l')
