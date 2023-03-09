USE administradorPreCREDITPRO
GO
/****** Object:  StoredProcedure [dbo].[spr_deleteRol]    Script Date: 09/03/2023 10:51:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spr_deleteRol]
	@codigoRol INT,
	@USUARIO_BITACORA nvarchar(64)
	
as
begin try
	DECLARE @XML VARCHAR(MAX)
	declare @METODO varchar(16)
	declare @SP varchar(64)
	set @METODO = 'DELETE'
	set @SP = 'spr_deletePersona'


	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>0</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE/><STACK_TRACE/></MSGPRE>' as xmlRespuesta

	DECLARE @EXISTE_ROLASIGNADO INT =( select count(*) from usuario where codigoRol = @codigoRol)

	if(@EXISTE_ROLASIGNADO != 0)
		begin
			SET @XML = '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>2</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE>El Rol no puede ser eliniado</MENSAJE><STACK_TRACE/></MSGPRE>'
				GOTO final_sp
		end

	UPDATE rol set estatus = -1 where codigoRol = @codigoRol
	

	SET @XML = '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>0</CODIGO><IDENTITY>' + CONVERT(nvarchar(100), @codigoRol) + '</IDENTITY><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE>Proceso realizado con éxito!</MENSAJE><STACK_TRACE/></MSGPRE>';	
	final_sp:
end try
begin catch
	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>1</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE><![CDATA['+ ERROR_MESSAGE() +']]></MENSAJE><STACK_TRACE><![CDATA[' + cast(ERROR_NUMBER() as nvarchar(50)) + ' del error ocurrido en ' + isnull(ERROR_PROCEDURE(),'') + ' en la línea ' + cast(ERROR_LINE() as nvarchar(50)) + ']]></STACK_TRACE></MSGPRE>' as xmlRespuesta
end catch