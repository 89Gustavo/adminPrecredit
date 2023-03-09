use administradorPreCREDITPRO

create table usuario(
	codigoUsuario int identity(1,1),
	codigoPersona int,
	codigoRol int,
	nombreUsuario nvarchar(64),
	contrasenia nvarchar(64),
	estatus int,
	usuarioCrea nvarchar(64),
	fechaCrea datetime,
	usuarioModifica nvarchar(64),
	fechaModifica datetime,
	CONSTRAINT FK_usuario PRIMARY KEY (codigoUsuario),
	CONSTRAINT PK_usuario_persona FOREIGN KEY(codigoPersona) references persona(codigoPersona),
	CONSTRAINT PK_usuario_rol FOREIGN KEY(codigoRol) references rol(codigoRol)
)
