USE administradorPreCREDITPRO
GO
/****** Object:  StoredProcedure [dbo].[spr_insertUpdateRol]    Script Date: 09/03/2023 10:35:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[spr_insertUpdateRol]
	@codigoRol int,
	@nombreRol nvarchar(64),
	@desecripcion nvarchar(64),
	@USUARIO_BITACORA nvarchar(64)
	
as
begin try
	declare @METODO varchar(16)
	declare @SP varchar(64)
	set @METODO = 'SELECT'
	set @SP = 'getListadoPersona'


	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>0</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE/><STACK_TRACE/></MSGPRE>' as xmlRespuesta

	if(@codigoRol = 0)
		begin
			insert into rol(codigoRol, nombreRol,descripcion, estatus, usuarioCrea, fechaCrea)
				        values(@codigoRol, @nombreRol, @desecripcion,1, @USUARIO_BITACORA, GETDATE()) 


		end
	else
		begin
			UPDATE rol set
				nombreRol = @nombreRol,
				descripcion = @desecripcion,
				usuarioModifica = @USUARIO_BITACORA,
				fechaModifica = GETDATE()
				where codigoRol = @codigoRol
				
		end

end try
begin catch
	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>1</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE><![CDATA['+ ERROR_MESSAGE() +']]></MENSAJE><STACK_TRACE><![CDATA[' + cast(ERROR_NUMBER() as nvarchar(50)) + ' del error ocurrido en ' + isnull(ERROR_PROCEDURE(),'') + ' en la línea ' + cast(ERROR_LINE() as nvarchar(50)) + ']]></STACK_TRACE></MSGPRE>' as xmlRespuesta
end catch