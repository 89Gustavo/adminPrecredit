use administradorPreCREDITPRO

create table persona(
	codigoPersona int identity(1,1),
	primerNombre nvarchar(64),
	segundoNombre nvarchar(64),
	tercerNombre nvarchar(64),
	primerApellido nvarchar(64),
	segundoApellido nvarchar(64),
	apellidoCasada nvarchar(64),
	fechaNacimiento date,
	genero int,
	dpi nvarchar(16),
	correo nvarchar(64),
	estatus int,
	usuarioCrea nvarchar(64),
	fechaCrea datetime,
	usuarioModifica nvarchar(64),
	fechaModifica datetime,
	CONSTRAINT FK_persona PRIMARY KEY (codigoPersona)
)