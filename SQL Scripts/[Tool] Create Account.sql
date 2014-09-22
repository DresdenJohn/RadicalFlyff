USE [ACCOUNT_DBF]
GO
DECLARE @account varchar(32)
DECLARE @email varchar(100)
DECLARE @salt varchar(100)
DECLARE @password varchar(100)

PRINT N'********************************************************************************
************* Welcome to the Project Flight Account Creation Tool!	************
*************					Created by Cuvvvvie					************
*************				http://project-flight.com/				************
********************************************************************************'

/* PLEASE SET THE VARAIBLES BELOW BEFORE EXECUTING THE SCRIPT! */
SET @account	= '' -- User Account (use this to login)	
SET @password	= '' -- User Password (use this to login)
SET @email		= '' -- User Email (optional)
SET @salt		= 'flight' -- Password Salt (default is 'flight')

DECLARE @RC int
DECLARE @pw varchar(32)
SET @pw = CONVERT(VARCHAR(32), HashBytes('MD5', @salt+@password), 2)
EXECUTE @RC = [ACCOUNT_DBF].[dbo].[usp_CreateNewAccount] 
   @account
  ,@pw
  ,@email
GO
USE [master]
GO