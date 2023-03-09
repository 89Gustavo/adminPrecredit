USE administradorPreCREDITPRO

GO
CREATE procedure [dbo].[spr_getListarPersonas]

as
begin try
	declare @METODO varchar(16)
	declare @SP varchar(64)
	set @METODO = 'SELECT'
	set @SP = 'getListadoPersona'


	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>0</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE/><STACK_TRACE/></MSGPRE>' as xmlRespuesta


		select codigoPersona,
		concat(primerNombre, ' ', segundoNombre, ' ', tercerNombre,' ', primerApellido, ' ', segundoApellido, ' ', apellidoCasada ) as nombreCompleto,
		fechaNacimiento,
		case genero
			when 1 then 'Masculino'
			when 2 then 'Femenino'
		end genero,
		dpi,
		correo,
		estatus

	 from persona

end try
begin catch
	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>1</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE><![CDATA['+ ERROR_MESSAGE() +']]></MENSAJE><STACK_TRACE><![CDATA[' + cast(ERROR_NUMBER() as nvarchar(50)) + ' del error ocurrido en ' + isnull(ERROR_PROCEDURE(),'') + ' en la línea ' + cast(ERROR_LINE() as nvarchar(50)) + ']]></STACK_TRACE></MSGPRE>' as xmlRespuesta
end catch