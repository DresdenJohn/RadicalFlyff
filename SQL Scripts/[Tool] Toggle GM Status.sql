USE [ACCOUNT_DBF]
GO
DECLARE @username varchar(100)

PRINT N'********************************************************************************
************* Welcome to the Project Flight GM Status Toggle Tool!	************
*************					Created by Cuvvvvie					************
*************				http://project-flight.com/				************
********************************************************************************'

/* PLEASE SET THE VARAIBLE BELOW BEFORE EXECUTING THE SCRIPT! */
SET		@username = '' -- Username to change GM status

IF (SELECT [m_chAuthority] FROM [CHARACTER_01_DBF].[dbo].[CHARACTER_TBL] WHERE [m_szName] = @username) = 'F'
BEGIN
	UPDATE [CHARACTER_01_DBF].[dbo].[CHARACTER_TBL]
	SET [m_chAuthority] = 'S' WHERE [m_szName] = @username
	PRINT N'Username '+@username+' is now a GM!'
END
ELSE
BEGIN
	UPDATE [CHARACTER_01_DBF].[dbo].[CHARACTER_TBL]
	SET [m_chAuthority] = 'F' WHERE [m_szName] = @username
	PRINT N'Username "'+@username+'" is no longer a GM!'
END
GO
USE [master]
GO