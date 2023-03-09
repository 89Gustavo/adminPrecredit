USE administradorPreCREDITPRO
GO
/****** Object:  StoredProcedure [dbo].[spr_deletePersona]    Script Date: 09/03/2023 10:48:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spr_deletePersona]
	@codigoPersona INT,
	@USUARIO_BITACORA nvarchar(64)
	
as
begin try
	declare @METODO varchar(16)
	declare @SP varchar(64)
	set @METODO = 'DELETE'
	set @SP = 'spr_deletePersona'


	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>0</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE/><STACK_TRACE/></MSGPRE>' as xmlRespuesta

	UPDATE persona set estatus = -1 where codigoPersona = @codigoPersona
		
end try
begin catch
	select '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>1</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE><![CDATA['+ ERROR_MESSAGE() +']]></MENSAJE><STACK_TRACE><![CDATA[' + cast(ERROR_NUMBER() as nvarchar(50)) + ' del error ocurrido en ' + isnull(ERROR_PROCEDURE(),'') + ' en la línea ' + cast(ERROR_LINE() as nvarchar(50)) + ']]></STACK_TRACE></MSGPRE>' as xmlRespuesta
end catch