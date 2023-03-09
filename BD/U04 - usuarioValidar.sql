USE administradorPreCREDITPRO
GO
/****** Object:  StoredProcedure [dbo].[spr_validarUsuario]    Script Date: 09/03/2023 11:28:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[spr_validarUsuario]
	@codigoUsuario int,
	@codigoPersona int,
	@codigoRol int,
	@nombreUsuario nvarchar(64),
	@USUARIO_BITACORA nvarchar(64)
	
as
begin try
	declare @METODO varchar(16)
	declare @SP varchar(64)
	set @METODO = 'VALIDAR'
	set @SP = 'spr_validarUsuario'


	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>0</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE/><STACK_TRACE/></MSGPRE>' as xmlRespuesta
	
--SELECT * FROM usuario
	if(@codigoUsuario = 0)
		begin
			insert into usuario(codigoPersona, codigoRol, nombreUsuario, estatus, usuarioCrea, fechaCrea)
				        values(@codigoPersona, @codigoRol, @nombreUsuario,  1, @USUARIO_BITACORA, GETDATE()) 


		end
	else
		begin
			UPDATE usuario set
				nombreUsuario = @nombreUsuario,
				codigoRol = @codigoRol,
				usuarioModifica = @USUARIO_BITACORA,
				fechaModifica = GETDATE()
				where codigoUsuario =  @codigoUsuario
				
		end

end try
begin catch
	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>1</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE><![CDATA['+ ERROR_MESSAGE() +']]></MENSAJE><STACK_TRACE><![CDATA[' + cast(ERROR_NUMBER() as nvarchar(50)) + ' del error ocurrido en ' + isnull(ERROR_PROCEDURE(),'') + ' en la línea ' + cast(ERROR_LINE() as nvarchar(50)) + ']]></STACK_TRACE></MSGPRE>' as xmlRespuesta
end catch