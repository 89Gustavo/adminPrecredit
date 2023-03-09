USE administradorPreCREDITPRO
GO
/****** Object:  StoredProcedure [dbo].[spr_getListarUsuarios]    Script Date: 09/03/2023 9:55:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[spr_getListarUsuarios]

as
begin try
	declare @METODO varchar(16)
	declare @SP varchar(64)
	set @METODO = 'SELECT'
	set @SP = 'spr_getListarUsuarios'
	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>0</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE/><STACK_TRACE/></MSGPRE>' as xmlRespuesta

	select a.codigoUsuario, a.codigoPersona, concat(primerNombre, ' ', segundoNombre, ' ', tercerNombre,' ', apellidoCasada) as nombreCompleto, c.codigoRol, nombreRol from usuario a
	inner join persona b on a.codigoPersona = b.codigoPersona
	inner join rol	c on a.codigoRol = c.codigoRol
	where a.estatus = 1

end try
begin catch
	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>1</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE><![CDATA['+ ERROR_MESSAGE() +']]></MENSAJE><STACK_TRACE><![CDATA[' + cast(ERROR_NUMBER() as nvarchar(50)) + ' del error ocurrido en ' + isnull(ERROR_PROCEDURE(),'') + ' en la línea ' + cast(ERROR_LINE() as nvarchar(50)) + ']]></STACK_TRACE></MSGPRE>' as xmlRespuesta
end catch