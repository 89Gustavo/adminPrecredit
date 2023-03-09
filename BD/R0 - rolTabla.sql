use administradorPreCREDITPRO

create table rol(
	codigoRol int identity(1,1),
	nombreRol nvarchar(64),
	descripcion nvarchar(512),
	estatus int,
	usuarioCrea nvarchar(64),
	fechaCrea datetime,
	usuarioModifica nvarchar(64),
	fechaModifica datetime,
	CONSTRAINT FK_rol PRIMARY KEY (codigoRol)
)
