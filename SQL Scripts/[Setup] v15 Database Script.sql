PRINT  '
################################################################################
#################  v15 Database Script: Project Flight Edition  ################
#################			http://project-flight.com/			################
################################################################################
#################			Base Database:	Aeonsoft			################
#################			Configured by:	Cuvvvie				################
################################################################################

'
--				Welcome to the Project Flight v15 Database Script!
--
--						Base Database:	Aeonsoft
--						Configured by:	Cuvvvie
--						Revision #	 :	rev2
--						For more info:	http://project-flight.com/
--						
--	This database has been generated from the official v15 databases that was
--	originally released as backup files, to be restored in SSMS. All necessary
--	data/structure is recreated with this script, along with the linked servers.
--
--	This database was made for use with Project Flight, but it is a clean v15
--	database script and can be used with any v15 (or possibly later) server.
--
--	Features added by Cuvvvie:
--	--	Automatically DROP old databases/linked servers if they exist
--	--	Automatically CREATE databases/linked servers using "@@SERVERNAME"
--	--	All tables are clear besides [CHARACTER_01_DBF].[BASE_VALUE_TBL]
--
--	Changes from raw scripts:
--	--	Changed [dbo].[usp_ChangePW] to not use the [dbo].[xp_crypt] procedure
--	--	Removed ITEM_DBF database (not needed)
--	--	Removed EoCRM login from MANAGE_DBF (this means no EoCRM support)
--	--	Removed PRIMARY/LOG disk details from each database creation
--	--	Fixed character delete (still prompts for password but anything works)
--
--	Note for experienced users:
--		This release doesn't have any of the features or fixes included in the
--		AllInOne DB (v3) created by Sedrika and Cross. This is a clean script
--		that is an alternative to restoring the database backup files manually.
--
--	Contact me if you have any issues or suggestions or a future release:
--				http://forum.ragezone.com/members/784256.html

-- Start script
USE [master]
GO

-- Start linked server deletion
PRINT 'Deleting existing linked servers...'

IF EXISTS ( SELECT 1 FROM sysservers WHERE srvname = 'ACCOUNT' )
EXEC master.dbo.sp_dropserver @server=N'ACCOUNT', @droplogins='droplogins'
GO
IF EXISTS ( SELECT 1 FROM sysservers WHERE srvname = 'CHR01' )
EXEC master.dbo.sp_dropserver @server=N'CHR01', @droplogins='droplogins'
GO
IF EXISTS ( SELECT 1 FROM sysservers WHERE srvname = 'RANKING' )
EXEC master.dbo.sp_dropserver @server=N'RANKING', @droplogins='droplogins'
GO
-- End linked server deletion

-- Start database deletion
PRINT 'Deleting existing databases...'

IF EXISTS(select * from sys.databases where name='ACCOUNT_DBF')
BEGIN
	ALTER DATABASE [ACCOUNT_DBF] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'ACCOUNT_DBF'
	DROP DATABASE [ACCOUNT_DBF]
END
GO
IF EXISTS(select * from sys.databases where name='CHARACTER_01_DBF')
BEGIN
	ALTER DATABASE [CHARACTER_01_DBF] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'CHARACTER_01_DBF'
	DROP DATABASE [CHARACTER_01_DBF]
END
GO
IF EXISTS(select * from sys.databases where name='LOGGING_01_DBF')
BEGIN
	ALTER DATABASE [LOGGING_01_DBF] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'LOGGING_01_DBF'
	DROP DATABASE [LOGGING_01_DBF]
END
GO
IF EXISTS(select * from sys.databases where name='MANAGE_DBF')
BEGIN
	ALTER DATABASE [MANAGE_DBF] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'MANAGE_DBF'
	DROP DATABASE [MANAGE_DBF]
END
GO
IF EXISTS(select * from sys.databases where name='RANKING_DBF')
BEGIN
	ALTER DATABASE [RANKING_DBF] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'RANKING_DBF'
	DROP DATABASE [RANKING_DBF]
END
GO
-- End database deletion

-- Start linked servers creation
PRINT  'Creating new linked servers...'

exec sys.sp_addlinkedserver  'ACCOUNT', '', 'SQLNCLI', @@servername, null, null, 'ACCOUNT_DBF'
exec sys.sp_serveroption @server='ACCOUNT', @optname='rpc', @optvalue='true'
exec sys.sp_serveroption @server='ACCOUNT', @optname='rpc out', @optvalue='true'

exec sys.sp_addlinkedserver  'CHR01', '', 'SQLNCLI', @@servername, null, null, 'CHARACTER_01_DBF'
exec sys.sp_serveroption @server='CHR01', @optname='rpc', @optvalue='true'
exec sys.sp_serveroption @server='CHR01', @optname='rpc out', @optvalue='true'

exec sys.sp_addlinkedserver  'RANKING', '', 'SQLNCLI', @@servername, null, null, 'RANKING_DBF'
exec sys.sp_serveroption @server='RANKING', @optname='rpc', @optvalue='true'
exec sys.sp_serveroption @server='RANKING', @optname='rpc out', @optvalue='true'
-- End linked servers creation

-- Start database creation
PRINT  'Creating new databases...'

-- Start ACCOUNT_DBF creation
USE [master]
GO
CREATE DATABASE [ACCOUNT_DBF] --ON  PRIMARY 
--( NAME = N'ACCOUNT_DBF', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL\MSSQL\DATA\ACCOUNT_DBF.mdf' , SIZE = 7168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
-- LOG ON 
--( NAME = N'ACCOUNT_DBF_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL\MSSQL\DATA\ACCOUNT_DBF_1.LDF' , SIZE = 12352KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'ACCOUNT_DBF', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ACCOUNT_DBF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ACCOUNT_DBF] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET ANSI_NULLS OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET ANSI_PADDING OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET ARITHABORT OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [ACCOUNT_DBF] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [ACCOUNT_DBF] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [ACCOUNT_DBF] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET  DISABLE_BROKER
GO
ALTER DATABASE [ACCOUNT_DBF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [ACCOUNT_DBF] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [ACCOUNT_DBF] SET  READ_WRITE
GO
ALTER DATABASE [ACCOUNT_DBF] SET RECOVERY SIMPLE
GO
ALTER DATABASE [ACCOUNT_DBF] SET  MULTI_USER
GO
ALTER DATABASE [ACCOUNT_DBF] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [ACCOUNT_DBF] SET DB_CHAINING OFF
GO
USE [ACCOUNT_DBF]
GO
CREATE ROLE [acc_on9@te] AUTHORIZATION [dbo]
GO
CREATE ROLE [account] AUTHORIZATION [dbo]
GO
CREATE ROLE [billing] AUTHORIZATION [dbo]
GO
CREATE ROLE [ongate] AUTHORIZATION [dbo]
GO
CREATE SCHEMA [acc_on9@te] AUTHORIZATION [account]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_MessengerList]
@serverindex char(2),
@m_szName varchar(32)
as

set nocount on

declare @q1 nvarchar(4000)
declare @m_idPlayer char(7)
set @q1 = '
select @m_idPlayer = m_idPlayer from CHR' + @serverindex + '.CHARACTER_' + @serverindex + '_DBF.dbo.CHARACTER_TBL where m_szName = ''' + @m_szName + ''''
exec sp_executesql @q1, N'@m_idPlayer char(7) output', @m_idPlayer output

set @q1 = '
select c.m_szName, m_idPlayer
from CHR' + @serverindex + '.CHARACTER_' + @serverindex + '_DBF.dbo.tblMessenger as m
	inner join CHR' + @serverindex + '.CHARACTER_' + @serverindex + '_DBF.dbo.CHARACTER_TBL as c on m.idFriend = c.m_idPlayer
where m.idPlayer = ''' + @m_idPlayer + ''' and isblock = ''F'' and chUse = ''T'' order by m.idFriend'
exec sp_executesql @q1
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PCZone](
	[PCZoneID] [int] IDENTITY(1,1) NOT NULL,
	[PCZoneName] [varchar](100) NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[Phone] [varchar](100) NOT NULL,
	[CPU] [varchar](100) NOT NULL,
	[VGA] [varchar](100) NOT NULL,
	[RAM] [varchar](100) NOT NULL,
	[Monitor] [varchar](100) NOT NULL,
	[Comment] [varchar](1000) NOT NULL,
	[Grade] [tinyint] NOT NULL,
	[Account] [varchar](32) NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_iCafeInfo_1] PRIMARY KEY CLUSTERED 
(
	[PCZoneID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shop](
	[id] [int] NOT NULL,
	[itemid] [int] NOT NULL,
	[name] [text] NOT NULL,
	[info] [text] NOT NULL,
	[count] [int] NOT NULL,
	[cost] [int] NOT NULL,
	[pages] [int] NOT NULL,
	[category] [text] NOT NULL,
	[format] [text] NOT NULL,
 CONSTRAINT [PK_shop] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CashHistory](
	[account] [varchar](32) NULL,
	[beforeCash] [int] NULL,
	[afterCash] [int] NULL,
	[regdate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountPlay](
	[Account] [varchar](32) NOT NULL,
	[PlayDate] [int] NOT NULL,
	[PlayTime] [int] NOT NULL,
 CONSTRAINT [PK_AccountPlay] PRIMARY KEY CLUSTERED 
(
	[Account] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ACCOUNT_TBL_DETAIL](
	[account] [varchar](32) NOT NULL,
	[gamecode] [char](4) NOT NULL,
	[tester] [char](1) NOT NULL,
	[m_chLoginAuthority] [char](1) NULL,
	[regdate] [datetime] NOT NULL,
	[BlockTime] [char](8) NULL,
	[EndTime] [char](8) NULL,
	[WebTime] [char](8) NULL,
	[isuse] [char](1) NULL,
	[secession] [datetime] NULL,
	[email] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [ACCOUNT_TBL_DETAIL_ID1] ON [dbo].[ACCOUNT_TBL_DETAIL] 
(
	[account] DESC,
	[gamecode] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ACCOUNT_TBL](
	[account] [varchar](32) NOT NULL,
	[password] [char](32) NOT NULL,
	[isuse] [char](1) NULL,
	[member] [char](1) NULL,
	[id_no1] [char](6) NULL,
	[id_no2] [char](255) NULL,
	[realname] [char](1) NULL,
	[reload] [char](1) NULL,
	[cash] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [ACCOUNT_ID1] ON [dbo].[ACCOUNT_TBL] 
(
	[account] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'123', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ACCOUNT_TBL', @level2type=N'COLUMN',@level2name=N'account'
GO
EXEC sys.sp_addextendedproperty @name=N'123', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ACCOUNT_TBL', @level2type=N'COLUMN',@level2name=N'password'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_og_ChangePassWord]
@account varchar(32),
@password varchar(32)
as
set nocount on
set xact_abort on

if exists (select * from ACCOUNT_TBL where account = @account)
begin	
	begin tran			
		Update ACCOUNT_TBL SET Password = @password Where account=@account
		if @@error <> 0
		begin
			rollback tran
			select -1
		end
		else
		begin
			commit tran
			select 1
		end
end
else
begin
	select 0
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[ACCOUNT_STR]
@iaccount   	VARCHAR(32),
@ipassword VARCHAR(16)
/***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************



	ACCOUNT_STR 스토어드
	작성자 : 최석준
	작성일 : 2004.01.18

	ex) ACCOUNT_STR 'beat','1234'

***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************/
AS
set nocount on

IF EXISTS(SELECT a.account FROM ACCOUNT_TBL a,ACCOUNT_TBL_DETAIL b 
                  WHERE a.account = b.account AND a.account = @iaccount AND gamecode = 'A000')
	BEGIN
		IF EXISTS(SELECT account FROM ACCOUNT_TBL  
                        WHERE account = @iaccount  AND password = @ipassword )
-- 			BEGIN
-- 			
-- 				DECLARE @birthyear CHAR(4),@currdate CHAR(8)
-- 				SELECT  @birthyear = 	CASE 	WHEN  SUBSTRING(id_no2,1,1) IN ('9','0') THEN '18' + SUBSTRING(id_no1,1,2)
-- 							             							WHEN  SUBSTRING(id_no2,1,1) IN ('1','2') THEN '19' + SUBSTRING(id_no1,1,2)
-- 																	WHEN	 SUBSTRING(id_no2,1,1) IN ('3','4') THEN '20' + SUBSTRING(id_no1,1,2)
-- 																	WHEN  SUBSTRING(id_no2,1,1) IN ('5','6') THEN '21' + SUBSTRING(id_no1,1,2)			
-- 																	WHEN  SUBSTRING(id_no2,1,1) IN ('7','8') THEN '22' + SUBSTRING(id_no1,1,2)
-- 														END			 
-- 				   FROM ACCOUNT_TBL
-- 				WHERE account = @iaccount
-- 
-- 				SELECT @currdate = CONVERT(CHAR(8),GETDATE(),112)
-- 
-- 				SELECT	fError = 	CASE 	WHEN a.id_no1 = 'a00000' 
-- 																THEN '0' 
-- 								 							WHEN b.BlockTime >= @currdate AND b.EndTime < @currdate
-- 										   						THEN '3' 		
-- 															WHEN a.realname = 'F' 
-- 																THEN '4' 										 			
-- 												 			WHEN  @birthyear >  DATEADD(Year,-13,@currdate)
-- 																THEN '5'
-- 												 			WHEN  @birthyear >=  DATEADD(Year,-11,@currdate) AND b.tester = '0'
-- 																THEN '6'															
-- 															ELSE '0' 	END,
-- 
-- 								fText 	=	CASE 	WHEN a.id_no1 = 'a00000' 
-- 																THEN '사원 및 기자'	
-- 												 			WHEN b.BlockTime >= @currdate AND b.EndTime < @currdate
-- 														   		THEN '계정블럭이거나 유료화 초과'			
-- 															WHEN a.realname = 'F' 
-- 																THEN '실명처리가 안된것'									 			
-- 												 			WHEN  @birthyear >  DATEADD(Year,-13,@currdate)
-- 																THEN '프리프는 12세 이상 이용가 이므로 게임접속을 할수 없습니다.'	
-- 												 			WHEN  @birthyear >=  DATEADD(Year,-11,@currdate) AND b.tester = '0'
-- 																THEN '14세 미만 가입자 분들은 부모님 동의서를 보내주셔야 게임 접속이 가능합니다'																
-- 															ELSE  '정상사용자 14세 이상' END
-- 				   FROM 	ACCOUNT_TBL a, ACCOUNT_TBL_DETAIL b 
-- 				WHERE 	a.account = b.account AND b.account = @iaccount AND a.[password] = @ipassword
-- 			END
			BEGIN
				SELECT fError = '0', fText = 'OK'
			END
		ELSE
			BEGIN
				SELECT fError = '1', fText = 'Wrong Password !!'
			END
	END	
ELSE
	BEGIN
		SELECT fError = '2', fText = 'Account Not Exists !!'
	END
RETURN

-- 계정 검사 Rule
-- 1. (fError=2 리턴) 계정있는지 확인. 계정확인시 "gamecode = A000" 만 프리프 회원.
-- 2. (fError=1 리턴) 암호확인.
-- 3. (fError=0 리턴) 사원 및 기자 확인( id_no1가 a0000 )으로 확인.계정.암호만 확인
-- 4. (fError=3 리턴) 블럭타임과, 과금타임 확인.
-- 5. (fError=4 리턴) 실명확인.
-- 6. (fError=5 리턴) 12세 이상인지 확인. 이하이면 "프리프는 12세 이상 이용가 이므로 ]
--                            게임접속을 할수 없습니다." 라고 알림.
-- 7. (fError=6 리턴) 부모동의서가 없는 애덜 확인 tester = 0 이면 "14세 미만 가입자 분들은 
--                            부모등의서를 보내주셔야 게임 접속이 가능합니다"라고 알림.
-- 8. (fError=0 리턴) 위의 예말고는 정상 사용자로 인정.
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PCZoneIP](
	[IPID] [int] IDENTITY(1,1) NOT NULL,
	[PCZoneID] [int] NOT NULL,
	[IPFrom1] [tinyint] NOT NULL,
	[IPFrom2] [tinyint] NOT NULL,
	[IPFrom3] [tinyint] NOT NULL,
	[IPFrom4] [tinyint] NOT NULL,
	[IPTo4] [tinyint] NOT NULL,
	[IsUse] [tinyint] NOT NULL,
	[RegDate] [datetime] NOT NULL,
	[OperID] [varchar](32) NULL,
	[OperDate] [datetime] NULL,
 CONSTRAINT [PK_iCafeIP_1] PRIMARY KEY CLUSTERED 
(
	[IPID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE       PROC [dbo].[LOGIN_RELOAD_STR]
/**********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************
	LOGIN_RELOAD_STR 스토어드
	작성자 : 최석준
	작성일 : 2005.01.24
	ex) LOGIN_RELOAD_STR

**********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************/

AS
set nocount on
SELECT account FROM ACCOUNT_TBL WHERE reload='T'
set nocount off

RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROC  [dbo].[CREATE_ACCOUNT_STR] 
@iGu CHAR(1) = 'A',
@k INT = 100
AS
DECLARE @i INT,@j INT,@oSeq CHAR(6)
IF @iGu = 'A'
BEGIN	
	SET @j = 1
	SELECT @i = ISNULL(CONVERT(INT,(MAX(account))),0) + 1 FROM ACCOUNT_TBL
	SELECT CONVERT(INT,(MAX(account))) + @k  FROM ACCOUNT_TBL
	WHILE @j < @k + 1
	BEGIN
		SET @oSeq = RIGHT('000000' + CONVERT(VARCHAR(6),@i),6)
		INSERT ACCOUNT_TBL
		(account,password,isuse,member,id_no1,id_no2,realname)
		VALUES
		(@oSeq,@oSeq,'T','A','','','')
		INSERT ACCOUNT_TBL_DETAIL
		(account,gamecode,tester,m_chLoginAuthority,regdate,BlockTime,EndTime,WebTime,isuse,secession)
		VALUES
		(@oSeq,'A000','2','F',GETDATE(),CONVERT(CHAR(8),GETDATE()-1,112),CONVERT(CHAR(8),DATEADD(year,6,GETDATE()),112),CONVERT(CHAR(8),GETDATE()-1,112),'T',NULL)
		SET @i = @i + 1
		SET @j = @j + 1
		IF (@j  % 100 = 0)
		PRINT @oSeq
	END
RETURN
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[LOGINJOIN_STR]
	@iGu        		CHAR(2) 			= 'A1', 
	@iaccount   	VARCHAR(32)
/***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************

	LOGINJOIN_STR 스토어드
	작성자 : 송현석
	작성일 : 2004.01.30 
	수정일 : 

	ex) LOGINONOFF_STR 'A1','1234'

***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************/

AS
set nocount on

IF @iGu = 'A1' -- ON
	BEGIN
		UPDATE ACCOUNT_TBL_DETAIL
		SET isuse = 'J'
		WHERE account = @iaccount
	RETURN
	END

ELSE
IF @iGu = 'A2' -- OFF
	BEGIN
		UPDATE ACCOUNT_TBL_DETAIL
		SET isuse = 'O'
		WHERE account = @iaccount	
	RETURN
	END

ELSE
IF @iGu = 'A3' -- ALL OFF
	BEGIN
		UPDATE ACCOUNT_TBL_DETAIL
		SET isuse = 'O'
	RETURN
	END

set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_CreateNewAccount]
@account varchar(32),
@pw varchar(32),
--@cash int = 0,
@email varchar(100) = ''
as
set nocount on
set xact_abort on

if not exists (select * from ACCOUNT_TBL where account = @account)
begin

	begin tran
	INSERT ACCOUNT_TBL(account,password,isuse,member,id_no1,id_no2,realname, cash)
	VALUES(@account, @pw, 'T', 'A', '', '', '', '0')
	INSERT ACCOUNT_TBL_DETAIL(account,gamecode,tester,m_chLoginAuthority,regdate,BlockTime,EndTime,WebTime,isuse,secession, email)
	VALUES(@account,'A000','2','F',GETDATE(),CONVERT(CHAR(8),GETDATE()-1,112),CONVERT(CHAR(8),DATEADD(year,10,GETDATE()),112),CONVERT(CHAR(8),GETDATE()-1,112),'T',NULL, @email)
	insert AccountPlay (Account, PlayDate)
	select @account, convert(int, convert(char(8), getdate(), 112))

	if @@error <> 0
	begin
		rollback tran
		select -1
	end
	else
	begin
		commit tran
		select 1
	end
end
else
begin
	select 0
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_ChangePW]
	-- Modified to not use the master.dbo.xp_crypt procedure
	-- Instead, pass the hashed password as @pw (by Cuvvvie)
@account varchar(32),
@pw varchar(32)
as
set nocount on
set xact_abort on

if exists (select * from ACCOUNT_TBL where account = @account)
begin
/*
	declare @hash char(32), @tpw varchar(40)
	set @tpw = 'tpgk' + @pw
	exec master.dbo.xp_crypt @tpw, @hash output
*/
	begin tran
	update ACCOUNT_TBL
	set [password] = lower(@pw) --lower(@hash)
	where account = @account

	if @@error <> 0
	begin
		rollback tran
		select -1
	end
	else
	begin
		commit tran
		select 1
	end
end
else
begin
	select 0
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_ChangeEmail]
@account varchar(32),
@email varchar(100)
as
set nocount on
set xact_abort on

if exists (select * from ACCOUNT_TBL_DETAIL where account = @account)
begin
	begin tran
	update ACCOUNT_TBL_DETAIL
	set email = @email
	where account = @account

	if @@error <> 0
	begin
		rollback tran
		select -1
	end
	else
	begin
		commit tran
		select 1
	end
end
else
begin
	select 0
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_UpdateAccountPassword]
		@account		varchar(32),
		@password	varchar(32)
AS
SET NOCOUNT ON


	Update ACCOUNT_TBL SET Password = @password Where Account=@account
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_UpdateCashInfo]
@account varchar(32),
@cash int
as
set nocount on
set xact_abort on

if exists (select * from ACCOUNT_TBL where account = @account)
begin
	begin tran
		insert into CashHistory (account, beforeCash, afterCash)
		select @account, cash, @cash from ACCOUNT_TBL where account = @account

		update ACCOUNT_TBL
		set cash = @cash
		where account = @account
	if @@error <> 0
	begin
		rollback tran
		select -1
	end
	else
	begin
		commit tran
		select 1
	end
end
else
begin
	select 0
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
declare @o_Grade tinyint
exec dbo.USP_PCZoneIP_Check '218.38.238.131', @o_Grade output
select @o_Grade

exec LOGIN_STR 'chipi', '85158c7b8a7f3113b0f32b70ed936b2c', '127.0.0.0'
*/
create   proc [dbo].[USP_PCZoneIP_Check]
     @i_IPAddress varchar(15)
    , @o_Grade tinyint output
as
set nocount on
set transaction isolation level read uncommitted

declare @i_IP1 tinyint
declare @i_IP2 tinyint
declare @i_IP3 tinyint
declare @i_IP4 tinyint

declare @index int

--@i_IP1
set @index = charindex('.', @i_IPAddress)
set @i_IP1 = left(@i_IPAddress, @index-1)
set @i_IPAddress = right(@i_IPAddress, len(@i_IPAddress)-@index)

--@i_IP2
set @index = charindex('.', @i_IPAddress)
set @i_IP2 = left(@i_IPAddress, @index-1)
set @i_IPAddress = right(@i_IPAddress, len(@i_IPAddress)-@index)

--@i_IP3, @i_IP4 
set @index = charindex('.', @i_IPAddress)
set @i_IP3 = left(@i_IPAddress, @index-1)
set @i_IP4 = right(@i_IPAddress, len(@i_IPAddress)-@index)

--PCZoneIP_Check
select @o_Grade = b.Grade
from PCZoneIP a
        inner join PCZone b
            on a.PCZoneID = b.PCZoneID
where IsUse in (1, 9)
and IPFrom1 = @i_IP1
and IPFrom2 = @i_IP2
and IPFrom3 = @i_IP3
and IPFrom4 <= @i_IP4 and IPTo4 >= @i_IP4

select @o_Grade = isnull(@o_Grade, 0)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LOGIN_STR]
	@iaccount   	VARCHAR(32),
	@ipassword 		char(32)
   -- Ver. 14 PCZoneIP
   ,@i_IPAddress varchar(15) = '0.0.0.0'
/***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************



	ACCOUNT_STR ????
	??? : ???
	??? : 2004.01.18

	ex) ACCOUNT_STR 'beat','1234'
SELECT * FROM ACCOUNT_TBL_DETAIL WHERE account='aeonsoft'

***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************/
AS
set nocount on

-- Ver 14. PCZoneIP_Check
declare @o_Grade tinyint
exec dbo.USP_PCZoneIP_Check @i_IPAddress, @o_Grade output      

IF EXISTS(SELECT a.account FROM ACCOUNT_TBL a,ACCOUNT_TBL_DETAIL b 
                  WHERE a.account = b.account AND a.account = @iaccount ) -- AND gamecode = 'A000') 
BEGIN
	
	DECLARE @curDate char(8)

		IF EXISTS(SELECT account FROM ACCOUNT_TBL  
                        WHERE account = @iaccount  AND password = @ipassword) BEGIN

			SELECT 	@curDate=CONVERT(CHAR(8), getdate(), 112)
			
			SELECT 	fError=CASE 
							-- WHEN session<>@isession OR sessionExpireDt<getdate() THEN '91'
							WHEN BlockTime>=@curDate THEN '9' 
							ELSE '0' END,
				   	fText= CASE 
							-- WHEN session<>@isession OR sessionExpireDt<getdate() THEN 'Session Expired'
							WHEN BlockTime>=@curDate THEN 'Block' ELSE 'OK' END,
				   	fCheck=tester,
					f18='1' 
					-- Ver14. PCZoneIP
					 ,fPCZone = @o_Grade
			FROM ACCOUNT_TBL a INNER JOIN ACCOUNT_TBL_DETAIL b ON (a.account=b.account)
			WHERE a.account=@iaccount
		END
		ELSE BEGIN
			SELECT fError = '1', fText = 'Wrong Password !!',fCheck ='',f18='1', fPCZone = '0'			-- PCZoneIP (, fPCZone = '0' ??)
		END
END	
ELSE BEGIN
	SELECT fError = '2', fText = 'Account Not Exists !!',fCheck ='',f18='1', fPCZone = '0'			-- PCZoneIP (, fPCZone = '0' ??)
END

RETURN

-- ?? ?? Rule
-- 1. (fError=2 ??) ????? ??. ????? "gamecode = A000" ? ??? ??.
-- 2. (fError=1 ??) ????.
-- 3. (fError=0 ??) ?? ? ?? ??( id_no1? a0000 )?? ??.??.??? ??
-- 4. (fError=3 ??) ?????, ???? ??.
-- 5. (fError=4 ??) ????.
-- 6. (fError=5 ??) 12? ???? ??. ???? "???? 12? ?? ??? ??? ]
--                            ????? ?? ????." ?? ??.
-- 7. (fError=6 ??) ?????? ?? ?? ?? tester = 0 ?? "14? ?? ??? ??? 
--                            ?????? ????? ?? ??? ?????"?? ??.
-- 8. (fError=0 ??) ?? ???? ?? ???? ??.
set nocount off
GO
ALTER TABLE [dbo].[PCZone] ADD  CONSTRAINT [DF_PCZone_Grade]  DEFAULT ((1)) FOR [Grade]
GO
ALTER TABLE [dbo].[PCZone] ADD  CONSTRAINT [DF_PCZone_Account]  DEFAULT ('') FOR [Account]
GO
ALTER TABLE [dbo].[PCZone] ADD  CONSTRAINT [DF_PCZone_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[CashHistory] ADD  CONSTRAINT [DF_CashHistory_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[AccountPlay] ADD  CONSTRAINT [DF_AccountPlay_Account]  DEFAULT ('') FOR [Account]
GO
ALTER TABLE [dbo].[AccountPlay] ADD  CONSTRAINT [DF_AccountPlay_PlayDate]  DEFAULT ('') FOR [PlayDate]
GO
ALTER TABLE [dbo].[AccountPlay] ADD  CONSTRAINT [DF_AccountPlay_PlayTime]  DEFAULT ((0)) FOR [PlayTime]
GO
ALTER TABLE [dbo].[ACCOUNT_TBL_DETAIL] ADD  CONSTRAINT [DF_ACCOUNT_DETAIL_email]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[ACCOUNT_TBL] ADD  CONSTRAINT [DF_ACCOUNT_TBL_cash]  DEFAULT ((0)) FOR [cash]
GO
ALTER TABLE [dbo].[PCZoneIP] ADD  CONSTRAINT [DF_PCZoneIP_IsUse]  DEFAULT ((0)) FOR [IsUse]
GO
ALTER TABLE [dbo].[PCZoneIP] ADD  CONSTRAINT [DF_PCZoneIP_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[PCZoneIP]  WITH NOCHECK ADD  CONSTRAINT [FK_iCafeIP_iCafeInfo1] FOREIGN KEY([PCZoneID])
REFERENCES [dbo].[PCZone] ([PCZoneID])
GO
ALTER TABLE [dbo].[PCZoneIP] CHECK CONSTRAINT [FK_iCafeIP_iCafeInfo1]
GO
-- End ACCOUNT_DBF creation

-- Start CHARACTER_01_DBF creation
USE [master]
GO
CREATE DATABASE [CHARACTER_01_DBF] --ON  PRIMARY 
--( NAME = N'CHARACTER_01_DBF', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL\MSSQL\DATA\CHARACTER_01_DBF.mdf' , SIZE = 7168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
-- LOG ON 
--( NAME = N'CHARACTER_01_DBF_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL\MSSQL\DATA\CHARACTER_01_DBF_1.ldf' , SIZE = 1792KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'CHARACTER_01_DBF', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CHARACTER_01_DBF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CHARACTER_01_DBF] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET ANSI_NULLS OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET ANSI_PADDING OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET ARITHABORT OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [CHARACTER_01_DBF] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [CHARACTER_01_DBF] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [CHARACTER_01_DBF] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET  DISABLE_BROKER
GO
ALTER DATABASE [CHARACTER_01_DBF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [CHARACTER_01_DBF] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [CHARACTER_01_DBF] SET  READ_WRITE
GO
ALTER DATABASE [CHARACTER_01_DBF] SET RECOVERY SIMPLE
GO
ALTER DATABASE [CHARACTER_01_DBF] SET  MULTI_USER
GO
ALTER DATABASE [CHARACTER_01_DBF] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [CHARACTER_01_DBF] SET DB_CHAINING OFF
GO
USE [CHARACTER_01_DBF]
GO
CREATE ROLE [billing] AUTHORIZATION [dbo]
GO
CREATE ROLE [character01] AUTHORIZATION [dbo]
GO
CREATE ROLE [ongate] AUTHORIZATION [dbo]
GO
CREATE TYPE [dbo].[m_idPlayer] FROM [char](7) NOT NULL
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCouple_deleted](
	[cid] [int] NULL,
	[nServer] [int] NULL,
	[nExperience] [int] NULL,
	[add_Date] [datetime] NULL,
	[del_Date] [datetime] NULL,
	[rid] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCouple](
	[cid] [int] IDENTITY(1,1) NOT NULL,
	[nServer] [int] NOT NULL,
	[nExperience] [int] NULL,
	[add_Date] [datetime] NULL,
 CONSTRAINT [PK_tblCouple] PRIMARY KEY CLUSTERED 
(
	[cid] ASC,
	[nServer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TASKBAR_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[m_aSlotApplet] [varchar](3100) NULL,
	[m_aSlotQueue] [varchar](225) NULL,
	[m_SkillBar] [smallint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [TASKBAR_ID1] ON [dbo].[TASKBAR_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TASKBAR_ITEM_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[m_aSlotItem] [varchar](6885) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [TASKBAR_ITEM_ID1] ON [dbo].[TASKBAR_ITEM_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TAG_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[f_idPlayer] [char](7) NULL,
	[m_Message] [varchar](255) NULL,
	[State] [char](1) NULL,
	[CreateTime] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [TAG_ID1] ON [dbo].[TAG_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCombatInfo](
	[CombatID] [int] NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[Status] [varchar](3) NOT NULL,
	[StartDt] [datetime] NULL,
	[EndDt] [datetime] NULL,
	[Comment] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_tblCombatInfo] PRIMARY KEY CLUSTERED 
(
	[CombatID] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblChangeBankPW](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MESSENGER_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[f_idPlayer] [char](7) NULL,
	[m_nJob] [int] NULL,
	[m_dwSex] [int] NULL,
	[State] [char](1) NULL,
	[CreateTime] [datetime] NULL,
	[m_dwState] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [MESSENGER_ID1] ON [dbo].[MESSENGER_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [MESSENGER_ID2] ON [dbo].[MESSENGER_TBL] 
(
	[f_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [MESSENGER_ID3] ON [dbo].[MESSENGER_TBL] 
(
	[State] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QUEST_TBL](
	[m_idPlayer] [char](6) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_wId] [int] NULL,
	[m_nState] [tinyint] NULL,
	[m_wTime] [int] NULL,
	[m_nKillNPCNum_0] [tinyint] NULL,
	[m_nKillNPCNum_1] [tinyint] NULL,
	[m_bPatrol] [tinyint] NULL,
	[m_bDialog] [tinyint] NULL,
	[m_bReserve3] [tinyint] NULL,
	[m_bReserve4] [tinyint] NULL,
	[m_bReserve5] [tinyint] NULL,
	[m_bReserve6] [tinyint] NULL,
	[m_bReserve7] [tinyint] NULL,
	[m_bReserve8] [tinyint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [QUEST_ID1] ON [dbo].[QUEST_TBL] 
(
	[m_idPlayer] ASC,
	[serverindex] ASC,
	[m_wId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PARTY_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[partyname] [varchar](16) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [PARTY_ID1] ON [dbo].[PARTY_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RAINBOWRACE_TBL](
	[serverindex] [char](2) NULL,
	[nTimes] [int] NULL,
	[m_idPlayer] [char](7) NULL,
	[chState] [char](1) NULL,
	[nRanking] [int] NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [CL_RAINBOWRACE_TBL_nTimes] ON [dbo].[RAINBOWRACE_TBL] 
(
	[nTimes] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [NC_RAINBOWRACE_TBL_m_idPlayer] ON [dbo].[RAINBOWRACE_TBL] 
(
	[m_idPlayer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_generate_insert_script] 
	@tablename_mask sysname = NULL
as
	begin
	
	-------------------------------------------------------------------------------- 
	
	-- Stored Procedure: sp_generate_insert_script
	-- Language: Microsoft Transact SQL (7.0)
	-- Author: Inez Boone (inez.boone@xs4al.nl)
	-- working on the Sybase version of & thanks to:
	-- Reinoud van Leeuwen (reinoud@xs4all.nl)
	-- Version: 1.4
	-- Date: December 6th, 2000
	-- Description: This stored procedure generates an SQL script to fill the
	-- tables in the database with their current content.
	-- Parameters: IN: @tablename_mask : mask for tablenames
	-- History: 1.0 October 3rd 1998 Reinoud van Leeuwen
	-- first version for Sybase
	-- 1.1 October 7th 1998 Reinoud van Leeuwen
	-- added limited support for text fields; the first 252 
	-- characters are selected.
	-- 1.2 October 13th 1998 Reinoud van Leeuwen
	-- added support for user-defined datatypes
	-- 1.3 August 4 2000 Inez Boone
	-- version for Microsoft SQL Server 7.0
	-- use dynamic SQL, no intermediate script
	-- 1.4 December 12 2000 Inez Boone
	-- handles quotes in strings, handles identity columns
	-- 1.5 December 21 2000 Inez Boone
	-- Output sorted alphabetically to assist db compares,
	-- skips timestamps
	-- 1.6 June 10 2005 Beatchoi@yahoo.co.kr
	-- added support for reserver keyword 
	-------------------------------------------------------------------------------- 
	
	-- NOTE: If, when executing in the Query Analyzer, the result is truncated, you can remedy
	-- this by choosing Query / Current Connection Options, choosing the Advanced tab and
	-- adjusting the value of 'Maximum characters per column'.
	-- Unchecking 'Print headers' will get rid of the line of dashes.
	
	
	declare @tablename varchar (128)
	declare @tablename_max varchar (128)
	declare @tableid int
	declare @columncount numeric (7,0)
	declare @columncount_max numeric (7,0)
	declare @columnname varchar (30)
	declare @columntype int
	declare @string varchar (30)
	declare @leftpart varchar (8000) /* 8000 is the longest string SQLSrv7 can EXECUTE */
	declare @rightpart varchar (8000) /* without having to resort to concatenation */
	declare @hasident int
	 
	
	set nocount on
	
	-- take ALL tables when no mask is given (!)
	
	if (@tablename_mask is NULL)
		begin
			select @tablename_mask = '%'
		end
	
	
	-- create table columninfo now, because it will be used several times
	
	 
	
	create table #columninfo (num numeric (7,0) identity,name varchar(30),usertype smallint)
	
	select name,id into #tablenames
	from sysobjects
	where type in ('U' ,'S')
	and name like @tablename_mask
	
	 
	
	-- loop through the table #tablenames
	
	select @tablename_max = MAX (name),@tablename = MIN (name)
	from #tablenames
	
	
	while @tablename <= @tablename_max
		begin
			select @tableid = id
			from #tablenames
			where name = @tablename
			
			if (@@rowcount <> 0)
			begin
				-- Find out whether the table contains an identity column
				select @hasident = max( status & 0x80 )
				from syscolumns
				where id = @tableid
				
				truncate table #columninfo
				
				insert into #columninfo (name,usertype)
				select name, type
				from syscolumns C
				where id = @tableid
				and type <> 37 -- do not include timestamps
				
				-- Fill @leftpart with the first part of the desired insert-statement, with the fieldnames
				
				select @leftpart = 'select ''insert into '+@tablename
				select @leftpart = @leftpart + '('
				select @columncount = MIN (num),@columncount_max = MAX (num)
				from #columninfo
				
				
				while @columncount <= @columncount_max
					begin
						select @columnname = quotename([name]),@columntype = usertype
						from #columninfo
						where num = @columncount
				
						if (@@rowcount <> 0)			
							begin
								if (@columncount < @columncount_max)
									begin
										select @leftpart = @leftpart + @columnname + ','
									end
								else
									begin
										select @leftpart = @leftpart + @columnname + ')'
									end
							end
						select @columncount = @columncount + 1
					end
		
		 
		
				select @leftpart = @leftpart + ' values('''
	
				-- Now fill @rightpart with the statement to retrieve the values of the fields, correctly formatted
	
				select @columncount = MIN (num),
				@columncount_max = MAX (num)
				from #columninfo
	
	 
				select @rightpart = ''
	
				while @columncount <= @columncount_max
					begin
						select @columnname = quotename(name),@columntype = usertype
						from #columninfo
						where num = @columncount
				
						if (@@rowcount <> 0)
							begin
							
								if @columntype in (39,47) /* char fields need quotes (except when entering NULL);
								                                        * use char(39) == ', easier readable than escaping
								                                        */
								begin
									select @rightpart = @rightpart + '+'
									select @rightpart = @rightpart + 'ISNULL(' + replicate( char(39), 4 ) + '+replace(' + @columnname + ',' + replicate( char(39), 4 ) + ',' + replicate( char(39), 6) + ')+' + replicate ( char(39), 4 ) + ',''NULL'')'
								end
								
								else if @columntype = 35 /* TEXT fields cannot be RTRIM-ed and need quotes */
																			 /* convert to VC 1000 to leave space for other fields */
								begin
									select @rightpart = @rightpart + '+'
									select @rightpart = @rightpart + 'ISNULL(' + replicate( char(39), 4 ) + '+replace (convert(varchar(1000),' + @columnname + ')' + ',' + replicate( char(39), 4 ) + ',' + replicate( char(39), 6 ) + ')+' + replicate( char(39), 4 ) + ',''NULL'')'
								end
								
								else if @columntype in (58,61,111) /* datetime fields */
								begin
									select @rightpart = @rightpart + '+'
									select @rightpart = @rightpart + 'ISNULL(' + replicate( char(39), 4 ) + '+convert (varchar(20),' + @columnname + ')+'+ replicate( char(39), 4 ) + ',''NULL'')'
								end
								
								else /* numeric types */
								begin
									select @rightpart = @rightpart + '+'
									select @rightpart = @rightpart + 'ISNULL(convert(varchar(99),' + @columnname + '),''NULL'')'
								end
					
								if ( @columncount < @columncount_max)
								begin
									select @rightpart = @rightpart + '+'','''
								end
				
							end
								select @columncount = @columncount + 1
						end
				end
	
			select @rightpart = @rightpart + '+'')''' + ' from ' + @tablename
	
			-- Order the select-statements by the first column so you have the same order for
			-- different database (easy for comparisons between databases with different creation orders)
	
			select @rightpart = @rightpart + ' order by 1' 
	
			-- For tables which contain an identity column we turn identity_insert on
			-- so we get exactly the same content 
		
			if @hasident > 0
				select 'SET IDENTITY_INSERT ' + @tablename + ' ON'
			
				exec ( @leftpart + @rightpart )
			
			if @hasident > 0
				select 'SET IDENTITY_INSERT ' + @tablename + ' OFF'
			
			select @tablename = MIN (name)
			from #tablenames
			where name > @tablename

		end

	end
return
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[smtp](
	[date1] [varchar](8000) NULL,
	[time1] [varchar](8000) NULL,
	[send_id] [varchar](8000) NULL,
	[send_svr] [varchar](8000) NULL,
	[email] [varchar](8000) NULL,
	[err1] [varchar](8000) NULL,
	[err2] [varchar](8000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SKILLINFLUENCE_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NULL,
	[SkillInfluence] [varchar](7500) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [SKILLINFLUENCE_TBL_ID1] ON [dbo].[SKILLINFLUENCE_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SKILL_TBL](
	[Index] [int] NULL,
	[szName] [nvarchar](255) NULL,
	[job] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SHOW_STAT_DATE_STR]
@tablemask sysname='%', @indexmask sysname='%'
AS

	SELECT
			LEFT(CAST(user_name(uid)+'.'+o.name AS sysname),30) AS tablename,
			LEFT(i.name,30) as indexname,
			CASE
				WHEN indexproperty(o.id, i.name, 'IsAutoStatistics') = 1 THEN 'AutoStatistics'
				WHEN indexproperty(o.id, i.name, 'IsStatistics') = 1     THEN 'Statistics'
				ELSE 'Index'
			END AS Type,
			stats_date(o.id, i.indid) AS statsUpdated,
			rowcnt,
			rowmodctr,
			ISNULL(CAST(rowmodctr/CAST(NULLIF(rowcnt,0) AS decimal(20,2)) * 100 AS int),0) AS percentmodifiedRows,
			CASE i.status & 0x1000000
				WHEN 0 THEN 'No'
				ELSE 'Yes'
			END AS [norecompute?],
			i.status
	  FROM
			dbo.sysobjects o join dbo.sysindexes i ON (o.id = i.id)
	 WHERE
			o.name like @tablemask
	   AND 	i.name like @indexmask
	   AND 	objectproperty(o.id, 'IsUserTable')=1
	   AND	i.indid between 1 and 254
	 ORDER BY tablename, indexname

RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SHOP](
	[SHOP] [nchar](10) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SEQ](
	[SEQ] [char](2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SECRET_ROOM_TBL](
	[serverindex] [char](2) NULL,
	[nTimes] [int] NULL,
	[nContinent] [int] NULL,
	[m_idGuild] [char](6) NULL,
	[nPenya] [int] NULL,
	[chState] [char](1) NULL,
	[s_date] [datetime] NULL,
	[dwWorldID] [int] NULL,
	[nWarState] [int] NULL,
	[nKillCount] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [IDX_CLU_SECRET_ROOM_TBL_serverindex] ON [dbo].[SECRET_ROOM_TBL] 
(
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_SECRET_ROOM_TBL_m_idGuild] ON [dbo].[SECRET_ROOM_TBL] 
(
	[m_idGuild] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_SECRET_ROOM_TBL_nTimes_chState] ON [dbo].[SECRET_ROOM_TBL] 
(
	[nTimes] ASC,
	[chState] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCampus](
	[idCampus] [int] NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_tblCampus] PRIMARY KEY CLUSTERED 
(
	[idCampus] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사제 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampus', @level2type=N'COLUMN',@level2name=N'idCampus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampus', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사제 생성 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampus', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblAccountList](
	[account] [varchar](32) NULL,
	[rid] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [IDX_CLU_tblAccountList_rid] ON [dbo].[tblAccountList] 
(
	[rid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_TOP_FAQ](
	[num] [tinyint] NOT NULL,
	[oper_id] [varchar](20) NOT NULL,
	[input_day] [smalldatetime] NOT NULL,
	[title] [varchar](300) NOT NULL,
	[memo] [varchar](8000) NOT NULL,
	[view_cnt] [int] NOT NULL,
 CONSTRAINT [PK_TOP_FAQ_TBL] PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_USER_CNT](
	[s_date] [char](8) NOT NULL,
	[number] [int] NULL,
	[svr01] [int] NULL,
	[svr02] [int] NULL,
	[svr03] [int] NULL,
	[svr04] [int] NULL,
	[svr05] [int] NULL,
	[svr06] [int] NULL,
 CONSTRAINT [PK_LOG_STAT_USER_CNT] PRIMARY KEY CLUSTERED 
(
	[s_date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_TOTAL_SEED](
	[s_date] [char](8) NOT NULL,
	[serverindex] [char](2) NULL,
	[total_gold] [bigint] NULL,
	[gold] [bigint] NULL,
	[bank_gold] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_TOTAL_PLAY_TIME](
	[s_date] [char](8) NOT NULL,
	[user_cnt] [int] NOT NULL,
	[play_time] [int] NOT NULL,
 CONSTRAINT [PK_TBL_STAT_TOTAL_PLAY_TIME] PRIMARY KEY CLUSTERED 
(
	[s_date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_TOP_SEED](
	[s_date] [char](8) NOT NULL,
	[serverindex] [char](2) NULL,
	[account] [varchar](32) NULL,
	[m_szName] [varchar](32) NULL,
	[m_nLevel] [int] NULL,
	[m_dwGold] [int] NULL,
	[m_dwBank] [int] NULL,
	[total_Gold] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_TOP_LEVEL](
	[s_date] [char](8) NOT NULL,
	[serverindex] [char](2) NULL,
	[account] [varchar](50) NULL,
	[m_szName] [varchar](32) NULL,
	[m_nLevel] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_SECESSION](
	[s_date] [char](8) NOT NULL,
	[number] [int] NULL,
	[sex_1] [int] NULL,
	[sex_2] [int] NULL,
	[a_1] [int] NULL,
	[a_2] [int] NULL,
	[b_1] [int] NULL,
	[b_2] [int] NULL,
	[c_1] [int] NULL,
	[c_2] [int] NULL,
	[d_1] [int] NULL,
	[d_2] [int] NULL,
	[e_1] [int] NULL,
	[e_2] [int] NULL,
	[f_1] [int] NULL,
	[f_2] [int] NULL,
 CONSTRAINT [PK_TBL_STAT_SECESSION] PRIMARY KEY CLUSTERED 
(
	[s_date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_PLAY_TIME](
	[s_date] [char](8) NULL,
	[gubun] [char](1) NULL,
	[number] [int] NULL,
	[sex_1] [int] NULL,
	[sex_2] [int] NULL,
	[a_1] [int] NULL,
	[a_2] [int] NULL,
	[b_1] [int] NULL,
	[b_2] [int] NULL,
	[c_1] [int] NULL,
	[c_2] [int] NULL,
	[d_1] [int] NULL,
	[d_2] [int] NULL,
	[e_1] [int] NULL,
	[e_2] [int] NULL,
	[f_1] [int] NULL,
	[f_2] [int] NULL,
	[etc] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_MAIL_MANAGE](
	[s_date] [char](8) NOT NULL,
	[oper_id] [varchar](20) NOT NULL,
	[gubun] [tinyint] NOT NULL,
	[number] [int] NULL,
	[c01] [int] NULL,
	[c02] [int] NULL,
	[c03] [int] NULL,
	[c04] [int] NULL,
	[c05] [int] NULL,
	[c06] [int] NULL,
	[c07] [int] NULL,
	[c08] [int] NULL,
 CONSTRAINT [PK_TBL_STAT_MAIL_MANAGE] PRIMARY KEY CLUSTERED 
(
	[s_date] ASC,
	[oper_id] ASC,
	[gubun] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_MAIL_ACCEPT](
	[s_date] [char](8) NOT NULL,
	[gubun] [tinyint] NOT NULL,
	[number] [int] NULL,
	[c01] [int] NULL,
	[c02] [int] NULL,
	[c03] [int] NULL,
	[c04] [int] NULL,
	[c05] [int] NULL,
	[c06] [int] NULL,
	[c07] [int] NULL,
	[c08] [int] NULL,
 CONSTRAINT [PK_TBL_STAT_MAIL_ACCEPT] PRIMARY KEY CLUSTERED 
(
	[s_date] ASC,
	[gubun] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_LEVEL](
	[s_date] [char](8) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_nLevel] [int] NOT NULL,
	[cnt] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_JOIN](
	[s_date] [char](8) NOT NULL,
	[region] [varchar](20) NOT NULL,
	[sex] [char](1) NOT NULL,
	[gubun] [char](1) NOT NULL,
	[join_cnt] [int] NOT NULL,
	[chr_cnt] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_JOB_PLAY_TIME](
	[s_date] [char](8) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_nJob] [int] NOT NULL,
	[playtime] [int] NULL,
 CONSTRAINT [PK_TBL_STAT_JOB_PLAY_TIME] PRIMARY KEY CLUSTERED 
(
	[s_date] ASC,
	[serverindex] ASC,
	[m_nJob] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_JOB](
	[s_date] [char](8) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_nJob] [int] NOT NULL,
	[cnt] [int] NULL,
	[level] [int] NULL,
 CONSTRAINT [PK_TBL_STAT_JOB] PRIMARY KEY CLUSTERED 
(
	[s_date] ASC,
	[serverindex] ASC,
	[m_nJob] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_ECONOMY](
	[s_date] [char](8) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[total_money] [bigint] NULL,
	[pre_money] [bigint] NULL,
	[sell_money] [bigint] NULL,
	[buy_money] [bigint] NULL,
	[quest_money] [bigint] NULL,
	[join_chr] [int] NULL,
 CONSTRAINT [PK_TBL_STAT_ECONOMY] PRIMARY KEY CLUSTERED 
(
	[s_date] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_STAT_CHR_CREATE](
	[s_date] [char](8) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[cnt] [int] NOT NULL,
 CONSTRAINT [PK_TBL_STAT_CHR_CREATE] PRIMARY KEY CLUSTERED 
(
	[s_date] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_SERVER_LIST](
	[id] [char](2) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[memo] [varchar](50) NULL,
	[cnt] [tinyint] NOT NULL,
 CONSTRAINT [PK_TBL_SERVER_LIST] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_OPER_PIC](
	[imageid] [int] NOT NULL,
	[imageblob] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_OPER_MENU](
	[oper_id] [varchar](20) NOT NULL,
	[Am] [int] NOT NULL,
	[Am1] [int] NOT NULL,
	[Am2] [int] NOT NULL,
	[Am3] [int] NOT NULL,
	[Am4] [int] NOT NULL,
	[Am5] [int] NOT NULL,
	[Bm] [int] NOT NULL,
	[Bm1] [int] NOT NULL,
	[Bm2] [int] NOT NULL,
	[Bm3] [int] NOT NULL,
	[Bm4] [int] NOT NULL,
	[Bm5] [int] NOT NULL,
	[Bm6] [int] NOT NULL,
	[Cm] [int] NOT NULL,
	[Cm1] [int] NOT NULL,
	[Cm2] [int] NOT NULL,
	[Cm3] [int] NOT NULL,
	[Cm4] [int] NOT NULL,
	[Cm5] [int] NOT NULL,
	[Cm6] [int] NOT NULL,
	[Cm7] [int] NOT NULL,
	[Cm8] [int] NOT NULL,
	[Dm] [int] NOT NULL,
	[Dm1] [int] NOT NULL,
	[Dm2] [int] NOT NULL,
	[Dm3] [int] NOT NULL,
	[Dm4] [int] NOT NULL,
	[Dm5] [int] NOT NULL,
	[Dm6] [int] NOT NULL,
	[Dm7] [int] NOT NULL,
	[Dm8] [int] NOT NULL,
	[Em] [int] NOT NULL,
	[Em1] [int] NOT NULL,
	[Em11] [int] NOT NULL,
	[Em12] [int] NOT NULL,
	[Em13] [int] NOT NULL,
	[Em14] [int] NOT NULL,
	[Em2] [int] NOT NULL,
	[Em21] [int] NOT NULL,
	[Em22] [int] NOT NULL,
	[Em23] [int] NOT NULL,
	[Em24] [int] NOT NULL,
	[Em25] [int] NOT NULL,
	[Em26] [int] NOT NULL,
	[Fm] [int] NOT NULL,
	[Fm1] [int] NOT NULL,
	[Fm11] [int] NOT NULL,
	[Fm12] [int] NOT NULL,
	[Fm13] [int] NOT NULL,
	[Fm14] [int] NOT NULL,
	[Fm15] [int] NOT NULL,
	[Fm16] [int] NOT NULL,
	[Fm2] [int] NOT NULL,
	[Fm21] [int] NOT NULL,
	[Fm22] [int] NOT NULL,
	[Fm3] [int] NOT NULL,
	[Fm31] [int] NOT NULL,
	[Fm32] [int] NOT NULL,
	[Fm33] [int] NOT NULL,
	[Fm4] [int] NOT NULL,
	[Fm41] [int] NOT NULL,
	[Fm42] [int] NOT NULL,
	[Fm43] [int] NOT NULL,
	[Gm] [int] NOT NULL,
	[Gm1] [int] NOT NULL,
	[Gm2] [int] NOT NULL,
	[Hm] [int] NOT NULL,
	[Hm1] [int] NOT NULL,
	[Hm2] [int] NOT NULL,
	[Hm3] [int] NOT NULL,
	[Im] [int] NOT NULL,
	[Im1] [int] NOT NULL,
	[Im2] [int] NOT NULL,
	[Im3] [int] NOT NULL,
	[Im4] [int] NOT NULL,
	[Im5] [int] NOT NULL,
	[Im6] [int] NOT NULL,
	[Im7] [int] NOT NULL,
	[Im8] [int] NOT NULL,
	[Im9] [int] NOT NULL,
	[regioper_id] [varchar](20) NOT NULL,
	[regidate] [datetime] NOT NULL,
	[delchk] [int] NOT NULL,
	[modioper_id] [varchar](20) NULL,
	[modidate] [datetime] NULL,
	[deloper_id] [varchar](20) NULL,
	[deldate] [datetime] NULL,
 CONSTRAINT [PK_TBL_OPER_MENU] PRIMARY KEY CLUSTERED 
(
	[oper_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_OPER_AUTH](
	[oper_id] [varchar](20) NOT NULL,
	[code] [char](3) NOT NULL,
	[auth] [tinyint] NOT NULL,
	[input_day] [smalldatetime] NULL,
	[input_id] [varchar](20) NULL,
 CONSTRAINT [PK_TBL_OPER_AUTH] PRIMARY KEY CLUSTERED 
(
	[oper_id] ASC,
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_OPER](
	[oper_id] [varchar](20) NOT NULL,
	[pwd] [varchar](10) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[ip] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[class] [tinyint] NOT NULL,
	[input_day] [smalldatetime] NULL,
	[input_id] [varchar](20) NULL,
	[nickname] [varchar](50) NULL,
 CONSTRAINT [PK_TBL_OPER] PRIMARY KEY CLUSTERED 
(
	[oper_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_MMAIL_TestList](
	[email] [varchar](300) NULL,
	[uname] [varchar](300) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_MMAIL](
	[id] [int] NOT NULL,
	[comment] [varchar](100) NULL,
	[title] [varchar](100) NOT NULL,
	[body] [text] NULL,
	[sql_statement] [varchar](2000) NULL,
	[sql_column] [varchar](100) NULL,
	[input_date] [datetime] NOT NULL,
	[input_id] [varchar](20) NOT NULL,
	[importance] [int] NULL,
	[text_type] [int] NULL,
	[send_date] [datetime] NULL,
	[send_count] [int] NULL,
	[sender_name] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_MAIL_TEMPLET](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[oper_id] [varchar](32) NOT NULL,
	[input_day] [datetime] NULL,
	[content] [varchar](8000) NOT NULL,
	[stat] [char](1) NOT NULL,
	[title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TBL_MAIL_TEMPLET] PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_MAIL_SERVER_PROVIDER_LIST](
	[s_domain] [varchar](100) NOT NULL,
	[s_name] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_MAIL_PAST](
	[num] [int] NOT NULL,
	[mail_code] [char](6) NULL,
	[input_day] [smalldatetime] NOT NULL,
	[account] [varchar](32) NULL,
	[server_index] [char](2) NULL,
	[m_szName] [varchar](32) NULL,
	[title] [varchar](100) NULL,
	[content] [text] NULL,
	[file1] [varchar](100) NULL,
	[file2] [varchar](100) NULL,
	[oper_id] [varchar](20) NOT NULL,
	[working_day] [smalldatetime] NULL,
	[var_data] [varchar](1000) NOT NULL,
	[answer] [text] NULL,
	[end_day] [smalldatetime] NULL,
 CONSTRAINT [PK_TBL_MAIL_PAST] PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_MAIL_FORM](
	[code] [char](6) NOT NULL,
	[oper_id] [varchar](20) NOT NULL,
	[input_day] [datetime] NOT NULL,
	[title] [varchar](100) NULL,
	[memo] [varchar](200) NULL,
 CONSTRAINT [PK_MAIL_FORM_TBL] PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_MAIL_CUR](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[mail_code] [char](6) NULL,
	[input_day] [smalldatetime] NOT NULL,
	[account] [varchar](32) NOT NULL,
	[server_index] [char](2) NULL,
	[m_szName] [varchar](32) NULL,
	[title] [varchar](100) NOT NULL,
	[content] [text] NOT NULL,
	[file1] [varchar](100) NULL,
	[file2] [varchar](100) NULL,
	[stat] [char](1) NOT NULL,
	[oper_id] [varchar](20) NULL,
	[working_day] [smalldatetime] NULL,
	[var_data] [varchar](2000) NOT NULL,
 CONSTRAINT [PK_TBL_MAIL_CUR] PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_LOG_SECESSION_CHARACTER](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[serverindex] [tinyint] NOT NULL,
	[m_szName] [varchar](32) NOT NULL,
	[slot] [tinyint] NOT NULL,
	[end_time] [char](12) NULL,
	[input_id] [varchar](20) NOT NULL,
	[input_day] [smalldatetime] NOT NULL,
	[reason] [varchar](100) NULL,
 CONSTRAINT [PK_TBL_LOG_RECOVERY_CHARACTER] PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_LOG_SECESSION_ACCOUNT](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[account] [varchar](32) NOT NULL,
	[secession_day] [datetime] NULL,
	[tester] [tinyint] NULL,
	[new_tester] [tinyint] NULL,
	[input_id] [varchar](20) NOT NULL,
	[input_day] [smalldatetime] NOT NULL,
	[memo] [varchar](200) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_LOG_REAL_NAME](
	[account] [varchar](32) NOT NULL,
	[code] [tinyint] NOT NULL,
	[input_day] [smalldatetime] NOT NULL,
	[input_id] [varchar](20) NULL,
 CONSTRAINT [PK_LOG_REAL_NAME] PRIMARY KEY CLUSTERED 
(
	[account] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_LOG_ITEM_SEND_070808](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[server_index] [char](2) NOT NULL,
	[m_idPlayer] [char](7) NOT NULL,
	[item_name] [varchar](32) NULL,
	[item_count] [int] NULL,
	[m_AbilityOption] [int] NULL,
	[m_bItemResist] [int] NULL,
	[m_nResistAbilityOption] [int] NULL,
	[isEvent] [char](1) NULL,
	[oper_id] [varchar](32) NULL,
	[input_day] [datetime] NULL,
	[cancel] [char](1) NULL,
	[m_nNo] [int] NULL,
	[reason] [varchar](500) NULL,
	[nRandomOptItemId] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_LOG_ITEM_SEND](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[server_index] [char](2) NOT NULL,
	[m_idPlayer] [char](7) NOT NULL,
	[item_name] [varchar](32) NULL,
	[item_count] [int] NULL,
	[m_AbilityOption] [int] NULL,
	[m_bItemResist] [int] NULL,
	[m_nResistAbilityOption] [int] NULL,
	[isEvent] [char](1) NULL,
	[oper_id] [varchar](32) NULL,
	[input_day] [datetime] NULL,
	[cancel] [char](1) NULL,
	[m_nNo] [int] NULL,
	[reason] [varchar](500) NULL,
	[nRandomOptItemId] [int] NULL,
 CONSTRAINT [PK_TBL_LOG_ITEM_SEND] PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_LOG_ITEM_REMOVE](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[server_index] [char](2) NOT NULL,
	[m_idPlayer] [char](7) NOT NULL,
	[item_name] [varchar](32) NOT NULL,
	[item_count] [int] NOT NULL,
	[m_AbilityOption] [int] NOT NULL,
	[m_bItemResist] [int] NULL,
	[m_nResistAbilityOption] [int] NULL,
	[state] [char](1) NOT NULL,
	[reason] [varchar](200) NULL,
	[oper_id] [varchar](32) NULL,
	[input_day] [datetime] NULL,
	[m_nNo] [int] NULL,
	[RandomOpt] [int] NOT NULL,
 CONSTRAINT [PK_TBL_ITEM_REMOVE] PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_LOG_BLOCK_CHARACTER](
	[num] [int] NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_szName] [varchar](32) NOT NULL,
	[start_day] [smalldatetime] NOT NULL,
	[end_day] [smalldatetime] NOT NULL,
	[oper_id] [varchar](20) NOT NULL,
	[block_code] [char](1) NOT NULL,
	[comment] [varchar](200) NULL,
 CONSTRAINT [PK_TBL_BLOCK_CHARACTER] PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_LOG_BLOCK_ACCOUNT](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[account] [varchar](32) NOT NULL,
	[code1] [tinyint] NOT NULL,
	[code2] [tinyint] NOT NULL,
	[code3] [tinyint] NOT NULL,
	[old_block_day] [char](8) NOT NULL,
	[old_web_day] [char](8) NOT NULL,
	[block_day] [char](8) NOT NULL,
	[web_day] [char](8) NOT NULL,
	[input_id] [varchar](20) NOT NULL,
	[input_day] [smalldatetime] NOT NULL,
	[r_web_day] [char](8) NULL,
	[r_block_day] [char](8) NULL,
	[r_reason] [varchar](500) NULL,
	[r_input_id] [varchar](20) NULL,
	[r_input_day] [smalldatetime] NULL,
	[reason] [varchar](500) NULL,
 CONSTRAINT [PK_TBL_LOG_BLOCK_ACCOUNT] PRIMARY KEY NONCLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_FAQ](
	[code] [char](6) NOT NULL,
	[oper_id] [varchar](20) NOT NULL,
	[input_day] [smalldatetime] NOT NULL,
	[title] [varchar](100) NULL,
	[memo] [text] NULL,
	[view_cnt] [int] NOT NULL,
	[email_code] [char](6) NOT NULL,
 CONSTRAINT [PK_FAQ_TBL] PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_DB_CHK_TIME](
	[num] [int] IDENTITY(1,1) NOT NULL,
	[from_date] [datetime] NULL,
	[to_date] [datetime] NULL,
	[oper_id] [varchar](50) NULL,
	[input_date] [datetime] NULL,
	[db_server] [char](100) NULL,
	[comment] [varchar](200) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CODE_PROGRAM](
	[code] [nvarchar](3) NOT NULL,
	[title] [nvarchar](30) NOT NULL,
	[comment] [nvarchar](2000) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_CODE_INI](
	[code] [varchar](5) NOT NULL,
	[section] [varchar](10) NOT NULL,
	[key] [varchar](30) NOT NULL,
	[value] [varchar](500) NULL,
	[input_day] [datetime] NULL,
	[input_id] [varchar](20) NULL,
 CONSTRAINT [PK_TBL_CODE_INI] PRIMARY KEY CLUSTERED 
(
	[code] ASC,
	[section] ASC,
	[key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_CODE_COMMON](
	[code] [varchar](3) NOT NULL,
	[key] [varchar](50) NOT NULL,
	[value] [varchar](5000) NULL,
	[input_day] [smalldatetime] NULL,
	[input_id] [varchar](20) NULL,
 CONSTRAINT [PK_코드_공통_TBL] PRIMARY KEY CLUSTERED 
(
	[code] ASC,
	[key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_CODE_CLASS](
	[class] [tinyint] NOT NULL,
	[code] [char](3) NOT NULL,
	[auth] [tinyint] NULL,
	[input_id] [varchar](20) NULL,
	[input_day] [smalldatetime] NULL,
 CONSTRAINT [PK_TBL_CODE_CLASS] PRIMARY KEY CLUSTERED 
(
	[class] ASC,
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_CODE_BLOCK](
	[code1] [tinyint] NOT NULL,
	[code2] [tinyint] NOT NULL,
	[title] [varchar](100) NULL,
	[code3_1] [char](5) NULL,
	[code3_2] [char](5) NULL,
	[code3_3] [char](5) NULL,
	[code3_4] [char](5) NULL,
	[input_day] [smalldatetime] NULL,
	[input_id] [varchar](20) NULL,
 CONSTRAINT [PK_TBL_CODE_BLOCK] PRIMARY KEY CLUSTERED 
(
	[code1] ASC,
	[code2] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_CODE](
	[code1] [char](2) NOT NULL,
	[code2] [char](2) NOT NULL,
	[title] [varchar](50) NULL,
	[title_eng] [varchar](50) NULL,
	[input_day] [smalldatetime] NOT NULL,
	[oper_id] [varchar](20) NULL,
 CONSTRAINT [PK_TBL_GAME_CODE] PRIMARY KEY CLUSTERED 
(
	[code1] ASC,
	[code2] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_VALENTINE_EVENT](
	[Prodate] [char](8) NOT NULL,
	[m_idPlayer] [char](7) NOT NULL,
	[regdate] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TAX_INFO_TBL](
	[serverindex] [char](2) NULL,
	[nTimes] [int] NULL,
	[nContinent] [int] NULL,
	[dwID] [char](7) NULL,
	[dwNextID] [char](7) NULL,
	[bSetTaxRate] [int] NULL,
	[change_time] [char](12) NULL,
	[save_time] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [IDX_CLU_TAX_INFO_TBL_serverindex_nTimes] ON [dbo].[TAX_INFO_TBL] 
(
	[serverindex] ASC,
	[nTimes] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_CLU_TAX_INFO_TBL_nContinent] ON [dbo].[TAX_INFO_TBL] 
(
	[nContinent] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[make_comma](

@cur_num varchar(6005) 

) returns int

as

begin
  

 declare @i as int
 declare @ret as int




  set @i = 1
  set @ret = 0

 

  while @i <= len(@cur_num)

   begin

      

       if   substring(@cur_num,@i,1)  = '/'

         begin
         

             set @ret = @ret + 1


         end 

       set @i = @i + 1             

   end 

 

   return @ret

 

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MAIL_TBL](
	[serverindex] [char](2) NOT NULL,
	[nMail] [bigint] NOT NULL,
	[idReceiver] [char](7) NULL,
	[idSender] [char](7) NULL,
	[nGold] [bigint] NOT NULL,
	[tmCreate] [int] NULL,
	[byRead] [int] NULL,
	[szTitle] [varchar](128) NULL,
	[szText] [varchar](255) NULL,
	[dwItemId] [int] NOT NULL,
	[nItemNum] [int] NOT NULL,
	[nRepairNumber] [int] NOT NULL,
	[nHitPoint] [int] NOT NULL,
	[nMaxHitPoint] [int] NOT NULL,
	[nMaterial] [int] NOT NULL,
	[byFlag] [int] NOT NULL,
	[dwSerialNumber] [int] NOT NULL,
	[nOption] [int] NOT NULL,
	[bItemResist] [int] NOT NULL,
	[nResistAbilityOption] [int] NOT NULL,
	[idGuild] [int] NOT NULL,
	[nResistSMItemId] [int] NOT NULL,
	[bCharged] [int] NOT NULL,
	[dwKeepTime] [int] NOT NULL,
	[nRandomOptItemId] [bigint] NULL,
	[nPiercedSize] [int] NOT NULL,
	[dwItemId1] [int] NOT NULL,
	[dwItemId2] [int] NOT NULL,
	[dwItemId3] [int] NOT NULL,
	[dwItemId4] [int] NOT NULL,
	[SendDt] [datetime] NULL,
	[ReadDt] [datetime] NULL,
	[GetGoldDt] [datetime] NULL,
	[DeleteDt] [datetime] NULL,
	[ItemFlag] [int] NOT NULL,
	[ItemReceiveDt] [datetime] NULL,
	[GoldFlag] [int] NOT NULL,
	[bPet] [int] NULL,
	[nKind] [int] NULL,
	[nLevel] [int] NULL,
	[dwExp] [int] NULL,
	[wEnergy] [int] NULL,
	[wLife] [int] NULL,
	[anAvailLevel_D] [int] NULL,
	[anAvailLevel_C] [int] NULL,
	[anAvailLevel_B] [int] NULL,
	[anAvailLevel_A] [int] NULL,
	[anAvailLevel_S] [int] NULL,
	[dwItemId5] [int] NULL,
	[dwItemId6] [int] NULL,
	[dwItemId7] [int] NULL,
	[dwItemId8] [int] NULL,
	[dwItemId9] [int] NULL,
	[dwItemId10] [int] NULL,
	[dwItemId11] [int] NULL,
	[dwItemId12] [int] NULL,
	[dwItemId13] [int] NULL,
	[dwItemId14] [int] NULL,
	[dwItemId15] [int] NULL,
	[nPiercedSize2] [int] NULL,
	[szPetName] [varchar](32) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [IDX_U_CLU_MAIL_TBL_nMail] ON [dbo].[MAIL_TBL] 
(
	[serverindex] ASC,
	[nMail] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_MAIL_TBL_byRead] ON [dbo].[MAIL_TBL] 
(
	[byRead] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_MAIL_TBL_tmCreate] ON [dbo].[MAIL_TBL] 
(
	[tmCreate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [MAIL_TBL_ID1] ON [dbo].[MAIL_TBL] 
(
	[idSender] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [MAIL_TBL_ID2] ON [dbo].[MAIL_TBL] 
(
	[idReceiver] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUILD_QUEST_TBL](
	[m_idGuild] [char](6) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[n_Id] [int] NOT NULL,
	[nState] [int] NULL,
	[s_date] [char](14) NULL,
	[e_date] [char](14) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUILD_VOTE_TBL](
	[m_idGuild] [char](6) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_idVote] [int] NULL,
	[m_cbStatus] [char](1) NULL,
	[m_szTitle] [varchar](128) NULL,
	[m_szQuestion] [varchar](255) NULL,
	[m_szString1] [varchar](32) NULL,
	[m_szString2] [varchar](32) NULL,
	[m_szString3] [varchar](32) NULL,
	[m_szString4] [varchar](32) NULL,
	[m_cbCount1] [int] NULL,
	[m_cbCount2] [int] NULL,
	[m_cbCount3] [int] NULL,
	[m_cbCount4] [int] NULL,
	[CreateTime] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [GUILD_VOTE_ID1] ON [dbo].[GUILD_VOTE_TBL] 
(
	[m_idVote] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[fn_GetExpRatio] (
    @Level	int,
    @exp	bigint
)  
RETURNS NUMERIC(3,0)
AS  
BEGIN 
	
	RETURN
		CASE 	WHEN @Level=1 THEN CAST(@exp AS NUMERIC(12,0)) / 14.0 * 100
				WHEN @Level=2 THEN CAST(@exp AS NUMERIC(12,0)) / 20.0 * 100
				WHEN @Level=3 THEN CAST(@exp AS NUMERIC(12,0)) / 36.0 * 100 	
				WHEN @Level=4 THEN CAST(@exp AS NUMERIC(12,0)) / 	90.0 * 100 	
				WHEN @Level=5 THEN CAST(@exp AS NUMERIC(12,0)) / 	152.0 * 100 	
				WHEN @Level=6 THEN CAST(@exp AS NUMERIC(12,0)) / 	250.0 * 100 	
				WHEN @Level=7 THEN CAST(@exp AS NUMERIC(12,0)) / 	352.0 * 100 	
				WHEN @Level=8 THEN CAST(@exp AS NUMERIC(12,0)) / 	480.0 * 100 	
				WHEN @Level=9 THEN CAST(@exp AS NUMERIC(12,0)) / 	591.0 * 100 	
				WHEN @Level=11 THEN CAST(@exp AS NUMERIC(12,0)) / 	743.0 * 100 	
				WHEN @Level=12 THEN CAST(@exp AS NUMERIC(12,0)) / 	973.0 * 100 	
				WHEN @Level=13 THEN CAST(@exp AS NUMERIC(12,0)) / 	1290.0 * 100 	
				WHEN @Level=14 THEN CAST(@exp AS NUMERIC(12,0)) / 	1632.0 * 100 	
				WHEN @Level=15 THEN CAST(@exp AS NUMERIC(12,0)) / 	1928.0 * 100 	
				WHEN @Level=16 THEN CAST(@exp AS NUMERIC(12,0)) / 	2340.0 * 100 	
				WHEN @Level=17 THEN CAST(@exp AS NUMERIC(12,0)) / 	3480.0 * 100 	
				WHEN @Level=18 THEN CAST(@exp AS NUMERIC(12,0)) / 	4125.0 * 100 	
				WHEN @Level=19 THEN CAST(@exp AS NUMERIC(12,0)) / 	4995.0 * 100 	
				WHEN @Level=20 THEN CAST(@exp AS NUMERIC(12,0)) / 	5880.0 * 100 	
				WHEN @Level=21 THEN CAST(@exp AS NUMERIC(12,0)) / 	7840.0 * 100 	
				WHEN @Level=22 THEN CAST(@exp AS NUMERIC(12,0)) / 	6875.0 * 100 	
				WHEN @Level=23 THEN CAST(@exp AS NUMERIC(12,0)) / 	8243.0 * 100 	
				WHEN @Level=24 THEN CAST(@exp AS NUMERIC(12,0)) / 	10380.0 * 100 	
				WHEN @Level=25 THEN CAST(@exp AS NUMERIC(12,0)) / 	13052.0 * 100 	
				WHEN @Level=26 THEN CAST(@exp AS NUMERIC(12,0)) / 	16450.0 * 100 	
				WHEN @Level=27 THEN CAST(@exp AS NUMERIC(12,0)) / 	20700.0 * 100 	
				WHEN @Level=28 THEN CAST(@exp AS NUMERIC(12,0)) / 	26143.0 * 100 	
				WHEN @Level=29 THEN CAST(@exp AS NUMERIC(12,0)) / 	31950.0 * 100 	
				WHEN @Level=30 THEN CAST(@exp AS NUMERIC(12,0)) / 	38640.0 * 100 	
				WHEN @Level=31 THEN CAST(@exp AS NUMERIC(12,0)) / 	57035.0 * 100 	
				WHEN @Level=32 THEN CAST(@exp AS NUMERIC(12,0)) / 	65000.0 * 100 	
				WHEN @Level=33 THEN CAST(@exp AS NUMERIC(12,0)) / 	69125.0 * 100 	
				WHEN @Level=34 THEN CAST(@exp AS NUMERIC(12,0)) / 	72000.0 * 100 	
				WHEN @Level=35 THEN CAST(@exp AS NUMERIC(12,0)) / 	87239.0 * 100 	
				WHEN @Level=36 THEN CAST(@exp AS NUMERIC(12,0)) / 	105863.0 * 100 	
				WHEN @Level=37 THEN CAST(@exp AS NUMERIC(12,0)) / 	128694.0 * 100 	
				WHEN @Level=38 THEN CAST(@exp AS NUMERIC(12,0)) / 	182307.0 * 100 	
		WHEN @Level=39 THEN CAST(@exp AS NUMERIC(12,0)) / 	221450.0 * 100 	
		WHEN @Level=40 THEN CAST(@exp AS NUMERIC(12,0)) / 	269042.0 * 100 	
		WHEN @Level=41 THEN CAST(@exp AS NUMERIC(12,0)) / 	390368.0 * 100 	
		WHEN @Level=42 THEN CAST(@exp AS NUMERIC(12,0)) / 	438550.0 * 100 	
		WHEN @Level=43 THEN CAST(@exp AS NUMERIC(12,0)) / 	458137.0 * 100 	
		WHEN @Level=44 THEN CAST(@exp AS NUMERIC(12,0)) / 	468943.0 * 100 	
		WHEN @Level=45 THEN CAST(@exp AS NUMERIC(12,0)) / 	560177.0 * 100 	
		WHEN @Level=46 THEN CAST(@exp AS NUMERIC(12,0)) / 	669320.0 * 100 	
		WHEN @Level=47 THEN CAST(@exp AS NUMERIC(12,0)) / 	799963.0 * 100 	
		WHEN @Level=48 THEN CAST(@exp AS NUMERIC(12,0)) / 	1115396.0 * 100
		WHEN @Level=49 THEN CAST(@exp AS NUMERIC(12,0)) / 	1331100.0 * 100
		WHEN @Level=50 THEN CAST(@exp AS NUMERIC(12,0)) / 	1590273.0 * 100
		WHEN @Level=51 THEN CAST(@exp AS NUMERIC(12,0)) / 	2306878.0 * 100
		WHEN @Level=52 THEN CAST(@exp AS NUMERIC(12,0)) / 	2594255.0 * 100
		WHEN @Level=53 THEN CAST(@exp AS NUMERIC(12,0)) / 	2711490.0 * 100
		WHEN @Level=54 THEN CAST(@exp AS NUMERIC(12,0)) / 	2777349.0 * 100
		WHEN @Level=55 THEN CAST(@exp AS NUMERIC(12,0)) / 	3318059.0 * 100
		WHEN @Level=56 THEN CAST(@exp AS NUMERIC(12,0)) / 	3963400.0 * 100
		WHEN @Level=57 THEN CAST(@exp AS NUMERIC(12,0)) / 	4735913.0 * 100
		WHEN @Level=58 THEN CAST(@exp AS NUMERIC(12,0)) / 	6600425.0 * 100
		WHEN @Level=59 THEN CAST(@exp AS NUMERIC(12,0)) / 	7886110.0 * 100
		WHEN @Level=60 THEN CAST(@exp AS NUMERIC(12,0)) / 	9421875.0 * 100
		WHEN @Level=61 THEN CAST(@exp AS NUMERIC(12,0)) / 	13547310.0 * 100 	
		WHEN @Level=62 THEN CAST(@exp AS NUMERIC(12,0)) / 	15099446.0 * 100 	
		WHEN @Level=63 THEN CAST(@exp AS NUMERIC(12,0)) / 	15644776.0 * 100 	
		WHEN @Level=64 THEN CAST(@exp AS NUMERIC(12,0)) / 	15885934.0 * 100 	
		WHEN @Level=65 THEN CAST(@exp AS NUMERIC(12,0)) / 	18817757.0 * 100 	
		WHEN @Level=66 THEN CAST(@exp AS NUMERIC(12,0)) / 	22280630.0 * 100 	
		WHEN @Level=67 THEN CAST(@exp AS NUMERIC(12,0)) / 	26392968.0 * 100 	
		WHEN @Level=68 THEN CAST(@exp AS NUMERIC(12,0)) / 	36465972.0 * 100 	
		WHEN @Level=69 THEN CAST(@exp AS NUMERIC(12,0)) / 	43184958.0 * 100 	
		WHEN @Level=70 THEN CAST(@exp AS NUMERIC(12,0)) / 	51141217.0 * 100 	
		WHEN @Level=71 THEN CAST(@exp AS NUMERIC(12,0)) / 	73556918.0 * 100 	
		WHEN @Level=72 THEN CAST(@exp AS NUMERIC(12,0)) / 	81991117.0 * 100 	
		WHEN @Level=73 THEN CAST(@exp AS NUMERIC(12,0)) / 	84966758.0 * 100 	
		WHEN @Level=74 THEN CAST(@exp AS NUMERIC(12,0)) / 	86252845.0 * 100 	
		WHEN @Level=75 THEN CAST(@exp AS NUMERIC(12,0)) / 	102171368.0 * 100 	
		WHEN @Level=76 THEN CAST(@exp AS NUMERIC(12,0)) / 	120995493.0 * 100 	
		WHEN @Level=77 THEN CAST(@exp AS NUMERIC(12,0)) / 	143307208.0 * 100 	
		WHEN @Level=78 THEN CAST(@exp AS NUMERIC(12,0)) / 	198000645.0 * 100 	
		WHEN @Level=79 THEN CAST(@exp AS NUMERIC(12,0)) / 	234477760.0 * 100 	
		WHEN @Level=80 THEN CAST(@exp AS NUMERIC(12,0)) / 	277716683.0 * 100 	
		WHEN @Level=81 THEN CAST(@exp AS NUMERIC(12,0)) / 	381795797.0 * 100 	
		WHEN @Level=82 THEN CAST(@exp AS NUMERIC(12,0)) / 	406848219.0 * 100 	
		WHEN @Level=83 THEN CAST(@exp AS NUMERIC(12,0)) / 	403044458.0 * 100 	
		WHEN @Level=84 THEN CAST(@exp AS NUMERIC(12,0)) / 	391191019.0 * 100 	
		WHEN @Level=85 THEN CAST(@exp AS NUMERIC(12,0)) / 	442876559.0 * 100 	
		WHEN @Level=86 THEN CAST(@exp AS NUMERIC(12,0)) / 	501408635.0 * 100 	
		WHEN @Level=87 THEN CAST(@exp AS NUMERIC(12,0)) / 	567694433.0 * 100 	
		WHEN @Level=88 THEN CAST(@exp AS NUMERIC(12,0)) / 	749813704.0 * 100 	
		WHEN @Level=89 THEN CAST(@exp AS NUMERIC(12,0)) / 	849001357.0 * 100 	
		WHEN @Level=90 THEN CAST(@exp AS NUMERIC(12,0)) / 	961154774.0 * 100 	
		WHEN @Level=91 THEN CAST(@exp AS NUMERIC(12,0)) / 	1309582668.0 * 100 	
		WHEN @Level=92 THEN CAST(@exp AS NUMERIC(12,0)) / 	1382799035.0 * 100 	
		WHEN @Level=93 THEN CAST(@exp AS NUMERIC(12,0)) / 	1357505030.0 * 100 	
		WHEN @Level=94 THEN CAST(@exp AS NUMERIC(12,0)) / 	1305632790.0 * 100 	
		WHEN @Level=95 THEN CAST(@exp AS NUMERIC(12,0)) / 	1464862605.0 * 100 	
		WHEN @Level=96 THEN CAST(@exp AS NUMERIC(12,0)) / 	1628695740.0 * 100 	
		WHEN @Level=97 THEN CAST(@exp AS NUMERIC(12,0)) / 	1810772333.0 * 100 	
		WHEN @Level=98 THEN CAST(@exp AS NUMERIC(12,0)) / 	2348583653.0 * 100 	
		WHEN @Level=99 THEN CAST(@exp AS NUMERIC(12,0)) / 	2611145432.0 * 100 	
		WHEN @Level=100 THEN CAST(@exp AS NUMERIC(12,0)) / 	2903009208.0 * 100 	
		WHEN @Level=101 THEN CAST(@exp AS NUMERIC(12,0)) / 	3919352097.0 * 100 	
		WHEN @Level=102 THEN CAST(@exp AS NUMERIC(12,0)) / 	4063358600.0 * 100 	
		WHEN @Level=103 THEN CAST(@exp AS NUMERIC(12,0)) / 	3916810682.0 * 100 	
		WHEN @Level=104 THEN CAST(@exp AS NUMERIC(12,0)) / 	4314535354.0 * 100 	
		WHEN @Level=105 THEN CAST(@exp AS NUMERIC(12,0)) / 	4752892146.0 * 100 	
		WHEN @Level=106 THEN CAST(@exp AS NUMERIC(12,0)) / 	5235785988.0 * 100 	
		WHEN @Level=107 THEN CAST(@exp AS NUMERIC(12,0)) / 	5767741845.0 * 100 	
		WHEN @Level=108 THEN CAST(@exp AS NUMERIC(12,0)) / 	6353744416.0 * 100 	
		WHEN @Level=109 THEN CAST(@exp AS NUMERIC(12,0)) / 	6999284849.0 * 100 	
		WHEN @Level=110 THEN CAST(@exp AS NUMERIC(12,0)) / 	7710412189.0 * 100 	
		WHEN @Level=111 THEN CAST(@exp AS NUMERIC(12,0)) / 	8493790068.0 * 100 	
		WHEN @Level=112 THEN CAST(@exp AS NUMERIC(12,0)) / 	9356759139.0 * 100	
		WHEN @Level=113 THEN CAST(@exp AS NUMERIC(12,0)) / 	10307405867.0 * 100 	
		WHEN @Level=114 THEN CAST(@exp AS NUMERIC(12,0)) / 	11354638303.0 * 100 	
		WHEN @Level=115 THEN CAST(@exp AS NUMERIC(12,0)) / 	12508269555.0 * 100 	
		WHEN @Level=116 THEN CAST(@exp AS NUMERIC(12,0)) / 	13779109742.0 * 100 	
		WHEN @Level=117 THEN CAST(@exp AS NUMERIC(12,0)) / 	15179067292.0 * 100 	
		WHEN @Level=118 THEN CAST(@exp AS NUMERIC(12,0)) / 	16721260528.0 * 100 	
		WHEN @Level=119 THEN CAST(@exp AS NUMERIC(12,0)) / 	18420140598.0 * 100 	
		WHEN @Level=120 THEN CAST(@exp AS NUMERIC(12,0)) / 	20291626883.0 * 100 	
		WHEN @Level=121 THEN CAST(@exp AS NUMERIC(12,0)) / 	22353256174.0 * 100 	
		WHEN @Level=122 THEN CAST(@exp AS NUMERIC(12,0)) / 	24624347002.0 * 100 	
		WHEN @Level=123 THEN CAST(@exp AS NUMERIC(12,0)) / 	27126180657.0 * 100 	
		WHEN @Level=124 THEN CAST(@exp AS NUMERIC(12,0)) / 	29882200612.0 * 100 	
		WHEN @Level=125 THEN CAST(@exp AS NUMERIC(12,0)) / 	32918232194.0 * 100 	
		WHEN @Level=126 THEN CAST(@exp AS NUMERIC(12,0)) / 	36262724585.0 * 100 	
		WHEN @Level=127 THEN CAST(@exp AS NUMERIC(12,0)) / 	39947017402.0 * 100 	
		WHEN @Level=128 THEN CAST(@exp AS NUMERIC(12,0)) / 	44005634371.0 * 100 	
		WHEN @Level=129 THEN CAST(@exp AS NUMERIC(12,0)) / 	48476606823.0 * 100 	
		WHEN @Level=130 THEN CAST(@exp AS NUMERIC(12,0)) / 	53401830076.0 * 100 	
		WHEN @Level=131 THEN CAST(@exp AS NUMERIC(12,0)) / 	58827456011.0 * 100 	
		WHEN @Level=132 THEN CAST(@exp AS NUMERIC(12,0)) / 	64804325542.0 * 100 	
		WHEN @Level=133 THEN CAST(@exp AS NUMERIC(12,0)) / 	71388445017.0 * 100 	
		WHEN @Level=134 THEN CAST(@exp AS NUMERIC(12,0)) / 	78641511031.0 * 100 	
		WHEN @Level=135 THEN CAST(@exp AS NUMERIC(12,0)) / 	86631488552.0 * 100 	
		WHEN @Level=136 THEN CAST(@exp AS NUMERIC(12,0)) / 	95433247789.0 * 100 	
		WHEN @Level=137 THEN CAST(@exp AS NUMERIC(12,0)) / 	105129265764.0 * 100 	
		WHEN @Level=138 THEN CAST(@exp AS NUMERIC(12,0)) / 	115810399166.0 * 100 	
		WHEN @Level=139 THEN CAST(@exp AS NUMERIC(12,0)) / 	127576735721.0 * 100 	
		WHEN @Level=140 THEN CAST(@exp AS NUMERIC(12,0)) / 	140538532070.0 * 100 	
		WHEN @Level=141 THEN CAST(@exp AS NUMERIC(12,0)) / 	154817246928.0 * 100 	
		WHEN @Level=142 THEN CAST(@exp AS NUMERIC(12,0)) / 	170546679216.0 * 100 	
		WHEN @Level=143 THEN CAST(@exp AS NUMERIC(12,0)) / 	187874221825.0 * 100 	
		WHEN @Level=144 THEN CAST(@exp AS NUMERIC(12,0)) / 	206962242762.0 * 100 	
		WHEN @Level=145 THEN CAST(@exp AS NUMERIC(12,0)) / 	227989606627.0 * 100 	
		WHEN @Level=146 THEN CAST(@exp AS NUMERIC(12,0)) / 	251153350660.0 * 100 	
		WHEN @Level=147 THEN CAST(@exp AS NUMERIC(12,0)) / 	276670531087.0 * 100 	
		WHEN @Level=148 THEN CAST(@exp AS NUMERIC(12,0)) / 	304780257046.0 * 100 	
		WHEN @Level=149 THEN CAST(@exp AS NUMERIC(12,0)) / 	335745931162.0 * 100 	
		WHEN @Level=150 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=151 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=152 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=153 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=154 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=155 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=156 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=157 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=158 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=159 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=160 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=161 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=162 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=163 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=164 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=165 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=166 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=167 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=168 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=169 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=170 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=171 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=172 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=173 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=174 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=175 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=176 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=177 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=178 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=179 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=180 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=181 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=182 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=183 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=184 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=185 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=186 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=187 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=188 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=189 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=190 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=191 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=192 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=193 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=194 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=195 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=196 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=197 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=198 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=199 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
		WHEN @Level=200 THEN CAST(@exp AS NUMERIC(12,0)) / 	369857717768.0 * 100 	
	    ELSE  0	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EVIDANCE](
	[account] [varchar](32) NOT NULL,
	[gamecode] [char](4) NOT NULL,
	[tester] [char](1) NOT NULL,
	[m_chLoginAuthority] [char](1) NOT NULL,
	[regdate] [datetime] NOT NULL,
	[BlockTime] [char](8) NULL,
	[EndTime] [char](8) NULL,
	[WebTime] [char](8) NULL,
	[isuse] [char](1) NOT NULL,
	[secession] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Event_20090604](
	[account] [varchar](32) NULL,
	[serverindex] [char](2) NULL,
	[m_idPlayer] [char](7) NULL,
	[regdate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUILD_TBL](
	[m_idGuild] [char](6) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[Lv_1] [int] NULL,
	[Lv_2] [int] NULL,
	[Lv_3] [int] NULL,
	[Lv_4] [int] NULL,
	[Pay_0] [int] NULL,
	[Pay_1] [int] NULL,
	[Pay_2] [int] NULL,
	[Pay_3] [int] NULL,
	[Pay_4] [int] NULL,
	[m_szGuild] [varchar](48) NULL,
	[m_nLevel] [int] NULL,
	[m_nGuildGold] [bigint] NULL,
	[m_nGuildPxp] [int] NULL,
	[m_nWin] [int] NULL,
	[m_nLose] [int] NULL,
	[m_nSurrender] [int] NULL,
	[m_nWinPoint] [int] NULL,
	[m_dwLogo] [int] NULL,
	[m_szNotice] [varchar](127) NULL,
	[isuse] [char](1) NULL,
	[CreateTime] [datetime] NULL,
	[serverindex_old] [char](2) NULL,
	[m_idGuild_old] [char](6) NULL,
	[tKeepTime] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [GUILD_ID1] ON [dbo].[GUILD_TBL] 
(
	[m_idGuild] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[level](
	[Col001] [int] NULL,
	[Col002] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JOB_SKILL_TBL](
	[m_nJob] [int] NOT NULL,
	[SkillID] [int] NOT NULL,
	[SkillPosition] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ITEM_SEND_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[Item_Name] [varchar](32) NOT NULL,
	[Item_count] [int] NOT NULL,
	[m_nAbilityOption] [int] NOT NULL,
	[m_nNo] [int] IDENTITY(1,1) NOT NULL,
	[End_Time] [char](8) NULL,
	[m_bItemResist] [int] NOT NULL,
	[m_nResistAbilityOption] [int] NOT NULL,
	[m_bCharged] [int] NOT NULL,
	[idSender] [char](7) NULL,
	[nPiercedSize] [int] NOT NULL,
	[adwItemId0] [int] NOT NULL,
	[adwItemId1] [int] NOT NULL,
	[adwItemId2] [int] NOT NULL,
	[adwItemId3] [int] NOT NULL,
	[m_dwKeepTime] [bigint] NOT NULL,
	[nRandomOptItemId] [bigint] NULL,
	[ItemFlag] [int] NOT NULL,
	[ReceiveDt] [datetime] NOT NULL,
	[ProvideDt] [datetime] NULL,
	[SendComment] [varchar](20) NOT NULL,
	[adwItemId5] [int] NULL,
	[adwItemId6] [int] NULL,
	[adwItemId7] [int] NULL,
	[adwItemId8] [int] NULL,
	[adwItemId9] [int] NULL,
	[nUMPiercedSize] [int] NULL,
	[adwUMItemId0] [int] NULL,
	[adwUMItemId1] [int] NULL,
	[adwUMItemId2] [int] NULL,
	[adwUMItemId3] [int] NULL,
	[adwUMItemId4] [int] NULL,
	[adwItemId4] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IDX_ITEM_SEND_nNo] ON [dbo].[ITEM_SEND_TBL] 
(
	[m_nNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ITEM_SEND_ID1] ON [dbo].[ITEM_SEND_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ITEM_REMOVE_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[Item_Name] [varchar](32) NOT NULL,
	[m_nAbilityOption] [int] NOT NULL,
	[Item_count] [int] NOT NULL,
	[State] [char](1) NOT NULL,
	[m_nNo] [int] IDENTITY(1,1) NOT NULL,
	[End_Time] [char](8) NOT NULL,
	[m_bItemResist] [int] NOT NULL,
	[m_nResistAbilityOption] [int] NOT NULL,
	[ItemFlag] [int] NOT NULL,
	[ReceiveDt] [datetime] NOT NULL,
	[DeleteDt] [datetime] NULL,
	[RequestUser] [varchar](30) NOT NULL,
	[RandomOption] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ITEM_REMOVE_ID1] ON [dbo].[ITEM_REMOVE_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[INVENTORY_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[m_Inventory] [varchar](6000) NULL,
	[m_apIndex] [varchar](500) NULL,
	[m_adwEquipment] [varchar](500) NULL,
	[m_dwObjIndex] [varchar](512) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [INVENTORY_ID1] ON [dbo].[INVENTORY_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[INVENTORY_EXT_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[m_extInventory] [varchar](1296) NULL,
	[m_InventoryPiercing] [varchar](1872) NULL,
	[szInventoryPet] [varchar](4200) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [INVENTORY_EXT_ID1] ON [dbo].[INVENTORY_EXT_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUILD_WAR_TBL](
	[m_idGuild] [char](6) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_idWar] [int] NULL,
	[f_idGuild] [char](6) NULL,
	[m_nDeath] [int] NULL,
	[m_nSurrender] [int] NULL,
	[m_nCount] [int] NULL,
	[m_nAbsent] [int] NULL,
	[f_nDeath] [int] NULL,
	[f_nSurrender] [int] NULL,
	[f_nCount] [char](10) NULL,
	[f_nAbsent] [int] NULL,
	[State] [char](1) NULL,
	[StartTime] [char](12) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [GUILD_WAR_ID1] ON [dbo].[GUILD_WAR_TBL] 
(
	[m_idWar] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUILD_BANK_EXT_TBL](
	[m_idGuild] [char](6) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_extGuildBank] [varchar](1296) NULL,
	[m_GuildBankPiercing] [varchar](1872) NULL,
	[szGuildBankPet] [varchar](4200) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [GUILD_BANK_EXT_ID1] ON [dbo].[GUILD_BANK_EXT_TBL] 
(
	[m_idGuild] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getQuest](@str1 varchar(8000))
returns int
as
begin


declare @return int
declare @tmp table (no int null)

--declare @str1 varchar(8000)
declare @str2 varchar(8000)
--set @str1 = '22, 14, 0/20, 14, 0/21, 14, 0/100, 14, 0/19, 0, 0/107, 0, 0/4, 14, 0/2009, 0, 0/$'
declare @str1_s int,@str1_e int
declare @str2_s int,@str2_e int
declare @i int

set @str1_s = 1
while 1=1
begin
set @str1_e = charindex('/',@str1 ,@str1_s)
if @str1_e < 1 
break

set @str2 = SUBSTRING(@str1,@str1_s,@str1_e-@str1_s)

set @str2_s = 1
set @i = 1
	while 1=1
		begin
		set @str2_e = charindex(',',@str2 ,@str2_s)
		if @str2_e < 1 
		break
		
		if @i = 1
		begin
		insert @tmp
		(no)
		select SUBSTRING(@str2,@str2_s,@str2_e-@str2_s)
		end
		set @str2_s = @str2_e + 1
		set @i = @i + 1
		end



set @str1_s = @str1_e + 1
end

if exists(select * from @tmp where no between 100 and 200)
select @return = 1
else
select @return = 0

return @return

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GET_INSERT_SCRIPT_STR]
@tbl_name VARCHAR(128) 
AS
/*

     email : beatchoi@yahoo.co.kr
     Program : Sukjoon Choi
     Date : 2005.4.29
*/


-- DECLARE @tbl_name VARCHAR(128)
-- 
-- SET @tbl_name = 'sysfiles'

DECLARE @column VARCHAR(8000)
DECLARE @value VARCHAR(8000)

DECLARE @columnsStr VARCHAR(8000)
DECLARE @valuesStr VARCHAR(8000)

SET @column = ''
SET @value = ''
SET @columnsStr = ''
SET @valuesStr = ''

DECLARE TBL_Column_Cursor CURSOR 
FOR 
SELECT 
[column] = QUOTENAME(a.name) + ',',
[value] = CASE  WHEN b.xprec = 23 
                        THEN   ''''''' + CONVERT(VARCHAR,(ISNULL('+ a.name + ',''''))) + '''''
                        WHEN b.xprec = 0 
                        THEN   ''''''' + ISNULL('+ a.name + ','''') + '''''  
                        ELSE  ''' + CONVERT(VARCHAR,(ISNULL('+ a.name + ',''''))) + ' 
              END +''','
FROM syscolumns a,systypes b 
WHERE a.id = object_id( @tbl_name) 
AND a.xtype = b.xtype
ORDER BY  a.colid

OPEN TBL_Column_Cursor

FETCH NEXT FROM TBL_Column_Cursor 
INTO @column,@value

WHILE @@FETCH_STATUS = 0
BEGIN
SET	@columnsStr = @columnsStr + @column
SET	@valuesStr = @valuesStr + @value  

FETCH NEXT FROM TBL_Column_Cursor 
INTO   @column,@value
END

SET @columnsStr = LEFT(@columnsStr,LEN(@columnsStr) -1)
SET @valuesStr = LEFT(@valuesStr,LEN(@valuesStr) -1)

CLOSE TBL_Column_Cursor
DEALLOCATE TBL_Column_Cursor

EXEC('SELECT ''INSERT INTO '  + @tbl_name + ' ('  + @columnsStr + '''' +' + '') VALUES (' + @valuesStr + ')'' 
           FROM  ' +  @tbl_name)

RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[fnTimeFormat] (
    @iTime   INT,
    @iFormat INT
)  
RETURNS VARCHAR(50) 
AS  
BEGIN 
    DECLARE @ret  VARCHAR(50)
    DECLARE @ret1 VARCHAR(50)
    DECLARE @ret2 VARCHAR(50)
    DECLARE @ret3 VARCHAR(50)
    DECLARE @ret4 VARCHAR(50)

    SET @ret  = ''
    SET @ret1 = ''
    SET @ret2 = ''
    SET @ret3 = ''
    SET @ret4 = ''
  
    IF @iTime > 60*60*24   
    BEGIN
        SELECT @ret1  = CAST(FLOOR((@iTime)/(60*60*24)) AS VARCHAR) + 'Day '
        SELECT @iTime = @iTime - FLOOR(@iTime/(60*60*24))*60*60*24
    END

    IF @iTime > 60*60
    BEGIN
        SELECT @ret2  = CAST(FLOOR((@iTime)/(60*60)) AS VARCHAR) + 'Hour'
        SELECT @iTime = @iTime - FLOOR(@iTime/(60*60))*60*60
    END

    IF @iTime > 60
    BEGIN
        SELECT @ret3  = CAST(FLOOR((@iTime)/(60)) AS VARCHAR) + 'Min '
        SELECT @iTime = @iTime - FLOOR(@iTime/(60))*60
    END

    IF @iTime <> 0
    BEGIN
        SELECT @ret4  = CAST(@iTime AS VARCHAR) + 'Sec'
    END
  
    SELECT @ret = @ret1 + @ret2 + @ret3 + @ret4

    RETURN @ret

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  FUNCTION [dbo].[fnGetRandomOptFromExtInformation] (
		@pItemExtText	varchar(5000)='',	
		@pObjectID		bigint
)
RETURNS bigINT
AS
BEGIN

	IF @pItemExtText=''
		RETURN 0

	DECLARE		@NUMBER_OF_COLUMN	int
	SELECT		@NUMBER_OF_COLUMN=3

	DECLARE		@ItemExtSetStartPos	bigint,
			  	@ItemExtSetEndPos	bigint,
				@ItemExtSetIndex		bigint,
				@ItemExtSetLength	int,
				@ItemExtTextLength	int

	DECLARE		@ItemExtString		varchar(100)
	
    DECLARE		@bCharged			bigint,
				@RandomOpt		bigint,
				@ExpirationDt		bigint

    DECLARE		@ItemString		varchar(500),
				@ItemStringLength 	int


	DECLARE		@ItemElemStartPos	bigint,
				@ItemElemEndPos	bigint,
				@ItemElemLength		int,
				@ItemElemIndex		bigint,
				@ItemElemString		int

	SELECT	@ItemExtTextLength=Len(@pItemExtText), 
	        @ItemExtSetStartPos = 0,                    
			@ItemExtSetEndPos   = -1,
			@ItemExtSetIndex	= -1                   

    WHILE ( @ItemExtSetEndPos <> 0 )	BEGIN
		SELECT @bCharged=0, @RandomOpt=0, @ExpirationDt=0

		SELECT @ItemExtSetStartPos = @ItemExtSetEndPos+1
        SELECT @ItemExtSetEndPos = CHARINDEX('/', @pItemExtText, @ItemExtSetStartPos)
		SELECT @ItemExtSetIndex = @ItemExtSetIndex + 1
		
		IF @ItemExtSetEndPos=0 BREAK

        SELECT @ItemExtSetLength = @ItemExtSetEndPos - @ItemExtSetStartPos
        
        IF (@ItemExtSetEndPos>@ItemExtTextLength) 
			BREAK
		ELSE BEGIN
			SELECT @ItemExtString = SUBSTRING(@pItemExtText, @ItemExtSetStartPos, @ItemExtSetLength)
    
            SET	@ItemElemStartPos	= 1
            SET	@ItemElemEndPos		= 0
            SET	@ItemElemIndex		= 0

			SELECT @ItemElemEndPos=CHARINDEX(',',@ItemExtString, 1)
			SET @bCharged = SUBSTRING(@ItemExtString, @ItemElemStartPos, @ItemElemEndPos-@ItemElemStartPos)

			SET @ItemElemStartPos=@ItemElemEndPos+1

			SELECT @ItemElemEndPos=CHARINDEX(',', @ItemExtString, @ItemElemStartPos)
		
			IF @ItemElemEndPos>0 BEGIN
				SET @ExpirationDt = SUBSTRING(@ItemExtString, @ItemElemStartPos, @ItemElemEndPos-@ItemElemStartPos)
			
				SET @ItemElemStartPos=@ItemElemEndPos+1
				SELECT @ItemElemEndPos = Len(@ItemExtString)+1
				SET @RandomOpt = SUBSTRING(@ItemExtString, @ItemElemStartPos, @ItemElemEndPos-@ItemElemStartPos)
			END				
			ELSE BEGIN
				SELECT @ItemElemEndPos = Len(@ItemExtString)+1
				SET @ExpirationDt = SUBSTRING(@ItemExtString, @ItemElemStartPos, @ItemElemEndPos-@ItemElemStartPos)
			END
			

			IF(@ItemExtSetIndex=@pObjectID) BEGIN
				RETURN @RandomOpt
			END
		END
    END

	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE    FUNCTION [dbo].[fnGetPattern] (
    @iData   VARCHAR(3000),
    @iValue  VARCHAR(1)
)  
RETURNS INT
AS  
BEGIN 

    DECLARE @len INT, @cur INT, @ret INT
    SET     @cur = 1
    SET     @ret = 0
    SET     @len = LEN(@iData)

                WHILE ( @cur <> @len )
                BEGIN
                    IF ( SUBSTRING(@iData, @cur, 1) = @iValue )
                    BEGIN
                        SET @ret = @ret + 1
                    END
                    SET @cur = @cur + 1
                END

  RETURN @ret
END


-- SELECT dbo.fnGetPattern('/1/-1/-1/-1/-1/-1/-1/-1/$', '/')
--SELECT substring('A/1/-1/-1/-1/-1/-1/-1/-1/$', 5, 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  FUNCTION [dbo].[fnFromJuminGetCode1] (
    @iJumin   CHAR(2),
    @iFormat INT
)  
RETURNS CHAR(1)
AS  
BEGIN 
  RETURN
  CASE 
    WHEN @iJumin >= '94' AND @iJumin <= '04'  THEN 'A'        --  0 - 11세
    WHEN @iJumin >= '87' AND @iJumin <= '93'  THEN 'B'        -- 12 - 18세
    WHEN @iJumin >= '82' AND @iJumin <= '86'  THEN 'C'        -- 19 - 23세
    WHEN @iJumin >= '77' AND @iJumin <= '81'  THEN 'D'        -- 24 - 28세
    WHEN @iJumin >= '70' AND @iJumin <= '76'  THEN 'E'        -- 29 - 35세
    WHEN @iJumin >= '05' AND @iJumin <= '69'  THEN 'F'        -- 36 -   세
    ELSE                                           'N'        -- NOT DEFINED
  END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[fnFromJuminGetCode] (
    @iJumin   CHAR(2),
    @iFormat INT
)  
RETURNS CHAR(1)
AS  
BEGIN 
  RETURN
  CASE 
    WHEN @iJumin >= '94' AND @iJumin <= '04'  THEN 'A'        --  0 - 11세
    WHEN @iJumin >= '87' AND @iJumin <= '93'  THEN 'B'        -- 12 - 18세
    WHEN @iJumin >= '82' AND @iJumin <= '86'  THEN 'C'        -- 19 - 23세
    WHEN @iJumin >= '77' AND @iJumin <= '81'  THEN 'D'        -- 24 - 28세
    WHEN @iJumin >= '70' AND @iJumin <= '76'  THEN 'E'        -- 29 - 35세
    WHEN @iJumin >= '05' AND @iJumin <= '69'  THEN 'F'        -- 36 -   세
    ELSE                                           'N'        -- NOT DEFINED
  END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    FUNCTION [dbo].[fnDateFormat] (
    @iDate   VARCHAR(14),
    @iFormat INT
)  
RETURNS VARCHAR(50) 
AS  
BEGIN 
  RETURN
  CASE 
    WHEN @iFormat = 0 THEN        -- YYYY년 MM월 DD일 HH시 MM분 SS초
                SUBSTRING(@iDate,  1, 4) + '년 ' + 
                SUBSTRING(@iDate,  5, 2) + '월 ' + 
                SUBSTRING(@iDate,  7, 2) + '일 ' + 
                SUBSTRING(@iDate,  9, 2) + '시 ' + 
                SUBSTRING(@iDate, 11, 2) + '분 ' + 
                SUBSTRING(@iDate, 13, 2) + '초'
    WHEN @iFormat = 1 THEN         -- YY/MM/DD HH:MM:SS
                SUBSTRING(@iDate,  3, 2) + '/' + 
                SUBSTRING(@iDate,  5, 2) + '/' + 
                SUBSTRING(@iDate,  7, 2) + ' ' + 
                SUBSTRING(@iDate,  9, 2) + ':' + 
                SUBSTRING(@iDate, 11, 2) + ':' + 
                SUBSTRING(@iDate, 13, 2)
    WHEN @iFormat = 2 THEN         -- YY/MM/DD HH시
                SUBSTRING(@iDate,  3, 2) + '/' + 
                SUBSTRING(@iDate,  5, 2) + '/' + 
                SUBSTRING(@iDate,  7, 2) + ' ' + 
                SUBSTRING(@iDate,  9, 2) + '시'
    WHEN @iFormat = 3 THEN         -- YY/MM/DD
                SUBSTRING(@iDate,  3, 2) + '/' + 
                SUBSTRING(@iDate,  5, 2) + '/' + 
                SUBSTRING(@iDate,  7, 2)
    WHEN @iFormat = 4 THEN         -- MM/DD HH:MM:SS
                SUBSTRING(@iDate,  5, 2) + '/' + 
                SUBSTRING(@iDate,  7, 2) + ' ' + 
                SUBSTRING(@iDate,  9, 2) + ':' + 
                SUBSTRING(@iDate, 11, 2) + ':' + 
                SUBSTRING(@iDate, 13, 2)
    WHEN @iFormat = 5 THEN         -- MM/DD HH:MM:SS
                SUBSTRING(@iDate,  1, 4) + '/' + 
                SUBSTRING(@iDate,  5, 2) + '/' + 
                SUBSTRING(@iDate,  7, 2) + ' ' + 
                SUBSTRING(@iDate,  9, 2) + ':' + 
                SUBSTRING(@iDate, 11, 2) 
    ELSE     'Not Define iFormat'
  END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_job](@m_nJob int)
returns varchar(50)
as
begin
return
	case when @m_nJob = 0 then 'Vagarant'
		when @m_nJob = 1 then 'Mecenary'
		when @m_nJob = 2 then 'Acrobat'
		when @m_nJob = 3 then 'Assist'
		when @m_nJob = 4 then 'Magician'
		when @m_nJob = 6 then 'Knight'
		when @m_nJob = 7 then 'Blade'
		when @m_nJob = 8 then 'Jester'
		when @m_nJob = 9 then 'Ranger'
		when @m_nJob = 10 then 'Ringmaster'
		when @m_nJob = 11 then 'Billposter'
		when @m_nJob = 12 then 'Psykeeper'
		when @m_nJob = 13 then 'Elementer'
		when @m_nJob = 16 then 'Master Knight'
		when @m_nJob = 17 then 'Master Blade'
		when @m_nJob = 18 then 'Master Jester'
		when @m_nJob = 19 then 'Master Ranger'
		when @m_nJob = 20 then 'Master Ringmaster'
		when @m_nJob = 21 then 'Master Billposter'
		when @m_nJob = 22 then 'Master Psykeeper'
		when @m_nJob = 23 then 'Master Elementer'
		when @m_nJob = 24 then 'Hero Knight'
		when @m_nJob = 25 then 'Hero Blade'
		when @m_nJob = 26 then 'Hero Jester'
		when @m_nJob = 27 then 'Hero Ranger'
		when @m_nJob = 28 then 'Hero Ringmaster'
		when @m_nJob = 29 then 'Hero Billposter'
		when @m_nJob = 30 then 'Hero Psykeeper'
		when @m_nJob = 31 then 'Hero Elementer'
		else 'Not Define' end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_ItemResist] (@iResist int)  
returns varchar(50)
as
begin  
/*********************************************************************************
m_bItemResist : 속성 (예> 불, 물, 바람, 땅 )	속성
>  // * 타입 없음. : 0	무(無)
>  // * 불   속성 : 1	불(火)
>  // * 물   속성 : 2	물(水)
>  // * 전기 속성 : 3	전기(電)
>  // * 바람 속성 : 4	바람(風)
>  // * 땅   속성 : 5	땅(土)
**********************************************************************************/
declare @ret varchar(50)

if @iResist is null
	set @ret = ''
else
	select @ret =  case @iResist
			when 0 then '무(無)'
			when 1 then '불(火)'
			when 2 then '물(水)'
			when 3 then '전기(電)'
			when 4 then '바람(風)'
			when 5 then '땅(土)'
			else convert(varchar(50), @iResist)
			end
return @ret
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_item2row]
(@m_idPlayer char(7),@serverindex char(2),@arr_item varchar(6000))
returns @item_row table (m_idPlayer char(7),serverindex char(2),m_dwObjId int,m_dwItemId int, m_nItemNum int, m_nUniqueNo bigint, m_nAbilityOption int, ItemResist int, ResistAbilityOpt int)
as
begin

declare @item varchar(255),@item_property varchar(50)
declare @pos_s int,@pos_e int
declare @pos_sub_s int,@pos_sub_e int

declare @m_dwobjid varchar(11)
declare @m_dwitemid varchar(11)
declare @m_nitemnum varchar(11)
declare @m_nUniqueNo varchar(11)
declare @m_nabilityoption varchar(11)
--------------------------------------------------
/*	추가부분	Start				*/
--------------------------------------------------
declare @ItemResist varchar(11)
declare @ResistAbilityOpt varchar(11)
--------------------------------------------------
/*	추가부분	End				*/
--------------------------------------------------

declare @idx int

set @pos_e = 1
while 1=1
begin
set @pos_s = charindex('/',@arr_item,@pos_e)

if @pos_s = 0
break
  set @item = substring(@arr_item,@pos_e,@pos_s-@pos_e)
  set @pos_sub_e = 1
  set @idx = 1
  while @idx <= 15  --   <- 13에서 15로 수정
     begin
       set @pos_sub_s = charindex(',',@item,@pos_sub_e)
       if @pos_sub_s = 0
       break
       set @item_property = substring(@item,@pos_sub_e,@pos_sub_s-@pos_sub_e)

	   if @idx = 1
          set @m_dwobjid = @item_property
       if @idx = 2
          set @m_dwitemid = @item_property
       if @idx = 6
          set @m_nitemnum = @item_property
       if @idx=12
	set @m_nUniqueNo=@item_property
       if @idx = 13
          set @m_nabilityoption = @item_property
--------------------------------------------------
/*	추가부분	Start				*/
--------------------------------------------------
       if @idx = 14
	set @ItemResist = @item_property
       if @idx = 15
	set @ResistAbilityOpt = @item_property
--------------------------------------------------
/*	추가부분	End				*/
--------------------------------------------------

       set @idx = @idx + 1
       set @pos_sub_e = @pos_sub_s + 1 

     end
     if not exists(select * from @item_row where m_dwObjId = @m_dwobjid) and @m_dwobjid is not null and @m_dwitemid is not null
     insert @item_row
     values
     (@m_idPlayer,@serverindex,@m_dwobjid,@m_dwitemid,@m_nitemnum,@m_nUniqueNo, @m_nabilityoption, @ItemResist, @ResistAbilityOpt)

set @pos_e = @pos_s + 1 
end
return 
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[fn_HI_Kind]
(
    @hkind int
)
RETURNS VARCHAR(50)
AS
BEGIN

	DECLARE @ret VARCHAR(50)

	IF @hkind IS NULL
		SET @ret = ''
	ELSE
		SELECT @ret =  CASE @hkind
			WHEN 0 THEN '채집의 달인'	-- HS_COLLECT
			WHEN 1 THEN '장사의 달인'	-- HS_TRADE
			WHEN 2 THEN '알 부화의 달인'	-- HS_HATCHING_EGG
			WHEN 3 THEN '카사노바'		-- HS_COUPLE_COUNT
			WHEN 4 THEN '위대한 커플'	-- HS_COUPLE_LV
			WHEN 5 THEN '무시무시한놈'	-- HS_PK_COUNT
			WHEN 6 THEN '힘의 달인'		-- HS_STR
			WHEN 7 THEN '체력의 달인'	-- HS_STA
			WHEN 8 THEN '민첩의 달인'	-- HS_DEX
			WHEN 9 THEN '지능의 달인'	-- HS_INT
			WHEN 10 THEN '초보 파이터'	-- HS_PVP_POINT01
			WHEN 11 THEN '견습 파이터'	-- HS_PVP_POINT02
			WHEN 12 THEN '노력하는 파이터'	-- HS_PVP_POINT03
			WHEN 13 THEN '패기있는 파이터'	-- HS_PVP_POINT04
			WHEN 14 THEN '알려진 파이터'	-- HS_PVP_POINT05
			WHEN 15 THEN '강한 파이터'	-- HS_PVP_POINT06
			WHEN 16 THEN '유명한 파이터'	-- HS_PVP_POINT07
			WHEN 17 THEN '훌륭한 파이터'	-- HS_PVP_POINT08
			WHEN 18 THEN '인기많은 파이터'	-- HS_PVP_POINT09
			WHEN 19 THEN '최강의 파이터'	-- HS_PVP_POINT10
			WHEN 20 THEN '나이트 마스터'	-- JOB_KNIGHT_MASTER
			WHEN 21 THEN '블레이드 마스터'	-- JOB_BLADE_MASTER
			WHEN 22 THEN '제스터 마스터'	-- JOB_JESTER_MASTER
			WHEN 23 THEN '레인저 마스터'	-- JOB_RANGER_MASTER
			WHEN 24 THEN '링마스터 마스터'	-- JOB_RINGMASTER_MASTER
			WHEN 25 THEN '빌포스터 마스터'	-- JOB_BILLPOSTER_MASTER
			WHEN 26 THEN '싸이키퍼 마스터'	-- JOB_PSYCHIKEEPER_MASTER
			WHEN 27 THEN '엘리멘터 마스터'	-- JOB_ELEMENTOR_MASTER
			WHEN 28 THEN '나이트 히어로'	-- JOB_KNIGHT_HERO
			WHEN 29 THEN '블레이드 히어로'	-- JOB_BLADE_HERO
			WHEN 30 THEN '제스터 히어로'	-- JOB_JESTER_HERO
			WHEN 31 THEN '레인저 히어로'	-- JOB_RANGER_HERO
			WHEN 32 THEN '링마스터 히어로'	-- JOB_RINGMASTER_HERO
			WHEN 33 THEN '빌포스터 히어로'	-- JOB_BILLPOSTER_HERO
			WHEN 34 THEN '싸이키퍼 히어로'	-- JOB_PSYCHIKEEPER_HERO
			WHEN 35 THEN '엘리멘터 히어로'	-- JOB_ELEMENTOR_HERO
			WHEN 36 THEN '군주'		-- HS_LORD
			WHEN 37 THEN '점프의달인'	-- HS_JUMP
			WHEN 38 THEN '회색 알약 중독자'	-- II_GEN_FOO_PIL_GRAY
			WHEN 39 THEN '노란 알약 중독자'	-- II_GEN_FOO_PIL_YELLOW
			WHEN 40 THEN '파란 알약 중독자'	-- II_GEN_FOO_PIL_BLUE
			WHEN 41 THEN '붉은 알얄 중독자'	-- II_GEN_FOO_PIL_RED
			WHEN 42 THEN '황금 알약 중독자'	-- II_GEN_FOO_PIL_GOLD
			WHEN 43 THEN '신비한 알약 중독자'	-- II_GEN_FOO_PIL_SINBI
			WHEN 44 THEN '막대사탕 중독자'	-- II_GEN_FOO_INS_LOLLIPOP
			WHEN 45 THEN '비스킷 중독자'	-- II_GEN_FOO_INS_BISCUIT
			WHEN 46 THEN '초콜릿 바 중독자'	-- II_GEN_FOO_INS_CHOCOLATE
			WHEN 47 THEN '우유 중독자'	-- II_GEN_FOO_INS_MILK
			WHEN 48 THEN '식빵 중독자'	-- II_GEN_FOO_INS_BREAD
			WHEN 49 THEN '핫도그 중독자'	-- II_GEN_FOO_INS_HOTDOG
			WHEN 50 THEN '호떡 중독자'	-- II_GEN_FOO_INS_HODDUK
			WHEN 51 THEN '김밥 중독자'	-- II_GEN_FOO_INS_KIMBAP
			WHEN 52 THEN '닭다리 중독자'	-- II_GEN_FOO_INS_CHICKENSTICK
			WHEN 53 THEN '별사탕 중독자'	-- II_GEN_FOO_INS_STARCANDY
			WHEN 54 THEN '꼬치 중독자'	-- II_GEN_FOO_COO_MEATSKEWER
			WHEN 55 THEN '바베큐 중독자'	-- II_GEN_FOO_COO_BARBECUE
			WHEN 56 THEN '해물파전 중독자'	-- II_GEN_FOO_COO_SEAFOODPANCAKE
			WHEN 57 THEN '생선스프 중독자'	-- II_GEN_FOO_COO_FISHSOUP
			WHEN 58 THEN '소시지전골 중독자'	-- II_GEN_FOO_COO_SAUSAGECASSEROLE
			WHEN 59 THEN '생선스튜 중독자'	-- II_GEN_FOO_COO_FISHSTEW
			WHEN 60 THEN '해물찜 중독자'	-- II_GEN_FOO_COO_STEAMEDSEAFOOD
			WHEN 61 THEN '고기샐러드 중독자'	-- II_GEN_FOO_COO_MEATSALAD
			WHEN 62 THEN '그라탕 중독자'	-- II_GEN_FOO_COO_GRATIN
			WHEN 63 THEN '해물피자 중독자'	-- II_GEN_FOO_COO_SEAFOODPIZZA
			WHEN 64 THEN '오렌지주스 중독자'	-- II_GEN_FOO_ICE_ORANGEJUIICE
			WHEN 65 THEN '딸기쉐이크 중독자'	-- II_GEN_FOO_ICE_STRAWBERRYSHAKE
			WHEN 66 THEN '파인애플콘 중독자'	-- II_GEN_FOO_ICE_PINEAPPLECONE
			WHEN 67 THEN '바나나쭈쭈바 중독자'	-- II_GEN_FOO_ICE_BANANAJUJUBAR
			WHEN 68 THEN '과일주스 중독자'	-- II_GEN_FOO_ICE_FRUITJUICE
			WHEN 69 THEN '과일빙수 중독자'	-- II_GEN_FOO_ICE_FRUITICEWATER
			WHEN 70 THEN '과일파르페 중독자'	-- II_GEN_FOO_ICE_FRUITPARFAIT
			WHEN 71 THEN '과일샤벳 중독자'	-- II_GEN_FOO_ICE_FRUITSHERBET
			WHEN 72 THEN '아이스크림케익 중독자'	-- II_GEN_FOO_ICE_ICECREAMCAKE
			WHEN 73 THEN '과일화채 중독자'	-- II_GEN_FOO_ICE_FRUITPUNCH
			WHEN 74 THEN '아이바트 눈알 빼먹는'	-- MI_AIBATT2
			WHEN 75 THEN '라울프를 바비큐 해먹는'	-- MI_LAWOLF2

			WHEN 76 THEN '카드퍼펫의 주인님'	-- MI_CARDPUPPET2
			WHEN 77 THEN '글라팬이 벌벌떠는'	-- MI_GLAPHAN2
			WHEN 78 THEN '용 사냥꾼'	-- MI_DU_METEONYKER
			WHEN 79 THEN '싸이클롭스X 가 인정한'	-- MI_CYCLOPSX
			WHEN 80 THEN '예티 사냥꾼'	-- MI_NPC_YETI01
			WHEN 81 THEN '예티가 펫인줄 아는'	-- MI_NPC_YETI02
			WHEN 82 THEN '아우구 헌터'	-- MI_NPC_AUGOO01
			WHEN 83 THEN '아우구를 구워먹는'	-- MI_NPC_AUGOO02
			WHEN 84 THEN '유령 사냥꾼'	-- MI_NPC_SADKING01
			WHEN 85 THEN '유령도 벌벌떠는'	-- MI_NPC_SADKING02
			WHEN 86 THEN '메머드 사냥꾼'	-- MI_NPC_MAMMOTH01
			WHEN 87 THEN '메머드로 훈제 해먹는'	-- MI_NPC_MAMMOTH02
			WHEN 88 THEN '킹스터 수염뽑아 노는'	-- MI_KINGSTER02
			WHEN 89 THEN '크라켄 으로 튀김 해먹는'	-- MI_KRAKEN02
			WHEN 90 THEN '크레퍼로 맛살 해먹는'	-- MI_CREPER02
			WHEN 91 THEN '나가로 술 담궈 먹는'	-- MI_NAGA02
			WHEN 92 THEN '아트록스를 벌레 잡듯 잡는'	-- MI_ATROX02
			WHEN 93 THEN '오케안을 불태운'	-- MI_OKEAN02
			WHEN 94 THEN '타이가를 애완동물 삼은'	-- MI_TAIGA02
			WHEN 95 THEN '도리안으로 회 떠먹는'	-- MI_DORIAN02
			WHEN 96 THEN '머럴이 두려워하는'	-- MI_MEREL02
			WHEN 97 THEN '클락워크를 굴복시킨'	-- MI_CLOCKWORK1
			WHEN 98 THEN '진정한 용 사냥꾼'	-- MI_DU_METEONYKER2
			ELSE CONVERT(VARCHAR(50), @hkind)
	END
	RETURN @ret
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_GuildGold] (@m_nGuildGold int)
returns bigint
as
begin
	declare @result bigint
	if @m_nGuildGold >= 0
	begin
		select @result =  @m_nGuildGold
	end
	else
	begin
		select @result =  2147483647 - cast(@m_nGuildGold as bigint)
	end
	return @result
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUILD_MEMBER_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[m_idGuild] [char](6) NOT NULL,
	[m_szAlias] [varchar](20) NULL,
	[m_nWin] [int] NULL,
	[m_nLose] [int] NULL,
	[m_nSurrender] [int] NULL,
	[m_nMemberLv] [int] NULL,
	[m_nGiveGold] [bigint] NULL,
	[m_nGivePxp] [int] NULL,
	[m_idWar] [int] NULL,
	[m_idVote] [int] NULL,
	[isuse] [char](1) NULL,
	[CreateTime] [datetime] NULL,
	[m_nClass] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [GUILD_MEMBER_ID1] ON [dbo].[GUILD_MEMBER_TBL] 
(
	[m_idPlayer] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUILD_COMBAT_1TO1_TENDER_TBL](
	[serverindex] [char](2) NOT NULL,
	[combatID] [int] NOT NULL,
	[m_idGuild] [char](6) NOT NULL,
	[m_nPenya] [int] NOT NULL,
	[s_date] [datetime] NOT NULL,
	[State] [char](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUILD_COMBAT_1TO1_BATTLE_TBL](
	[serverindex] [char](2) NOT NULL,
	[combatID] [int] NOT NULL,
	[m_idWorld] [int] NOT NULL,
	[Start_Time] [datetime] NOT NULL,
	[End_Time] [datetime] NULL,
	[m_idGuild_1st] [char](6) NOT NULL,
	[m_idGuild_2nd] [char](6) NOT NULL,
	[State] [char](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [Guild_BATTLE_ID1] ON [dbo].[GUILD_COMBAT_1TO1_BATTLE_TBL] 
(
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Guild_BATTLE_ID2] ON [dbo].[GUILD_COMBAT_1TO1_BATTLE_TBL] 
(
	[combatID] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Guild_BATTLE_ID3] ON [dbo].[GUILD_COMBAT_1TO1_BATTLE_TBL] 
(
	[m_idWorld] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Guild_BATTLE_ID4] ON [dbo].[GUILD_COMBAT_1TO1_BATTLE_TBL] 
(
	[m_idGuild_1st] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Guild_BATTLE_ID5] ON [dbo].[GUILD_COMBAT_1TO1_BATTLE_TBL] 
(
	[m_idGuild_2nd] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Guild_BATTLE_ID6] ON [dbo].[GUILD_COMBAT_1TO1_BATTLE_TBL] 
(
	[State] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Guild_BATTLE_ID7] ON [dbo].[GUILD_COMBAT_1TO1_BATTLE_TBL] 
(
	[Start_Time] DESC,
	[End_Time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUILD_COMBAT_1TO1_BATTLE_PERSON_TBL](
	[serverindex] [char](2) NOT NULL,
	[combatID] [int] NOT NULL,
	[m_idGuild] [char](6) NOT NULL,
	[m_idPlayer] [char](7) NOT NULL,
	[m_nSeq] [int] NULL,
	[Start_Time] [datetime] NULL,
	[End_Time] [datetime] NULL,
	[State] [char](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUILD_BANK_TBL](
	[m_idGuild] [char](6) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_apIndex] [varchar](215) NULL,
	[m_dwObjIndex] [varchar](215) NULL,
	[m_GuildBank] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [GUILD_BANK_ID1] ON [dbo].[GUILD_BANK_TBL] 
(
	[m_idGuild] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[chkHanguel](@str nvarchar(1000))
returns int
as
begin
declare @i int,@j nchar(1),@ret int
set @i = 1
set @j = ''
set @ret =0

set @str = rtrim(ltrim(@str))

while @i <= len(@str)
	begin
		set @j = substring(@str,@i,1)
		
		if charindex(@j,N'!"#$%& ''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~',1) > 0
		select @ret = @ret + 1

		set @i = @i + 1
	end


if len(@str) = @ret
set @ret = 1
else
set @ret = 0

return @ret
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHARACTER_TBL_validity_check](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NULL,
	[account] [varchar](32) NULL,
	[m_szName] [varchar](32) NULL,
	[TotalPlayTime] [bigint] NULL,
	[m_dwGold] [int] NULL,
	[m_nLevel] [int] NULL,
	[m_nJob] [int] NULL,
	[sum_ability] [int] NULL,
	[CreateTime] [datetime] NULL,
	[regdate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHARACTER_TBL_penya_check](
	[account] [varchar](32) NULL,
	[m_szName] [varchar](32) NULL,
	[m_dwGold] [int] NULL,
	[s_date] [datetime] NULL,
	[check_sec] [int] NULL,
	[serverindex] [char](2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHARACTER_TBL_DEL](
	[serverindex] [char](2) NULL,
	[m_idPlayer] [char](7) NULL,
	[m_szName] [varchar](32) NULL,
	[account] [varchar](32) NULL,
	[m_nLevel] [int] NULL,
	[m_nJob] [int] NULL,
	[CreateTime] [datetime] NULL,
	[deldate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHARACTER_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[account] [varchar](32) NOT NULL,
	[m_szName] [varchar](32) NULL,
	[playerslot] [int] NULL,
	[dwWorldID] [int] NULL,
	[m_dwIndex] [int] NULL,
	[m_vScale_x] [real] NULL,
	[m_dwMotion] [int] NULL,
	[m_vPos_x] [real] NULL,
	[m_vPos_y] [real] NULL,
	[m_vPos_z] [real] NULL,
	[m_fAngle] [real] NULL,
	[m_szCharacterKey] [varchar](32) NULL,
	[m_nHitPoint] [int] NULL,
	[m_nManaPoint] [int] NULL,
	[m_nFatiguePoint] [int] NULL,
	[m_nFuel] [int] NULL,
	[m_dwSkinSet] [int] NULL,
	[m_dwHairMesh] [int] NULL,
	[m_dwHairColor] [int] NULL,
	[m_dwHeadMesh] [int] NULL,
	[m_dwSex] [int] NULL,
	[m_dwRideItemIdx] [int] NULL,
	[m_dwGold] [int] NULL,
	[m_nJob] [int] NULL,
	[m_pActMover] [varchar](50) NULL,
	[m_nStr] [int] NULL,
	[m_nSta] [int] NULL,
	[m_nDex] [int] NULL,
	[m_nInt] [int] NULL,
	[m_nLevel] [int] NULL,
	[m_nMaximumLevel] [int] NULL,
	[m_nExp1] [bigint] NULL,
	[m_nExp2] [bigint] NULL,
	[m_aJobSkill] [varchar](500) NULL,
	[m_aLicenseSkill] [varchar](500) NULL,
	[m_aJobLv] [varchar](500) NULL,
	[m_dwExpertLv] [int] NULL,
	[m_idMarkingWorld] [int] NULL,
	[m_vMarkingPos_x] [real] NULL,
	[m_vMarkingPos_y] [real] NULL,
	[m_vMarkingPos_z] [real] NULL,
	[m_nRemainGP] [int] NULL,
	[m_nRemainLP] [int] NULL,
	[m_nFlightLv] [int] NULL,
	[m_nFxp] [int] NULL,
	[m_nTxp] [int] NULL,
	[m_lpQuestCntArray] [varchar](3072) NULL,
	[m_chAuthority] [char](1) NULL,
	[m_dwMode] [int] NULL,
	[m_idparty] [int] NULL,
	[m_idCompany] [char](6) NULL,
	[m_idMuerderer] [int] NULL,
	[m_nFame] [int] NULL,
	[m_nDeathExp] [bigint] NULL,
	[m_nDeathLevel] [int] NULL,
	[m_dwFlyTime] [int] NULL,
	[m_nMessengerState] [int] NULL,
	[blockby] [varchar](32) NULL,
	[TotalPlayTime] [int] NULL,
	[isblock] [char](1) NULL,
	[End_Time] [char](12) NULL,
	[BlockTime] [char](8) NULL,
	[CreateTime] [datetime] NULL,
	[m_tmAccFuel] [int] NULL,
	[m_tGuildMember] [char](14) NULL,
	[m_dwSkillPoint] [int] NULL,
	[m_aCompleteQuest] [varchar](1024) NULL,
	[m_dwReturnWorldID] [int] NULL,
	[m_vReturnPos_x] [real] NULL,
	[m_vReturnPos_y] [real] NULL,
	[m_vReturnPos_z] [real] NULL,
	[m_szNameCol] [varchar](32) NULL,
	[MultiServer] [int] NULL,
	[SkillPoint] [int] NOT NULL,
	[SkillLv] [int] NOT NULL,
	[SkillExp] [bigint] NOT NULL,
	[dwEventFlag] [bigint] NULL,
	[dwEventTime] [int] NULL,
	[dwEventElapsed] [int] NULL,
	[AngelExp] [bigint] NULL,
	[AngelLevel] [int] NOT NULL,
	[PKValue] [int] NOT NULL,
	[PKPropensity] [int] NOT NULL,
	[PKExp] [int] NOT NULL,
	[m_dwPetId] [int] NULL,
	[m_nExpLog] [int] NULL,
	[m_nAngelExpLog] [int] NULL,
	[m_nCoupon] [int] NOT NULL,
	[serverindex_old] [char](2) NULL,
	[m_idPlayer_old] [char](7) NULL,
	[m_nLayer] [int] NULL,
	[m_nHonor] [int] NULL,
	[m_aCheckedQuest] [varchar](100) NULL,
	[idCampus] [int] NULL,
	[m_nCampusPoint] [int] NULL,
	[tKeepTime] [int] NULL,
	[m_nNumKill] [int] NULL,
	[m_nSlaughter] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [CHARACTER_ID1] ON [dbo].[CHARACTER_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [CHARACTER_ID2] ON [dbo].[CHARACTER_TBL] 
(
	[account] ASC,
	[m_idPlayer] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [CI_CHARACTER_TBL_szName] ON [dbo].[CHARACTER_TBL] 
(
	[m_szName] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_CHARACTER_TBL_old] ON [dbo].[CHARACTER_TBL] 
(
	[serverindex_old] ASC,
	[m_idPlayer_old] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저가 퀘스트 추적기에 등록한 퀘스트 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CHARACTER_TBL', @level2type=N'COLUMN',@level2name=N'm_aCheckedQuest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사제 Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CHARACTER_TBL', @level2type=N'COLUMN',@level2name=N'idCampus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 사제 포인트' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CHARACTER_TBL', @level2type=N'COLUMN',@level2name=N'm_nCampusPoint'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     FUNCTION [dbo].[ChangeTime] (
    @iTime   VARCHAR(14) )

RETURNS VARCHAR(50) 
AS  
BEGIN 
    DECLARE @ret  VARCHAR(30)
    DECLARE @ret1 VARCHAR(4)
    DECLARE @ret2 VARCHAR(2)
    DECLARE @ret3 VARCHAR(2)
    DECLARE @ret4 VARCHAR(2)
    DECLARE @ret5 VARCHAR(2)


    SET @ret  = ''
    SET @ret1 = ''
    SET @ret2 = ''
    SET @ret3 = ''
    SET @ret4 = ''
    SET @ret5 = ''

  
    BEGIN
        SELECT @ret1  = left(@iTime, 4)
        SELECT @ret2  = substring(@iTime, 5, 2)
        SELECT @ret3  = substring(@iTime, 7, 2)
        SELECT @ret4  = substring(@iTime, 9, 2)
        SELECT @ret5  = substring(@iTime, 11, 2)

    END

    SELECT @ret = @ret1 + '-' + @ret2 + '-' + @ret3 + ' ' + @ret4 + ':' + @ret5

    RETURN @ret

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CARD_CUBE_TBL](
	[m_idPlayer] [char](7) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_Card] [varchar](1980) NULL,
	[m_Cube] [varchar](1980) NULL,
	[m_apIndex_Card] [varchar](215) NULL,
	[m_dwObjIndex_Card] [varchar](215) NULL,
	[m_apIndex_Cube] [varchar](215) NULL,
	[m_dwObjIndex_Cube] [varchar](215) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BILING_ITEM_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[m_dwSMTime] [varchar](2560) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [BILING_ITEM_ID1] ON [dbo].[BILING_ITEM_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BASE_VALUE_TBL](
	[g_nSex] [char](1) NULL,
	[m_vScale_x] [real] NULL,
	[m_dwMotion] [int] NULL,
	[m_fAngle] [real] NULL,
	[m_nHitPoint] [int] NULL,
	[m_nManaPoint] [int] NULL,
	[m_nFatiguePoint] [int] NULL,
	[m_dwRideItemIdx] [int] NULL,
	[m_dwGold] [int] NULL,
	[m_nJob] [int] NULL,
	[m_pActMover] [varchar](50) NULL,
	[m_nStr] [int] NULL,
	[m_nSta] [int] NULL,
	[m_nDex] [int] NULL,
	[m_nInt] [int] NULL,
	[m_nLevel] [int] NULL,
	[m_nExp1] [bigint] NULL,
	[m_nExp2] [bigint] NULL,
	[m_aJobSkill] [varchar](500) NULL,
	[m_aLicenseSkill] [varchar](500) NULL,
	[m_aJobLv] [varchar](500) NULL,
	[m_dwExpertLv] [int] NULL,
	[m_idMarkingWorld] [int] NULL,
	[m_vMarkingPos_x] [real] NULL,
	[m_vMarkingPos_y] [real] NULL,
	[m_vMarkingPos_z] [real] NULL,
	[m_nRemainGP] [int] NULL,
	[m_nRemainLP] [int] NULL,
	[m_nFlightLv] [int] NULL,
	[m_nFxp] [int] NULL,
	[m_nTxp] [int] NULL,
	[m_lpQuestCntArray] [varchar](1024) NULL,
	[m_chAuthority] [char](1) NULL,
	[m_dwMode] [int] NULL,
	[blockby] [varchar](32) NULL,
	[TotalPlayTime] [int] NULL,
	[isblock] [char](1) NULL,
	[m_Inventory] [varchar](6940) NULL,
	[m_apIndex] [varchar](345) NULL,
	[m_adwEquipment] [varchar](135) NULL,
	[m_aSlotApplet] [varchar](3100) NULL,
	[m_aSlotItem] [varchar](6885) NULL,
	[m_aSlotQueue] [varchar](225) NULL,
	[m_SkillBar] [smallint] NULL,
	[m_dwObjIndex] [varchar](345) NULL,
	[m_Card] [varchar](1980) NULL,
	[m_Cube] [varchar](1980) NULL,
	[m_apIndex_Card] [varchar](215) NULL,
	[m_dwObjIndex_Card] [varchar](215) NULL,
	[m_apIndex_Cube] [varchar](215) NULL,
	[m_dwObjIndex_Cube] [varchar](215) NULL,
	[m_idparty] [int] NULL,
	[m_nNumKill] [int] NULL,
	[m_idMuerderer] [int] NULL,
	[m_nSlaughter] [int] NULL,
	[m_nFame] [int] NULL,
	[m_nDeathExp] [int] NULL,
	[m_nDeathLevel] [int] NULL,
	[m_dwFlyTime] [int] NULL,
	[m_nMessengerState] [int] NULL,
	[m_Bank] [varchar](4290) NULL,
	[m_apIndex_Bank] [varchar](215) NULL,
	[m_dwObjIndex_Bank] [varchar](215) NULL,
	[m_dwGoldBank] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [BASE_VALUE_ID1] ON [dbo].[BASE_VALUE_TBL] 
(
	[g_nSex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BANK_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[m_BankPw] [char](4) NULL,
	[m_Bank] [varchar](4290) NULL,
	[m_apIndex_Bank] [varchar](215) NULL,
	[m_dwObjIndex_Bank] [varchar](215) NULL,
	[m_dwGoldBank] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [BANK_ID1] ON [dbo].[BANK_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aaa_test](
	[rid] [int] NULL,
	[times] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_#tmpTestCheck](
	[sdate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_#tmpSendCheck](
	[mid] [int] NULL,
	[sdate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BANK_EXT_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[m_extBank] [varchar](1296) NULL,
	[m_BankPiercing] [varchar](1872) NULL,
	[szBankPet] [varchar](4200) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [BANK_EXT_ID1] ON [dbo].[BANK_EXT_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BACKSYSTEM_STR]
@iGu		CHAR(2) 	= 'S1',
@iIndex		INT		= 0
AS
set nocount on
IF @iGu = 'G1'  -- Base GameSetting
	BEGIN
		select * from Base_GameSetteing
		RETURN
	END
ELSE
IF @iGu = 'G2' -- QUEST_TBL Data Insert
	BEGIN
		RETURN
	END

set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[armor](
	[armor] [int] NULL,
	[rid] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[COMPANY_TBL](
	[m_idCompany] [char](6) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_szCompany] [varchar](16) NULL,
	[m_leaderid] [char](6) NULL,
	[isuse] [char](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [COMPANY_ID1] ON [dbo].[COMPANY_TBL] 
(
	[m_idCompany] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/*============================================================    
1. 작성자 : 박혜민    
2. 작성일 : 2009.11.23    
3. 스크립트 명 : usp_GuildFurniture_Log    
4. 스크립트 목적 : 길드 하우스 가구 Log 입력    
5. 매개변수    
 @serverindex char(2)   서버군    
 @m_idGuild  char (6)  길드아이디    
 @SEQ   int     SEQ  ( 0 일경우 GuildHouse 가 삭제되어 일괄 삭제 됨)  
6. 리턴값      
7. 수정 내역    
8. 샘플 실행 코드    
    EXEC usp_GuildFurniture_Log '05', '123456'    
9. 조회 및 ident 값 초기화    
 select * from tblGuildHouse_FurnitureLog    
 delete tblGuildHouse_FurnitureLog    
============================================================*/    
    
CREATE proc [dbo].[usp_GuildFurniture_Log]    
 @serverindex char(2),    
 @m_idGuild  char (6),  
 @SEQ int = 0  
as    
    
set nocount on    
set xact_abort on    
  
if @SEQ = 0  
begin  
-- EXEC('  insert into LOG_' + @serverindex + '_DBF.dbo.tblGuildHouse_FurnitureLog   
 EXEC('  insert into LOGGING_01_DBF.dbo.tblGuildHouse_FurnitureLog   
   (  
    serverindex, m_idGuild, SEQ, ItemIndex, bSetup, s_date, set_date  
   )  
  SELECT  serverindex, m_idGuild, SEQ, ItemIndex, bSetup, s_date, set_date   
   from tblGuildHouse_Furniture (nolock)  
   where serverindex = ' + @serverindex + ' and m_idGuild = ' + @m_idGuild +''  
  )  
end  
else if @SEQ <> 0  
begin  
-- EXEC('  insert into LOG_' + @serverindex + '_DBF.dbo.tblGuildHouse_FurnitureLog   
 EXEC('  insert into LOGGING_01_DBF.dbo.tblGuildHouse_FurnitureLog    (  
    serverindex, m_idGuild, SEQ, ItemIndex, bSetup, s_date, set_date  
   )  
  SELECT  serverindex, m_idGuild, SEQ, ItemIndex, bSetup, s_date, set_date  
   
   from tblGuildHouse_Furniture (nolock)  
   where serverindex = ' + @serverindex + ' and m_idGuild = ' + @m_idGuild + ' and SEQ = ' + @SEQ + ' '  
  )  
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/*============================================================  
1. 작성자 : 박혜민  
2. 작성일 : 2009.11.23  
3. 스크립트 명 : usp_GuildHouse_Log  
4. 스크립트 목적 : 길드 하우스 Log 입력  
5. 매개변수  
 @serverindex char(2)   서버군  
 @m_idGuild  char (6)  길드아이디  
 @SEQ   int     SEQ  
 @dwItemId    int    사용 ITEM  
 @bSetup   int    설치 여부  
6. 리턴값    
7. 수정 내역  
8. 샘플 실행 코드  
    EXEC usp_GuildHouse_Log '05', '123456'  
9. 조회 및 ident 값 초기화  
 select * from tblGuildHouse  
 delete tblGuildHouse  
============================================================*/  
  
CREATE      proc [dbo].[usp_GuildHouse_Log]  
	@serverindex char(2),  
	@m_idGuild  char (6),
	@SEQ int = 0
as  
  
set nocount on  
set xact_abort on  

--	EXEC('  insert into LOG_' + @serverindex + '_DBF.dbo.tblGuildHouse_FurnitureLog 
	EXEC('  insert into LOGGING_01_DBF.dbo.tblGuildHouseLog 			(
				serverindex, m_idGuild, dwWorldID, tKeepTime, m_szGuild
			)
		SELECT  serverindex, m_idGuild, dwWorldID, tKeepTime, m_szGuild
			from tblGuildHouse (nolock)
			where serverindex = ' + @serverindex + ' and m_idGuild = ' + @m_idGuild + ' '
		)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SECRET_ROOM_MEMBER_TBL](
	[serverindex] [char](2) NULL,
	[nTimes] [int] NULL,
	[nContinent] [int] NULL,
	[m_idGuild] [char](6) NULL,
	[m_idPlayer] [char](7) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [IDX_CLU_SECRET_ROOM_MEMBER_TBL_serverindex] ON [dbo].[SECRET_ROOM_MEMBER_TBL] 
(
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_SECRET_ROOM_MEMBER_TBL_nTimes_nContinent_m_idGuild] ON [dbo].[SECRET_ROOM_MEMBER_TBL] 
(
	[nTimes] ASC,
	[nContinent] ASC,
	[m_idGuild] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TAX_DETAIL_TBL](
	[serverindex] [char](2) NULL,
	[nTimes] [int] NULL,
	[nContinent] [int] NULL,
	[nTaxKind] [int] NULL,
	[nTaxRate] [int] NULL,
	[nTaxCount] [int] NULL,
	[nTaxGold] [int] NULL,
	[nTaxPerin] [int] NULL,
	[nNextTaxRate] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [IDX_CLU_TAX_DETAIL_TBL_serverindex] ON [dbo].[TAX_DETAIL_TBL] 
(
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_CLU_TAX_DETAIL_TBL_nTaxKind] ON [dbo].[TAX_DETAIL_TBL] 
(
	[nTaxKind] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_CLU_TAX_DETAIL_TBL_nTimes_nContinent] ON [dbo].[TAX_DETAIL_TBL] 
(
	[nTimes] ASC,
	[nContinent] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_BulkMailingRec_Test]
as
set nocount on

select email, account, rid
from mail_bulk_test
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_BulkMailingRec_List]
@mid int
as
set nocount on

declare @q1 nvarchar(4000), @q2 nvarchar(4000), @mailID varchar(10)

set @mailID = cast(@mid as varchar(10))

set @q1 = 'mail_[&mid&]'
set @q2 = replace(@q1, '[&mid&]', @mailID)

if exists (select * from sysobjects where [name] = @q2 and type = 'U')
begin
	if @mid >= 200
	begin
		set @q1 = '
		select email, account--, rid
		from mail_[&mid&] with (nolock)'
	end
	else
	begin
		set @q1 = '
		select 이메일 as email, 계정 as account--, '''' as rid
		from mail_[&mid&] with (nolock)'
	end

	set @q2 = replace(@q1, '[&mid&]', @mailID)

	exec sp_executesql @q2
end
else
begin
	select -1
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE       PROC [dbo].[BILL_USER_INFO_UPDATE]
AS
        DECLARE @s_date CHAR(8)
        
        SET @s_date = CONVERT(CHAR(8), DATEADD(dd, -1, GETDATE()), 112)

        UPDATE BILL.QLORD_MASTER.dbo.BX_TG_USERINFO
        SET    USER_NM  = A.이름
        ,      SOCIAL_NO = CASE SUBSTRING(A.주민번호, 1, 1) WHEN 'a' THEN '0' + SUBSTRING(A.주민번호, 2, 12)
                                ELSE 주민번호 END
        ,      ZIP_CD    = SUBSTRING(A.우편번호, 1, 3) + SUBSTRING(A.우편번호, 5, 3)
        ,      EMAIL     = A.이메일
        FROM   ONLINE_DBF.dbo.USER_TBL A
        WHERE  REG_DT BETWEEN @s_date + ' 00:00:00' AND GETDATE()
        AND    USER_NO = A.계정 COLLATE Korean_Wansung_CI_AS
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TMP_SA](
	[mon] [varchar](8) NULL,
	[day] [nvarchar](30) NULL,
	[dw] [int] NULL,
	[s_date] [char](8) NOT NULL,
	[region] [varchar](20) NOT NULL,
	[join_cnt] [int] NULL,
	[chr_cnt] [int] NULL,
	[sex_1] [int] NULL,
	[sex_2] [int] NULL,
	[a_1] [int] NULL,
	[a_2] [int] NULL,
	[b_1] [int] NULL,
	[b_2] [int] NULL,
	[c_1] [int] NULL,
	[c_2] [int] NULL,
	[d_1] [int] NULL,
	[d_2] [int] NULL,
	[e_1] [int] NULL,
	[e_2] [int] NULL,
	[f_1] [int] NULL,
	[f_2] [int] NULL,
	[n_1] [int] NULL,
	[n_2] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_no](
	[account] [varchar](32) NULL,
	[s_date] [varchar](32) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tester_Mail_List](
	[이메일] [varchar](100) NULL,
	[계정] [varchar](32) NOT NULL,
	[비밀번호] [varchar](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblSkillPoint](
	[serverindex] [char](2) NOT NULL,
	[PlayerID] [char](7) NULL,
	[SkillID] [int] NOT NULL,
	[SkillLv] [int] NOT NULL,
	[SkillPosition] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [tblSkillPoint_ID1] ON [dbo].[tblSkillPoint] 
(
	[serverindex] ASC,
	[PlayerID] ASC,
	[SkillID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblServerList](
	[serverindex] [char](2) NULL,
	[servername] [varchar](20) NULL,
	[serverseq] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblRestPoint](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NULL,
	[m_nRestPoint] [int] NULL,
	[m_LogOutTime] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblRemoveItemFromGuildBank](
	[nNum] [int] IDENTITY(1,1) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[idGuild] [char](6) NOT NULL,
	[ItemIndex] [varchar](32) NOT NULL,
	[ItemSerialNum] [int] NOT NULL,
	[ItemCnt] [int] NOT NULL,
	[DeleteRequestCnt] [int] NOT NULL,
	[DeleteCnt] [int] NOT NULL,
	[ItemFlag] [int] NOT NULL,
	[RegisterDt] [datetime] NOT NULL,
	[DeleteDt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [NCI_idGuild] ON [dbo].[tblRemoveItemFromGuildBank] 
(
	[idGuild] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblQuizAnswer](
	[m_nIndex] [int] NOT NULL,
	[m_Answer1] [varchar](256) NULL,
	[m_Answer2] [varchar](256) NULL,
	[m_Answer3] [varchar](256) NULL,
	[m_Answer4] [varchar](256) NULL,
 CONSTRAINT [PK_tblQuizAnswer] PRIMARY KEY CLUSTERED 
(
	[m_nIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀴즈번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswer', @level2type=N'COLUMN',@level2name=N'm_nIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀴즈보기 1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswer', @level2type=N'COLUMN',@level2name=N'm_Answer1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀴즈보기 2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswer', @level2type=N'COLUMN',@level2name=N'm_Answer2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀴즈보기 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswer', @level2type=N'COLUMN',@level2name=N'm_Answer3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀴즈보기 4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswer', @level2type=N'COLUMN',@level2name=N'm_Answer4'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblQuiz](
	[m_nIndex] [int] IDENTITY(1,1) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_nQuizType] [int] NOT NULL,
	[m_nAnswer] [int] NULL,
	[m_chState] [char](1) NOT NULL,
	[m_szQuestion] [varchar](1024) NULL,
	[m_item] [int] NULL,
	[m_itemCount] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPropose](
	[nServer] [int] NULL,
	[idProposer] [int] NULL,
	[tPropose] [int] NULL,
 CONSTRAINT [UQ_tblPropose_idProposer] UNIQUE CLUSTERED 
(
	[nServer] ASC,
	[idProposer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPocketExt](
	[serverindex] [char](2) NOT NULL,
	[idPlayer] [char](7) NOT NULL,
	[nPocket] [tinyint] NULL,
	[szExt] [varchar](2000) NOT NULL,
	[szPiercing] [varchar](2000) NOT NULL,
	[szPet] [varchar](4200) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPocket](
	[serverindex] [char](2) NOT NULL,
	[idPlayer] [char](7) NOT NULL,
	[nPocket] [int] NOT NULL,
	[szItem] [varchar](4290) NOT NULL,
	[szIndex] [varchar](215) NOT NULL,
	[szObjIndex] [varchar](215) NOT NULL,
	[bExpired] [int] NOT NULL,
	[tExpirationDate] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblMultiServerInfo](
	[serverindex] [char](2) NOT NULL,
	[m_idPlayer] [char](7) NOT NULL,
	[MultiServer] [int] NOT NULL,
 CONSTRAINT [PK_tblMultiServerInfo] PRIMARY KEY CLUSTERED 
(
	[serverindex] ASC,
	[m_idPlayer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblMessenger](
	[idPlayer] [char](7) NOT NULL,
	[idFriend] [char](7) NOT NULL,
	[bBlock] [int] NOT NULL,
	[chUse] [char](1) NOT NULL,
	[serverindex] [char](2) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [messenger_idx_1] ON [dbo].[tblMessenger] 
(
	[idPlayer] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [messenger_idx_2] ON [dbo].[tblMessenger] 
(
	[idPlayer] ASC,
	[idFriend] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblMaster_all](
	[serverindex] [char](2) NULL,
	[m_idPlayer] [char](7) NULL,
	[sec] [tinyint] NULL,
	[c01] [int] NULL,
	[c02] [int] NULL,
	[c03] [int] NULL,
	[c04] [int] NULL,
	[c05] [int] NULL,
	[c06] [int] NULL,
	[c07] [int] NULL,
	[c08] [int] NULL,
	[c09] [int] NULL,
	[c10] [int] NULL,
	[c11] [int] NULL,
	[c12] [int] NULL,
	[c13] [int] NULL,
	[c14] [int] NULL,
	[c15] [int] NULL,
	[c16] [int] NULL,
	[c17] [int] NULL,
	[c18] [int] NULL,
	[c19] [int] NULL,
	[c20] [int] NULL,
	[c21] [int] NULL,
	[c22] [int] NULL,
	[c23] [int] NULL,
	[c24] [int] NULL,
	[c25] [int] NULL,
	[c26] [int] NULL,
	[c27] [int] NULL,
	[c28] [int] NULL,
	[c29] [int] NULL,
	[c30] [int] NULL,
	[c31] [int] NULL,
	[c32] [int] NULL,
	[c33] [int] NULL,
	[c34] [int] NULL,
	[c35] [int] NULL,
	[c36] [int] NULL,
	[c37] [int] NULL,
	[c38] [int] NULL,
	[c39] [int] NULL,
	[c40] [int] NULL,
	[c41] [int] NULL,
	[c42] [int] NULL,
	[c43] [int] NULL,
	[c44] [int] NULL,
	[c45] [int] NULL,
	[c46] [int] NULL,
	[c47] [int] NULL,
	[c48] [int] NULL,
	[c49] [int] NULL,
	[c50] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [IDX_tblMaster_all_m_idPlayer] ON [dbo].[tblMaster_all] 
(
	[serverindex] ASC,
	[m_idPlayer] ASC,
	[sec] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLordSkill](
	[nServer] [int] NULL,
	[nSkill] [int] NULL,
	[nTick] [int] NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IDX_CLU_tblLordSkill_nServer] ON [dbo].[tblLordSkill] 
(
	[nServer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_tblLordSkill_nSkill] ON [dbo].[tblLordSkill] 
(
	[nSkill] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLordEvent](
	[nServer] [int] NULL,
	[idPlayer] [int] NULL,
	[nTick] [int] NULL,
	[fEFactor] [float] NULL,
	[fIFactor] [float] NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IDX_CLU_tblLordEvent_nServer] ON [dbo].[tblLordEvent] 
(
	[nServer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_tblLordEvent_idPlayer] ON [dbo].[tblLordEvent] 
(
	[idPlayer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_tblLordEvent_nTick] ON [dbo].[tblLordEvent] 
(
	[nTick] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLordElector](
	[nServer] [int] NOT NULL,
	[idElection] [int] NOT NULL,
	[idElector] [int] NOT NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLordElection](
	[nServer] [int] NULL,
	[idElection] [int] NULL,
	[eState] [int] NULL,
	[szBegin] [varchar](16) NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [IDX_CLU_tblLordElection_nServer] ON [dbo].[tblLordElection] 
(
	[nServer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_tblLordElection_idElection] ON [dbo].[tblLordElection] 
(
	[idElection] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLordCandidates](
	[nServer] [int] NULL,
	[idElection] [int] NULL,
	[idPlayer] [int] NULL,
	[iDeposit] [bigint] NULL,
	[nVote] [int] NULL,
	[szPledge] [varchar](255) NULL,
	[IsLeftOut] [char](1) NULL,
	[nPledge] [int] NULL,
	[tCreate] [int] NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [IDX_CLU_tblLordCandidates_nServer] ON [dbo].[tblLordCandidates] 
(
	[nServer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_tblLordCandidates_idElection_idPlayer] ON [dbo].[tblLordCandidates] 
(
	[idElection] ASC,
	[idPlayer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_tblLordCandidates_idElection_IsLeftOut] ON [dbo].[tblLordCandidates] 
(
	[idElection] ASC,
	[IsLeftOut] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_tblLordCandidates_idPlayer] ON [dbo].[tblLordCandidates] 
(
	[idPlayer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLord](
	[nServer] [int] NULL,
	[idElection] [int] NULL,
	[idLord] [int] NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IDX_CLU_tblLord_nServer] ON [dbo].[tblLord] 
(
	[nServer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_NCL_tblLord_idElection] ON [dbo].[tblLord] 
(
	[idElection] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLogout_Penya_Diff_Log](
	[serverindex] [char](2) NULL,
	[m_idPlayer] [char](7) NULL,
	[m_dwGold_old] [bigint] NULL,
	[regdate_old] [datetime] NULL,
	[m_dwGold_now] [bigint] NULL,
	[regdate_now] [datetime] NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLogout_Penya](
	[serverindex] [char](2) NULL,
	[m_idPlayer] [char](7) NULL,
	[m_dwGold] [bigint] NULL,
	[regdate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblitem2row](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NULL,
	[m_dwObjId] [int] NULL,
	[m_nItemNum] [int] NULL,
	[m_nUniqueNo] [bigint] NULL,
	[m_nAbilityOption] [int] NULL,
	[m_dwItemId] [varchar](32) NULL,
	[m_position] [char](1) NULL,
	[ItemResist] [int] NULL,
	[ResistAbilityOpt] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblHousing_Visit](
	[serverindex] [char](2) NULL,
	[m_idPlayer] [char](7) NULL,
	[f_idPlayer] [char](7) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [IDX_CLU_tblHousing_Visit_m_idPlayer] ON [dbo].[tblHousing_Visit] 
(
	[serverindex] ASC,
	[m_idPlayer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_NCL_UNI_tblHousing_Visit] ON [dbo].[tblHousing_Visit] 
(
	[serverindex] ASC,
	[m_idPlayer] ASC,
	[f_idPlayer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblHousing](
	[serverindex] [char](2) NULL,
	[m_idPlayer] [char](7) NULL,
	[ItemIndex] [int] NULL,
	[tKeepTime] [bigint] NULL,
	[bSetup] [int] NULL,
	[x_Pos] [float] NULL,
	[y_Pos] [float] NULL,
	[z_Pos] [float] NULL,
	[fAngle] [float] NULL,
	[Start_Time] [datetime] NULL,
	[End_Time] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [IDX_CLU_tblHousing] ON [dbo].[tblHousing] 
(
	[serverindex] ASC,
	[m_idPlayer] ASC,
	[bSetup] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblGuildHousingUpdate](
	[serverindex] [char](2) NULL,
	[m_idGuild] [char](6) NULL,
	[tKeepTime] [bigint] NULL,
	[dwWorldID] [int] NULL,
	[bSetup] [int] NULL,
	[itemindex] [int] NULL,
	[x_pos] [real] NULL,
	[y_pos] [real] NULL,
	[z_pos] [real] NULL,
	[fAngle] [nchar](10) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GuildFurniture_delete1]
@serverindex char(2),
@m_idGuild char(6),
@ItemIndex int
as
set nocount on
set xact_abort on

update tblGuildHousingFurniture
set bSetup = 99, End_Time = getdate()
where serverindex = @serverindex and m_idGuild = @m_idGuild and ItemIndex = @ItemIndex and bSetup <> 99
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblGuildHouseFurnitureUpdate](
	[serverindex] [char](2) NULL,
	[m_idGuild] [char](6) NULL,
	[tKeepTime] [int] NULL,
	[bSetup] [int] NULL,
	[x_pos] [real] NULL,
	[y_pos] [real] NULL,
	[z_pos] [real] NULL,
	[fAngle] [real] NULL,
	[itemindex] [int] NULL,
	[SEQ] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblGuildHouse_Furniture_SEQ](
	[m_szGuild] [varchar](50) NULL,
	[m_idGuild] [char](6) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblGuildHouse_Furniture](
	[serverindex] [char](2) NULL,
	[m_idGuild] [char](6) NULL,
	[tKeepTime] [int] NULL,
	[bSetup] [int] NULL,
	[x_pos] [real] NULL,
	[y_pos] [real] NULL,
	[z_pos] [real] NULL,
	[fAngle] [real] NULL,
	[itemindex] [int] NULL,
	[SEQ] [int] NULL,
	[set_date] [datetime] NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_Furniture', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_Furniture', @level2type=N'COLUMN',@level2name=N'm_idGuild'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 사용 유효시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_Furniture', @level2type=N'COLUMN',@level2name=N'tKeepTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 설치 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_Furniture', @level2type=N'COLUMN',@level2name=N'bSetup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가구 설치 각도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_Furniture', @level2type=N'COLUMN',@level2name=N'fAngle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용 ITEM ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_Furniture', @level2type=N'COLUMN',@level2name=N'itemindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시퀸스 넘버' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_Furniture', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첫 설치시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_Furniture', @level2type=N'COLUMN',@level2name=N'set_date'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblGuildHouse](
	[serverindex] [char](2) NULL,
	[m_idGuild] [char](6) NULL,
	[tKeepTime] [bigint] NULL,
	[dwWorldID] [int] NULL,
	[m_szGuild] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse', @level2type=N'COLUMN',@level2name=N'm_idGuild'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 하우스 자체 유지시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse', @level2type=N'COLUMN',@level2name=N'tKeepTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'월드 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse', @level2type=N'COLUMN',@level2name=N'dwWorldID'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblFunnyCoin](
	[fcid] [int] IDENTITY(1,1) NOT NULL,
	[account] [varchar](32) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_idPlayer] [char](7) NOT NULL,
	[Item_Name] [int] NOT NULL,
	[Item_Cash] [int] NOT NULL,
	[Item_UniqueNo] [bigint] NOT NULL,
	[s_date] [datetime] NOT NULL,
	[fid] [int] NOT NULL,
	[ItemFlag] [tinyint] NOT NULL,
	[f_date] [datetime] NULL,
 CONSTRAINT [PK_tblFunnyCoin] PRIMARY KEY CLUSTERED 
(
	[fcid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblEvent_Board_Provide](
	[account] [varchar](32) NULL,
	[regdate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblElection](
	[s_week] [char](6) NULL,
	[chrcount] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE CLUSTERED INDEX [IDX_CLU_tblElection_s_week] ON [dbo].[tblElection] 
(
	[s_week] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCouplePlayer_deleted](
	[nServer] [int] NULL,
	[idPlayer] [int] NULL,
	[cid] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WANTED_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[penya] [bigint] NULL,
	[szMsg] [varchar](40) NULL,
	[s_date] [char](12) NULL,
	[CreateTime] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [WANTED_ID1] ON [dbo].[WANTED_TBL] 
(
	[m_idPlayer] DESC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[uspGetGuildMemberListByGuildName]
		@pserverindex		char(2),
		@pGuildName			varchar(32),
		@debug				bit=0
AS
SET NOCOUNT ON

	DECLARE @sql	nvarchar(2000)
	
	SET @sql='
	SELECT	m_szName
	FROM	CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.CHARACTER_TBL a 
			INNER JOIN	CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.GUILD_MEMBER_TBL b
			ON (a.m_idPlayer=b.m_idPlayer)
			INNER JOIN	CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.GUILD_TBL c
			ON (b.m_idGuild=c.m_idGuild)
	WHERE	c.m_szGuild=@GuildName
	'

	IF @debug=1	PRINT @sql
	
	EXEC sp_executesql	@sql, 
						N'@GuildName varchar(32)', 
						@pGuildName
			
			
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[uspGetGuildCombatList]
		@pserverindex		char(2),
		@pStartDt			char(8),
		@pEndDt				char(8),
		@debug				bit=0
AS
SET NOCOUNT ON

	DECLARE @sql	nvarchar(2000)
	
	IF @pStartDt='' BEGIN
		SELECT	@pStartDt=CONVERT(char(8), getdate(), 112),
				@pEndDt=CONVERT(char(8), dateadd(dd, 1, getdate()), 112)
	END
	ELSE BEGIN
		SELECt @pEndDt=CONVERT(char(8), dateadd(dd, 1, @pEndDt), 112)
	END
	
	SET @sql=N'
		SELECT	a.CombatID, 
				d.CommentEng as Status,
				CONVERT(char(19), a.EndDt, 120) as EndDt,
				count(distinct b.GuildID) as GuildCnt,
				count(distinct c.PlayerID) as PlayerCnt
		FROM	CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.tblCombatInfo a
				LEFT OUTER JOIN	CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.tblCombatJoinGuild b ON (a.CombatID=b.CombatID)
				LEFT OUTER JOIN	CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.tblCombatJoinPlayer c ON (b.CombatID=c.CombatID AND b.GuildID=c.GuildID)
				INNER JOIN
				(	SELECT Code, CommentEng FROM CRM.MANAGE_DBF.dbo.tblCode WHERE CodeGroup=''310'') d ON (a.Status=d.Code)
		WHERE	a.EndDt BETWEEN @pStartDt AND @pEndDt
		GROUP BY a.CombatID, d.CommentEng, CONVERT(char(19), a.EndDt, 120)
		ORDER BY a.CombatID DESC
	'

	IF @debug=1	PRINT @sql
	
	EXEC sp_executesql @sql, N'@pStartDt smalldatetime, @pEndDt smalldatetime', @pStartDt, @pEndDt
		

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[uspGetGuildCombatInfo]
		@pserverindex		char(2),
		@pCombatID			int,
		@debug				bit=0
AS
SET NOCOUNT ON

	DECLARE @sql	nvarchar(2000)
	
	SET @sql=N'
		SELECT	CONVERT(char(16), a.EndDt, 120) as EndDt,
				(SELECT m_szGuild FROM CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.GUILD_TBL WHERE m_idGuild=b.GuildID) as GuildName,
				b.Point as GuildPoint,
				b.Reward as GuildReward,
				(SELECT m_szName FROM CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.CHARACTER_TBL WHERE m_idPlayer=c.PlayerID) as CharName,
				(SELECT b.CommentEng FROM CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.CHARACTER_TBL a 
											INNER JOIN	CRM.MANAGE_DBF.dbo.tblCode b ON (a.m_nJob=b.Code)
									 WHERE b.CodeGroup=''120'' AND a.m_idPlayer=c.PlayerID) as Job,
				(SELECT m_nLevel FROM CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.CHARACTER_TBL WHERE m_idPlayer=c.PlayerID) as CharLevel,
				c.Point,
				c.Reward
		FROM	CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.tblCombatInfo a
				LEFT OUTER JOIN	CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.tblCombatJoinGuild b ON (a.CombatID=b.CombatID)
				LEFT OUTER JOIN	CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.tblCombatJoinPlayer c ON (b.CombatID=c.CombatID AND b.GuildID=c.GuildID)
		WHERE	a.CombatID=@CombatID
		ORDER BY b.Reward DESC, b.Point DESC, c.Reward DESC, c.Point DESC
	'

	IF @debug=1	PRINT @sql
	
	EXEC sp_executesql @sql, N'@CombatID int', @pCombatID
		

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GuildHouse_Update]
@serverindex char(2),
@m_idguild char(6),
@ItemIndex int,
@dwWorldID int,
@bsetup int,
@x_Pos float,
@y_Pos float,
@z_Pos float,
@fAngle float
as
set nocount on
set xact_abort on

update tblGuildHouseFurniture
set bSetup = @bSetup, x_Pos = @x_Pos, y_Pos = @y_Pos, z_Pos = @z_Pos, fAngle = @fAngle
where serverindex = @serverindex and m_idGuild = @m_idGuild and bSetup =@bsetup
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure [dbo].[uspInquiryCharacterMail]
		@pserverindex		char(2),
		@pCharName			varchar(32),
		@pStartDt			char(8)='',
		@pEndDt				char(8)='',
		@pRoleFlag			int=0, -- 0: Receiver , 1: Sender
		@debug				bit=0
AS
SET NOCOUNT ON

	DECLARE @sql	nvarchar(3000)

	IF @pStartDt='' BEGIN
		SELECT	@pStartDt=CONVERT(char(8), getdate(), 112),
				@pEndDt=CONVERT(char(8), dateadd(dd, 1, getdate()), 112)
	END
	ELSE BEGIN
		SELECt @pEndDt=CONVERT(char(8), dateadd(dd, 1, @pEndDt), 112)
	END
		
	SET @sql='
		SELECT	a.nMail, 
				(SELECT m_szName FROM CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.CHARACTER_TBL WHERE m_idPlayer=a.idReceiver) as Receiver,
				(SELECT m_szName FROM CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.CHARACTER_TBL WHERE m_idPlayer=a.idSender) as Sender,
				CONVERT(char(19), SendDt, 120) as SendDt,
				CASE byRead
					WHEN 90 THEN ''Deleted''
					WHEN 1 THEN ''Read''
					ELSE ''Not Read''
				END as ReadFlag, 
				CONVERT(char(19), ReadDt, 120) as ReadDt, 
				DeleteDt, 
				nGold, 
				CASE GoldFlag
					WHEN 90 THEN ''Received''
					ELSE ''Not Received''
				END as GoldFlag, 
				CONVERT(char(19), GetGoldDt, 120) as GetGoldDt,
				CASE ItemFlag
					WHEN 90 THEN ''Received''
					ELSE ''Not Received''
				END as ItemFlag, 
				CONVERT(char(19), ItemReceiveDt, 120) as ItemReceiveDt,
				(SELECT szName FROM CRM.ITEM_DBF.dbo.ITEM_TBL WHERE [Index]=dwItemId) as ItemName, 
				nItemNum, 
				szTitle,
				szText
		FROM	CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.MAIL_TBL a
				INNER JOIN
				CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.CHARACTER_TBL b
				ON (a.idSender=b.m_idPlayer)
	    WHERE	b.m_szName=@CharName
	    AND		a.SendDt between @StartDt and @EndDt
		union all
		SELECT	a.nMail, 
				isnull((SELECT m_szName FROM CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.CHARACTER_TBL WHERE m_idPlayer=a.idReceiver), ''GAME'') as Receiver,
				isnull((SELECT m_szName FROM CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.CHARACTER_TBL WHERE m_idPlayer=a.idSender), ''GAME'') as Sender,
				CONVERT(char(19), SendDt, 120) as SendDt,
				CASE byRead
					WHEN 90 THEN ''Deleted''
					WHEN 1 THEN ''Read''
					ELSE ''Not Read''
				END as ReadFlag, 
				CONVERT(char(19), ReadDt, 120) as ReadDt, 
				DeleteDt, 
				nGold, 
				CASE GoldFlag
					WHEN 90 THEN ''Received''
					ELSE ''Not Received''
				END as GoldFlag, 
				CONVERT(char(19), GetGoldDt, 120) as GetGoldDt,
				CASE ItemFlag
					WHEN 90 THEN ''Received''
					ELSE ''Not Received''
				END as ItemFlag, 
				CONVERT(char(19), ItemReceiveDt, 120) as ItemReceiveDt,
				(SELECT szName FROM CRM.ITEM_DBF.dbo.ITEM_TBL WHERE [Index]=dwItemId) as ItemName, 
				nItemNum, 
				szTitle,
				szText
		FROM	CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.MAIL_TBL a
				INNER JOIN
				CHR'+@pserverindex+'.CHARACTER_'+@pserverindex+'_DBF.dbo.CHARACTER_TBL b
				ON (a.idReceiver=b.m_idPlayer)
	    WHERE	b.m_szName=@CharName
	    AND		a.SendDt between @StartDt and @EndDt
	    ORDER BY	a.SendDt
	'

	IF @debug=1	PRINT @sql
	
	EXEC sp_executesql @sql,  N'@CharName	varchar(32), 
								@StartDt	smalldatetime,
								@EndDt		smalldatetime ', @pCharName, @pStartDt, @pEndDt

	RETURN
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspSetSealCharUpdate]
@serverindex    char(2),
@im_idPlayer    CHAR(7) = '',
@account        VARCHAR(32)     = '',
@nPlayerSlot    INT     =0,
@im_idPlayerW   CHAR(7) = ''
AS
SET NOCOUNT ON
        
UPDATE CHARACTER_TBL
SET     isblock = 'F' ,account = @account, playerslot = @nPlayerSlot
WHERE   m_idPlayer = @im_idPlayerW AND serverindex = @serverindex AND isblock = 'S'
RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspSetSealChar]
@serverindex    char(2),
@im_idPlayer    CHAR(7) = ''
AS
SET NOCOUNT ON
        
UPDATE CHARACTER_TBL
SET     isblock                         = 'S' 
WHERE   m_idPlayer = @im_idPlayer AND serverindex = @serverindex

UPDATE MESSENGER_TBL
SET State = 'D'
WHERE m_idPlayer = @im_idPlayer AND serverindex = @serverindex AND State = 'T'

UPDATE MAIL_TBL
SET byRead=90, DeleteDt=getdate() 
WHERE idReceiver = @im_idPlayer AND serverindex = @serverindex AND byRead<>90
RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[uspSavePocket]
@serverindex    CHAR(2),
@idPlayer       CHAR(7),
@nPocket        int,
@pszItem        VARCHAR(4290)   = '$',
@pszIndex       VARCHAR(215)    = '$',
@pszObjIndex    VARCHAR(215)    = '$',
@pszExt         VARCHAR(2000)   = '$',
@pszPiercing    VARCHAR(2000)   = '$',
@pszPet         VARCHAR(4200)   = '$',
@bExpired       int     = 1,
@tExpirationDate        int             = 0
AS
set nocount on

UPDATE  tblPocket
SET     szItem = @pszItem,
        szIndex = @pszIndex,
        szObjIndex = @pszIndex,
        bExpired         = @bExpired,
        tExpirationDate = @tExpirationDate
WHERE   serverindex = @serverindex AND idPlayer = @idPlayer AND nPocket = @nPocket

UPDATE  tblPocketExt
SET     szExt = @pszExt,
        szPiercing = @pszPiercing,
        szPet = @pszPet
WHERE   serverindex = @serverindex AND idPlayer = @idPlayer AND nPocket = @nPocket
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspRestorePropose]
@nServer int
as
set nocount on

select nServer, idProposer, tPropose from tblPropose where nServer = @nServer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspRestoreLordSkill]
@nServer int
as
set nocount on

select nSkill, nTick
from tblLordSkill
where nServer = @nServer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspRestoreLord]
@nServer int
as
set nocount on

select top 1 idLord
from tblLord
where nServer = @nServer
order by idElection desc
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspRestoreLEvent]
@nServer int
as
set nocount on

select idPlayer, nTick, fEFactor, fIFactor
from tblLordEvent
where nServer = @nServer and nTick > 0
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspRestoreElection]
@nServer int
as
set nocount on

select top 1 idElection, eState, szBegin, nRequirement = (select top 1 chrcount from tblElection order by s_week desc)
from tblLordElection
where nServer = @nServer
order by idElection desc
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspRestoreCandidates]
@nServer int,
@idElection int
as
set nocount on

select idPlayer, iDeposit, szPledge, nVote, tCreate
from tblLordCandidates
where nServer = @nServer and idElection = @idElection and IsLeftOut = 'F'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspReservRemoveItemFromCharacter]
		@pserverindex		char(2),
		@pPlayerID			char(7),
		@pItemIndex			int,
		@pItemCnt			int=1,
		@pStorage			char(1)='I',
		@pAbilityOpt		int=0,
		@pItemResist		int=0,
		@pResAbilityOpt		int=0,
		@pRandomOpt			int=0,
		@pPiercedSize		int=0,
		@pPierceID1			int=0,
		@pPierceID2			int=0,
		@pPierceID3			int=0,
		@pPierceID4			int=0,
		@pRequestUser		varchar(32)='EoCRM'
AS
SET NOCOUNT ON

	INSERT INTO ITEM_REMOVE_TBL
		(serverindex, m_idPlayer, 
			Item_Name, Item_count, m_nAbilityOption, m_bItemResist, m_nResistAbilityOption, RandomOption,
			State, 
			RequestUser)
	VALUES
		(@pserverindex, @pPlayerID,
			@pItemIndex, @pItemCnt, @pAbilityOpt, @pItemResist, @pResAbilityOpt, @pRandomOpt,
			@pStorage,
			@pRequestUser) 

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspRemoveItemFromGuildBank]
		@pserverindex	char(2),
		@pNum			int,
		@pDeleteCnt		int
AS
SET NOCOUNT ON

	UPDATE tblRemoveItemFromGuildBank
		SET ItemFlag=1, DeleteCnt=@pDeleteCnt, DeleteDt=getdate()
	WHERE	serverindex=@pserverindex 
	AND		nNum=@pNum
	
	IF @@ROWCOUNT=0 BEGIN
		SELECT retValue ='0'
	END
	ELSE BEGIN
		SELECT retValue = '1'
	END
	
	RETURN
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspProvideItemToCharacter]
		@pPlayerID			char(7),
		@pserverindex		char(2),
		@pItemIndex			int,
		@pItemCnt			int=1,
		@pAbilityOption		int=0,
		@pEndTime			char(8)=NULL,
		@pItemResist		int=0,
		@pResAbilityOpt		int=0,
		@pCharged			int=0,
		@pSender			char(7)='0000000',
		@pRandomOption		int=0,
		@pPiercedSize		int=0,
		@pPierceID1			int=0,
		@pPierceID2			int=0,
		@pPierceID3			int=0,
		@pPierceID4			int=0,
		@pKeepTime			int=0,
		@pSendComment		varchar(20)='PayLetter'
AS
SET NOCOUNT ON

	DECLARE	@ItemName	varchar(32)

	IF @pItemIndex=12 OR @pItemIndex=13 OR @pItemIndex=14 OR @pItemIndex=15 BEGIN
		SET @ItemName='penya'
	END
	ELSE BEGIN
		SET @ItemName=@pItemIndex
	END
	
	INSERT INTO ITEM_SEND_TBL
		(m_idPlayer, serverindex, 
				Item_Name, Item_count, m_nAbilityOption, End_Time, m_bItemResist, m_nResistAbilityOption, nRandomOptItemId,
				m_bCharged, idSender, 
				nPiercedSize, adwItemId0, adwItemId1, adwItemId2, adwItemId3,
				m_dwKeepTime, SendComment)
		VALUES
		(@pPlayerID, @pserverindex,
				@ItemName, @pItemCnt, @pAbilityOption, @pEndTime, @pItemResist, @pResAbilityOpt, @pRandomOption,
				@pCharged, @pSender,
				@pPiercedSize, @pPierceID1, @pPierceID2, @pPierceID3, @pPierceID4,
				@pKeepTime, @pSendComment) 
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspLordSkillTick]
@nServer int,
@nSkill int,
@nTick int
as
set nocount on
set xact_abort on

if exists (select * from tblLordSkill where nServer = @nServer and nSkill = @nSkill)
begin
	update tblLordSkill
	set nTick = @nTick
	where nServer = @nServer and nSkill = @nSkill
end
else
begin
	insert tblLordSkill(nServer, nSkill, nTick)
	values (@nServer, @nSkill, @nTick)
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspLordEventTick]
@nServer int,
@idPlayer int,
@nTick int
as
set nocount on

update tblLordEvent
set nTick = @nTick
where nServer = @nServer and idPlayer = @idPlayer and nTick > 0
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspLoggingRemoveItem]
		@pserverindex		char(2),
		@pPlayerID			char(6),
		@pNo				int,
		@pStorage			char(1),
		@pItemName			varchar(32),
		@pItemCnt			int=1,
		@pAbilityOpt		int=0,
		@pItemResist		int=0,
		@pResAbilityOpt		int=0,
		@pRandomOpt			int=0,
		@pPiercedSize		int=0,
		@pPierceID1			int=0,
		@pPierceID2			int=0,
		@pPierceID3			int=0,
		@pPierceID4			int=0,
		@pOperID			varchar(32)='EoCRM',
		@pReason			varchar(500)=''
AS
SET NOCOUNT ON

	INSERT INTO TBL_LOG_ITEM_REMOVE
		(server_index, m_idPlayer,
				item_name, item_count, m_AbilityOption, m_bItemResist, m_nResistAbilityOption, RandomOpt,
				state, 
				oper_id, input_day, m_nNo, reason)
		VALUES
		(@pserverindex,@pPlayerID,
				@pItemName, @pItemCnt, @pAbilityOpt, @pItemResist, @pResAbilityOpt, @pRandomOpt,
				@pStorage, 
				@pOperID, getdate(), @pNo, @pReason)
		

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspLoggingProvideItem]
		@pserverindex		char(2),
		@pPlayerID			char(7),
		@pItemName			varchar(32),
		@pNo				int=0,
		@pItemCnt			int=1,
		@pAbilityOption		int=0,
		@pItemResist		int=0,
		@pResAbilityOpt		int=0,
		@pRandomOption		int=0,
		@pPiercedSize		int=0,
		@pPierceID1			int=0,
		@pPierceID2			int=0,
		@pPierceID3			int=0,
		@pPierceID4			int=0,
		@pKeepTime			int=0,
		@pIsEvent			char(1)='F',
		@pOperID			varchar(32)='EoCRM',
		@pReason			varchar(500)='',
		@pSender			char(7)='0000000',
		@pEndTime			char(8)=NULL
AS
SET NOCOUNT ON

	INSERT INTO TBL_LOG_ITEM_SEND
		(server_index, m_idPlayer,
				item_name, item_count, m_AbilityOption, m_bItemResist, m_nResistAbilityOption, 
				isEvent, oper_id, input_day, cancel, m_nNo, reason)
		VALUES
		(@pserverindex,@pPlayerID,
				@pItemName, @pItemCnt, @pAbilityOption, @pItemResist, @pResAbilityOpt,
				@pIsEvent, @pOperID, getdate(), 'N', @pNo, @pReason)
		

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspLoadSealChar]
@serverindex    char(2),
@account        VARCHAR(32)     = ''
AS
SET NOCOUNT ON
select TOP 3 playerslot,m_idPlayer,m_szName from CHARACTER_TBL where serverindex=@serverindex and account= @account and isblock='F' order by playerslot
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspLoadRemoveItemFromGuildBank]
		@pserverindex	char(2)
AS
SET NOCOUNT ON
	
	SELECT	nNum,
			idGuild,
			ItemIndex,
			ItemSerialNum,
			ItemCnt,
			DeleteCnt,
			DeleteRequestCnt
	FROM	tblRemoveItemFromGuildBank
	WHERE	serverindex=@pserverindex and DeleteCnt = 0
--	AND		ItemFlag=0

	-- Error Handling
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspLoadPlayerData]
@iserverindex   char(2)
AS
SET NOCOUNT ON

SELECT m_idPlayer, m_szName, m_dwSex, m_nLevel, m_nJob, m_nMessengerState
FROM CHARACTER_TBL
WHERE   serverindex = @iserverindex ORDER BY m_idPlayer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspLoadMessengerListRegisterMe]
		@pserverindex		char(2),
		@pPlayerID			char(7)
AS
SET NOCOUNT ON

	SELECT	a.f_idPlayer, count(a.f_idPlayer)
	FROM	MESSENGER_TBL a, MESSENGER_TBL b
	WHERE	a.f_idPlayer=b.m_idPlayer
		AND	a.serverindex=b.serverindex
		AND	a.m_idPlayer = @pPlayerID
		AND a.serverindex = @pserverindex
		AND a.State = 'T'
		AND b.State = 'T'
	GROUP BY a.f_idPlayer
	
	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspLoadMessengerList]
		@pserverindex		char(2),
		@pPlayerID			char(7)
AS
SET NOCOUNT ON

	SELECT	a.f_idPlayer, b.m_nJob, b.m_dwSex, a.m_dwState
	FROM	dbo.MESSENGER_TBL a
			INNER JOIN dbo.CHARACTER_TBL b
				ON (a.serverindex=b.serverindex AND a.f_idPlayer=b.m_idPlayer)
	WHERE	a.serverindex=@pserverindex
		AND	a.m_idPlayer=@pPlayerID
		AND	a.State='T'
		AND	b.isblock='F'
	ORDER BY	a.CreateTime
	
	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspLoadMessenger]
@serverindex    char(2),
@idPlayer       char(7)
AS
SET NOCOUNT ON
SELECT idPlayer, idFriend, bBlock FROM tblMessenger
WHERE   serverindex = @serverindex AND idPlayer = @idPlayer AND chUse = 'T'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[uspLoadMaxMailID]
@pserverindex char(2)
AS
SET NOCOUNT ON

/*	SELECT	MAX(nMail) as MaxMailID 
	FROM 	dbo.MAIL_TBL
	WHERE	serverindex=@pserverindex*/
	SELECT MaxMailID = (SELECT isnull(MAX(nMail), 0)
				FROM dbo.MAIL_TBL
				WHERE serverindex=@pserverindex),
		nCount = (SELECT COUNT(nMail)
				FROM MAIL_TBL
				WHERE serverindex = @pserverindex AND byRead<90)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspLoadMaxCombatID]
		@pserverindex	char(2)
AS
SET NOCOUNT ON

	SELECT	ISNULL(MAX(CombatID),0) as MaxNum FROM tblCombatInfo
	 WHERE	serverindex=@pserverindex
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspLoadGuildMember]
		@pserverindex	char(2),
		@pGuildID		char(6)
AS
SET NOCOUNT ON

	SELECT	m_idPlayer 
	  FROM	GUILD_MEMBER_TBL
	 WHERE	m_idGuild=@pGuildID
	 
	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspLoadCombatList]
		@pserverindex	char(2)
AS
SET NOCOUNT ON

	SELECT	CombatID, serverindex, Status, StartDt, EndDt, Comment 
	  FROM	tblCombatInfo
	 WHERE	serverindex=@pserverindex
 
	RETURN


SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspLoadCombatInfo]
		@pCombatID		int,
		@pserverindex	char(2)
AS
SET NOCOUNT ON

	SELECT	CombatID, serverindex, Status, StartDt, EndDt, Comment 
	  FROM	tblCombatInfo
	 WHERE	serverindex=@pserverindex
	   AND	CombatID=@pCombatID
 
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE    Procedure [dbo].[uspInquiryItemList]
		@pItemList		varchar(5000),
 		@pItemIndex		varchar(1000),
		@pItemExtList	varchar(5000)=''
AS
SET NOCOUNT ON


DECLARE	@ObjectID	bigint, 
		@ItemIndex	bigint, 
		@ItemName	varchar(500), 
		@ItemCnt	bigint,
		@ItemSerialNum	bigint, 
		@AbilityOpt	bigint, 
		@ItemResist	bigint, 
		@ResistAbilityOpt	bigint,
		@RandomOpt	bigint

DECLARE	@ItemString	varchar(500),
		@ItemStringLength	bigint

DECLARE	@ItemSetStartPos	bigint,
		@ItemSetEndPos	bigint,
		@ItemSetLength	bigint

DECLARE	@ItemElemStartPos	bigint,
		@ItemElemEndPos	bigint,
		@ItemElemLength		bigint,
		@ItemElemIndex		bigint,
		@ItemElemString		bigint
	
	IF LEFT(@pItemIndex,1)<>'/'			
		SET @pItemIndex = '/' + @pItemIndex


    SELECT	-1 as m_dwObjId, 
			-1 as m_dwItemId,
			-1 as m_nItemNum, 
			-1 as m_dwSerialNumber, 
			-1 as m_nAbilityOption, 
			-1 as m_bItemResist, 
			-1 as m_nResistAbilityOption, 
			-1 as m_nRandomOptItemId 
    INTO   #TMP

    SELECT @ItemStringLength = LEN(@pItemList)
    SELECT @ItemSetStartPos = 0                    -- ItemSet position(start)
    SELECT @ItemSetEndPos   = -1                    -- ItemSet position(end)

    WHILE ( @ItemSetEndPos <> 0 )	BEGIN
		SELECT @ItemSetStartPos = @ItemSetEndPos+1
        SELECT @ItemSetEndPos = CHARINDEX('/', @pItemList, @ItemSetStartPos)
		
		IF @ItemSetEndPos=0 BREAK

        SELECT @ItemSetLength = @ItemSetEndPos - @ItemSetStartPos
        
		--SELECT @ItemStringLength,@ItemSetStartPos, @ItemSetEndPos,@ItemSetLength
        IF (@ItemSetEndPos>@ItemStringLength) 
			BREAK
		ELSE BEGIN
			SELECT @ItemString = SUBSTRING(@pItemList, @ItemSetStartPos, @ItemSetLength)
			PRINT @ItemString
                
            SET	@ItemElemStartPos	= 1
            SET	@ItemElemEndPos		= 0
            SET	@ItemElemIndex		= 0

            WHILE(@ItemElemEndPos<=@ItemSetLength-1 AND @ItemElemIndex<16) BEGIN
				-- find next end point
				SELECT @ItemElemStartPos = @ItemElemEndPos + 1
				SELECT @ItemElemEndPos = CHARINDEX(',',@ItemString, @ItemElemStartPos)

				IF @ItemElemEndPos=0 BEGIN
					BREAK
				END
				ELSE BEGIN
					SELECT @ItemElemLength = @ItemElemEndPos - @ItemElemStartPos
						
	            	SET @ItemElemIndex = @ItemElemIndex + 1
	
					-- Get item element
               		SET @ItemElemString = SUBSTRING(@ItemString, @ItemElemStartPos, @ItemElemLength)
					
					IF(@ItemElemIndex= 1)	SET @ObjectID			=@ItemElemString
					IF(@ItemElemIndex= 2)	SET @ItemIndex			=@ItemElemString
					IF(@ItemElemIndex= 5)	SET @ItemName			=@ItemElemString
					IF(@ItemElemIndex= 6)	SET @ItemCnt			=@ItemElemString
					IF(@ItemElemIndex=12)	SET @ItemSerialNum		=@ItemElemString
					IF(@ItemElemIndex=13)	SET @AbilityOpt			=@ItemElemString
					IF(@ItemElemIndex=14)	SET @ItemResist			=@ItemElemString
					IF(@ItemElemIndex=15)	SET @ResistAbilityOpt	=@ItemElemString
				END
            END
			
			-- find ext information
			SET @RandomOpt = dbo.fnGetRandomOptFromExtInformation(@pItemExtList, @ObjectID)
			
			IF @pItemIndex='/' 
				SET @ObjectID=-1
			ELSE
				SET @ObjectID = dbo.fnGetPattern( SUBSTRING(@pItemIndex, 1, CHARINDEX('/' + LTRIM(STR(@ObjectID)) + '/', @pItemIndex, 0) ), '/' ) + 1

			SELECT @ObjectID AS 'ObjectID', @ItemIndex AS 'Item Index', @ItemName AS 'Item Name', @ItemCnt AS 'Item Cnt', @ItemSerialNum as 'Item Serial Num', @AbilityOpt AS 'Item Ability Opt', @ItemResist AS 'Item Resist', @ResistAbilityOpt AS 'Item Resist Ability', @RandomOpt AS 'Random Option'
		END
        --INSERT INTO #TMP SELECT @m_dwObjId, @m_dwItemId, @m_nItemNum, @m_dwSerialNumber, @m_nAbilityOption, @m_bItemResist, @m_nResistAbilityOption
    END

	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[uspLoadCharacterSkill]
		@serverindex	char(2),
		@pPlayerID		char(7)
AS
SET NOCOUNT ON

	SELECT PlayerID, SkillID, SkillLv, SkillPosition FROM tblSkillPoint 
	WHERE 	PlayerID=@pPlayerID 
	and		serverindex=@serverindex

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspLearnSkill]
		@serverindex 		char(2),
		@pPlayerID			char(7),
		@pSkillID			int,
		@pSkillLv			int,
		@pSkillPosition		int
AS
SET NOCOUNT ON

	IF @pSkillID=-1 BEGIN
		IF EXISTS ( SELECT * FROM dbo.tblSkillPoint WHERE serverindex=@serverindex AND PlayerID=@pPlayerID AND SkillPosition=@pSkillPosition) BEGIN
			
			DELETE	tblSkillPoint 
			WHERE	serverindex=@serverindex AND PlayerID=@pPlayerID and SkillPosition=@pSkillPosition
			
		END
	END
	ELSE BEGIN
		IF EXISTS ( SELECT * FROM dbo.tblSkillPoint WHERE serverindex=@serverindex AND PlayerID=@pPlayerID AND SkillPosition=@pSkillPosition) BEGIN
			
			UPDATE	tblSkillPoint 
			SET		SkillID=@pSkillID,SkillLv=@pSkillLv 
			WHERE	serverindex=@serverindex AND PlayerID=@pPlayerID AND SkillPosition=@pSkillPosition
			
		END
		ELSE BEGIN
		
			INSERT INTO tblSkillPoint VALUES (@serverindex, @pPlayerID, @pSkillID, @pSkillLv, @pSkillPosition)
			
		END
	END
		
	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[uspInquiryBC]
		@pFlag			char(1),
		@pInquiryDt		char(8)
AS
SET NOCOUNT ON

	IF @pFlag='A' BEGIN
		SELECT	m_nJob, 
				SUM(CASE serverindex WHEN '01' THEN cnt ELSE 0 END) s01,
				SUM(CASE serverindex WHEN '02' THEN cnt ELSE 0 END) s02,
				SUM(CASE serverindex WHEN '03' THEN cnt ELSE 0 END) s03,
				SUM(CASE serverindex WHEN '04' THEN cnt ELSE 0 END) s04,
				SUM(cnt) total
		FROM	TBL_STAT_JOB
		WHERE	s_date=@pInquiryDt
		GROUP BY m_nJob
	END
	ELSE IF @pFlag='B' BEGIN
		SELECT	m_nJob,
				SUM(CASE serverindex WHEN '01' THEN level ELSE 0 END) s01,
				SUM(CASE serverindex WHEN '02' THEN level ELSE 0 END) s02,
				SUM(CASE serverindex WHEN '03' THEN level ELSE 0 END) s03,
				SUM(CASE serverindex WHEN '04' THEN level ELSE 0 END) s04
		FROM	TBL_STAT_JOB
		WHERE	s_date=@pInquiryDt
		GROUP BY m_nJob
	END
	ELSE IF @pFlag='C' BEGIN
		SELECT	m_nJob,
				SUM(CASE serverindex WHEN '01' THEN playtime ELSE 0 END) s01,
				SUM(CASE serverindex WHEN '02' THEN playtime ELSE 0 END) s02,
				SUM(CASE serverindex WHEN '03' THEN playtime ELSE 0 END) s03,
				SUM(CASE serverindex WHEN '04' THEN playtime ELSE 0 END) s04
		FROM	TBL_STAT_JOB_PLAY_TIME
		WHERE	s_date=@pInquiryDt
		GROUP BY	m_nJob
	END
		

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure [dbo].[uspInquiryBBC]
		@pFlag			char(1)='A',
		@pserverindex	char(2),
		@pInquiryDt		char(8)
AS
SET NOCOUNT ON

	IF DB_NAME() <> 'EoCRM_DBF' BEGIN
		RETURN
	END

	IF @pFlag='A' BEGIN
		SELECT	m_nLevel, cnt
		FROM	TBL_STAT_LEVEL
		WHERE	serverindex=@pserverindex AND s_date=@pInquiryDt
	END
	ELSE IF @pFlag='B' BEGIN
		SELECT	account, m_szName, m_nLevel
		FROM	TBL_STAT_TOP_LEVEL
		WHERE	serverindex=@pserverindex AND s_date=@pInquiryDt
	END
	ELSE IF @pFlag='C' BEGIN
		SELECT account, m_szName, m_nLevel, total_Gold, m_dwGold, m_dwBank
		FROM	TBL_STAT_TOP_SEED
		WHERE	serverindex=@pserverindex AND s_date=@pInquiryDt
	END 
	ELSE IF @pFlag='D' BEGIN
		SELECT	total_gold, gold, bank_gold
		FROM	TBL_STAT_TOTAL_SEED
		WHERE	serverindex=@pserverindex AND s_date=@pInquiryDt
	END
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE	PROCEDURE [dbo].[uspInitMultiServer]
		@pserverindex	char(2),
		@pMultiServer	int
AS
SET NOCOUNT ON
	UPDATE tblMultiServerInfo SET MultiServer=0 
		WHERE serverindex=@pserverindex AND MultiServer=@pMultiServer

	SELECT 1
	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspInitializeLEvent]
@nServer int
as
set nocount on

update tblLordEvent
set nTick = 0
where nServer = @nServer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure [dbo].[uspGetMessengerFriend]
		@pserverindex		char(2),
		@pPlayerID			char(7)
AS
SET NOCOUNT ON

	SELECT	a.f_idPlayer, b.account, b.m_nJob, b.m_szName
	FROM	MESSENGER_TBL a 
			INNER JOIN CHARACTER_TBL b
			ON (a.f_idPlayer=b.m_idPlayer)
	WHERE	a.m_idPlayer=@pPlayerID
	ORDER BY	a.f_idPlayer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE        PROC [dbo].[CHARACTER_DELETE_STR]
AS
DECLARE @serverindex char(2)

DECLARE Delete_Server CURSOR FOR 
SELECT serverindex FROM CHARACTER_TBL GROUP BY serverindex ORDER BY serverindex

OPEN Delete_Server

FETCH NEXT FROM Delete_Server 
INTO @serverindex

WHILE @@FETCH_STATUS = 1
BEGIN

---		DECLARE @DeleteDelayDay int
---		set @DeleteDelayDay = '-7'
---		SELECT * FROM CHARACTER_TBL WHERE isblock='D' AND End_Time <= convert(char(8), DATEADD(d,@DeleteDelayDay,getdate()),112)

					DELETE CHARACTER_TBL WHERE isblock='D' AND  End_Time <= convert(char(8),DATEADD(d,-7,getdate()),112) and serverindex = @serverindex
					
					DECLARE @name varchar(256)
					DECLARE Delete_Cursor CURSOR FOR 
					SELECT	B.name
						FROM	syscolumns A,sysobjects B
						WHERE	A.id = B.id
					   AND B.name NOT IN('CHARACTER_TBL','MESSENGER_TBL')
					   AND A.name = 'm_idPlayer' and A.name = 'serverindex'
					   AND B.type='U'
					ORDER BY B.name
					
					OPEN Delete_Cursor
					
					FETCH NEXT FROM Delete_Cursor 
					INTO @name
					
					WHILE @@FETCH_STATUS = 1
					BEGIN
						PRINT @name + '삭제'
						EXEC('DELETE ' + @name + ' WHERE m_idPlayer NOT IN (SELECT m_idPlayer FROM CHARACTER_TBL where serverindex = ''' + @serverindex + ''') and serverindex = ''' + @serverindex + '''')
					   FETCH NEXT FROM Delete_Cursor 
					   INTO @name
					END
					
					DELETE TAG_TBL  WHERE f_idPlayer NOT IN (SELECT m_idPlayer FROM CHARACTER_TBL where serverindex = @serverindex) and serverindex = @serverindex
					
					PRINT '메신저 친구 삭제'
					-- 추가 2009-09-16 메신저 삭제 부분 추가 (EXEC MESSENGER_STR 'D2','',@serverindex 부분 주석 처리)
					delete tblMessenger
					where idPlayer not in (select m_idPlayer from CHARACTER_TBL where serverindex = @serverindex)

					delete tblMessenger
					where idFriend not in (select m_idPlayer from CHARACTER_TBL where serverindex = @serverindex)

--					EXEC MESSENGER_STR 'D2','',@serverindex

					
					PRINT 'Delete Skill'
					DELETE 	tblSkillPoint 
					WHERE 	PlayerID NOT IN (SELECT m_idPlayer FROM CHARACTER_TBL WHERE serverindex=@serverindex) 
					AND 	serverindex=@serverindex


					CLOSE Delete_Cursor
					DEALLOCATE Delete_Cursor

FETCH NEXT FROM Delete_Server 
INTO @serverindex

END
CLOSE Delete_Server
DEALLOCATE Delete_Server

RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
SELECT count(*) FROM tblSkillPoint

TRUNCATe TABLE tblSkillPoint
UPDATE CHARACTER_TBL SET SkillExp=0, SkillLv=0, SkillPoint=0

SELECT * FROM tblSkillPoint
SELECT m_idPlayer FROM CHARACTER_TBL WHERE serverindex='01' and m_idPlayer='033924'
TRUNCATE TABLE tblSkillPoint
dbo.uspConvertCharacterSkill '01', '033924'
SELECT serverindex, m_szName, m_idPlayer, m_nJob, m_nLevel, m_aJobSkill, m_nExp1 FROM CHARACTER_TBL WHERE m_aJobSkill=''

SELECT serverindex, m_szName, m_idPlayer, m_nJob, m_nLevel, m_aJobSkill, m_nExp1 FROM CHARACTER_TBL WHERE m_szName='향단이'
select * from tblSkillPoint WHERE PlayerID='009672'

20,1,1,1/0,1,2,1/0,1,3,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/0,1,-1,0/$



--SELECT * FROM CHARACTER_TBL WHERE m_szName='ccasse'
*/
CREATE                Procedure [dbo].[uspConvertCharacterSkill]
		@serverindex		char(2),
		@pPlayerID			char(7)='',
		@pEndPlayerID		char(7)='',
		@pSkillList			varchar(5000)=''
AS
SET NOCOUNT ON

	DECLARE	@SkillExp		int,
				@SkillLevel	int,
				@SkillID		int,
				@SkillStatus	int
				
    DECLARE	@SkillString		varchar(500),
				@SkillStringLength 	int

	DECLARE	@SkillSetStartPos	int,
				@SkillSetEndPos		int,
				@SkillSetLength		int
				
	DECLARE	@SkillElemStartPos	int,
				@SkillElemEndPos		int,
				@SkillElemLength		int,
				@SkillElemIndex		int,
				@SkillElemString		int
	
    SELECT	-1 as SkillExp,
			-1 as SkillLevel,
			-1 as SkillID, 
			-1 as SkillStatus
    INTO   #TMP

	DECLARE 	@CharacterLevel int,
				@Job	int,
				@CharExp	bigint

	DECLARE 	@ExtraPointForJob 	int,
				@ExtraPointForLevelExp	int,
				@LevelExpRatio		int,
				@FinalSkillPoint	int


	IF @pPlayerID='' BEGIN
		DELETE FROM tblSkillPoint WHERE serverindex=@serverindex
	END
	ELSE BEGIN
		DELETE FROM tblSkillPoint WHERE serverindex=@serverindex and PlayerID BETWEEN @pPlayerID and @pEndPlayerID
	END

	
	IF @pPlayerID='' BEGIN
		DECLARE curCharacter CURSOR FOR
			SELECT m_idPlayer, m_nJob, m_nLevel, m_aJobSkill, m_nExp1 FROM CHARACTER_TBL WHERE serverindex=@serverindex AND isblock<>'D'
	END
	ELSE BEGIN
		DECLARE curCharacter CURSOR FOR
			SELECT m_idPlayer, m_nJob, m_nLevel, m_aJobSkill, m_nExp1 FROM CHARACTER_TBL WHERE serverindex=@serverindex and m_idPlayer BETWEEN @pPlayerID and @pEndPlayerID
	END

	OPEN curCharacter

	FETCH NEXT FROM curCharacter INTO @pPlayerID, @Job, @CharacterLevel, @pSkillList, @CharExp

	--PRINT 'START'	
	WHILE(@@FETCH_STATUS=0) BEGIN
		--PRINT 'START'
		-- READ FROM TABLE
		--SELECT @CharacterLevel=m_nLevel , @pSkillList=m_aJobSkill FROM CHARACTER_TBL WHERE m_idPlayer=@pPlayerID and serverindex=@serverindex
	
	    SELECT @SkillStringLength = LEN(@pSkillList)
	    SELECT @SkillSetStartPos = 0             
	    SELECT @SkillSetEndPos   = -1          
	
		DECLARE @SkillPosition	int, @SkillPoint int, @Point int
		SET @SkillPosition=0
		SET @SkillPoint=0
		SET @Point=0
		SET 	@ExtraPointForJob 	=0
		SET		@ExtraPointForLevelExp	=0
		SET		@LevelExpRatio		=0
		SET @FinalSkillPoint=0
	
	
		--PRINT @SkillSetEndPos
		SET @SkillPosition=-1
		SET 	@ExtraPointForJob=0
		SET		@ExtraPointForLevelExp=0
		SET		@LevelExpRatio=0
		SET 	@SkillPoint=0

	    WHILE ( @SkillSetEndPos <> 0 )	BEGIN
			SET @Point=0

			SET @SkillPosition = @SkillPosition + 1
			SELECT @SkillSetStartPos = @SkillSetEndPos+1
	        SELECT @SkillSetEndPos = CHARINDEX('/', @pSkillList, @SkillSetStartPos)
			--PRINT @SkillSetEndPos
			
			IF @SkillSetEndPos=0 BREAK
	
	        SELECT @SkillSetLength = @SkillSetEndPos - @SkillSetStartPos
	        
	        IF (@SkillSetEndPos>@SkillStringLength) 
				BREAK
			ELSE BEGIN

				SELECT @SkillString = SUBSTRING(@pSkillList, @SkillSetStartPos, @SkillSetLength) + ','
				--PRINT @SkillString
	                
	            SET	@SkillElemStartPos	= 1
	            SET @SkillElemEndPos = CHARINDEX(',', @SkillString, @SkillElemStartPos)   
				SET @SkillElemLength = @SkillElemEndPos-@SkillElemStartPos
				
				SET @SkillExp = SUBSTRING(@SkillString, @SkillElemStartPos, @SkillElemLength)
				
				SET @SkillElemStartPos=@SkillElemEndPos+1
				SET @SkillElemEndPos=CHARINDEX(',',@SkillString, @SkillElemStartPos)
				SET @SkillElemLength = @SkillElemEndPos-@SkillElemStartPos
				
				SET @SkillLevel = SUBSTRING(@SkillString, @SkillElemStartPos, @SkillElemLength)
				
				SET @SkillElemStartPos=@SkillElemEndPos+1
				SET @SkillElemEndPos=CHARINDEX(',',@SkillString, @SkillElemStartPos)
				SET @SkillElemLength = @SkillElemEndPos-@SkillElemStartPos
				
				SET @SkillID = SUBSTRING(@SkillString, @SkillElemStartPos, @SkillElemLength)
	
				SET @SkillElemStartPos=@SkillElemEndPos+1
				SET @SkillElemEndPos=CHARINDEX(',',@SkillString, @SkillElemStartPos)
				SET @SkillElemLength = @SkillElemEndPos-@SkillElemStartPos
				
				SET @SkillStatus = SUBSTRING(@SkillString, @SkillElemStartPos, @SkillElemLength)
				
				--SELECT @SkillPosition as 'Skill Position', @SkillExp as 'Skill Exp', @SkillLevel as 'Skill Level', @SkillID as 'Skill ID', @SkillStatus as 'Skill Status'
			END
	
			SELECT @Point=CASE WHEN job=0 THEN 1 
								WHEN job in (1,2,3,4,5) THEN 2
								WHEN job>5 THEN 3
								ELSE 0 END * @SkillLevel
			 FROM MANAGE_DBF.dbo.SKILL_TBL WITH (NOLOCK)
			WHERE [Index]=@SkillID

			--PRINT @Point
			
			SET @SkillPoint = @SkillPoint + @Point
	
			--PRINT @SkillPoint

			IF @SkillID > -1 BEGIN		
		        INSERT INTO tblSkillPoint(serverindex, SkillPosition, PlayerID, SkillID, SkillLv) 
					SELECT @serverindex, @SkillPosition, @pPlayerID, @SkillID, 0
			END

	    END -- END OF WHILE

		-- EXTRA POINT FOR JOB	
		SELECT @ExtraPointForJob=CASE 	WHEN @Job=0 THEN 0
										WHEN @Job in (1,2,3,4,5) THEN 30
										WHEN @Job>5	THEN 60
								 ELSE 0	END
		
		-- EXTRA POINT FOR LEVEL EXP
		SELECT @LevelExpRatio = MANAGE_DBF.dbo.fn_GetExpRatio(@CharacterLevel, @CharExp)

		SELECT @ExtraPointForLevelExp = CASE WHEN @LevelExpRatio < 33 THEN 0
											WHEN @LevelExpRatio BETWEEN 33 AND 65 THEN 1
											WHEN @LevelExpRatio BETWEEN 66 AND 98 THEN 2
											WHEN @LevelExpRatio BETWEEN 99 AND 100 THEN 3
										ELSE 0 END
		
		IF @SkillPoint<(@CharacterLevel-1)*3
			SET @SkillPoint = (@CharacterLevel-1)*3

		UPDATE CHARACTER_TBL SET SkillExp	=0, 
								 SkillPoint	=@SkillPoint	+@ExtraPointForLevelExp + @ExtraPointForJob, 
								 SkillLv	=@SkillPoint	+@ExtraPointForLevelExp
		 WHERE m_idPlayer=@pPlayerID AND serverindex=@serverindex

		FETCH NEXT FROM curCharacter INTO @pPlayerID, @Job, @CharacterLevel, @pSkillList, @CharExp
	END	-- END OF CURSOR

	CLOSE curCharacter
	DEALLOCATE curCharacter

	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GuildHouse_MaxSEQ] 
@serverindex char(2)

AS

	
	SET NOCOUNT ON;

	SELECT SEQ, bSetup from tblGuildHouse_Furniture
	where serverindex = @serverindex
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspChangeMultiServer]
		@pserverindex 	char(2),
		@pidPlayer		char(7),
		@pMultiServer	int
AS
SET NOCOUNT ON	
	UPDATE tblMultiServerInfo SET MultiServer=@pMultiServer
		WHERE m_idPlayer=@pidPlayer and serverindex=@pserverindex

	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001
		RETURN
	END

	SELECT 1
	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Housing_Visit_Insert]
@serverindex char(2),
@m_idPlayer char(7),
@f_idPlayer char(7)
as
set nocount on

insert into tblHousing_Visit (serverindex, m_idPlayer, f_idPlayer)
select @serverindex, @m_idPlayer, @f_idPlayer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Housing_Visit_Delete]
@serverindex char(2),
@m_idPlayer char(7),
@f_idPlayer char(7)
as
set nocount on

delete tblHousing_Visit
where serverindex = @serverindex and m_idPlayer = @m_idPlayer and f_idPlayer = @f_idPlayer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Housing_Update]
@serverindex char(2),
@m_idPlayer char(7),
@ItemIndex int,
@bSetup int,
@x_Pos float,
@y_Pos float,
@z_Pos float,
@fAngle float
as
set nocount on
set xact_abort on

update tblHousing
set bSetup = @bSetup, x_Pos = @x_Pos, y_Pos = @y_Pos, z_Pos = @z_Pos, fAngle = @fAngle
where serverindex = @serverindex and m_idPlayer = @m_idPlayer and ItemIndex = @ItemIndex and bSetup <> 99
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Housing_Load]
@serverindex char(2),
@m_idPlayer char(7)
as
set nocount on

select serverindex, m_idPlayer, ItemIndex, tKeepTime, bSetup, x_Pos, y_Pos, z_Pos, fAngle, Start_Time, End_Time
from tblHousing with (nolock)
where serverindex = @serverindex and m_idPlayer = @m_idPlayer and bSetup <> 99

select serverindex, m_idPlayer, f_idPlayer
from tblHousing_Visit with (nolock)
where serverindex = @serverindex and m_idPlayer = @m_idPlayer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Housing_Insert]
@serverindex char(2),
@m_idPlayer char(7),
@ItemIndex int,
@tKeepTime bigint
as
set nocount on
set xact_abort on

insert into tblHousing (serverindex, m_idPlayer, ItemIndex, tKeepTime)
select @serverindex, @m_idPlayer, @ItemIndex, @tKeepTime
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Housing_Del]
@serverindex char(2),
@m_idPlayer char(7),
@ItemIndex int
as
set nocount on
set xact_abort on

update tblHousing
set bSetup = 99, End_Time = getdate()
where serverindex = @serverindex and m_idPlayer = @m_idPlayer and ItemIndex = @ItemIndex and bSetup <> 99
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE proc [dbo].[uspAttendance]

@serverindex char(2),
--@m_szName varchar(32)
@m_idPlayer char(7)

as

set nocount on

select master.dbo.dec2bin(dwEventFlag)
from CHARACTER_TBL
where serverindex = @serverindex and m_idPlayer = @m_idPlayer--m_szName = @m_szName
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspAddPropose]
@nServer int,
@idProposer int,
@tPropose int
as
set nocount on

insert into tblPropose (nServer, idProposer, tPropose)
select @nServer, @idProposer, @tPropose
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspAddNewCombat]
		@pCombatID		int,
		@pserverindex	char(2),
		@pComment		varchar(1000)=''
AS
SET NOCOUNT ON

	INSERT INTO tblCombatInfo(CombatID,serverindex,Status,StartDt,EndDt,Comment)
			VALUES (@pCombatID, @pserverindex, '10', NULL, NULL, @pComment)

	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001 as retValue
		RETURN
	END
	
	SELECT 1 as retValue
	RETURN
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspAddMessenger]
@serverindex    char(2),
@idPlayer       char(7),
@idFriend       char(7)
AS
SET NOCOUNT ON

IF EXISTS(SELECT * FROM tblMessenger WHERE serverindex = @serverindex AND idPlayer = @idPlayer AND idFriend = @idFriend)
BEGIN
        UPDATE tblMessenger SET chUse = 'T', bBlock = 0
        WHERE serverindex = @serverindex AND idPlayer = @idPlayer AND idFriend = @idFriend
END
ELSE
BEGIN
        INSERT tblMessenger (serverindex, idPlayer, idFriend) VALUES (@serverindex, @idPlayer, @idFriend)
END

IF EXISTS(SELECT * FROM tblMessenger WHERE serverindex = @serverindex AND idPlayer = @idFriend AND idFriend = @idPlayer)
BEGIN
        UPDATE tblMessenger SET chUse = 'T', bBlock = 0
        WHERE serverindex = @serverindex AND idPlayer = @idFriend AND idFriend = @idPlayer
END
ELSE
BEGIN
        INSERT tblMessenger (serverindex, idPlayer, idFriend) VALUES (@serverindex, @idFriend, @idPlayer)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspAddLEComponent]
@nServer int,
@idPlayer int,
@nTick int,
@fEFactor float,
@fIFactor float
as
set nocount on

if exists (select * from tblLordEvent where nServer = @nServer and idPlayer = @idPlayer and nTick > 0)
begin
	select bResult = 0
end
else
begin
	insert into tblLordEvent (nServer, idPlayer, nTick, fEFactor, fIFactor)
	values (@nServer, @idPlayer, @nTick, @fEFactor, @fIFactor)

	select bResult = 1
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspEndCombat]
		@pCombatID		int,
		@pserverindex	char(2)
AS
SET NOCOUNT ON

	UPDATE tblCombatInfo SET Status='30',EndDt=getdate() WHERE CombatID=@pCombatID AND serverindex=@pserverindex

	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001 as retValue
		RETURN
	END

	SELECT 1 as retValue
	RETURN 1
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspElectionSetPledge]
@nServer int,
@idElection int,
@idPlayer int,
@szPledge varchar(255)
as
set nocount on
set xact_abort on

update tblLordCandidates
set szPledge = @szPledge, nPledge = nPledge + 1
where nServer = @nServer and idElection = @idElection and idPlayer = @idPlayer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create  proc [dbo].[uspElectionLeaveOut]
@nServer int,
@idElection int,
@idPlayer int
as
set nocount on
set xact_abort on

update tblLordCandidates
set IsLeftOut = 'D'
where nServer = @nServer and idElection = @idElection and idPlayer = @idPlayer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create  proc [dbo].[uspElectionInitialize]
@nServer int,
@idElection int,
@szBegin varchar(16)
as
set nocount on
set xact_abort on

insert into tblLordElection (nServer, idElection, eState, szBegin)
values (@nServer, @idElection, 0, @szBegin)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspElectionIncVote]
@nServer int,
@idElection int,
@idPlayer int,
@idElector int
as
set nocount on
set xact_abort on

if exists (select * from tblLordElector where nServer = @nServer and idElection = @idElection and idElector = @idElector)
begin
	select	bResult = 0
end
else
begin
	insert tblLordElector (nServer, idElection, idElector)
	values (@nServer, @idElection, @idElector)

	update tblLordCandidates
	set nVote = nVote + 1
	where nServer = @nServer and idElection = @idElection and idPlayer = @idPlayer

	select bResult = 1
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspElectionEndVote]
@nServer int,
@idElection int,
@idPlayer int,
@szBegin varchar(16)
as
set nocount on
set xact_abort on

update tblLordElection
set eState = 3
where nServer = @nServer and idElection = @idElection

update tblLordSkill
set nTick =0
where nServer = @nServer

insert into tblLord (nServer, idElection, idLord)
values (@nServer, @idElection, @idPlayer)

insert into tblLordElection (nServer, idElection, eState, szBegin)
values (@nServer, @idElection + 1, 0, @szBegin)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspElectionBeginVote]
@nServer int,
@idElection int
as
set nocount on
set xact_abort on

update tblLordElection
set eState = 2
where nServer = @nServer and idElection = @idElection

select top 1 nRequirement = chrcount from tblElection order by s_week desc
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspElectionBeginCandidacy]
@nServer int,
@idElection int
as
set nocount on
set xact_abort on

if exists ( select * from tblLordElection where nServer = @nServer and idElection = @idElection )
begin
	update tblLordElection
	set eState = 1
	where nServer = @nServer and idElection = @idElection
end
else
begin
	insert tblLordElection ( nServer, idElection, eState )
	values ( @nServer, @idElection, 1 )
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------
create proc [dbo].[uspElectionAddDeposit]
@nServer int,
@idElection int,
@idPlayer int,
@iDeposit bigint,
@tCreate int
as
set nocount on
set xact_abort on

if exists (select * from tblLordCandidates where nServer = @nServer and idElection = @idElection and idPlayer = @idPlayer)
begin
	update tblLordCandidates
	set iDeposit = iDeposit + @iDeposit
	where nServer = @nServer and idElection = @idElection and idPlayer = @idPlayer
end
else
begin
	insert into tblLordCandidates (nServer, idElection, idPlayer, iDeposit, szPledge, nVote, tCreate)
	values (@nServer, @idElection, @idPlayer, @iDeposit, '', 0, @tCreate)
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspDeletePropose]
@nServer int,
@tPropose int
as
set nocount on

delete tblPropose where nServer = @nServer and tPropose < @tPropose
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspDeleteMessenger]
@serverindex    char(2),
@idPlayer               char(7),
@idFriend               char(7)
AS
SET NOCOUNT ON

UPDATE tblMessenger SET chUse = 'F' WHERE serverindex = @serverindex AND ( ( idPlayer = @idPlayer AND idFriend = @idFriend ) OR ( idPlayer = @idFriend AND idFriend = @idPlayer ) )
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[WANTED_STR]
@iGu char(2) = 'S1',
@im_idPlayer CHAR(7) = '',
@iserverindex CHAR(2) = '',
@ipenya INT = 0,
@iszMsg VARCHAR(40) = ''
AS
SET NOCOUNT ON
IF @iGu = 'A1'
	BEGIN 
		IF EXISTS(SELECT m_idPlayer FROM WANTED_TBL WHERE m_idPlayer =@im_idPlayer AND serverindex = @iserverindex)
			UPDATE WANTED_TBL
				   SET penya = penya + @ipenya,
							szMsg = CASE WHEN @iszMsg = '' THEN szMsg ELSE @iszMsg END,
							s_date = CONVERT(CHAR(8),DATEADD(d,30,GETDATE()),112) + '2359'
			 WHERE m_idPlayer =@im_idPlayer 
			       AND serverindex = @iserverindex
		ELSE
			INSERT WANTED_TBL
				(m_idPlayer,serverindex,penya,szMsg,s_date,CreateTime)
			VALUES
				(@im_idPlayer,@iserverindex,@ipenya, @iszMsg,CONVERT(CHAR(8),DATEADD(d,30,GETDATE()),112) + '2359',GETDATE())
	END 
/*
	
	 현상금 걸기
	 ex ) 
	 WANTED_STR 'A1',@im_idPlayer,@iserverindex,@ipenya,@iszMsg
	 WANTED_STR 'A1','000001','01',1000,1
*/
ELSE
IF @iGu = 'S1'
	BEGIN
		IF EXISTS(SELECT m_idPlayer FROM  WANTED_TBL WHERE s_date  <= CONVERT(CHAR(8),GETDATE(),112) + '2359' AND serverindex = @iserverindex) 
			DELETE WANTED_TBL
			WHERE s_date  <= CONVERT(CHAR(8),GETDATE(),112) + '2359'
			    AND serverindex = @iserverindex

		SELECT A.m_idPlayer,A.serverindex,B.m_szName,szMsg = ISNULL(A.szMsg,''),A.penya,A.s_date
		   FROM WANTED_TBL A,CHARACTER_TBL B
		 WHERE A.m_idPlayer = B.m_idPlayer
		      AND A.serverindex = B.serverindex
	END
/*
	
	 현상금 리스트 가져오기
	 ex ) 
	 WANTED_STR 'S1',@im_idPlayer,@iserverindex
	WANTED_STR 'S1','','01'
*/
ELSE
IF @iGu = 'D1'
	BEGIN
		DELETE WANTED_TBL
		WHERE m_idPlayer =@im_idPlayer 
		     AND serverindex = @iserverindex
	END
/*
	
	 현상금 삭제
	 ex ) 
	 WANTED_STR 'D1',@im_idPlayer,@iserverindex
	WANTED_STR 'D1','000001','01'
*/
RETURN
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viwCharacterItem]
AS
	SELECT 	a.m_idPlayer,
			a.serverindex,
			a.m_szName,
			a.m_nLevel,
			b.m_Inventory,
			c.m_extInventory,
			d.m_Bank,
			e.m_extBank
	FROM	CHARACTER_TBL a 
			INNER JOIN INVENTORY_TBL b ON (a.m_idPlayer=b.m_idPlayer)
			INNER JOIN INVENTORY_EXT_TBL c ON (a.m_idPlayer=c.m_idPlayer)
			INNER JOIN BANK_TBL d ON (a.m_idPlayer=d.m_idPlayer)
			INNER JOIN BANK_EXT_TBL e ON (a.m_idPlayer=e.m_idPlayer)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[viw_Item_Info]
as
select a.m_idPlayer, a.serverindex, b.m_Inventory,c.m_Bank,
	(select top 1 szItem from tblPocket with (nolock) where nPocket = 0 and idPlayer = a.m_idPlayer) as szItem0,
	(select top 1 szItem from tblPocket with (nolock) where nPocket = 1 and idPlayer = a.m_idPlayer) as szItem1,
	(select top 1 szItem from tblPocket with (nolock) where nPocket = 2 and idPlayer = a.m_idPlayer) as szItem2
from CHARACTER_TBL as a with (nolock)
			inner join INVENTORY_TBL as b with (nolock) on a.serverindex = b.serverindex and a.m_idPlayer = b.m_idPlayer
			inner join BANK_TBL as c with (nolock) on a.serverindex = c.serverindex and a.m_idPlayer = c.m_idPlayer
where a.isblock = 'F'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[view_character_level]
as
select a.m_idPlayer,a.serverindex,a.m_szName,m_nLevel=(a.m_nLevel/10)+1,b.m_Inventory,c.m_Bank
from CHARACTER_TBL a,INVENTORY_TBL b,BANK_TBL c
where a.m_idPlayer = b.m_idPlayer
and b.m_idPlayer = c.m_idPlayer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspUpdateMessenger]
@serverindex    char(2),
@idPlayer               char(7),
@idFriend               char(7),
@bBlock                 int
AS
SET NOCOUNT ON

UPDATE tblMessenger SET bBlock = @bBlock WHERE serverindex = @serverindex AND idPlayer = @idPlayer AND idFriend = @idFriend
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCouplePlayer](
	[cid] [int] NULL,
	[nServer] [int] NULL,
	[idPlayer] [int] NULL,
 CONSTRAINT [UQ_tblCouplePlayer_idPlayer] UNIQUE CLUSTERED 
(
	[nServer] ASC,
	[idPlayer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_BulkMailingList_Test_Input]
@email varchar(300),
@uname varchar(300)
as
set nocount on
set xact_abort on

insert into TBL_MMAIL_TestList (email, uname)
select @email, @uname
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_BulkMailingList_Test]
as
set nocount on

select email, uname
from TBL_MMAIL_TestList with (nolock)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_BulkMailingList]
as
set nocount on

select [id] as 'mid', title , isnull(sender_name, 'FLYFF') as 'sender', input_date , body as 'mbody', text_type
from TBL_MMAIL with (nolock)
where [id] >= 1 and left(sql_statement, 1) <> '&'
order by [id] desc
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_BulkMailingID_Max]
as
set nocount on

select case when max([id]) < 200 then 200 else max([id]) end as 'mid'
from TBL_MMAIL
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_BulkMailing_SendCount]
@mid int
as
set nocount on

update TBL_MMAIL
set send_count = send_count + 1
where [id] = @mid
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_BulkMailing_Create]
@mid int,
@title varchar(100) = '',
@sender varchar(100) = '',
@mbody text = '',
@uid varchar(20) = '',
@HTML int = 1
as
set nocount on
set xact_abort on

declare @q1 nvarchar(4000), @q2 nvarchar(4000)
if not exists (select * from TBL_MMAIL with (nolock) where [id] = @mid)
begin
	set @q1 = '	
	select 이메일 as ''email'', 이름 as ''uname'' into mail_[&mid&]
	from ONLINE_DBF.dbo.USER_TBL (nolock)
	where 메일수신여부 = ''Y'' and len(이메일) >= 6'
	set @q2 = replace(@q1, '[&mid&]', cast(@mid as varchar(10)))
	exec sp_executesql @q2

	insert into TBL_MMAIL ([id], comment, title, sender_name, body, input_date, input_id, text_type, send_count)
	select @mid, @title, @title, @sender, @mbody, getdate(), @uid, @HTML, 0
end
else
begin
	update TBL_MMAIL
	set comment = @title, title = @title, sender_name = @sender, body = @mbody, input_id = @uid, text_type = @HTML
	where [id] = @mid
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_BulkMailing_CheckCount]
@mid int
as
set nocount on

declare @q1 nvarchar(4000), @q2 nvarchar(4000)
declare @total int, @count int

set @q1 = 'select @total = count(*) from mail_[&mid&] with (nolock)'
set @q2 = replace(@q1, '[&mid&]', @mid)
exec sp_executesql @q2, N'@total int output', @total output

select @count = send_count from TBL_MMAIL with (nolock) where [id] = @mid

select @count as 'scount', @total as 'tcount'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_bf]

@serverindex char(2),
@ls_date char(8),
@hs_date char(8)

as

set nocount on

SELECT	s_date								as [Date],
	total_money							as [TotalPenya],
	total_money - pre_money						as [InDeCreasePenya],
	sell_money							as [SellItem],
	buy_money							as [BuyItem],
	sell_money - buy_money						as [TradeEarning],
	(sell_money - buy_money ) / join_chr				as [AVGTradeEaringPerDailyCharacter],
	quest_money							as [QuestEarning],
	total_money - pre_money - sell_money + buy_money - quest_money	as [GetPenya],
	total_money - pre_money + buy_money				as [TotalGrowthPenya],
	join_chr								as [JoinCharacter]
FROM   TBL_STAT_ECONOMY
WHERE  serverindex = @serverindex
	AND s_date >= @ls_date
	AND s_date <= @hs_date
ORDER BY s_date
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_be]

@ls_date char(8),
@hs_date char(8)

as

set nocount on

SELECT s_date, user_cnt, play_time
FROM   TBL_STAT_TOTAL_PLAY_TIME
WHERE  s_date >= @ls_date
	AND  s_date <= @hs_date
ORDER BY s_date
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_bc_time]

@s_date char(8)

as

set nocount on

SELECT m_nJob,  SUM(CASE serverindex WHEN '01' THEN playtime ELSE 0 END) s01,
	SUM(CASE serverindex WHEN '02' THEN playtime ELSE 0 END) s02,
	SUM(CASE serverindex WHEN '03' THEN playtime ELSE 0 END) s03,
	SUM(CASE serverindex WHEN '04' THEN playtime ELSE 0 END) s04
FROM   TBL_STAT_JOB_PLAY_TIME
WHERE  s_date = @s_date
GROUP BY m_nJob
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_bc_level]

@s_date char(8)

as

set nocount on

SELECT m_nJob,  SUM(CASE serverindex WHEN '01' THEN level ELSE 0 END) s01,
	SUM(CASE serverindex WHEN '02' THEN level ELSE 0 END) s02,
	SUM(CASE serverindex WHEN '03' THEN level ELSE 0 END) s03,
	SUM(CASE serverindex WHEN '04' THEN level ELSE 0 END) s04
FROM   TBL_STAT_JOB
WHERE  s_date = @s_date
GROUP BY m_nJob
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_bc_cnt]

@s_date char(8)

as

set nocount on

SELECT m_nJob,  SUM(CASE serverindex WHEN '01' THEN cnt ELSE 0 END) s01,
	SUM(CASE serverindex WHEN '02' THEN cnt ELSE 0 END) s02,
	SUM(CASE serverindex WHEN '03' THEN cnt ELSE 0 END) s03,
	SUM(CASE serverindex WHEN '04' THEN cnt ELSE 0 END) s04,
	SUM(cnt) total
FROM   TBL_STAT_JOB
WHERE  s_date = @s_date
GROUP BY m_nJob
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[TAX_DETAIL_STR]
@iGu char(2) = 'S2',
@serverindex char(2) = '01',
@nTimes int,
@nContinent int,
@nTaxKind int,
@nTaxRate int,
@nTaxCount int,
@nTaxGold int,
@nTaxPerin int,
@nNextTaxRate int
as

set nocount on

if @iGu = 'S2'
begin
	select nTaxKind, nTaxRate, nTaxCount, nTaxGold, nTaxPerin, nNextTaxRate
	from TAX_DETAIL_TBL
	where serverindex = @serverindex and nTimes = @nTimes and nContinent = @nContinent
end

if @iGu = 'I1'
begin
	insert into TAX_DETAIL_TBL (serverindex, nTimes, nContinent, nTaxKind, nTaxRate, nTaxCount, nTaxGold, nTaxPerin, nNextTaxRate)
	select @serverindex, @nTimes, @nContinent, @nTaxKind, @nTaxRate, @nTaxCount, @nTaxGold, @nTaxPerin, @nNextTaxRate
end

if @iGu = 'U1'
begin
	update TAX_DETAIL_TBL
	set nTaxRate = @nTaxRate, nTaxCount = @nTaxCount, nTaxGold = @nTaxGold, nTaxPerin = @nTaxPerin, nNextTaxRate = @nNextTaxRate
	where serverindex = @serverindex and nTimes = @nTimes and nContinent = @nContinent and nTaxKind = @nTaxKind
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SECRET_ROOM_MEMBER_STR]
@iGu char(2),
@serverindex char(2),
@nTimes int,
@nContinent int,
@m_idGuild char(6),
@m_idPlayer char(7)
as

set nocount on
set xact_abort on

if @iGu = 'S2'
begin
	select m_idPlayer
	from SECRET_ROOM_MEMBER_TBL
	where serverindex = @serverindex and nTimes = @nTimes and nContinent = @nContinent and m_idGuild = @m_idGuild
end

if @iGu = 'I1'
begin
	insert into SECRET_ROOM_MEMBER_TBL (serverindex, nTimes, nContinent, m_idGuild, m_idPlayer)
	select @serverindex, @nTimes, @nContinent, @m_idGuild, @m_idPlayer
end

if @iGu = 'D1'
begin
	delete SECRET_ROOM_MEMBER_TBL
	where serverindex = @serverindex and nTimes = @nTimes and nContinent = @nContinent and m_idGuild = @m_idGuild
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_aac_one]

@num int

as

set nocount on

SELECT A.code1 code1,
       A.code2 code2,
       A.code3 code3,
       B.title title, 
       A.block_day block_day,
       A.web_day   web_day,
       A.old_block_day,
       A.old_web_day,
       A.input_id,
       A.input_day,
       CASE A.code3 
            WHEN 1 THEN B.code3_1
            WHEN 2 THEN B.code3_2
            WHEN 3 THEN B.code3_3
            WHEN 4 THEN B.code3_4
                END AS code,
       A.reason
FROM   TBL_LOG_BLOCK_ACCOUNT A, TBL_CODE_BLOCK B
WHERE  A.num = @num
AND    A.code1 = B.code1
AND    A.code2 = B.code2
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_aac_grid]

@account varchar(32)

as

set nocount on

/*SELECT num, A.code1 as code1, A.code2 as code2, A.code3 as code3, A.block_day as block_day, A.web_day as web_day
FROM   TBL_LOG_BLOCK_ACCOUNT as A left outer join TBL_CODE_BLOCK as B on (A.code1 = B.code1 and A.code2 = B.code2)
WHERE  A.account = 'my791213'
*/
select num, code1, code2, code3, block_day, web_day
from TBL_LOG_BLOCK_ACCOUNT
where account = @account
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_aab_code]

@condition tinyint

as

set nocount on

select code1, code2, title, code3_1, code3_2, code3_3, code3_4
from TBL_CODE_BLOCK
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_Campus_Load    Script Date: 2009-12-01 오후 2:41:44 ******/





/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.11.20
3. 스크립트 명 : usp_Campus_Load
4. 스크립트 목적 : 사제 리스트 호출 
5. 매개변수
	@serverindex	char(2)		: 서버군
6. 리턴값 	
	idCampus			: 사제 ID
	serverindex			: 서버군
7. 수정 내역
8. 샘플 실행 코드
    EXEC usp_Campus_Load '05'
9. 조회 및 ident 값 초기화
	select * from tblCampus
	delete tblCampus
============================================================*/

CREATE   proc [dbo].[usp_Campus_Load] 

	@serverindex char(2)

as
set nocount on

	select idCampus, serverindex from tblCampus (nolock)
	where serverindex = @serverindex
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_Campus_Insert    Script Date: 2009-12-01 오후 2:41:44 ******/


/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.11.20
3. 스크립트 명 : usp_Campus_Insert
4. 스크립트 목적 : 사제 리스트 입력
5. 매개변수
	@idCampus		int			: 사제 ID
	@serverindex	char(2)		: 서버군
6. 리턴값 	
7. 수정 내역
8. 샘플 실행 코드
    EXEC usp_Campus_Insert 123, '05'
9. 조회 및 ident 값 초기화
	select * from tblCampus
	delete tblCampus
============================================================*/

CREATE       proc [dbo].[usp_Campus_Insert]

	@idCampus int, 
	@serverindex char(2)

as

set nocount on
set xact_abort on

	insert into tblCampus(idCampus, serverindex)
	select @idCampus, @serverindex
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_Campus_Delete    Script Date: 2009-12-01 오후 2:41:44 ******/


/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.11.20
3. 스크립트 명 : usp_Campus_Delete
4. 스크립트 목적 : 사제 리스트 삭제
5. 매개변수
	@idCampus		int			: 사제 ID
	@serverindex	char(2)		: 서버군
6. 리턴값 	
7. 수정 내역
8. 샘플 실행 코드
    EXEC usp_Campus_Delete 123, '05'
9. 조회 및 ident 값 초기화
	select * from tblCampus
	delete tblCampus
============================================================*/

CREATE      proc [dbo].[usp_Campus_Delete]

	@idCampus int, 
	@serverindex char(2)

as

set nocount on
set xact_abort on

	delete tblCampus where idCampus = @idCampus and serverindex = @serverindex
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_BulkMailingSend]
@mid int
as
set nocount on

select title, body
from TBL_MMAIL (nolock)
where [id] = @mid
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_BankPW_Check    Script Date: 2009-12-28 ?? 10:56:17 ******/






/*============================================================
1. ??? : ???
2. ??? : 2009.12.10
3. ???? ? : usp_BankPW_Check
4. ???? ?? : ?? ??? ?? 
5. ????
	@serverindex	char(2)		: ???
	@m_idPlayer		char(7)		: ??? ID
	@BankPW			char(4)		: Bank PW
6. ??? 	
	f_check			: 0 - ??, 1 - ???
7. ?? ??
8. ?? ?? ??
    EXEC usp_BankPW_Check '01', '1111111', '1234'
9. ?? ? ident ? ???
============================================================*/

CREATE    proc [dbo].[usp_BankPW_Check] 

	@serverindex char(2),
	@m_idPlayer char(7),
	@BankPW char(4)

as
set nocount on

	declare @c_BankPW char(4)
	select @c_BankPW = m_BankPw from BANK_TBL (nolock)
	where serverindex = @serverindex and m_idPlayer = @m_idPlayer

	if @c_BankPW = @BankPW
		select f_check = 0
	else
		select f_check = 1
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_AccountPlay_Update]
	@i_Account varchar(32)
	, @i_PlayDate int
	, @i_PlayTime int
as

set nocount on
set transaction isolation level read uncommitted

update ACCOUNT_DBF.dbo.AccountPlay set
	PlayDate = @i_PlayDate
	, PlayTime = @i_PlayTime
where Account = @i_Account
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_AccountPlay_Select]
@i_Account varchar(32)
as
set nocount on
set transaction isolation level read uncommitted

select PlayDate
	, PlayTime
from ACCOUNT_DBF.dbo.AccountPlay
where Account = @i_Account
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[usp_AccountBlockList_Sel]
@account varchar(32)

as
/*
사용처 : Account 제제 리스트
만든이 : 강현석
제작일 : 2007.08.30
주의점 : 
*/

set nocount on

	SELECT num, A.code1, A.code2, A.code3, A.block_day, A.web_day, A.input_id, A.input_day, B.title
	FROM TBL_LOG_BLOCK_ACCOUNT A, TBL_CODE_BLOCK B
	WHERE A.account = @account AND A.code1 = B.code1 AND A.code2 = B.code2
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[usp_AccountBlockDetail_Sel]
@num int
as
/*
사용처 : Account 제제 상세정보
만든이 : 강현석
제작일 : 2007.08.30
주의점 : 
*/
set nocount on
	SELECT num, A.code1, A.code2, A.code3, B.title, A.block_day, A.web_day,
	A.old_block_day, A.old_web_day, A.input_id, A.input_day, CASE A.code3
	WHEN 1 THEN B.code3_1
	WHEN 2 THEN B.code3_2
	WHEN 3 THEN B.code3_3
	WHEN 4 THEN B.code3_4
	END AS code, A.reason FROM
	TBL_LOG_BLOCK_ACCOUNT A, TBL_CODE_BLOCK B WHERE num = @num AND
	A.code1 = B.code1 AND A.code2 = B.code2
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GuildHouse_Load]
@serverindex char(2)

as
set nocount on

select serverindex, m_idGuild, dwWorldID, tKeepTime from tblGuildHouse (nolock)
where serverindex = @serverindex
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.usp_GuildHouse_Insert    Script Date: 2009-12-28 ?? 10:56:17 ******/




/*============================================================
1. ??? : ???
2. ??? : 2009.11.23
3. ???? ? : usp_GuildHouse_Insert
4. ???? ?? : ?? ??? ??
5. ????
	@serverindex char(2)	???
	@m_idGuild char(6)		?? ID
	@dwWorldId int			World ID
	@tKeepTime int			?? ??? ?? ????
6. ??? 	
7. ?? ??
8. ?? ?? ??
    EXEC usp_GuildHouse_Insert '01', '000011', 240, 150

select * from GUILD_TBL
9. ?? ? ident ? ???
	select * from tblGuildHouse
	select * from LOGGING_01_DBF.dbo.tblGuildHouseLog
	delete tblGuildHouse
============================================================*/

CREATE proc [dbo].[usp_GuildHouse_Insert]
	@serverindex char(2),
	@m_idGuild char(6), 
	@dwWorldId int, 
	@tKeepTime int
as

set nocount on
set xact_abort on

	declare @m_szGuild varchar(32)
	declare @q1 nvarchar(2000)

	select @m_szGuild = m_szGuild from GUILD_TBL (nolock)
	where m_idGuild = @m_idGuild and serverindex = @serverindex

	INSERT INTO tblGuildHouse (serverindex, m_idGuild, dwWorldID, tKeepTime, m_szGuild)
	select @serverindex, @m_idGuild, @dwWorldId, @tKeepTime, @m_szGuild

	set @q1 = 'insert into LOGGING_[&@serverindex&]_DBF.dbo.tblGuildHouseLog (serverindex, m_idGuild, dwWorldID, tKeepTime, m_szGuild)
		select ''[&@serverindex&]'', ''[&@m_idGuild&]'', [&@dwWorldId&], [&@tKeepTime&], ''[&@m_szGuild&]'''
	set @q1 = replace (@q1, '[&@serverindex&]', @serverindex)
	set @q1 = replace (@q1, '[&@m_idGuild&]', @m_idGuild)
	set @q1 = replace (@q1, '[&@dwWorldId&]', @dwWorldId)
	set @q1 = replace (@q1, '[&@tKeepTime&]', @tKeepTime)
	set @q1 = replace (@q1, '[&@m_szGuild&]', @m_szGuild)

	exec sp_executesql @q1, N' @serverindex char(2), @m_idGuild char(6), @dwWorldId int, 	@tKeepTime int, @m_szGuild varchar(32)', @serverindex, @m_idGuild, @dwWorldId, @tKeepTime, @m_szGuild
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.usp_GuildHouse_Expired    Script Date: 2009-12-01 오후 2:41:44 ******/





/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.11.23
3. 스크립트 명 : usp_GuildHouse_Expired
4. 스크립트 목적 : 길드 하우스 만료
5. 매개변수
	@serverindex char(2)	서버군
	@m_idGuild char(6)		길드 ID
6. 리턴값 	
7. 수정 내역
8. 샘플 실행 코드
    EXEC usp_GuildHouse_Expired '05', '123456'
9. 조회 및 ident 값 초기화
	select * from tblGuildHouse
	delete tblGuildHouse
============================================================*/

CREATE   proc [dbo].[usp_GuildHouse_Expired]
	@serverindex char(2),
	@m_idGuild char(6)
as

set nocount on
set xact_abort on

	if exists ( select * from tblGuildHouse (nolock) where serverindex = @serverindex and m_idGuild = @m_idGuild)
	begin
		update tblGuildHouse
		set tKeepTime = 0
		where serverindex = @serverindex and m_idGuild = @m_idGuild

		update tblGuildHouse_Furniture
		set bSetup = 0
		where serverindex = @serverindex and m_idGuild = @m_idGuild
	end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*============================================================    
1. 작성자 : 박혜민    
2. 작성일 : 2009.11.23    
3. 스크립트 명 : usp_GuildHouse_Delete    
4. 스크립트 목적 : 길드 하우스 수정    
5. 매개변수    
 @serverindex char(2) 서버군    
 @m_idGuild char(6)  길드 ID    
6. 리턴값      
7. 수정 내역    
8. 샘플 실행 코드    
    EXEC usp_GuildHouse_Delete '05', '123456'    
9. 조회 및 ident 값 초기화    
 select * from tblGuildHouse    
 delete tblGuildHouse    
============================================================*/    
    
CREATE         proc [dbo].[usp_GuildHouse_Delete]    
 @serverindex char(2),    
 @m_idGuild char(6)    
as    
    
set nocount on    
set xact_abort on    
    
if exists ( select * from tblGuildHouse where serverindex = @serverindex and m_idGuild = @m_idGuild)    
 begin     
 if exists (select * from tblGuildHouse_Furniture (nolock) where serverindex = @serverindex and m_idGuild = @m_idGuild)    
  begin    
   exec usp_GuildFurniture_Log @serverindex, @m_idGuild    
     
   delete tblGuildHouse_Furniture    
   where serverindex = @serverindex and m_idGuild = @m_idGuild    
  end    
  
  exec usp_GuildHouse_Log  @serverindex, @m_idGuild    
  
  delete tblGuildHouse     
  where serverindex = @serverindex and m_idGuild = @m_idGuild    
 end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE proc [dbo].[usp_GuildFurniture_Update]  
 @serverindex char(2),   
 @m_idGuild char(6),   
 @SEQ int,   
 @ItemIndex int,   
 @bSetup float,   
 @x_Pos float,    
 @y_Pos float,   
 @z_Pos float,   
 @fAngle float,   
 @tKeepTime int  
as  
  
set nocount on  
set xact_abort on  
  
 if exists ( select * from tblGuildHouse_Furniture (nolock) where serverindex = @serverindex and m_idGuild = @m_idGuild and SEQ = @SEQ)  
 begin  
	declare @s_tKeepTime int
	select @s_tKeepTime = tKeepTime from tblGuildHouse_Furniture (nolock) where serverindex = @serverindex and m_idGuild = @m_idGuild and SEQ = @SEQ

	if (@s_tKeepTime = 0 and @bSetup = 1)
	  update tblGuildHouse_Furniture   
	  set bSetup = @bSetup, x_Pos = @x_Pos, y_Pos = @y_Pos, z_Pos = @z_Pos, fAngle = @fAngle, tKeepTime = @tKeepTime, set_date = getdate()  
	  where serverindex = @serverindex and m_idGuild = @m_idGuild and SEQ = @SEQ  
	else
	  update tblGuildHouse_Furniture   
	  set bSetup = @bSetup, x_Pos = @x_Pos, y_Pos = @y_Pos, z_Pos = @z_Pos, fAngle = @fAngle, tKeepTime = @tKeepTime
	  where serverindex = @serverindex and m_idGuild = @m_idGuild and SEQ = @SEQ  
	
 end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_GuildFurniture_Load]
@serverindex char(2),
@m_idGuild char (6)


as
set nocount on

select serverindex, m_idGuild,  tKeepTime, x_pos, y_pos, z_pos, fAngle,ItemIndex,SEQ from tblGuildHouse_Furniture (nolock)
where serverindex = @serverindex AND m_idGuild = @m_idGuild
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_GuildFurniture_Insert    Script Date: 2009-12-28 ?? 10:56:17 ******/
/*============================================================      
1. ??? : ???      
2. ??? : 2009.11.23      
3. ???? ? : usp_GuildFurniture_Insert      
4. ???? ?? : ?? ?? ??      
5. ????      
 @serverindex char(2)  ???      
 @m_idGuild char(6)   ??ID      
 @ItemIndex int    ??? ID      
 @tKeepTime int    ??? ????      
6. ???        
 SEQ int      ?? SEQ ??      
7. ?? ??      
8. ?? ?? ??      
 exec usp_GuildHouse_Insert '01', '123456', 240, 30      
    EXEC usp_GuildFurniture_Insert '01', '123456', 3, 12345, 30      
9. ?? ? ident ? ???      
 select * from tblGuildHouse_Furniture      
 delete tblGuildHouse_Furniture      
============================================================*/      
      
CREATE proc [dbo].[usp_GuildFurniture_Insert]      
 @serverindex char(2),       
 @m_idGuild char(6),       
 @SEQ int,  
 @ItemIndex int,       
 @tKeepTime int,    
 @bSetup float = 0,       
 @x_Pos float = 0,        
 @y_Pos float = 0,       
 @z_Pos float = 0,       
 @fAngle float = 0       
    
as      
      
set nocount on      
set xact_abort on      
      
if   @bSetup = 0    
begin
	insert into tblGuildHouse_Furniture (serverindex, m_idGuild, SEQ, ItemIndex, tKeepTime, bSetup, x_Pos, y_Pos, z_Pos, fAngle)      
	select @serverindex, @m_idGuild, @SEQ, @ItemIndex, @tKeepTime, @bSetup, @x_Pos, @y_Pos, @z_Pos, @fAngle      

	insert into tblGuildHouse_Furniture_SEQ (m_idGuild)
	select @m_idGuild
end
else 
begin
	insert into tblGuildHouse_Furniture (serverindex, m_idGuild, SEQ, ItemIndex, tKeepTime, bSetup, x_Pos, y_Pos, z_Pos, fAngle, set_date)      
	select @serverindex, @m_idGuild, @SEQ, @ItemIndex, @tKeepTime, @bSetup, @x_Pos, @y_Pos, @z_Pos, @fAngle, getdate()      

	insert into tblGuildHouse_Furniture_SEQ (m_idGuild)
	select @m_idGuild       
 end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*============================================================  
1. 작성자 : 박혜민  
2. 작성일 : 2009.11.23  
3. 스크립트 명 : usp_GuildFurniture_Delete  
4. 스크립트 목적 : 길드 가구 로드  
5. 매개변수  
 @serverindex char(2)  : 서버군  
 @m_idGuild  char(6)  : 길드 ID  
6. 리턴값    
7. 수정 내역  
8. 샘플 실행 코드  
    EXEC usp_GuildFurniture_Delete '05', '123456'  
9. 조회 및 ident 값 초기화  
 select * from tblGuildHouse_Furniture_Furniture  
 delete tblGuildHouse_Furniture_Furniture  
============================================================*/  
  
CREATE   proc [dbo].[usp_GuildFurniture_Delete]  
	@serverindex char(2),  
	@m_idGuild char(6),  
	@SEQ int  
as  
  
set nocount on  
set xact_abort on  

	if exists ( select * from tblGuildHouse_Furniture (nolock) where serverindex = @serverindex and m_idGuild = @m_idGuild and SEQ = @SEQ)  
	begin   
		exec usp_GuildFurniture_Log @serverindex, @m_idGuild, @SEQ

		delete tblGuildHouse_Furniture  
		where serverindex = @serverindex and m_idGuild = @m_idGuild and SEQ = @SEQ  
	end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Guild_Combat_1to1_Tender]
@serverindex char(2),
@combatID int,
@m_idGuild char(6),
@m_nPenya int,
@State char(1),
@iGu char(2)
as
set nocount on
set xact_abort on

if @iGu = 'I1'
begin
        insert into GUILD_COMBAT_1TO1_TENDER_TBL(serverindex, combatID, m_idGuild, m_nPenya, State)
        select @serverindex, @combatID, @m_idGuild, @m_nPenya, @State
end

-- T : 입찰 및 추가 입찰
-- F : 입찰 실패
-- C : 입찰 취소
-- E : 대전 종료
-- G : 입찰 실패 길드 신청금 수령 완료
-- N : 입찰 실패 길드 신청금 수령 없이 다음 1:1길드대전 오픈
if @iGu = 'U1'
begin
        if @State = 'F' or @State = 'C' or @State = 'E'
        begin
                update GUILD_COMBAT_1TO1_TENDER_TBL
                set m_nPenya = @m_nPenya, State = @State, s_date = getdate()
                where serverindex = @serverindex and combatID = @combatID and m_idGuild = @m_idGuild and State = 'T'
        end
        else if @State ='N' or @State = 'G'
        begin
                update GUILD_COMBAT_1TO1_TENDER_TBL
                set m_nPenya = @m_nPenya, State = @State, s_date = getdate()
                where serverindex = @serverindex and m_idGuild = @m_idGuild and State = 'F'
        end
        else
        begin
                update GUILD_COMBAT_1TO1_TENDER_TBL
                set m_nPenya = @m_nPenya, State = @State, s_date = getdate()
                where serverindex = @serverindex and combatID = @combatID and m_idGuild = @m_idGuild
        end
end

-- 입찰 길드 목록
if @iGu = 'S1'
begin
        select m_idGuild, m_nPenya
        from GUILD_COMBAT_1TO1_TENDER_TBL
        where serverindex = @serverindex and combatID = @combatID and State = 'T'
        order by m_nPenya desc, s_date asc
end

-- 입찰 실패 길드 목록
if @iGu = 'S2'
begin
        select m_idGuild, m_nPenya
        from GUILD_COMBAT_1TO1_TENDER_TBL
        where serverindex = @serverindex and State = 'F'
--      where combatID in (select max(combatID), (max(combatID) - 1) from GUILD_COMBAT_1TO1_TENDER_TBL where State = 'F') and State = 'F'
        order by m_nPenya desc
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Guild_Combat_1to1_CombatID]
@serverindex char(2)
as
set nocount on

if not exists (select * from GUILD_COMBAT_1TO1_TENDER_TBL where serverindex = @serverindex)
begin
        select 0 as combatID
end
else
begin
        select max(combatID) as combatID
        from GUILD_COMBAT_1TO1_TENDER_TBL
        where serverindex = @serverindex
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Guild_Combat_1to1_Battle_Person]
@serverindex char(2),
@combatID int,
@m_idGuild char(6),
@m_idPlayer char(7),
@m_nSeq int,
@State char(1),
@iGu char(2)
as
set nocount on
set xact_abort on

if @iGu = 'I1'
begin
        insert into GUILD_COMBAT_1TO1_BATTLE_PERSON_TBL (serverindex, combatID, m_idGuild, m_idPlayer, m_nSeq, State)
        select @serverindex, @combatID, @m_idGuild, @m_idPlayer, @m_nSeq, @State
end

if @iGu = 'U1'
begin
        if @State = 'N'
        begin
                update GUILD_COMBAT_1TO1_BATTLE_PERSON_TBL
                set Start_Time = getdate(), State = @State
                where serverindex = @serverindex and combatID = @combatID and m_idGuild = @m_idGuild and m_idPlayer = @m_idPlayer
        end
        else
        begin
                update GUILD_COMBAT_1TO1_BATTLE_PERSON_TBL
                set End_Time = getdate(), State = @State
                where serverindex = @serverindex and combatID = @combatID and m_idGuild = @m_idGuild and m_idPlayer = @m_idPlayer
        end
end

if @iGu = 'S1'
begin
        select m_idPlayer
        from GUILD_COMBAT_1TO1_BATTLE_PERSON_TBL
        where serverindex = @serverindex and combatID = @combatID and m_idGuild = @m_idGuild
        order by m_nSeq
end

if @iGu = 'D1'
begin
        delete from GUILD_COMBAT_1TO1_BATTLE_PERSON_TBL
        where serverindex = @serverindex and combatID = @combatID and m_idGuild = @m_idGuild
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Guild_Combat_1to1_Battle]
@serverindex char(2),
@combatID int,
@m_idWorld int,
@m_idGuild_1st char(6),
@m_idGuild_2nd char(6),
@State char(1),
@iGu char(2)
as
set nocount on
set xact_abort on

if @iGu = 'I1'
begin
        delete from GUILD_COMBAT_1TO1_BATTLE_TBL
        where serverindex = @serverindex and combatID = @combatID and m_idWorld = @m_idWorld

        insert into GUILD_COMBAT_1TO1_BATTLE_TBL(serverindex, combatID, m_idWorld, m_idGuild_1st, m_idGuild_2nd, State)
        select @serverindex, @combatID, @m_idWorld, @m_idGuild_1st, @m_idGuild_2nd, @State
end

if @iGu = 'U1'
begin
        update GUILD_COMBAT_1TO1_BATTLE_TBL
        set End_Time = getdate(), State = @State
        where serverindex = @serverindex and combatID = @combatID and m_idWorld = @m_idWorld
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_FunnyCoin_update]
@fcid int
as
set nocount on
set xact_abort on

begin tran
update tblFunnyCoin
set ItemFlag = 1, f_date = getdate()
where fcid = @fcid

if @@error <> 0
begin
	rollback tran
	select -1 as 'result_code'
end
else
begin
	commit tran
	select 1 as 'result_code'
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[usp_FunnyCoin_input_NoResult]
@serverindex char(2),
@m_idPlayer char(7),
@Item_Name int,
@Item_Cash int,
@Item_UniqueNo bigint
--with encryption
as
set nocount on

/*if exists (select * from tblFunnyCoin where Item_UniqueNo = @Item_UniqueNo)
begin
	select -2 as 'result'
	return
end
*/
begin tran
declare @s_date datetime, @account varchar(32)
select @s_date = getdate(), @account = account
from CHARACTER_TBL (nolock)
where serverindex = @serverindex and m_idPlayer = @m_idPlayer

insert into tblFunnyCoin (account, serverindex, m_idPlayer, Item_Name, Item_Cash, Item_UniqueNo, s_date, fid)
select @account, @serverindex, @m_idPlayer, @Item_Name, @Item_Cash, @Item_UniqueNo, @s_date, dbo.fn_FC(@m_idPlayer, @Item_Cash, @Item_UniqueNo, @s_date)

if @@error <> 0
begin
	rollback tran
	--select -1 as 'result'
end
else
begin
	commit tran
	--select 1 as 'result'
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_FunnyCoin_input]
@serverindex char(2),
@m_idPlayer char(7),
@Item_Name int,
@Item_Cash int,
@Item_UniqueNo bigint
--with encryption
as
set nocount on

begin tran
declare @s_date datetime, @account varchar(32)
select @s_date = getdate(), @account = account
from CHARACTER_TBL (nolock)
where serverindex = @serverindex and m_idPlayer = @m_idPlayer

insert into tblFunnyCoin (account, serverindex, m_idPlayer, Item_Name, Item_Cash, Item_UniqueNo, s_date, fid)
select @account, @serverindex, @m_idPlayer, @Item_Name, @Item_Cash, @Item_UniqueNo, @s_date, dbo.fn_FC(@m_idPlayer, @Item_Cash, @Item_UniqueNo, @s_date)

if @@error <> 0
begin
	rollback tran
	select -1 as 'result'
end
else
begin
	commit tran
	select 1 as 'result'
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_ServerList]
as
set nocount on

select serverindex, serverindex + '   ' + servername as servername
from tblServerList
order by serverseq
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.11.30
3. 스크립트 명 : usp_RestPoint_Update
4. 스크립트 목적 : 케릭터 휴식 포인트 업데이트
5. 매개변수
	@serverindex char(2)		서버군
	@m_idPlyaer char(7)			케릭터 ID
	@m_nRestPoint int			휴식 포인트
	@m_LogOutTime int			시간
6. 리턴값 	
7. 수정 내역
8. 샘플 실행 코드
    EXEC usp_RestPoint_Update '01', '1234567', 100
9. 조회 및 ident 값 초기화
	select * from tblRestPoint
	delete tblGuildHouse_Furniture
	dbcc CHECKIDENT ( 'tblGuildHouse_Furniture', reseed, 0)
============================================================*/

CREATE  proc [dbo].[usp_RestPoint_Update]
	@serverindex char(2), 
	@m_idPlayer char(7), 
	@m_nRestPoint int,
	@m_LogOutTime int
as

set nocount on
set xact_abort on

	if exists ( select * from tblRestPoint (nolock) where serverindex = @serverindex and m_idPlayer = @m_idPlayer )
		begin
			update tblRestPoint 
			set m_nRestPoint = @m_nRestPoint, m_LogOutTime = @m_LogOutTime 
			where serverindex = @serverindex and m_idPlayer = @m_idPlayer
		end
	else
		begin
			insert into tblRestPoint (serverindex, m_idPlayer, m_nRestPoint, m_LogOutTime)
			select @serverindex, @m_idPlayer, @m_nRestPoint, @m_LogOutTime
		end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  proc [dbo].[usp_Quiz_update]

	@serverindex char(2),
	@m_nIndex int,
	@m_nQuizType int, 
	@m_nAnswer int, 
	@m_szQuestion varchar(1024)
as

set nocount on
set xact_abort on

	update tblQuiz set m_nQuizType = @m_nQuizType, m_nAnswer = @m_nAnswer, m_szQuestion = @m_szQuestion
	where serverindex = @serverindex and m_nIndex = @m_nIndex
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.09.09
3. 스크립트 명 : usp_Quiz_Load
4. 스크립트 목적 : tblQuiz 테이블 사용 가능 리스트 호출
5. 매개변수
	@serverindex	char(2)		: 서버군
	@nQuizType		int			: 퀴즈타입
6. 리턴값 	
	m_nIndex					: Quiz 번호
	m_nAnswer					: Quiz 정답
	m_szQuestion				: Quiz 문제
7. 수정 내역
    2009. 09.09 / 박혜민 / 최초 작성
	2009. 10.12 / 박혜민 / 리턴 값 추가 / m_nIndex
8. 샘플 실행 코드
    EXEC usp_Quiz_Load '05', 1
9. 조회 및 ident 값 초기화
	select * from tblQuizAnswer
	select * from tblQuiz
	delete tblQuiz
	delete tblQuizAnswer
	DBCC checkident(tblQuiz ,reseed, 0)
============================================================*/




CREATE        proc [dbo].[usp_Quiz_Load] 

	@serverindex char(2), 
	@m_nQuizType int 

as
set nocount on

	select TQ.m_nIndex ,m_nAnswer, 
	case when m_Answer1 is not null then TQ.m_szQuestion +'|'+ isnull(m_Answer1, '') +'|'+ isnull(m_Answer2, '') +'|'+ isnull(m_Answer3, '') +'|'+ isnull(m_Answer4, '') 
	else TQ.m_szQuestion end m_szQuestion, m_Item, m_ItemCount
	from tblQuiz TQ (nolock) left join tblQuizAnswer TQA (nolock)
	on TQ.m_nIndex = TQA.m_nIndex
	where serverindex = @serverindex and m_nQuizType = @m_nQuizType and m_chState = 'T'
	order by TQ.m_nIndex
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     proc [dbo].[usp_Quiz_Insert]

	@serverindex char(2), 
	@m_nQuizType int, 
	@m_nAnswer int, 
	@m_chState char(1), 
	@m_szQuestion varchar(1024),
	@m_Item int = Null,
	@m_ItemCount tinyint = Null,
	@m_Answer1 varchar(255) = '',
	@m_Answer2 varchar(255) = '',
	@m_Answer3 varchar(255) = '',
	@m_Answer4 varchar(255) = ''


/*
exec usp_Quiz_Insert '05', 1, 1, 'T', '김창섭은|개발4실/이다'
exec usp_Quiz_Insert '05', 1, 2, 'T', '김창섭은|개발4실/아니다'
exec usp_Quiz_Insert '05', 2, 2, 'T', '김창섭은|개발4실/이다'
exec usp_Quiz_Insert '05', 2, 2, 'T', '김창섭은|개발4실/아니다', '1. aa', '2. bb', '3. cc', '4. dd'
delete tblQuiz
delete tblQuizAnswer
select * from tblQuiz
select * from tblQuizAnswer
*/

as

set nocount on
set xact_abort on

	insert into tblQuiz(serverindex, m_nQuizType, m_nAnswer, m_chState, m_szQuestion, m_Item, m_ItemCount)
	select @serverindex, @m_nQuizType, @m_nAnswer, @m_chState, @m_szQuestion, @m_Item, @m_ItemCount 

if @m_nQuizType = 2 
	begin
		declare @m_nIndex int
		select @m_nIndex = max(m_nIndex) from tblQuiz (nolock)

		if 	@m_Answer1 = '' or @m_Answer2 = '' or @m_Answer3 = '' or @m_Answer4 = '' 
			begin
				set @m_Answer1 = '1'
				set @m_Answer2 = '2'
				set @m_Answer3 = '3'
				set @m_Answer4 = '4'
			end

		INSERT INTO tblQuizAnswer(m_nIndex, m_Answer1, m_Answer2, m_Answer3, m_Answer4)
		select @m_nIndex, @m_Answer1, @m_Answer2, @m_Answer3, @m_Answer4
	end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE proc [dbo].[usp_Quiz_Del]
	@serverindex char(2), 
	@m_nIndex int,
	@Gu  int = 0
as
set nocount on

if @Gu = 0

	update tblQuiz set m_chState = 'F'
	where serverindex = @serverindex and m_nIndex = @m_nIndex

else
	delete tblQuiz where serverindex = @serverindex and m_nIndex = @m_nIndex
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ProvideItem_Bill]
@m_idPlayer char(7),
@serverindex char(2),
@Item_Index varchar(32),
@Item_count int
as
set nocount on
set xact_abort on

insert into ITEM_SEND_TBL (serverindex, m_idPlayer, Item_Name, Item_count, m_bCharged, idSender)
select @serverindex, @m_idPlayer, @Item_Index, @Item_count, 0, 'BILL'

if @@error <> 0
begin
	select -1
end
else
begin
	select 1
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[usp_Operation_OperUPD]
@oper_id varchar(20),
@name varchar(50),
@pwd varchar(10),
@ip varchar(50),
@email varchar(50),
@class tinyint

as
/*
사용처 : Operation => Operator Insert
만든이 : 강현석
제작일 : 2007.10.08
주의점 : 
*/

begin
	declare @check	int
	begin Tran
		--관리자 정보 입력
		update TBL_OPER set [name] = @name,
				pwd = @pwd,
				ip = @ip,
				email = @email,
				class = @class
			where oper_id = @oper_id

	if(@@error <> 0)
		begin
			rollback tran
			select @check = 1
		end
	else
		begin
			commit tran
			select @check = 0
		end

	return @check
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[usp_Operation_OperMenuUPD]
@Am int,
@Am1 int,
@Am2 int,
@Am3 int,
@Am4 int,
@Am5 int,
@Bm int,
@Bm1 int,
@Bm2 int,
@Bm3 int,
@Bm4 int,
@Bm5 int,
@Bm6 int,
@Cm int,
@Cm1 int,
@Cm2 int,
@Cm3 int,
@Cm4 int,
@Cm5 int,
@Cm6 int,
@Cm7 int,
@Cm8 int,
@Dm int,
@Dm1 int,
@Dm2 int,
@Dm3 int,
@Dm4 int,
@Dm5 int,
@Dm6 int,
@Dm7 int,
@Dm8 int,
@Em int,
@Em1 int,
@Em11 int,
@Em12 int,
@Em13 int,
@Em14 int,
@Em2 int,
@Em21 int,
@Em22 int,
@Em23 int,
@Em24 int,
@Em25 int,
@Em26 int,
@Fm int,
@Fm1 int,
@Fm11 int,
@Fm12 int,
@Fm13 int,
@Fm14 int,
@Fm15 int,
@Fm16 int,
@Fm2 int,
@Fm21 int,
@Fm22 int,
@Fm3 int,
@Fm31 int,
@Fm32 int,
@Fm33 int,
@Fm4 int,
@Fm41 int,
@Fm42 int,
@Fm43 int,
@Gm int,
@Gm1 int,
@Gm2 int,
@Hm int,
@Hm1 int,
@Hm2 int,
@Hm3 int,
@Im int,
@Im1 int,
@Im2 int,
@Im3 int,
@Im4 int,
@Im5 int,
@Im6 int,
@Im7 int,
@Im8 int,
@Im9 int,
@oper_id varchar(20),
@modioper_id varchar(20)

as
/*
사용처 : Operation => Operator Menu update
만든이 : 강현석
제작일 : 2007.10.08
주의점 : 
*/

begin
	declare @check	int
	begin Tran
		--관리자 정보 입력
		update TBL_OPER_MENU set Am = @Am,
					Am1 = @Am1,
					Am2 = @Am2,
					Am3 = @Am3,
					Am4 = @Am4,
					Am5 = @Am5,
					Bm = @Bm,
					Bm1 = @Bm1,
					Bm2 = @Bm2,
					Bm3 = @Bm3,
					Bm4 = @Bm4,
					Bm5 = @Bm5,
					Bm6 = @Bm6,
					Cm = @Cm,
					Cm1 = @Cm1,
					Cm2 = @Cm2,
					Cm3 = @Cm3,
					Cm4 = @Cm4,
					Cm5 = @Cm5,
					Cm6 = @Cm6,
					Cm7 = @Cm7,
					Cm8 = @Cm8,
					Dm = @Dm,
					Dm1 = @Dm1,
					Dm2 = @Dm2,
					Dm3 = @Dm3,
					Dm4 = @Dm4,
					Dm5 = @Dm5,
					Dm6 = @Dm6,
					Dm7 = @Dm7,
					Dm8 = @Dm8,
					Em = @Em,
					Em1 = @Em1,
					Em11 = @Em11,
					Em12 = @Em12,
					Em13 = @Em13,
					Em14 = @Em14,
					Em2 = @Em2,
					Em21 = @Em21,
					Em22 = @Em22,
					Em23 = @Em23,
					Em24 = @Em24,
					Em25 = @Em25,
					Em26 = @Em26,
					Fm = @Fm,
					Fm1 = @Fm1,
					Fm11 = @Fm11,
					Fm12 = @Fm12,
					Fm13 = @Fm13,
					Fm14 = @Fm14,
					Fm15 = @Fm15,
					Fm16 = @Fm16,
					Fm2 = @Fm2,
					Fm21 = @Fm21,
					Fm22 = @Fm22,
					Fm3 = @Fm3,
					Fm31 = @Fm31,
					Fm32 = @Fm32,
					Fm33 = @Fm33,
					Fm4 = @Fm4,
					Fm41 = @Fm41,
					Fm42 = @Fm42,
					Fm43 = @Fm43,
					Gm = @Gm,
					Gm1 = @Gm1,
					Gm2 = @Gm2,
					Hm = @Hm,
					Hm1 = @Hm1,
					Hm2 = @Hm2,
					Hm3 = @Hm3,
					Im = @Im,
					Im1 = @Im1,
					Im2 = @Im2,
					Im3 = @Im3,
					Im4 = @Im4,
					Im5 = @Im5,
					Im6 = @Im6,
					Im7 = @Im7,
					Im8 = @Im8,
					Im9 = @Im9,
					modioper_id = @modioper_id,
					modidate = getdate()
				where oper_id = @oper_id

	if(@@error <> 0)
		begin
			rollback tran
			select @check = 1
		end
	else
		begin
			commit tran
			select @check = 0
		end

	return @check
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[usp_Operation_OperMenuIns]
@Am int,
@Am1 int,
@Am2 int,
@Am3 int,
@Am4 int,
@Am5 int,
@Bm int,
@Bm1 int,
@Bm2 int,
@Bm3 int,
@Bm4 int,
@Bm5 int,
@Bm6 int,
@Cm int,
@Cm1 int,
@Cm2 int,
@Cm3 int,
@Cm4 int,
@Cm5 int,
@Cm6 int,
@Cm7 int,
@Cm8 int,
@Dm int,
@Dm1 int,
@Dm2 int,
@Dm3 int,
@Dm4 int,
@Dm5 int,
@Dm6 int,
@Dm7 int,
@Dm8 int,
@Em int,
@Em1 int,
@Em11 int,
@Em12 int,
@Em13 int,
@Em14 int,
@Em2 int,
@Em21 int,
@Em22 int,
@Em23 int,
@Em24 int,
@Em25 int,
@Em26 int,
@Fm int,
@Fm1 int,
@Fm11 int,
@Fm12 int,
@Fm13 int,
@Fm14 int,
@Fm15 int,
@Fm16 int,
@Fm2 int,
@Fm21 int,
@Fm22 int,
@Fm3 int,
@Fm31 int,
@Fm32 int,
@Fm33 int,
@Fm4 int,
@Fm41 int,
@Fm42 int,
@Fm43 int,
@Gm int,
@Gm1 int,
@Gm2 int,
@Hm int,
@Hm1 int,
@Hm2 int,
@Hm3 int,
@Im int,
@Im1 int,
@Im2 int,
@Im3 int,
@Im4 int,
@Im5 int,
@Im6 int,
@Im7 int,
@Im8 int,
@Im9 int,
@oper_id varchar(20),
@regioper_id varchar(20)

as
/*
사용처 : Operation => Operator Menu Insert
만든이 : 강현석
제작일 : 2007.10.05
주의점 : 
*/

begin
	declare @check	int
	begin Tran
		--관리자 정보 입력
		insert into TBL_OPER_MENU (oper_id, Am, Am1, Am2, Am3, Am4, Am5, Bm, Bm1, Bm2, Bm3, Bm4, Bm5, Bm6, Cm, Cm1, Cm2, Cm3, Cm4, Cm5, Cm6, Cm7, Cm8 , Dm, Dm1, Dm2, Dm3, Dm4, Dm5, Dm6, Dm7, Dm8, Em, Em1, Em11, Em12, Em13, Em14, Em2, Em21, Em22, Em23, Em24, Em25, Em26, Fm, Fm1, Fm11, Fm12, Fm13, Fm14, Fm15, Fm16, Fm2, Fm21, Fm22, Fm3, Fm31, Fm32, Fm33, Fm4, Fm41, Fm42, Fm43, Gm, Gm1, Gm2, Hm, Hm1, Hm2, Hm3, Im, Im1, Im2, Im3, Im4, Im5, Im6, Im7, Im8, Im9, regioper_id)
		values (@oper_id, @Am, @Am1, @Am2, @Am3, @Am4, @Am5, @Bm, @Bm1, @Bm2, @Bm3, @Bm4, @Bm5, @Bm6, @Cm, @Cm1, @Cm2, @Cm3, @Cm4, @Cm5, @Cm6, @Cm7,@Cm8, @Dm, @Dm1, @Dm2, @Dm3, @Dm4, @Dm5, @Dm6, @Dm7, @Dm8, @Em, @Em1, @Em11, @Em12, @Em13, @Em14, @Em2, @Em21, @Em22, @Em23, @Em24, @Em25, @Em26, @Fm, @Fm1, @Fm11, @Fm12, @Fm13, @Fm14, @Fm15, @Fm16, @Fm2, @Fm21, @Fm22, @Fm3, @Fm31, @Fm32, @Fm33, @Fm4, @Fm41, @Fm42, @Fm43, @Gm, @Gm1, @Gm2, @Hm, @Hm1, @Hm2, @Hm3, @Im, @Im1, @Im2, @Im3, @Im4, @Im5, @Im6, @Im7, @Im8, @Im9, @regioper_id)

	if(@@error <> 0)
		begin
			rollback tran
			select @check = 1
		end
	else
		begin
			commit tran
			select @check = 0
		end

	return @check
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[usp_Operation_OperIns]
@oper_id varchar(20),
@pwd varchar(10),
@name varchar(50),
@ip varchar(50),
@email varchar(50),
@input_id varchar(20),
@class tinyint

as
/*
사용처 : Operation => Operator Insert
만든이 : 강현석
제작일 : 2007.10.04
주의점 : 
*/

begin
	declare @check	int
	begin Tran
		--관리자 정보 입력
		insert into TBL_OPER (oper_id, pwd, [name], ip, email, class, input_day, input_id)
		values (@oper_id, @pwd, @name, @ip, @email, @class, getdate(), @input_id)

	if(@@error <> 0)
		begin
			rollback tran
			select @check = 1
		end
	else
		begin
			commit tran
			select @check = 0
		end

	return @check
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[usp_Operation_OperDel]
@oper_id varchar(20)

as
/*
사용처 : Operation => Operator Delete
만든이 : 강현석
제작일 : 2007.10.08
주의점 : 
*/

begin
	declare @check	int
	begin Tran
		--관리자 정보 입력
		delete from TBL_OPER_MENU where oper_id = @oper_id
		delete from TBL_OPER where oper_id = @oper_id

	if(@@error <> 0)
		begin
			rollback tran
			select @check = 1
		end
	else
		begin
			commit tran
			select @check = 0
		end

	return @check
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_OPER_Login]
@oper_id varchar(32),
@pwd varchar(32)
as
set nocount on

if not exists (select * from TBL_OPER where oper_id = @oper_id)
begin
	select 0
end
else
begin
	if not exists (select * from TBL_OPER where oper_id = @oper_id and pwd = @pwd)
	begin
		select -1
	end
	else
	begin
		select 1
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_MessengerList]
@m_idPlayer char(7)
as

set nocount on

select m.idFriend, c.account, c.m_nJob, c.m_szName
from tblMessenger as m inner join CHARACTER_TBL as c on m.idFriend = c.m_idPlayer
where m.idPlayer = @m_idPlayer and isblock <>'D' and chUse = 'T'
order by m.idFriend
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Master_Update]
@serverindex char(2),
@m_idPlayer char(7),
@sec tinyint,
@c01 int = 0, @c02 int = 0, @c03 int = 0, @c04 int = 0, @c05 int = 0,
@c06 int = 0, @c07 int = 0, @c08 int = 0, @c09 int = 0, @c10 int = 0,
@c11 int = 0, @c12 int = 0, @c13 int = 0, @c14 int = 0, @c15 int = 0,
@c16 int = 0, @c17 int = 0, @c18 int = 0, @c19 int = 0, @c20 int = 0,
@c21 int = 0, @c22 int = 0, @c23 int = 0, @c24 int = 0, @c25 int = 0,
@c26 int = 0, @c27 int = 0, @c28 int = 0, @c29 int = 0, @c30 int = 0,
@c31 int = 0, @c32 int = 0, @c33 int = 0, @c34 int = 0, @c35 int = 0,
@c36 int = 0, @c37 int = 0, @c38 int = 0, @c39 int = 0, @c40 int = 0,
@c41 int = 0, @c42 int = 0, @c43 int = 0, @c44 int = 0, @c45 int = 0,
@c46 int = 0, @c47 int = 0, @c48 int = 0, @c49 int = 0, @c50 int = 0
as
set nocount on
set xact_abort on

update tblMaster_all
set	c01 = @c01, c02 = @c02, c03 = @c03, c04 = @c04, c05 = @c05,
	c06 = @c06, c07 = @c07, c08 = @c08, c09 = @c09, c10 = @c10,
	c11 = @c11, c12 = @c12, c13 = @c13, c14 = @c14, c15 = @c15,
	c16 = @c16, c17 = @c17, c18 = @c18, c19 = @c19, c20 = @c20,
	c21 = @c21, c22 = @c22, c23 = @c23, c24 = @c24, c25 = @c25,
	c26 = @c26, c27 = @c27, c28 = @c28, c29 = @c29, c30 = @c30,
	c31 = @c31, c32 = @c32, c33 = @c33, c34 = @c34, c35 = @c35,
	c36 = @c36, c37 = @c37, c38 = @c38, c39 = @c39, c40 = @c40,
	c41 = @c41, c42 = @c42, c43 = @c43, c44 = @c44, c45 = @c45,
	c46 = @c46, c47 = @c47, c48 = @c48, c49 = @c49, c50 = @c50
where serverindex = @serverindex and m_idPlayer = @m_idPlayer and sec = @sec
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Master_Select]
@serverindex char(2),
@m_idPlayer  char(7)
as
set nocount on

select 	serverindex, m_idPlayer, sec,
	c01, c02, c03, c04, c05, c06, c07, c08, c09, c10,
	c11, c12, c13, c14, c15, c16, c17, c18, c19, c20,
	c21, c22, c23, c24, c25, c26, c27, c28, c29, c30,
	c31, c32, c33, c34, c35, c36, c37, c38, c39, c40,
	c41, c42, c43, c44, c45, c46, c47, c48, c49, c50
from tblMaster_all with (nolock)
where serverindex = @serverindex and m_idPlayer = @m_idPlayer
order by sec
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE proc [dbo].[usp_login]

@oper_id varchar(20),
@pwd varchar(10)

as

set nocount on

declare @check tinyint
declare @rvalues int

set @check = (select count(*) from TBL_OPER where oper_id = @oper_id)

if(@check = 0)
begin
	set @rvalues = 0
end
else
begin
	set @check = (select count(*) from TBL_OPER where oper_id = @oper_id and pwd = @pwd)
	if(@check = 0)
	begin
		set @rvalues = -1
	end
	else
	begin
		set @rvalues = 1
	end
end

select @rvalues as rvalues
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[COMPANY_STR]
	@iGu        		  				CHAR(2) 			, 
	@im_idCompany			CHAR(6) 			= '000001',
	@iserverindex  				CHAR(2) 			= '01',
	@im_leaderid					CHAR(7) 			= '0000001',
	@im_szCompany			VARCHAR(16)	=	''

AS
set nocount on
IF 	@iGu = 'A1'
	BEGIN
		IF EXISTS(SELECT * FROM  COMPANY_TBL  WHERE m_szCompany = @im_szCompany  AND serverindex = @iserverindex AND isuse = 'T')
			BEGIN
				SELECT fError = '1', fText = '중복된 컴파니 이름'
				RETURN	
			END
		ELSE
		IF EXISTS(SELECT * FROM  COMPANY_TBL  WHERE m_leaderid = @im_leaderid  AND serverindex = @iserverindex AND isuse = 'T')
			BEGIN
				SELECT fError = '2', fText = '중복된 리더'
				RETURN	
			END

		ELSE
			BEGIN

			UPDATE CHARACTER_TBL SET m_idCompany = @im_idCompany WHERE m_idPlayer = @im_leaderid AND  serverindex = @iserverindex 
			INSERT COMPANY_TBL
				(m_idCompany,serverindex,m_szCompany,m_leaderid,isuse)
			VALUES
				(@im_idCompany,@iserverindex,@im_szCompany,@im_leaderid,'T')	
	
			SELECT fError = '0', fText = 'OK'
			RETURN

			END
	END			
/*
	
	 컴파니 이름  저장하기
	 ex ) 
	 COMPANY_STR 'A1',@im_idCompany,@iserverindex,@im_leaderid,@im_szCompany
	 COMPANY_STR 'A1','000001','01','000001','불타는닭갈비'

*/

ELSE
IF	@iGu = 'A2'
	BEGIN
		UPDATE  CHARACTER_TBL
			   SET m_idCompany = @im_idCompany
		 WHERE m_idPlayer = @im_leaderid
		      AND serverindex = @iserverindex
		RETURN
	END
/*
	
	 컴파니 가입하기
	 ex ) 
	 COMPANY_STR 'A2',@im_idCompany,@iserverindex,@im_leaderid(m_idPlayer),@im_szCompany
	 COMPANY_STR 'A2','000001','01','000001'

*/

ELSE
IF	@iGu = 'S1'
	BEGIN
		DECLARE @maxid CHAR(6)
		SELECT @maxid = max(m_idCompany) FROM COMPANY_TBL
		SELECT m_idCompany,m_szCompany,m_leaderid,maxid = @maxid
			FROM COMPANY_TBL
	     WHERE  serverindex = @iserverindex
			    AND isuse = 'T'
		  ORDER BY m_idCompany
		RETURN
	END
/*
	
	 컴파니 모두 가져오기
	 ex ) 
	 COMPANY_STR 'S1',@im_idCompany,@iserverindex
	 COMPANY_STR 'S1','','01'

*/

ELSE
IF @iGu = 'D1'
	BEGIN
		UPDATE COMPANY_TBL
			SET  isuse = 'F'
		WHERE m_idCompany = @im_idCompany
		    AND serverindex = @iserverindex

		UPDATE CHARACTER_TBL
			SET m_idCompany = '000000'
		WHERE m_idCompany = @im_idCompany
		    AND serverindex = @iserverindex
		SELECT  fError = '0', fText = 'OK'
	RETURN
	END
/*
	
	 컴파니 해체
	 ex ) 
	 COMPANY_STR 'D1',@im_idCompany,@iserverindex
	 COMPANY_STR 'D1','000001','01'

*/

ELSE
IF @iGu = 'D2'
	BEGIN
		UPDATE CHARACTER_TBL
			SET  m_idCompany = '000000'
		WHERE m_idPlayer = @im_idCompany
		    AND serverindex = @iserverindex
		SELECT  fError = '0', fText = 'OK'
	RETURN
	END
/*
	
	 컴파니 탈퇴
	 ex ) 
	 COMPANY_STR 'D2',@im_idCompany(m_idPlayer),@iserverindex
	 COMPANY_STR 'D2','000001','01'

*/

set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE      PROC [dbo].[ADD_BANK_STR]
	@iGu        		  				CHAR(2) 			= 'U1', 
	@im_idPlayer   				CHAR(7) 			= '0000001',
	@iserverindex  				CHAR(2) 			= '01',
	-- BANK_TBL
	@im_Bank						VARCHAR(4290)= '',
	@im_apIndex_Bank		VARCHAR(215)= '',
	@im_dwObjIndex_Bank VARCHAR(215)= '',
	@im_dwGoldBank			INT						= 0,
	@im_extBank	varchar(2000) = '',
	@im_BankPiercing	varchar(2000) = ''
	, @iszBankPet varchar(2688) = '$'

/*******************************************************
	Gu 구분
    S : SELECT
    I  : INSERT
    U : UPDATE
    D : DELETE
*******************************************************/
AS
set nocount on
IF @iGu = 'U1' -- 캐릭터 저장
	BEGIN
		UPDATE BANK_TBL 
			  SET 	m_Bank 						= @im_Bank,
						m_apIndex_Bank 		= @im_apIndex_Bank, 
						m_dwObjIndex_Bank = @im_dwObjIndex_Bank, 
						m_dwGoldBank 		= @im_dwGoldBank
		 WHERE 	m_idPlayer   				= @im_idPlayer 	
			  AND 	serverindex 				= @iserverindex

		UPDATE BANK_EXT_TBL
		SET m_extBank = @im_extBank,
		    m_BankPiercing = @im_BankPiercing,
		    szBankPet = @iszBankPet
		WHERE m_idPlayer = @im_idPlayer AND serverindex = @iserverindex

		SELECT fError = '1', fText = 'OK'
		RETURN
	END
/*
	
	정보업데이트
	 ex ) 
ADD_BANK_STR 'U1', @iGu,@im_idPlayer,@iserverindex,@im_Bank	,@im_apIndex_Bank	,@im_dwObjIndex_Bank,@im_dwGoldBank
ADD_BANK_STR 'U1','000001','01','$','$','$',1000

*/
set nocount off
RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROC [dbo].[BANK_STR]
	@iGu        		  				CHAR(1) 			, 
	@im_idPlayer					CHAR(7) 			= '0000001',
	@iserverindex  				CHAR(2) 			= '01',
	@im_BankPw					CHAR(4)

AS
set nocount on
IF 	@iGu = 'U'
	BEGIN
		UPDATE BANK_TBL 
			   SET m_BankPw = @im_BankPw
		WHERE  m_idPlayer = @im_idPlayer
		      AND serverindex = @iserverindex
		RETURN
	END			
/*
	
	 BANK 비밀번호  저장하기
	 ex ) 
	 BANK_STR 'U',@im_idPlayer,@iserverindex,@im_BankPw
	 BANK_STR 'U','000001','01','1234'

*/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROC [dbo].[GUILD_BANK_STR]
	@iGu        		  				CHAR(2) 				,	 
	@im_idGuild					CHAR(6)					,
	@iserverindex				CHAR(2)					,
	@im_nGuildGold			bigINT = 0,
	@im_apIndex 				VARCHAR(215) = '',
	@im_dwObjIndex 			VARCHAR(215) = '',
	@im_GuildBank				TEXT 				   = '',
	@im_idPlayer					CHAR(7) = '',
	@im_extGuildBank		varchar(2000) = '',
	@im_GuildBankPiercing varchar(2000) = ''
	, @iszGuildBankPet varchar(4200) = '$'
AS
set nocount on
IF @iGu = 'S1'
	BEGIN
		SELECT A.m_idGuild, A.serverindex, B.m_nGuildGold, A.m_apIndex, A.m_dwObjIndex, A.m_GuildBank,C.m_extGuildBank,C.m_GuildBankPiercing, C.szGuildBankPet
			FROM GUILD_BANK_TBL A, GUILD_TBL B, GUILD_BANK_EXT_TBL C
		WHERE A.m_idGuild = B.m_idGuild
			 AND B.m_idGuild = C.m_idGuild
			AND A.serverindex = B.serverindex 
			AND B.serverindex = C.serverindex 
			AND C.serverindex = @iserverindex
	RETURN
	END
/*
	 GUILD BANK 전체 불러오기
	 ex ) 
	 GUILD_BANK_STR 'S1',@im_idGuild,@iserverindex
	 GUILD_BANK_STR 'S1','000000','01'

*/
IF @iGu = 'U1'
	BEGIN

		DECLARE @om_nGuildGold bigINT

		SELECT @om_nGuildGold =  m_nGuildGold - @im_nGuildGold
			FROM GUILD_TBL
		 WHERE 	m_idGuild   				= @im_idGuild	
			  AND 	serverindex 				= @iserverindex

		UPDATE GUILD_BANK_TBL 
			  SET 	m_apIndex = @im_apIndex,
						m_dwObjIndex = @im_dwObjIndex,
						m_GuildBank = @im_GuildBank
		 WHERE 	m_idGuild   				= @im_idGuild	
			  AND 	serverindex 				= @iserverindex

		UPDATE GUILD_BANK_EXT_TBL 
			  SET 	m_extGuildBank = @im_extGuildBank,
						m_GuildBankPiercing = @im_GuildBankPiercing
				, szGuildBankPet = @iszGuildBankPet
		 WHERE 	m_idGuild   				= @im_idGuild	
			  AND 	serverindex 				= @iserverindex

		UPDATE GUILD_TBL 
			SET m_nGuildGold = @im_nGuildGold
		 WHERE 	m_idGuild   				= @im_idGuild	
			  AND 	serverindex 				= @iserverindex

		IF (@om_nGuildGold > 0 and @im_idPlayer <> '000000')
			BEGIN
				UPDATE GUILD_MEMBER_TBL
					   SET m_nGiveGold = m_nGiveGold - @om_nGuildGold
				 WHERE m_idPlayer = @im_idPlayer
					  AND 	serverindex  = @iserverindex
			END
	RETURN
	END
/*
	 GUILD BANK 저장하기
	 ex ) 
	 GUILD_BANK_STR 'U1',@im_idGuild,@iserverindex,@im_nGuildGold,@im_apIndex,@im_dwObjIndex,@im_GuildBank,@im_idPlayer
	 GUILD_BANK_STR 'U1','000001','01',0,'$','$','$', 1000  
	 GUILD_BANK_STR 'U1','000001','01',0,'$','$','$',  0       
*/


set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_GUILD_COMBAT_count] (@combatID int, @m_idGuild char(6))
returns int
as
begin
	declare @count int

	select @count = count(*) from GUILD_COMBAT_1TO1_BATTLE_PERSON_TBL
	where combatID = @combatID and m_idGuild = @m_idGuild and State = 'W'

	return @count
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[GUILD_WAR_STR]
	@iGu        		  				CHAR(2) 				,	 
	@im_idGuild					CHAR(6)					,
	@iserverindex				CHAR(2)					,
	@im_idWar						INT			=0,	
	@iState							CHAR(1) = '', -- 0:진행 1:개최측일반승 2:개최측기권승 3:개최측일반패 4:개최측기권패 9:무승부
	@if_idGuild						CHAR(6)	= '',
	@im_idPlayer					CHAR(6)='',
	@im_nWinPoint				INT =0,
	@if_nWinPoint				INT =0
AS
set nocount on
IF @iGu = 'S1'
	BEGIN


		SELECT m_idGuild,serverindex,f_idGuild,m_idWar,m_nDeath,m_nSurrender,m_nCount,m_nAbsent,f_nDeath,f_nSurrender,f_nCount,f_nAbsent,State,StartTime
 			FROM GUILD_WAR_TBL 
		WHERE 	serverindex 				= @iserverindex
			AND State = '0'
-- 		UNION ALL
-- 		SELECT m_idGuild=f_idGuild,serverindex,m_idWar,m_nDeath=f_nDeath,m_nSurrender=f_nSurrender,m_nCount=f_nCount,State,StartTime
--  			FROM GUILD_WAR_TBL 
-- 		WHERE 	serverindex 				= @iserverindex
-- 			AND State = '0'
		ORDER BY m_idWar,serverindex
	RETURN
	END
/*
	 GUILD WAR 전체 가져오기
	 ex ) 
	 GUILD_WAR_STR 'S1',@im_idGuild,@iserverindex,@im_idWar,@iState,@if_idGuild
	 GUILD_WAR_STR 'S1','000000','01'

*/
ELSE
IF @iGu = 'S2'
	BEGIN
		SELECT Max_m_idWar = ISNULL(MAX(m_idWar),0)
 			FROM GUILD_WAR_TBL 
		WHERE 	serverindex 				= @iserverindex
	RETURN
	END
/*
	 Max m_idWAR 가져오기
	 ex ) 
	 GUILD_WAR_STR 'S2','',@iserverindex
	 GUILD_WAR_STR 'S2','','01'

*/

ELSE
IF @iGu = 'A1'
	BEGIN
		DECLARE @currDate char(12),@om_nCount INT,@of_nCount INT				
		SET @currDate = CONVERT(CHAR(8),GETDATE(),112) 
								   + RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,GETDATE())),2) 
								   + RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,GETDATE())),2)

		
		SELECT @om_nCount = COUNT(m_idGuild) FROM GUILD_MEMBER_TBL WHERE m_idGuild = @im_idGuild AND isuse = 'T'
		SELECT @of_nCount = COUNT(m_idGuild) FROM GUILD_MEMBER_TBL WHERE m_idGuild = @if_idGuild AND isuse = 'T'

		INSERT GUILD_WAR_TBL
			(
				m_idGuild,serverindex,m_idWar,f_idGuild,m_nDeath,m_nSurrender,m_nCount,m_nAbsent,f_nDeath,f_nSurrender,f_nCount,f_nAbsent,State,StartTime
			)
		VALUES
			(
				@im_idGuild,@iserverindex,@im_idWar,@if_idGuild,0,0,@om_nCount,0,0,0,@of_nCount,0,'0',@currDate
			)
		UPDATE GUILD_MEMBER_TBL
			   SET m_idWar = @im_idWar
		 WHERE m_idGuild IN (@im_idGuild,@if_idGuild)
		      AND serverindex = @iserverindex
			   AND isuse = 'T'

	RETURN
	END
/*
	 GUILD 전 생성하기
	 ex ) 
	 GUILD_WAR_STR 'A1',@im_idGuild,@iserverindex,@im_idWar,@iState,@if_idGuild
	 GUILD_WAR_STR 'A1','000001','01',123,'','000002'

*/
ELSE
IF @iGu = 'U1'
	BEGIN
		UPDATE GUILD_WAR_TBL
			   SET m_nSurrender = m_nSurrender + 1
		 WHERE m_idWar = @im_idWar
			  AND m_idGuild = @im_idGuild
			  AND serverindex = @iserverindex
			  AND State  = '0'

		UPDATE GUILD_WAR_TBL
			   SET f_nSurrender = f_nSurrender + 1
		 WHERE m_idWar = @im_idWar
			  AND f_idGuild = @im_idGuild
			  AND serverindex 	= @iserverindex
			  AND State  = '0'

		UPDATE GUILD_MEMBER_TBL
			  SET m_idWar = 0,
					  m_nSurrender = m_nSurrender + 1 		
		 WHERE m_idPlayer = @im_idPlayer
			AND serverindex 	= @iserverindex
			AND m_idWar > 0

	RETURN
	END
/*
	 GUILD 개인 항복
	 ex ) 
	 GUILD_WAR_STR 'U1',@im_idGuild,@iserverindex,@im_idWar,@iState,@if_idGuild,@im_idPlayer
	 GUILD_WAR_STR 'U1','000001','01',123,'','000002'

*/
ELSE
IF @iGu = 'U2'
	BEGIN
		UPDATE GUILD_WAR_TBL
			   SET m_nDeath = m_nDeath + 1
		 WHERE m_idWar = @im_idWar
			  AND m_idGuild = @im_idGuild
			  AND serverindex = @iserverindex

		UPDATE GUILD_WAR_TBL
			   SET f_nDeath = f_nDeath + 1
		 WHERE m_idWar = @im_idWar
			  AND f_idGuild = @im_idGuild
			  AND serverindex 	= @iserverindex

	RETURN
	END
/*
	 GUILD 개인 사망
	 ex ) 
	 GUILD_WAR_STR 'U2',@im_idGuild,@iserverindex,@im_idWar,@iState,@if_idGuild (m_idPlayer)
	 GUILD_WAR_STR 'U2','000001','01',123,'','000002'

*/
ELSE
IF @iGu = 'U3'
	BEGIN
		UPDATE GUILD_WAR_TBL
			   SET State = @iState
		 WHERE m_idWar = @im_idWar
		      AND serverindex = serverindex

		IF @iState = '1' -- 개최측 일반승리
			BEGIN
				UPDATE GUILD_TBL
					SET m_nWin = m_nWin + 1,m_nWinPoint = @im_nWinPoint
				WHERE m_idGuild = @im_idGuild
				     AND serverindex = @iserverindex

				UPDATE GUILD_TBL
					SET m_nLose = m_nLose + 1,m_nWinPoint = @if_nWinPoint
				WHERE m_idGuild = @if_idGuild
				     AND serverindex = @iserverindex
	
				UPDATE GUILD_MEMBER_TBL
					  SET m_nWin = m_nWin + 1
				WHERE m_idGuild = @im_idGuild
					  AND serverindex = @iserverindex
				     AND m_idWar > 0
					  AND isuse='T'
	
				UPDATE GUILD_MEMBER_TBL
					  SET  m_nLose = m_nLose + 1
				WHERE m_idGuild = @if_idGuild
					  AND serverindex = @iserverindex
				     AND m_idWar > 0
					  AND isuse='T'
			END
		ELSE
		IF @iState = '2' -- 개최측 기권승리
			BEGIN
				UPDATE GUILD_TBL
					SET m_nWin = m_nWin + 1,m_nWinPoint = @im_nWinPoint
				WHERE m_idGuild = @im_idGuild
				     AND serverindex = @iserverindex	

				UPDATE GUILD_TBL
					SET m_nSurrender = m_nSurrender + 1,m_nWinPoint = @if_nWinPoint
				WHERE m_idGuild = @if_idGuild
				     AND serverindex = @iserverindex

				UPDATE GUILD_MEMBER_TBL
					  SET m_nWin = m_nWin + 1
				WHERE m_idGuild = @im_idGuild
					  AND serverindex = @iserverindex
				     AND m_idWar > 0
					  AND isuse='T'
	
				UPDATE GUILD_MEMBER_TBL
					  SET  m_nLose = m_nLose + 1
				WHERE m_idGuild = @if_idGuild
					  AND serverindex = @iserverindex
				     AND m_idWar > 0
					  AND isuse='T'
			END
		ELSE
		IF  @iState = '3'  -- 개최측 일반패배
			BEGIN
				UPDATE GUILD_TBL
					SET m_nLose = m_nLose + 1,m_nWinPoint = @im_nWinPoint
				WHERE m_idGuild = @im_idGuild
				     AND serverindex = @iserverindex

				UPDATE GUILD_TBL
					SET  m_nWin = m_nWin + 1,m_nWinPoint = @if_nWinPoint
				WHERE m_idGuild = @if_idGuild
				     AND serverindex = @iserverindex
	
				UPDATE GUILD_MEMBER_TBL
					  SET  m_nLose = m_nLose + 1
				WHERE m_idGuild = @im_idGuild
					  AND serverindex = @iserverindex
					  AND m_idWar > 0
					  AND isuse='T'

				UPDATE GUILD_MEMBER_TBL
					  SET m_nWin = m_nWin + 1
				WHERE m_idGuild = @if_idGuild
					  AND serverindex = @iserverindex
				     AND m_idWar > 0
					  AND isuse='T'
			END
		ELSE
		IF  @iState = '4'   -- 개최측 기권패배
			BEGIN
				UPDATE GUILD_TBL
					SET m_nSurrender = m_nSurrender + 1,m_nWinPoint = @im_nWinPoint
				WHERE m_idGuild = @im_idGuild
				     AND serverindex = @iserverindex	

				UPDATE GUILD_TBL
					SET  m_nWin = m_nWin + 1,m_nWinPoint = @if_nWinPoint
				WHERE m_idGuild = @if_idGuild
				     AND serverindex = @iserverindex
	
				UPDATE GUILD_MEMBER_TBL
					  SET  m_nLose = m_nLose + 1
				WHERE m_idGuild = @im_idGuild
					  AND serverindex = @iserverindex
				     AND m_idWar > 0	
					  AND isuse='T'

				UPDATE GUILD_MEMBER_TBL
					  SET  m_nWin = m_nWin + 1
				WHERE m_idGuild = @if_idGuild
					  AND serverindex = @iserverindex
				     AND m_idWar > 0
					  AND isuse='T'
			END

		UPDATE GUILD_MEMBER_TBL 
				SET m_idWar = 0
		 WHERE m_idWar = @im_idWar
			  AND serverindex = @iserverindex
		     AND m_idWar > 0
 		     AND isuse='T'			

	RETURN
	END
/*
	 GUILD 전 종료
	 ex ) 
	 GUILD_WAR_STR 'U3',@im_idGuild,@iserverindex,@im_idWar,@iState,@if_idGuild 
	 GUILD_WAR_STR 'U3','000001','01',123,'','000002'

*/
ELSE
IF @iGu = 'U4'
	BEGIN
		UPDATE GUILD_WAR_TBL
			   SET m_nAbsent=m_nAbsent+1
		 WHERE m_idWar = @im_idWar
			  AND m_idGuild = @im_idGuild
			  AND serverindex = @iserverindex

		UPDATE GUILD_WAR_TBL
			   SET f_nAbsent=f_nAbsent+1
		 WHERE m_idWar = @im_idWar
			  AND f_idGuild = @im_idGuild
			  AND serverindex 	= @iserverindex

	RETURN
	END
/*
	 GUILD 마스터 부재
	 ex ) 
	 GUILD_WAR_STR 'U4',@im_idGuild,@iserverindex,@im_idWar,@iState,@if_idGuild (m_idPlayer)
	 GUILD_WAR_STR 'U4','000001','01',123,'','000002'

*/
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[GUILD_STR]
	@iGu        		  				CHAR(2) 			=	'S1', 
	@im_idPlayer					CHAR(7) 			= '0000001',
	@iserverindex  				CHAR(2) 			= '01',
	@im_idGuild					CHAR(6)				= '000001',
	@im_szGuild					varCHAR(48)			='',
	@iLv_1								INT 						=1,
	@iLv_2								INT 						=1,
	@iLv_3								INT 						=1,
	@iLv_4								INT 						=1,
	@im_nLevel					INT 						=1,
	@im_nGuildGold			INT 						=0,
	@im_nGuildPxp				INT 						=0,
	@im_nWin						INT 						=0,
	@im_nLose					INT 						=0,
	@im_nSurrender			INT 						=0,
	@im_dwLogo					INT 						=0,
	@im_szNotice				VARCHAR(127)	='',
	@im_nClass					INT 						=0
AS
set nocount on
IF @iGu = 'S1'
	BEGIN
		SELECT  m_idGuild,serverindex,Lv_1,Lv_2,Lv_3,Lv_4,Pay_0,Pay_1,Pay_2,Pay_3,Pay_4,m_szGuild,m_nLevel,
						m_nGuildGold,m_nGuildPxp,m_nWin,m_nLose,m_nSurrender,m_nWinPoint,
						m_dwLogo,m_szNotice
		   FROM GUILD_TBL 
		 WHERE serverindex = @iserverindex
					AND isuse='T'
		 ORDER BY m_idGuild
		RETURN
	END
/*

	

	SELECT * FROM GUILD_TBL
	SELECT * FROM GUILD_MEMBER_TBL
	SELECT * FROM GUILD_BANK_TBL WHERE serverindex ='07'
	
	DELETE GUILD_TBL WHERE serverindex ='07'
	DELETE GUILD_MEMBER_TBL WHERE serverindex ='07'
	DELETE GUILD_BANK_TBL WHERE serverindex ='07'

	 GUILD 전체 불러오기 - 강현민
	 ex ) 
	 GUILD_STR 'S1',@im_idPlayer,@iserverindex
	 GUILD_STR 'S1','','01'

*/
ELSE
IF @iGu = 'S2'
	BEGIN
		SELECT 	A.m_idPlayer,A.serverindex,A.m_idGuild,A.m_szAlias,A.m_nWin,A.m_nLose,A.m_nSurrender,
						A.m_nMemberLv,A.m_nClass,A.m_nGiveGold,A.m_nGivePxp,B.m_nJob,B.m_nLevel,B.m_dwSex,
						m_idWar=ISNULL(A.m_idWar,0),m_idVote=ISNULL(A.m_idVote,0)
		   FROM GUILD_MEMBER_TBL A, CHARACTER_TBL B
		 WHERE A.m_idPlayer = B.m_idPlayer
		      AND A.serverindex = B.serverindex
				AND B.serverindex = @iserverindex
--		      AND B.isblock='F'
			   AND A.isuse = 'T'
		 ORDER BY A.m_idPlayer
		RETURN
	END

/*
	

	 GUILD 멤버 전체 불러오기- 강현민
	 ex ) 
	 GUILD_STR 'S2',@im_idPlayer,@iserverindex
	 GUILD_STR 'S2','','01'

*/
ELSE
IF @iGu = 'A1'
	BEGIN
-- 		IF NOT EXISTS (SELECT * FROM GUILD_TBL WHERE m_szGuild = @im_szGuild AND serverindex = @iserverindex)
-- 			BEGIN
				IF (NOT EXISTS (SELECT * FROM GUILD_TBL WHERE m_idGuild = @im_idGuild AND serverindex = @iserverindex) and  NOT EXISTS (SELECT * FROM GUILD_BANK_TBL WHERE m_idGuild = @im_szGuild AND serverindex = @iserverindex))
					BEGIN
						INSERT  GUILD_TBL
							(
								m_idGuild,serverindex,Lv_1,Lv_2,Lv_3,Lv_4,Pay_0,Pay_1,Pay_2,Pay_3,Pay_4,
							 	m_szGuild,m_nLevel,m_nGuildGold,m_nGuildPxp,
								m_nWin,m_nLose,m_nSurrender,m_nWinPoint,m_dwLogo,
								m_szNotice,isuse,CreateTime
							)
						VALUES
							(
								@im_idGuild,@iserverindex,@iLv_1,@iLv_2,@iLv_3,@iLv_4,0,0,0,0,0,
							 	@im_szGuild,1,0,0,
								0,0,0,0,@im_dwLogo,
								@im_szNotice,'T',GETDATE()
							)
						INSERT GUILD_BANK_TBL
							(
								m_idGuild,serverindex,m_apIndex,
								m_dwObjIndex,m_GuildBank
							)
						VALUES
							(
								@im_idGuild,@iserverindex,'$',
								'$','$'
							)

						INSERT GUILD_BANK_EXT_TBL
							(
								m_idGuild,serverindex,m_extGuildBank,m_GuildBankPiercing
							)
						VALUES
							(
								@im_idGuild,@iserverindex,'$','$'
							)
-- 						IF @@SERVERNAME='CHAR-DB1'
-- 						BEGIN
-- 						INSERT [LOG].LOG_DBF.dbo.GUILD_TBL  --로그 디비에 길드 생성 정진형 팀장 요청사항
-- 							(
-- 								m_idGuild,serverindex,m_szGuild,isuse
-- 							)
-- 						VALUES
-- 							(
-- 								@im_idGuild,@iserverindex,@im_szGuild,'T'
-- 							)
-- 						END
						SELECT  nError = '1', fText = '길드 생성 OK'
					END
				ELSE
					BEGIN
						SELECT  nError = '2', fText = '길드 아이디 중복'
					END
-- 			END
-- 		ELSE
-- 			BEGIN
-- 				SELECT  nError = '3', fText = '길드 이름 중복'
-- 			END	
-- 		RETURN
	END
/*
	
	 GUILD 생성- 강현민
	 ex ) 
	 GUILD_STR 'A1',@im_idPlayer,@iserverindex,@im_idGuild,@im_szGuild,@iLv_1,@iLv_2,@iLv_3,@iLv_4,@im_nLevel,@im_nGuildGold,
								  @im_nGuildPxp,@im_nWin,@im_nLose,@im_nSurrender,@im_dwLogo,@im_szNotice

	 GUILD_STR 'A1','000000','01','000004','멋쟁이길드',1,1,1,1,1,0,
								  0,0,0,0,0,'안녕하십니까? 길드원이 되신걸 환영합니다.'

*/
ELSE
IF @iGu = 'A2'
	BEGIN		
		IF NOT EXISTS( SELECT * FROM GUILD_MEMBER_TBL  WHERE  m_idPlayer = @im_idPlayer AND serverindex = @iserverindex AND m_idGuild = @im_idGuild)
		INSERT  GUILD_MEMBER_TBL 
			(
				m_idPlayer,serverindex,m_idGuild,m_szAlias,
				m_nWin,m_nLose,m_nSurrender,m_nMemberLv,m_nClass,
				m_nGiveGold,m_nGivePxp,m_idWar,m_idVote,isuse,CreateTime
			)
		VALUES
			(
				@im_idPlayer,@iserverindex,@im_idGuild,@im_szGuild, 	--(@im_szGuild = m_szAlias)
				0,0,0,@im_nLevel,	0,														--(@iLv_1 = m_nPay , @im_nLevel = m_nMemberLv)
				@im_nGuildGold,@im_nGuildPxp,0,'','T',GETDATE()				--(@im_nGuildGold = m_nGiveGold,@im_nGuildPxp= m_nGivePxp)
			)
		RETURN
	END
/*
	
	 GUILD 가입
	 ex ) 
	 GUILD_STR 'A2',@im_idPlayer,@iserverindex,@im_idGuild(@im_szGuild = m_szAlias),@im_szGuild,@iLv_1(@iLv_1 = m_nPay),
								 @iLv_2,@iLv_3,@iLv_4,@im_nLevel(@im_nLevel = m_nMemberLv),@im_nGuildGold(@im_nGuildGold = m_nGiveGold),
								  @im_nGuildPxp(@im_nGuildPxp= m_nGivePxp)

	 GUILD_STR 'A2','000023','01','000001','',1,
									0,0,0,0,1,0,
								  	0
*/
ELSE
IF @iGu = 'U1'
	BEGIN
		UPDATE GUILD_TBL
			  SET	Lv_1 = @iLv_1,
						Lv_2 = @iLv_2,
						Lv_3 = @iLv_3,
						Lv_4 = @iLv_4			 			
		 WHERE m_idGuild = @im_idGuild
			  AND serverindex = @iserverindex
			  AND isuse = 'T'
		RETURN
	END
/*
	
	 GUILD 권한 변경 - 송현석
	 ex ) 
	 GUILD_STR 'U1',@im_idPlayer,@iserverindex,@im_idGuild,@im_szGuild,@iLv_1,@iLv_2,@iLv_3,@iLv_4

	 GUILD_STR 'U1','000000','01','000001','',0,0,0,0,0
*/

ELSE
IF @iGu = 'U2'
	BEGIN
		UPDATE GUILD_MEMBER_TBL
			  SET	m_nMemberLv = @im_nLevel,
						m_nClass = 0		 			-- 송현석 요청사항
		 WHERE m_idPlayer = @im_idPlayer
			  AND serverindex = @iserverindex
			  AND isuse = 'T'
		RETURN
	END
/*
	
	 GUILD 멤버 권한 변경- 강현민
	 ex ) 
	 GUILD_STR 'U2',@im_idPlayer,@iserverindex,@im_idGuild,@im_szGuild,@iLv_1,@iLv_2,@iLv_3,@iLv_4,@im_nLevel

	 GUILD_STR 'U2','000000','01','000001','',0,0,0,0,0,12
*/
ELSE
IF @iGu = 'U3'
	BEGIN
		UPDATE GUILD_TBL
			SET m_dwLogo = @im_dwLogo
		 WHERE m_idGuild = @im_idGuild
		      AND serverindex = @iserverindex
		RETURN
	END
/*
	
	 GUILD 로고 변경하기- 이혁재
	 ex ) 
	 GUILD_STR 'U3',@im_idPlayer,@iserverindex,@im_idGuild,@im_szGuild,@iLv_1,@iLv_2,@iLv_3,@iLv_4,@im_nLevel,@im_nGuildGold,
								  @im_nGuildPxp,@im_nWin,@im_nLose,@im_nSurrender,@im_dwLogo,@im_szNotice

	 GUILD_STR 'U3','000000','01','000001','',0,0,0,0,0,0,
								  0,0,0,0,0,123,@im_szNotice

*/


ELSE
IF @iGu = 'U4'
	BEGIN
		UPDATE GUILD_TBL
			SET m_nLevel = @im_nLevel,
                  m_nGuildGold = @im_nGuildGold,
                  m_nGuildPxp = @im_nGuildPxp
	   WHERE m_idGuild = @im_idGuild
		      AND serverindex = @iserverindex

		UPDATE GUILD_MEMBER_TBL
			SET m_nGiveGold = m_nGiveGold +  @iLv_1,
                  m_nGivePxp = m_nGivePxp +  @iLv_2
		WHERE  m_idGuild = @im_idGuild
		      AND serverindex = @iserverindex
			  AND m_idPlayer = @im_idPlayer
		RETURN
	END
/*
	
	 GUILD 공헌 - 이혁재
	 ex ) 
	GUILD_STR 'U4',@im_idPlayer,@iserverindex,@im_idGuild,@im_szGuild,@iLv_1,@iLv_2,@iLv_3,@iLv_4,@im_nLevel,@im_nGuildGold,
								  @im_nGuildPxp

	GUILD_STR 'U4','000000','01','000001','',0,0,0,0,16,1000,
								  14

*/


ELSE
IF @iGu = 'U5'
	BEGIN
		UPDATE GUILD_TBL
			SET m_szNotice = @im_szNotice
		 WHERE m_idGuild = @im_idGuild
		      AND serverindex = @iserverindex
		RETURN
	END

/*
	
	 GUILD 공지변경 - 이혁재
	 ex ) 
	 GUILD_STR 'U5',@im_idPlayer,@iserverindex,@im_idGuild,@im_szGuild,@iLv_1,@iLv_2,@iLv_3,@iLv_4,@im_nLevel,@im_nGuildGold,
								  @im_nGuildPxp,@im_nWin,@im_nLose,@im_nSurrender,@im_dwLogo,@im_szNotice


	 GUILD_STR 'U5','000000','01','000001','',0,0,0,0,0,0,
								  0,0,0,0,0,0,'안녕하십니까? 길드원이 되신걸 환영합니다.'

*/


ELSE
IF @iGu = 'U6'
	BEGIN
		UPDATE GUILD_TBL
			SET Pay_0 = @im_dwLogo,
					Pay_1 = @iLv_1,
					Pay_2 = @iLv_2,
					Pay_3 = @iLv_3,
					Pay_4 = @iLv_4
		 WHERE m_idGuild = @im_idGuild
		      AND serverindex = @iserverindex
		RETURN
	END

/*
	
	 GUILD 월급지정 - 송현석
	 ex ) 
	 GUILD_STR 'U6',@im_idPlayer,@iserverindex,@im_idGuild,@im_szGuild,@iLv_1,@iLv_2,@iLv_3,@iLv_4,@im_nLevel,@im_nGuildGold,
								  @im_nGuildPxp,@im_nWin,@im_nLose,@im_nSurrender,@im_dwLogo

	 GUILD_STR 'U6','000000','01','000001','',100,80,60,40,0,0,
								  0,0,0,0,0,20

*/


ELSE
IF @iGu = 'U7'
	BEGIN
		INSERT ITEM_SEND_TBL
			(m_idPlayer,serverindex,Item_Name,Item_count,m_nAbilityOption,End_Time)

		SELECT 	A.m_idPlayer,
						A.serverindex,
						'penya',
						CASE A.m_nMemberLv 	WHEN 0 THEN  B.Pay_0 
																	WHEN 1 THEN  B.Pay_1 
																	WHEN 2 THEN  B.Pay_2
																	WHEN 3 THEN  B.Pay_3
																	WHEN 4 THEN  B.Pay_4 
																 	ELSE 0 END ,
						0,
						NULL
			FROM GUILD_MEMBER_TBL A,GUILD_TBL B
        WHERE A.m_idGuild =B.m_idGuild
				AND B.m_idGuild = @im_idGuild
		      AND A.serverindex = B.serverindex
			  AND B.serverindex = @iserverindex
			  AND A.isuse = 'T'
			  AND (
							(A.m_nMemberLv = 0 AND B.Pay_0  > 0)  OR
						  	(A.m_nMemberLv = 1 AND B.Pay_1  > 0)  OR 
						  	(A.m_nMemberLv = 2 AND B.Pay_2  > 0)  OR 
						  	(A.m_nMemberLv = 3 AND B.Pay_3  > 0)  OR 
						  	(A.m_nMemberLv = 4 AND B.Pay_4  > 0) 
						)

		UPDATE GUILD_TBL 
			   SET m_nGuildGold = @iLv_1	
			 WHERE m_idGuild = @im_idGuild  AND serverindex = @iserverindex
		SELECT nError = '1',fText ='OK'
	RETURN
	END

/*
	
	 GUILD 월급지급 - 송현석
	 ex ) 
	 GUILD_STR 'U7',@im_idPlayer,@iserverindex,@im_idGuild,'',@iLv_1

	 GUILD_STR 'U7','000000','02','000029','',10000


*/

ELSE
IF @iGu = 'U8'
	BEGIN
		UPDATE GUILD_TBL
			SET m_szGuild = @im_szGuild
		 WHERE m_idGuild = @im_idGuild
		      AND serverindex = @iserverindex

-- 		IF @@SERVERNAME='CHAR-DB1'
-- 		BEGIN
-- 		UPDATE [LOG].LOG_DBF.dbo.GUILD_TBL  --로그 디비에 이름 변경 정진형 팀장 요청사항
-- 			SET  m_szGuild = @im_szGuild
-- 		 WHERE m_idGuild = @im_idGuild
-- 		      AND serverindex = @iserverindex
-- 		END
		RETURN
	END


/*
	
	 GUILD 이름 변경 - 송현석
	 ex ) 
	 GUILD_STR 'U8',@im_idPlayer,@iserverindex,@im_idGuild,@im_szGuild

	 GUILD_STR 'U8', '000000', '01', '000001', 'asasas'    


*/
ELSE
IF @iGu = 'U9'
	BEGIN
		UPDATE GUILD_MEMBER_TBL 
			SET m_nClass = @im_nClass
		 WHERE m_idPlayer = @im_idPlayer
		      AND serverindex = @iserverindex
		RETURN
	END


/*
	
	 GUILD원 등급 변경 - 송현석
	 ex ) 
	 GUILD_STR 'U9',,@im_idPlayer,@iserverindex,@im_idGuild,@im_szGuild,@iLv_1,@iLv_2,@iLv_3,@iLv_4,@im_nLevel,@im_nGuildGold,
								  @im_nGuildPxp,@im_nWin,@im_nLose,@im_nSurrender,@im_dwLogo,@im_nClass

	 GUILD_STR 'U9','000000','01','000001','',100,80,60,40,0,0,
								  0,0,0,0,0,20,2


*/

ELSE
IF @iGu = 'UA'
	BEGIN
		UPDATE GUILD_MEMBER_TBL 
			SET m_szAlias = @im_szGuild --m_szAlias
		 WHERE m_idPlayer = @im_idPlayer
		      AND serverindex = @iserverindex
		RETURN
	END


/*
	
	 GUILD원 별칭 변경 - 송현석
	 ex ) 
	 GUILD_STR 'UA',,@im_idPlayer,@iserverindex,@im_idGuild,@im_szGuild(m_szAlias)

	 GUILD_STR 'UA','000000','01','000001','시다바리'


*/
ELSE
IF @iGu = 'D1'
	BEGIN
		
			UPDATE CHARACTER_TBL
	         	SET m_tGuildMember = CONVERT(CHAR(8),DATEADD(d,2,GETDATE()),112) 
										+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,DATEADD(d,2,GETDATE()))),2) 
										+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,DATEADD(d,2,GETDATE()))),2) 
										+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,DATEADD(d,2,GETDATE()))),2)
				FROM CHARACTER_TBL A,GUILD_MEMBER_TBL B
			 WHERE A.m_idPlayer = B.m_idPlayer
					AND B.m_idGuild = @im_idGuild
					AND A.serverindex = B.serverindex
			      AND B.serverindex = @iserverindex

			DELETE GUILD_TBL
			 WHERE m_idGuild = @im_idGuild
			      AND serverindex = @iserverindex
	
			DELETE GUILD_MEMBER_TBL
			 WHERE m_idGuild = @im_idGuild
			      AND serverindex = @iserverindex
	
			DELETE GUILD_BANK_TBL
			 WHERE m_idGuild = @im_idGuild
		      AND serverindex = @iserverindex

			DELETE GUILD_BANK_EXT_TBL
			 WHERE m_idGuild = @im_idGuild
		      AND serverindex = @iserverindex

-- 			IF @@SERVERNAME='CHAR-DB1'
-- 			BEGIN
-- 			UPDATE [LOG].LOG_DBF.dbo.GUILD_TBL  --로그 디비에 이름 변경 정진형 팀장 요청사항
-- 				SET  isuse = 'D'
-- 			 WHERE m_idGuild = @im_idGuild
-- 			      AND serverindex = @iserverindex
-- 
-- 			END





--		임시로 딜리트 (강현민 요청사항)
-- 		UPDATE GUILD_TBL
-- 			SET isuse = 'F'
-- 		 WHERE m_idGuild = @im_idGuild
-- 		      AND serverindex = @iserverindex
-- 
-- 		UPDATE GUILD_MEMBER_TBL
-- 			SET isuse = 'F'
-- 		 WHERE m_idGuild = @im_idGuild
-- 		      AND serverindex = @iserverindex
		RETURN
	END

/*
	
	 GUILD 해체- 강현민
	 ex ) 
	 GUILD_STR 'D1',@im_idPlayer,@iserverindex,@im_idGuild

	 GUILD_STR 'D1','000000','01','000001'

*/

ELSE
IF @iGu = 'D2'
	BEGIN

		UPDATE CHARACTER_TBL
         	SET m_tGuildMember = CONVERT(CHAR(8),DATEADD(d,2,GETDATE()),112) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,DATEADD(d,2,GETDATE()))),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,DATEADD(d,2,GETDATE()))),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,DATEADD(d,2,GETDATE()))),2)
		 WHERE m_idPlayer = @im_idPlayer
		      AND serverindex = @iserverindex


		DELETE  GUILD_MEMBER_TBL
		 WHERE m_idPlayer = @im_idPlayer
		      AND serverindex = @iserverindex


--		임시로 딜리트 (강현민 요청사항)
-- 		UPDATE GUILD_MEMBER_TBL
-- 			SET isuse = 'F'
-- 		 WHERE m_idGuild = @im_idGuild
-- 		      AND serverindex = @iserverindex
 		RETURN
	END

/*
	
	 GUILD 탈퇴/추방 - 강현민
	 ex ) 
	 GUILD_STR 'D2',@im_idPlayer,@iserverindex,@im_idGuild

	 GUILD_STR 'D2','000000','01','000001'

*/
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[DEL_FALSE_CHARACTER_STR]
@serverindex char(2) = '01'
AS
UPDATE CHARACTER_TBL
SET isblock = 'D'
 --select m_idPlayer,TotalPlayTime  from CHARACTER_TBL
  where m_idPlayer in (
			select x.m_idPlayer
			from 
			(
				select a.m_idPlayer 
				  from CHARACTER_TBL a,
					     (
	                          select account, playerslot
					        from CHARACTER_TBL 
					      where isblock='F'
							and serverindex =@serverindex
					       group by account,playerslot 
					      having count(account)>1
	                        ) b
				  where a.account=b.account
				    and a.playerslot =b.playerslot
					 and serverindex =@serverindex
				    and a.isblock = 'F'
			) x
			where x.m_idPlayer NOT IN(  select m_idPlayer = min(m_idPlayer) 
													   from CHARACTER_TBL
													 where isblock='F'
														  and serverindex =@serverindex
													   group by account,playerslot 
													  having count(account)>1)
			)
  and isblock = 'F'
  and serverindex =@serverindex
RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE   PROC [dbo].[GUILD_VOTE_STR]
@iGu CHAR(2) ='S1',
@iserverindex CHAR(2) = '01',
@im_idGuild CHAR(6) = '000000',
@im_idVote INT = 0,
@im_szTitle VARCHAR(128) ='',
@im_szQuestion VARCHAR(255) = '',
@im_szString1 VARCHAR(32) = '',
@im_szString2 VARCHAR(32) = '',
@im_szString3 VARCHAR(32) = '',
@im_szString4 VARCHAR(32) = '',
@im_cbCount	INT = 0
AS
set nocount on
IF @iGu = 'S1'
	BEGIN
		SELECT 	m_idGuild,serverindex,m_idVote,m_cbStatus,m_szTitle,m_szQuestion,
						m_szString1,m_szString2,m_szString3,m_szString4,
						m_cbCount1,m_cbCount2,m_cbCount3,m_cbCount4
		   FROM GUILD_VOTE_TBL
		WHERE serverindex = @iserverindex
			  AND m_cbStatus IN ('1','2')
		ORDER BY m_idGuild,m_idVote DESC
	RETURN
	END

/*
	 GUILD 투표 전부 가져오기
	 ex ) 
	 GUILD_VOTE_STR 'S1',	@iserverindex
	 GUILD_VOTE_STR 'S1',	'01'

*/
ELSE
IF @iGu = 'A1'
	BEGIN
		DECLARE @om_idVote INT,@oCount INT,@om_idVoteMin INT
	
		SELECT @om_idVote = ISNULL(MAX(m_idVote),0) + 1 
			FROM  GUILD_VOTE_TBL 
		 WHERE serverindex = @iserverindex
	
		SELECT @oCount = COUNT(m_idGuild),@om_idVoteMin = MIN(m_idVote) 
		   FROM GUILD_VOTE_TBL
		WHERE m_idGuild = @im_idGuild
			AND serverindex = @iserverindex
			AND m_cbStatus IN ('1','2')

		IF @oCount >= 20
		UPDATE GUILD_VOTE_TBL
			SET m_cbStatus = '3'
		WHERE m_idVote = @om_idVoteMin 
		    AND  m_idGuild = @im_idGuild
		

		INSERT GUILD_VOTE_TBL
		(
			m_idGuild,serverindex,m_idVote,m_cbStatus,m_szTitle,m_szQuestion,
			m_szString1,m_szString2,m_szString3,m_szString4,
			m_cbCount1,m_cbCount2,m_cbCount3,m_cbCount4,CreateTime
		)
		VALUES
		(
			@im_idGuild,@iserverindex,@om_idVote,'1',@im_szTitle,@im_szQuestion,
			@im_szString1,@im_szString2,@im_szString3,@im_szString4,
			0,0,0,0,GETDATE()
		)
		SELECT m_idVote  = @om_idVote 
	RETURN
	END
/*
	 GUILD 투표 저장하기
	 ex ) 
	 GUILD_VOTE_STR 'A1',	@iserverindex,@im_idGuild,@im_idVote,@im_szTitle,@im_szQuestion,
												@im_szString1,@im_szString2,@im_szString3,@im_szString4

	 GUILD_VOTE_STR 'A1',	'01','000001',0,'노무현 탄핵?','탄핵이 옳을까요? 아닐까요?',
												'옳다','아니다','모르겠다',''

*/
ELSE
IF @iGu = 'U1'
	BEGIN
		IF EXISTS(SELECT * FROM GUILD_MEMBER_TBL WHERE m_idPlayer= @im_idGuild AND serverindex = @iserverindex  AND m_idVote = @im_idVote)
			SELECT n_Error = '2',f_Text = '이미 투표하셨습니다.'
		ELSE
			BEGIN
			DECLARE @om_cbCount CHAR(1)
			SET @om_cbCount =  CONVERT(CHAR(1),@im_cbCount)
			EXEC('
			UPDATE GUILD_VOTE_TBL 
				SET m_cbCount ' + @om_cbCount + ' =  m_cbCount' + @om_cbCount +  ' + 1
			WHERE m_idVote = + ' + @im_idVote + '
			UPDATE GUILD_MEMBER_TBL
				SET m_idVote = ''' + @im_idVote + ''' 
			WHERE m_idPlayer= ''' + @im_idGuild + '''
			     AND serverindex = ''' + @iserverindex  + ''''
			)
			SELECT n_Error = '1',f_Text = 'OK.'
			END
	RETURN
	END
/*
	 GUILD 투표 하기
	 ex ) 
	 GUILD_VOTE_STR 'U1',	@iserverindex,@im_idGuild,@im_idVote,@im_szTitle,@im_szQuestion,
												@im_szString1,@im_szString2,@im_szString3,@im_szString4,
												@im_cbCount
	 GUILD_VOTE_STR 'U1',	'01','000001',0,'노무현 탄핵?','탄핵이 옳을까요? 아닐까요?',
												'옳다','아니다','모르겠다','',
												0

*/
IF @iGu = 'U2'
	BEGIN
		UPDATE GUILD_VOTE_TBL 
			SET 	m_cbStatus = '2'
		WHERE m_idVote = @im_idVote
		     AND serverindex = @iserverindex
	RETURN
	END

/*
	 GUILD 투표 마감하기
	 ex ) 
	 GUILD_VOTE_STR 'U2',@iserverindex,@im_idGuild,@im_idVote
	 GUILD_VOTE_STR 'U2','01','000000',123

*/
IF @iGu = 'D1'
	BEGIN
		UPDATE GUILD_VOTE_TBL 
			SET 	m_cbStatus = '3'
		WHERE m_idVote = @im_idVote
		     AND serverindex = @iserverindex
	RETURN
	END

/*
	 GUILD 투표 삭제하기
	 ex ) 
	 GUILD_VOTE_STR 'D1',@iserverindex,@im_idGuild,@im_idVote
	 GUILD_VOTE_STR 'D1','01','000000',123

*/

set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE               PROC [dbo].[GUILD_QUEST_STR]
	@iGu        		  				CHAR(2) 			=	'S1', 
	@im_idGuild				CHAR(6) 			= '000001',
	@iserverindex  				CHAR(2) 		= '01',
	@in_Id					INT					= 0,
	@in_State						INT					= 0
AS
set nocount on


DECLARE @odate CHAR(14)
  SELECT @odate = CONVERT(CHAR(8),GETDATE(),112) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,GETDATE())),2)

IF @iGu = 'S1'
	BEGIN
		SELECT m_idGuild,serverindex,n_Id,nState,s_date,e_date
          FROM GUILD_QUEST_TBL
		 WHERE serverindex = @iserverindex 
		 ORDER BY m_idGuild,serverindex,n_Id
		RETURN
	END
/*
  	길드 퀘스트 다 불러오기
	 ex ) 
   GUILD_QUEST_STR 'S1', @im_idGuild,@iserverindex

   	GUILD_QUEST_STR 'S1', '','01'
*/
ELSE
IF @iGu = 'A1'
	BEGIN
		IF NOT EXISTS(SELECT *  FROM GUILD_QUEST_TBL WHERE m_idGuild= @im_idGuild AND serverindex = @iserverindex AND n_Id	= @in_Id)
			INSERT GUILD_QUEST_TBL
				(m_idGuild,serverindex,n_Id,nState,s_date,e_date)
			VALUES
				(@im_idGuild,@iserverindex,@in_Id,0,@odate,'')
		RETURN
	END
/*
  	길드 퀘스트 시작
	 ex ) 
   GUILD_QUEST_STR 'A1', @im_idGuild,@iserverindex,@in_Id

   	GUILD_QUEST_STR 'A1', '000001','01',0
*/
ELSE
IF @iGu = 'U1'
	BEGIN
		UPDATE GUILD_QUEST_TBL
			   SET nState = @in_State,
						e_date =  @odate
		 WHERE m_idGuild= @im_idGuild 
             AND serverindex = @iserverindex 
             AND n_Id	= @in_Id
		RETURN
	END
/*
  	길드 퀘스트 종료
	 ex ) 
   GUILD_QUEST_STR 'U1', @im_idGuild,@iserverindex,@in_Id,@in_State

   	GUILD_QUEST_STR 'U1', '000001','01',0,1
*/
ELSE
IF @iGu = 'D1'
	BEGIN
		DELETE GUILD_QUEST_TBL
		 WHERE m_idGuild= @im_idGuild 
             AND serverindex = @iserverindex 
             AND n_Id	= @in_Id
		RETURN
	END
/*
  	길드 퀘스트 삭제
	 ex ) 
   GUILD_QUEST_STR 'D1', @im_idGuild,@iserverindex,@in_Id,@in_State

   	GUILD_QUEST_STR 'D1', '000001','01',0,1
*/
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[TAX_INFO_STR]
@iGu char(2) = 'S1',
@serverindex char(2) = '01',
@nTimes int,
@nContinent int,
@dwID char(7),
@dwNextID char(7),
@bSetTaxRate int,
@change_time char(12)
as

set nocount on

if @iGu = 'S1'
begin
	select isnull(max(nTimes), 0) as nTimes
	from TAX_INFO_TBL
	where serverindex = @serverindex
end

if @iGu = 'S2'
begin
	select  dwID, dwNextID, bSetTaxRate, change_time
	from TAX_INFO_TBL
	where serverindex = @serverindex and nTimes = @nTimes and nContinent = @nContinent
end

if @iGu = 'S3'
begin
	select m_idPlayer
	from GUILD_MEMBER_TBL
	where serverindex = @serverindex and m_idGuild = right(@dwID, 6) and m_nMemberLv = 0
end

if @iGu = 'I1'
begin
	insert into TAX_INFO_TBL (serverindex, nTimes, nContinent, dwID, dwNextID, change_time, bSetTaxRate)
	select @serverindex, @nTimes, @nContinent, @dwID, @dwNextID, @change_time, @bSetTaxRate
end

if @iGu = 'U1'
begin
	update TAX_INFO_TBL
	set dwID = @dwID, dwNextID = @dwNextID, bSetTaxRate = @bSetTaxRate, save_time = getdate()
	where serverindex = @serverindex and nTimes = @nTimes and nContinent = @nContinent
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SECRET_ROOM_STR]
@iGu char(2),
@serverindex char(2),
@nTimes int,
@nContinent int,
@m_idGuild char(6),
@nPenya int,
@chState char(1),
@dwWorldID int,
@nWarState int,
@nKillCount int
as

set nocount on
set xact_abort on

if @iGu = 'S1'
begin
	select isnull(max(nTimes), 0) as nTimes from SECRET_ROOM_TBL where serverindex = @serverindex
end

if @iGu = 'S2'
begin
	select nContinent, m_idGuild, nPenya
	from SECRET_ROOM_TBL
	where serverindex = @serverindex and nTimes = @nTimes and chState = @chState
	order by nContinent asc, nPenya desc, s_date asc
end

if @iGu = 'I1'
begin
	insert into SECRET_ROOM_TBL (serverindex, nTimes, nContinent, m_idGuild, nPenya, chState, s_date)
	select @serverindex, @nTimes, @nContinent, @m_idGuild, @nPenya, @chState, getdate()
end


if @iGu = 'U1'
begin
	update SECRET_ROOM_TBL
	set nPenya = @nPenya, chState = @chState, s_date = getdate()
	where serverindex = @serverindex and nTimes = @nTimes and nContinent = @nContinent and m_idGuild = @m_idGuild and chState = 'T'
end

if @iGu = 'U2'
begin
	update SECRET_ROOM_TBL
	set nPenya = @nPenya, chState = @chState, dwWorldID = @dwWorldID, nWarState = @nWarState, nKillCount = @nKillCount, s_date = getdate()
	where serverindex = @serverindex and nTimes = @nTimes and nContinent = @nContinent and m_idGuild = @m_idGuild and chState = 'T'
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[RAINBOWRACE_STR]
@iGu char(2),
@serverindex char(2),
@nTimes int,
@m_idPlayer char(7),
@nRanking int
as
set nocount on
set xact_abort on

declare @q1 nvarchar(4000)

if @iGu = 'S1'
begin
	select isnull(max(nTimes), 0) as nTimes from RAINBOWRACE_TBL where serverindex = @serverindex
end

-- 신청자 목록
if @iGu = 'S2'
begin
	set @q1 = '
	update RAINBOWRACE_TBL
	set chState = ''N''
	where serverindex = @serverindex and nTimes = @nTimes and chState = ''R'''
	exec sp_executesql @q1, N'@serverindex char(2), @nTimes int', @serverindex, @nTimes

	set @q1 = '
	select m_idPlayer
	from RAINBOWRACE_TBL
	where serverindex = @serverindex and nTimes = @nTimes and chState = ''N'''
	exec sp_executesql @q1, N'@serverindex char(2), @nTimes int', @serverindex, @nTimes

/*	select m_idPlayer
	from RAINBOWRACE_TBL
	where serverindex = @serverindex and nTimes = @nTimes and chState in ('N', 'R')
*/
end

-- 지난 랭킹
if @iGu = 'S3'
begin
	select m_idPlayer
	from RAINBOWRACE_TBL
	where serverindex = @serverindex and nTimes = @nTimes - 1 and chState = 'W' and nRanking > 0
	order by nRanking
end


-- 신청
if @iGu = 'I1'
begin
	insert into RAINBOWRACE_TBL (serverindex, nTimes, m_idPlayer, chState, nRanking, s_date)
	select @serverindex, @nTimes, @m_idPlayer, 'N', 0, getdate()
end

-- 완주(랭킹등록예약)
if @iGu = 'U1'
begin
	update RAINBOWRACE_TBL
	set chState = 'R', nRanking = @nRanking, s_date = getdate()
	where serverindex = @serverindex and nTimes = @nTimes and  m_idPlayer = @m_idPlayer and chState = 'N'
end

-- 레인보우 레이스 종료
if @iGu = 'U2'
begin
	set xact_abort off

	-- 랭킹등록예약자 완료
	update RAINBOWRACE_TBL
	set chState = 'W'
	where serverindex = @serverindex and nTimes = @nTimes and chState = 'R'

	-- 완주실패자 등록
	update RAINBOWRACE_TBL
	set chState = 'L',  nRanking = 0, s_date = getdate()
	where serverindex = @serverindex and nTimes = @nTimes and chState = 'N'
end

-- 탈락
if @iGu = 'U3'
begin
	update RAINBOWRACE_TBL
	set chState = 'F',  nRanking = 0, s_date = getdate()
	where serverindex = @serverindex and nTimes = @nTimes and m_idPlayer = @m_idPlayer
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[MAIL_STR]
	@iGu		CHAR(2),
	@nMail		INT,
	@serverindex	CHAR(2),
	@idReceiver	CHAR(7)	= '0000000',
	@idSender	CHAR(7)	= '0000000',
	@nGold		INT	= 0,
	@tmCreate	INT	= 0,
	@byRead	INT	= 0,
	@szTitle		VARCHAR(128)	= '',
	@szText		VARCHAR(1024)	= '',
	@dwItemId	INT	= 0,
	@nItemNum	INT	= 0,
	@nRepairNumber	INT	= 0,
	@nHitPoint	INT	= 0,
	@nMaxHitPoint	INT	= 0,
	@nMaterial	INT	= 0,
	@byFlag		INT	= 0,
	@dwSerialNumber	INT	= 0,
	@nOption	INT	= 0,
	@bItemResist	INT	= 0,
	@nResistAbilityOption	INT	= 0,
	@idGuild		INT	= 0,
	@nResistSMItemId	INT	= 0,
	@bCharged	INT	= 0,
	@dwKeepTime	INT	= 0,
	@nRandomOptItemId	bigINT	= 0,
	@nPiercedSize	INT	= 0,
	@dwItemId1	INT	= 0,
	@dwItemId2	INT	= 0,
	@dwItemId3	INT	= 0,
	@dwItemId4	INT	= 0
        ------------------- Version9 Pet
        ,@bPet    int = 0,
        @nKind  int = 0,
        @nLevel int = 0,
        @dwExp              int = 0,
        @wEnergy          int = 0,
        @wLife   int = 0,
        @anAvailLevel_D int = 0, 
        @anAvailLevel_C int = 0,
        @anAvailLevel_B int = 0,
        @anAvailLevel_A int = 0,
        @anAvailLevel_S int = 0,

        @dwItemId5 int = 0
	----------------- Ver. 12
	,@dwItemId6 int = 0, @dwItemId7 int = 0, @dwItemId8 int = 0, @dwItemId9 int = 0, @dwItemId10 int = 0
	,@dwItemId11 int = 0, @dwItemId12 int = 0, @dwItemId13 int = 0, @dwItemId14 int = 0, @dwItemId15 int = 0
	,@nPiercedSize2 int = 0
	----------------- Ver. 13
	, @szPetName varchar(32) = ''
AS
set nocount on
IF @iGu	= 'S1'
	BEGIN
		SELECT * FROM MAIL_TBL WHERE serverindex = @serverindex AND byRead<90 order by nMail
	RETURN
	END
ELSE
IF @iGu	= 'A1'
	BEGIN
		INSERT MAIL_TBL
			(
				nMail,
				serverindex,
				idReceiver,
				idSender,
				nGold,
				tmCreate,
				byRead,
				szTitle,
				szText,
				dwItemId,
				nItemNum,
				nRepairNumber,
				nHitPoint,
				nMaxHitPoint,
				nMaterial,
				byFlag,
				dwSerialNumber,
				nOption,
				bItemResist,
				nResistAbilityOption,
				idGuild,
				nResistSMItemId,
				bCharged,
				dwKeepTime,
				nRandomOptItemId,
				nPiercedSize,
				dwItemId1,
				dwItemId2,
				dwItemId3,
				dwItemId4,
				SendDt
				, bPet, nKind, nLevel, dwExp, wEnergy, wLife, anAvailLevel_D, anAvailLevel_C
				, anAvailLevel_B, anAvailLevel_A, anAvailLevel_S, dwItemId5
				, dwItemId6, dwItemId7, dwItemId8, dwItemId9, dwItemId10, dwItemId11
				, dwItemId12, dwItemId13, dwItemId14, dwItemId15, nPiercedSize2
				-- Ver. 13
				, szPetName
			)
			VALUES 
			(
				@nMail,
				@serverindex,
				@idReceiver,
				@idSender,
				@nGold,
				@tmCreate,
				@byRead,
				@szTitle,
				@szText,
				@dwItemId,
				@nItemNum,
				@nRepairNumber,
				@nHitPoint,
				@nMaxHitPoint,
				@nMaterial,
				@byFlag,
				@dwSerialNumber,
				@nOption,
				@bItemResist,
				@nResistAbilityOption,
				@idGuild,
				@nResistSMItemId,
				@bCharged,
				@dwKeepTime,
				@nRandomOptItemId,
				@nPiercedSize,
				@dwItemId1,
				@dwItemId2,
				@dwItemId3,
				@dwItemId4,
				getdate()
				, @bPet, @nKind, @nLevel, @dwExp, @wEnergy, @wLife, @anAvailLevel_D, @anAvailLevel_C
				, @anAvailLevel_B, @anAvailLevel_A, @anAvailLevel_S ,@dwItemId5
				, @dwItemId6, @dwItemId7, @dwItemId8, @dwItemId9, @dwItemId10, @dwItemId11
				, @dwItemId12, @dwItemId13, @dwItemId14, @dwItemId15, @nPiercedSize2
				-- Ver. 13
				, @szPetName 
			)
	RETURN
	END
IF @iGu	= 'D1'
	BEGIN
		UPDATE MAIL_TBL SET byRead=90, DeleteDt=getdate() WHERE nMail = @nMail AND serverindex = @serverindex
	RETURN
	END

IF @iGu = 'D2'
begin
	--update MAIL_TBL set byRead=90, DeleteDt=getdate() where serverindex = @serverindex and tmCreate < @tmCreate
	return
end

IF @iGu	= 'U1'
	BEGIN
		UPDATE MAIL_TBL SET 
			ItemFlag=90, ItemReceiveDt=getdate()
			WHERE nMail = @nMail AND serverindex = @serverindex
	RETURN
	END

IF @iGu	= 'U2'
	BEGIN
		UPDATE MAIL_TBL SET GoldFlag=90, GetGoldDt=getdate() WHERE nMail = @nMail AND serverindex = @serverindex
	RETURN
	END


IF @iGu	= 'U3'
	BEGIN
		UPDATE MAIL_TBL SET byRead = 1, ReadDt=getdate() WHERE nMail = @nMail AND serverindex = @serverindex
	RETURN
	END

set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PARTY_STR]
	@iGu        		  				CHAR(2) 			= 'S1', 
	@im_idPlayer   				CHAR(7) 			= '0000001',
	@iserverindex  				CHAR(2) 			= '01',
	@ipartyname 				VARCHAR(16)				=	''
AS
set nocount on
IF 	@iGu = 'A1'
	BEGIN
		IF EXISTS(SELECT * FROM  PARTY_TBL  WHERE m_idPlayer = @im_idPlayer  AND serverindex = @iserverindex)
		UPDATE PARTY_TBL
			SET partyname = @ipartyname
		WHERE m_idPlayer = @im_idPlayer
		    AND serverindex = @iserverindex
		ELSE
		INSERT PARTY_TBL
			(m_idPlayer,serverindex,partyname)
		VALUES
			(@im_idPlayer,@iserverindex,@ipartyname)	
		RETURN
	END
/*
	
	 파티이름  저장하기
	 ex ) 
	 PARTY_STR 'A1',@im_idPlayer,@iserverindex,@ipartyname
	 PARTY_STR 'A1','000001','01','불타는닭갈비'

*/

ELSE
IF @iGu = 'S1'
	BEGIN
		SELECT partyname
		   FROM PARTY_TBL
		WHERE m_idPlayer = @im_idPlayer
		    AND serverindex = @iserverindex
		RETURN
	END
/*
	
	 나의 파티이름 가져오기
	 ex ) 
	 PARTY_STR 'S1',@im_idPlayer,@iserverindex
	 PARTY_STR 'S1','000001','01'

*/

ELSE
IF @iGu = 'S2'
	BEGIN
		SELECT partyname,m_idPlayer
		   FROM PARTY_TBL
		WHERE serverindex = @iserverindex
	    ORDER BY partyname
		RETURN
	END
/*
	
	 나의 파티이름 전체 가져오기
	 ex ) 
	 PARTY_STR 'S2','',@iserverindex
	 PARTY_STR 'S2','','01'

*/
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[NEW_MESSENGER_STR]
	@iGu         			char(2)		= 'S1', 
	@im_idPlayer 			char(7)		= '0000001',
	@iserverindex  			char(2)		= '01',
	@if_idPlayer 			char(7)		=	'',
	@im_dwSex 				int			= 0,
	@im_nJob				int			= 0,
	@iState 				char(1)		='',
	@im_dwState				int			= 0
AS
SET NOCOUNT ON

	DECLARE	@sql	nvarchar(4000)
	SET	@sql=''
	
	IF	@iGu = 'A1'
		BEGIN
			IF EXISTS(SELECT * FROM  MESSENGER_TBL  WHERE m_idPlayer = @im_idPlayer  AND serverindex = @iserverindex  AND f_idPlayer = @if_idPlayer)
			UPDATE MESSENGER_TBL
				SET State = 'T',
						m_dwState = @im_dwState
			WHERE m_idPlayer = @im_idPlayer
				AND serverindex = @iserverindex
				AND f_idPlayer = @if_idPlayer
			ELSE
			INSERT MESSENGER_TBL
				(m_idPlayer,serverindex,f_idPlayer,m_nJob,m_dwSex,m_dwState,State,CreateTime)
			VALUES
				(@im_idPlayer,@iserverindex,@if_idPlayer,@im_nJob,@im_dwSex,0,'T',GETDATE())	
			RETURN
		END
	/*
		
		메신저 친구 저장하기
		ex ) 
		NEW_MESSENGER_STR 'A1',@im_idPlayer,@iserverindex,@if_idPlayer,@im_nJob,@im_dwSex
		NEW_MESSENGER_STR 'A1','000001','01','000002',1,1
	*/
	ELSE
	----------------------------------------
	--	메신저 리스트 가져오기
	--	NEW_MESSENGER_STR 'S1','000001','01'
	IF @iGu = 'S1'	BEGIN
		SET @sql=N'
			EXEC uspLoadMessengerList @pserverindex, @pPlayerID
		'
		
		EXECUTE sp_executesql	@sql, 
								N'@pPlayerID char(7), @pserverindex char(2)', 
								@im_idPlayer, @iserverindex

		RETURN
	END
	----------------------------------------
	--	나를 등록한 메신저 리스트 가져오기
	--	NEW_MESSENGER_STR 'S2','000001','02'
	ELSE
	IF @iGu = 'S2'	BEGIN
		SET @sql=N'
			EXEC uspLoadMessengerListRegisterMe @pserverindex, @pPlayerID
		'
		
		EXECUTE sp_executesql	@sql, 
								N'@pPlayerID char(7), @pserverindex char(2)', 
								@im_idPlayer, @iserverindex

			RETURN
		END
	ELSE
	IF	@iGu = 'D1'
		BEGIN
			UPDATE MESSENGER_TBL
				SET State = 'D'
			WHERE m_idPlayer = @im_idPlayer
				AND serverindex = @iserverindex
				AND f_idPlayer = @if_idPlayer
				AND State = 'T'
			RETURN
		END
	ELSE
	IF @iGu = 'D2'
		BEGIN
			DELETE MESSENGER_TBL
			WHERE m_idPlayer NOT IN
			(SELECT m_idPlayer 
				FROM CHARACTER_TBL where serverindex = @iserverindex)
				and  serverindex = @iserverindex

			DELETE MESSENGER_TBL
			WHERE f_idPlayer NOT IN
			(SELECT m_idPlayer 
				FROM CHARACTER_TBL where serverindex = @iserverindex)
				and  serverindex = @iserverindex

			DELETE MESSENGER_TBL
			WHERE State = 'D'
			and  serverindex = @iserverindex
			RETURN
		END

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- select m_idPlayer,serverindex,m_wId from QUEST_TBL
-- GROUP BY m_idPlayer,serverindex,m_wId
-- 
-- QUEST_STR 'D1','001011','02',36
-- QUEST_STR 'S1','001022','01'

CREATE   PROC [dbo].[QUEST_STR]
@iGu CHAR(2) = 'S1',
@m_idPlayer CHAR(7) = '0000001',
@serverindex CHAR(2) = '01',
@m_wId int = null,
@m_nState tinyint = null,
@m_wTime int = null,
@m_nKillNPCNum_0 tinyint = null,
@m_nKillNPCNum_1 tinyint = null,
@m_bPatrol tinyint = null,
@m_bDialog tinyint = null,
@m_bReserve3 tinyint = null,
@m_bReserve4 tinyint = null,
@m_bReserve5 tinyint = null,
@m_bReserve6 tinyint = null,
@m_bReserve7 tinyint = null,
@m_bReserve8 tinyint = null,
@m_Inventory varchar(6940) = '', 
@m_apIndex varchar(345) = '', 
@m_adwEquipment varchar(135) = '', 
@m_dwObjIndex varchar(345) = ''
AS
IF @iGu = 'S1'
	BEGIN
		SELECT m_idPlayer,serverindex,m_wId,m_nState,m_wTime,m_nKillNPCNum_0,m_nKillNPCNum_1,
                    m_bPatrol,m_bDialog,m_bReserve3,m_bReserve4,m_bReserve5,m_bReserve6,m_bReserve7,m_bReserve8
         FROM QUEST_TBL
		WHERE m_idPlayer = @m_idPlayer
            AND serverindex = @serverindex
       ORDER BY m_idPlayer,serverindex,m_wId
	END
/*
	
	 퀘스트 전체 가져오기
	 ex ) 
	 QUEST_STR 'S1',@m_idPlayer,@serverindex
	 QUEST_STR 'S1','000001','01'

*/
IF @iGu = 'A1'
	BEGIN 
		IF NOT EXISTS(SELECT * FROM QUEST_TBL WHERE m_idPlayer = @m_idPlayer AND  serverindex = @serverindex AND m_wId = @m_wId)
	       INSERT QUEST_TBL	
			( m_idPlayer,serverindex,m_wId,m_nState,m_wTime,m_nKillNPCNum_0,m_nKillNPCNum_1,
	          m_bPatrol,m_bDialog,m_bReserve3,m_bReserve4,m_bReserve5,m_bReserve6,m_bReserve7,m_bReserve8)
			VALUES
			(@m_idPlayer,@serverindex,@m_wId,@m_nState,@m_wTime,@m_nKillNPCNum_0,@m_nKillNPCNum_1,
	         @m_bPatrol,@m_bDialog,@m_bReserve3,@m_bReserve4,@m_bReserve5,@m_bReserve6,@m_bReserve7,@m_bReserve8)
		ELSE
			UPDATE QUEST_TBL
                 SET m_nState = @m_nState,
                        m_wTime = @m_wTime,
                        m_nKillNPCNum_0 = @m_nKillNPCNum_0,
                        m_nKillNPCNum_1 = @m_nKillNPCNum_1,
                        m_bPatrol = @m_bPatrol,
                        m_bDialog = @m_bDialog,
                        m_bReserve3 = @m_bReserve3,
                        m_bReserve4 = @m_bReserve4,
                        m_bReserve5 = @m_bReserve5,
                        m_bReserve6 = @m_bReserve6,
                        m_bReserve7 = @m_bReserve7,
                        m_bReserve8 = @m_bReserve8
			 WHERE m_idPlayer = @m_idPlayer 
		         AND  serverindex = @serverindex 
	             AND m_wId = @m_wId

		IF @m_Inventory <> ''
			UPDATE INVENTORY_TBL
				   SET m_Inventory = @m_Inventory, 
                         m_apIndex = @m_apIndex, 
                         m_adwEquipment = @m_adwEquipment, 
                         m_dwObjIndex = @m_dwObjIndex
			 WHERE m_idPlayer = @m_idPlayer 
		         AND  serverindex = @serverindex 
	END
/*
	
	 퀘스트 저장하기
	 ex ) 
	QUEST_STR 'A1',@m_idPlayer,@serverindex,@m_wId,@m_nState,@m_wTime,@m_nKillNPCNum_0,@m_nKillNPCNum_1,@m_bPatrol,@m_bDialog,
                               @m_bReserve3,@m_bReserve4,@m_bReserve5,@m_bReserve6,@m_bReserve7,@m_bReserve8,@m_Inventory, @m_apIndex, @m_adwEquipmen, @m_dwObjIndex

	QUEST_STR 'A1',@m_idPlayer,@serverindex,@m_wId = 1,@m_nState = 0,@m_wTime = 65535,@m_nKillNPCNum_0 = 0,@m_nKillNPCNum_1 = 0,@m_bPatrol = 0,@m_bDialog = 0,
                              @m_bReserve3 = 0,@m_bReserve4 = 0,@m_bReserve5 = 0,@m_bReserve6 = 0,@m_bReserve7 = 0,@m_bReserve8 = 0,@m_Inventory = '$', @m_apIndex = '$', @m_adwEquipmen = '$', @m_dwObjIndex = '$'


*/

IF @iGu = 'U1'
	BEGIN
		UPDATE QUEST_TBL
               SET m_nState = @m_nState,
                      m_wTime = @m_wTime,
                      m_nKillNPCNum_0 = @m_nKillNPCNum_0,
                      m_nKillNPCNum_1 = @m_nKillNPCNum_1,
                      m_bPatrol = @m_bPatrol,
                      m_bDialog = @m_bDialog,
                      m_bReserve3 = @m_bReserve3,
                      m_bReserve4 = @m_bReserve4,
                      m_bReserve5 = @m_bReserve5,
                      m_bReserve6 = @m_bReserve6,
                      m_bReserve7 = @m_bReserve7,
                      m_bReserve8 = @m_bReserve8
		 WHERE m_idPlayer = @m_idPlayer 
	         AND  serverindex = @serverindex 
             AND m_wId = @m_wId

		IF @m_Inventory <> ''
			UPDATE INVENTORY_TBL
				   SET m_Inventory = @m_Inventory, 
                         m_apIndex = @m_apIndex, 
                         m_adwEquipment = @m_adwEquipment, 
                         m_dwObjIndex = @m_dwObjIndex
			 WHERE m_idPlayer = @m_idPlayer 
		         AND  serverindex = @serverindex 	

   END

/*
	
	 퀘스트 수정하기
	 ex ) 
	QUEST_STR 'U1',@m_idPlayer,@serverindex,@m_wId,@m_nState,@m_wTime,@m_nKillNPCNum_0,@m_nKillNPCNum_1,@m_bPatrol,@m_bDialog,
                               @m_bReserve3,@m_bReserve4,@m_bReserve5,@m_bReserve6,@m_bReserve7,@m_bReserve8,@m_Inventory, @m_apIndex, @m_adwEquipmen, @m_dwObjIndex

	QUEST_STR 'U1',@m_idPlayer,@serverindex,@m_wId = 1,@m_nState = 0,@m_wTime = 65535,@m_nKillNPCNum_0 = 0,@m_nKillNPCNum_1 = 0,@m_bPatrol = 0,@m_bDialog = 0,
                              @m_bReserve3 = 0,@m_bReserve4 = 0,@m_bReserve5 = 0,@m_bReserve6 = 0,@m_bReserve7 = 0,@m_bReserve8 = 0,@m_Inventory = '$', @m_apIndex = '$', @m_adwEquipmen = '$', @m_dwObjIndex = '$'


*/
IF @iGu = 'D1'
	BEGIN	
			DELETE QUEST_TBL
			 WHERE m_idPlayer = @m_idPlayer 
		         AND  serverindex = @serverindex 
	             AND m_wId = @m_wId

		IF @m_Inventory <> ''
			UPDATE INVENTORY_TBL
				   SET m_Inventory = @m_Inventory, 
                         m_apIndex = @m_apIndex, 
                         m_adwEquipment = @m_adwEquipment, 
                         m_dwObjIndex = @m_dwObjIndex
			 WHERE m_idPlayer = @m_idPlayer 
		         AND  serverindex = @serverindex 
   END
/*
	
	 퀘스트 삭제하기
	 ex ) 
	QUEST_STR 'D1',@m_idPlayer,@serverindex,@m_wId,@m_nState,@m_wTime,@m_nKillNPCNum_0,@m_nKillNPCNum_1,@m_bPatrol,@m_bDialog,
                               @m_bReserve3,@m_bReserve4,@m_bReserve5,@m_bReserve6,@m_bReserve7,@m_bReserve8,@m_Inventory, @m_apIndex, @m_adwEquipmen, @m_dwObjIndex

	QUEST_STR 'D1',@m_idPlayer,@serverindex,@m_wId = 1,@m_nState = 0,@m_wTime = 65535,@m_nKillNPCNum_0 = 0,@m_nKillNPCNum_1 = 0,@m_bPatrol = 0,@m_bDialog = 0,
                              @m_bReserve3 = 0,@m_bReserve4 = 0,@m_bReserve5 = 0,@m_bReserve6 = 0,@m_bReserve7 = 0,@m_bReserve8 = 0,@m_Inventory = '$', @m_apIndex = '$', @m_adwEquipmen = '$', @m_dwObjIndex = '$'


*/

RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--EXEC PROC_STAT_SECESSION 'A', '20040404', '20040505'
CREATE PROC [dbo].[PROC_STAT_USER_CNT]
	@iGu       		CHAR(1) 		    = 'A',     -- A :  
    @istart_time    CHAR(8)             = '',      -- 시작일자
    @iend_time      CHAR(8)             = ''       -- 종료일자
AS
/*
	 동접 통계 조회 (SC)
*/

    SET NOCOUNT ON

    IF @iGu = 'A'        -- 
    BEGIN

        -- Query 
        SELECT mon, day, wk, dw, '*' region, cnt, svr01, svr02, svr03, svr04, svr05
        FROM
        (
            -- 월 통계
            SELECT substring(s_date, 1, 6) mon, '' wk, '' dw, '010' day, MAX(number) cnt, MAX(svr01) svr01, MAX(svr02) svr02, MAX(svr03) svr03, MAX(svr04) svr04, max(svr05) svr05
            FROM   TBL_STAT_USER_CNT   WHERE  s_date BETWEEN @istart_time AND @iend_time + '9'
            GROUP BY substring(s_date, 1, 6)
            UNION ALL
            -- 주 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), '', '030', MAX(number), MAX(svr01), MAX(svr02), MAX(svr03), MAX(svr04) svr04, max(svr05) svr05
            FROM   TBL_STAT_USER_CNT   WHERE  s_date BETWEEN @istart_time AND @iend_time + '9'
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date)
            UNION ALL
            -- 요일 통계
            SELECT substring(s_date, 1, 6), '', DATEPART(dw, s_date)-1, '040', MAX(number), MAX(svr01), MAX(svr02), MAX(svr03), MAX(svr04) svr04, max(svr05) svr05
            FROM   TBL_STAT_USER_CNT   WHERE  s_date BETWEEN @istart_time AND @iend_time + '9'
            GROUP BY substring(s_date, 1, 6), DATEPART(dw, s_date)-1
            UNION ALL
            -- 일 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date, number, svr01, svr02, svr03, svr04, svr05
            FROM   TBL_STAT_USER_CNT   WHERE  s_date BETWEEN @istart_time AND @iend_time + '9'
        ) A
        ORDER BY mon, day, wk, dw

    END

    SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--EXEC PROC_STAT_JOIN 'A', '20040404', '20040505'


CREATE   PROC [dbo].[PROC_STAT_SECESSION]
	@iGu       		CHAR(1) 		    = 'A',     -- A :  
    @istart_time    CHAR(8)             = '',      -- 시작일자
    @iend_time      CHAR(8)             = ''       -- 종료일자
AS
/*
	 탈퇴통계 조회
*/

    SET NOCOUNT ON

    IF @iGu = 'A'        -- 
    BEGIN

        -- Query 
        SELECT mon, day, wk, dw, '*' [region], number, sex_1, sex_2, a_1, a_2, b_1, b_2, c_1, c_2, d_1, d_2, e_1, e_2, f_1, f_2
        FROM
        (
            -- 월 통계
            SELECT substring(s_date, 1, 6) mon, '' wk, '' dw, '010' day, SUM(number) number, SUM(sex_1) sex_1, SUM(sex_2) sex_2, SUM(a_1) a_1, SUM(a_2) a_2, SUM(b_1) b_1, SUM(b_2) b_2, SUM(c_1) c_1, SUM(c_2) c_2, SUM(d_1) d_1, SUM(d_2) d_2, SUM(e_1) e_1, SUM(e_2) e_2, SUM(f_1) f_1, SUM(f_2) f_2
            FROM   TBL_STAT_SECESSION   WHERE  s_date BETWEEN @istart_time AND @iend_time
            GROUP BY substring(s_date, 1, 6)
            UNION ALL
            -- 주 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), '', '030', SUM(number), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2) 
            FROM   TBL_STAT_SECESSION   WHERE  s_date BETWEEN @istart_time AND @iend_time
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date)
            UNION ALL
            -- 요일 통계
            SELECT substring(s_date, 1, 6), '', DATEPART(dw, s_date)-1, '040', SUM(number), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2) 
            FROM   TBL_STAT_SECESSION   WHERE  s_date BETWEEN @istart_time AND @iend_time
            GROUP BY substring(s_date, 1, 6), DATEPART(dw, s_date)-1
            UNION ALL
            -- 일 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date, number, sex_1, sex_2, a_1, a_2, b_1, b_2, c_1, c_2, d_1, d_2, e_1, e_2, f_1, f_2
            FROM   TBL_STAT_SECESSION   WHERE  s_date BETWEEN @istart_time AND @iend_time
        ) A
        ORDER BY mon, day, wk, dw

    END

    SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--EXEC PROC_STAT_SECESSION 'A', '20040404', '20040505'


CREATE   PROC [dbo].[PROC_STAT_PLAY_TIME]
	@iGu       		CHAR(1) 		    = 'A',     -- A :  
    @istart_time    CHAR(8)             = '',      -- 시작일자
    @iend_time      CHAR(8)             = ''       -- 종료일자
AS
/*
	 사용시간 통계 조회 (SC)
*/

    SET NOCOUNT ON

    IF @iGu = 'A'        -- 
    BEGIN

        -- Query 
        SELECT mon, day, wk, dw, 
               CASE gubun 
                    WHEN '*' THEN '*'
                    WHEN 'A' THEN '~30MM'
                    WHEN 'B' THEN '30MM ~ 1HH'
                    WHEN 'C' THEN '1HH ~ 3HH'
                    WHEN 'D' THEN '3HH ~ 6HH'
                    WHEN 'E' THEN '1HH ~ '
                    ELSE 'NOT DEFINED'
               END AS region,
               number, sex_1, sex_2, a_1, a_2, b_1, b_2, c_1, c_2, d_1, d_2, e_1, e_2, f_1, f_2, etc
        FROM
        (
            -- 월 통계
            SELECT substring(s_date, 1, 6) mon, '' wk, '' dw, '010' day, '*' gubun, SUM(number) number, SUM(sex_1) sex_1, SUM(sex_2) sex_2, SUM(a_1) a_1, SUM(a_2) a_2, SUM(b_1) b_1, SUM(b_2) b_2, SUM(c_1) c_1, SUM(c_2) c_2, SUM(d_1) d_1, SUM(d_2) d_2, SUM(e_1) e_1, SUM(e_2) e_2, SUM(f_1) f_1, SUM(f_2) f_2, SUM(etc) etc
            FROM   TBL_STAT_PLAY_TIME   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6)
            UNION ALL
            -- 월별 구분별 통계
            SELECT substring(s_date, 1, 6) mon, '' wk, '' dw, '020' day, gubun, SUM(number) number, SUM(sex_1) sex_1, SUM(sex_2) sex_2, SUM(a_1) a_1, SUM(a_2) a_2, SUM(b_1) b_1, SUM(b_2) b_2, SUM(c_1) c_1, SUM(c_2) c_2, SUM(d_1) d_1, SUM(d_2) d_2, SUM(e_1) e_1, SUM(e_2) e_2, SUM(f_1) f_1, SUM(f_2) f_2, SUM(etc) etc
            FROM   TBL_STAT_PLAY_TIME   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), gubun
            UNION ALL
            -- 주 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), '', '030', '*', SUM(number), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2), SUM(etc)
            FROM   TBL_STAT_PLAY_TIME   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date)
            UNION ALL
            -- 주별 구분별 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), '', '030', gubun, SUM(number), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2), SUM(etc)
            FROM   TBL_STAT_PLAY_TIME   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date), gubun
            UNION ALL
            -- 요일 통계
            SELECT substring(s_date, 1, 6), '', DATEPART(dw, s_date)-1, '040', '*', SUM(number), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2), SUM(etc) 
            FROM   TBL_STAT_PLAY_TIME   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATEPART(dw, s_date)-1
            UNION ALL
            -- 요일별 구분별 통계
            SELECT substring(s_date, 1, 6), '', DATEPART(dw, s_date)-1, '040', gubun, SUM(number), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2), SUM(etc) 
            FROM   TBL_STAT_PLAY_TIME   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATEPART(dw, s_date)-1, gubun
            UNION ALL
            -- 일 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date, '*', SUM(number), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2), SUM(etc) 
            FROM   TBL_STAT_PLAY_TIME   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date
            UNION ALL
            -- 일별 구분별 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date, gubun, number, sex_1, sex_2, a_1, a_2, b_1, b_2, c_1, c_2, d_1, d_2, e_1, e_2, f_1, f_2, etc
            FROM   TBL_STAT_PLAY_TIME   WHERE  s_date BETWEEN @istart_time AND @iend_time 
        ) A
        ORDER BY mon, day, wk, dw, gubun

    END

    SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE      PROC [dbo].[PROC_STAT_MAIL_MANAGE]
	@iGu       		CHAR(1) 		    = 'A',     -- A :  
    @istart_time    CHAR(8)             = '',      -- 시작일자
    @iend_time      CHAR(8)             = ''       -- 종료일자
AS
/*
	 메일 답변 통계 조회 (SF)
*/

    SET NOCOUNT ON

    IF @iGu = 'A'        -- 
    BEGIN

        -- Query 
        SELECT mon, day, wk, dw, oper_id [region], number, c01, c02, c03, c04, c05, c06
        FROM
        (
            -- 월 통계
            SELECT substring(s_date, 1, 6) mon, '' wk, '' dw, '010' day, '*' oper_id, SUM(number) number, SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_MANAGE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6)
            UNION ALL
            -- 월별 운영자별 통계
            SELECT substring(s_date, 1, 6) mon, '' wk, '' dw, '020' day, oper_id, SUM(number) number, SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_MANAGE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), oper_id
            UNION ALL
            -- 주 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), '', '030', '*', SUM(number), SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_MANAGE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date)
            UNION ALL
            -- 주별 운영자별 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), '', '030', oper_id, SUM(number), SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_MANAGE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date), oper_id
            UNION ALL
            -- 요일 통계
            SELECT substring(s_date, 1, 6), '', DATEPART(dw, s_date)-1, '040', '*', SUM(number), SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_MANAGE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATEPART(dw, s_date)-1
            UNION ALL
            -- 요일별 운영자별 통계
            SELECT substring(s_date, 1, 6), '', DATEPART(dw, s_date)-1, '040', oper_id, SUM(number), SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_MANAGE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATEPART(dw, s_date)-1, oper_id
            UNION ALL
            -- 일 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date, '*', SUM(number), SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_MANAGE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date
            UNION ALL
            -- 일별 운영자별 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date, oper_id, number, c01, c02, c03, c04, c05, c06+c07+c08 as c6
            FROM   TBL_STAT_MAIL_MANAGE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
        ) A
        ORDER BY mon, day, wk, dw, oper_id

    END

    SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--EXEC PROC_STAT_PLAY_TIME 'A', '20040404', '20040505'

CREATE    PROC [dbo].[PROC_STAT_MAIL_ACCEPT]
	@iGu       		CHAR(1) 		    = 'A',     -- A :  
    @istart_time    CHAR(8)             = '',      -- 시작일자
    @iend_time      CHAR(8)             = ''       -- 종료일자
AS
/*
	 메일 질문 통계 조회 (SC)
*/

    SET NOCOUNT ON

    IF @iGu = 'A'        -- 
    BEGIN

        -- Query 
        SELECT mon, day, wk, dw, 
               CASE gubun 
                    WHEN 0 THEN '*'
                    WHEN 1 THEN '메일'
                    ELSE        '정의되지 않음'
               END AS region,
               number num, c01, c02, c03, c04, c05, c06
        FROM
        (
            -- 월 통계
            SELECT substring(s_date, 1, 6) mon, '' wk, '' dw, '010' day, 0 gubun, SUM(number) number, SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_ACCEPT   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6)
            UNION ALL
            -- 월별 구분별 통계
            SELECT substring(s_date, 1, 6) mon, '' wk, '' dw, '020' day, gubun, SUM(number) number, SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_ACCEPT   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), gubun
            UNION ALL
            -- 주 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), '', '030', 0, SUM(number), SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_ACCEPT   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date)
            UNION ALL
            -- 주별 구분별 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), '', '030', gubun, SUM(number), SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_ACCEPT   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date), gubun
            UNION ALL
            -- 요일 통계
            SELECT substring(s_date, 1, 6), '', DATEPART(dw, s_date)-1, '040', 0, SUM(number), SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_ACCEPT   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATEPART(dw, s_date)-1
            UNION ALL
            -- 요일별 구분별 통계
            SELECT substring(s_date, 1, 6), '', DATEPART(dw, s_date)-1, '040', gubun, SUM(number), SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_ACCEPT   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATEPART(dw, s_date)-1, gubun
            UNION ALL
            -- 일 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date, 0, SUM(number), SUM(c01) c01, SUM(c02) c02, SUM(c03) c03, SUM(c04) c04, SUM(c05) c05, SUM(c06+c07+c08) c06
            FROM   TBL_STAT_MAIL_ACCEPT   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date
            UNION ALL
            -- 일별 구분별 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date, gubun, number, c01, c02, c03, c04, c05, c06+c07+c08 as c6
            FROM   TBL_STAT_MAIL_ACCEPT   WHERE  s_date BETWEEN @istart_time AND @iend_time 
        ) A
        ORDER BY mon, day, wk, dw, gubun

    END

    SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE     PROC [dbo].[PROC_STAT_JOIN]
	@iGu       		CHAR(1) 		    = 'A',     -- A :  
    @istart_time    CHAR(8)             = '',      -- 시작일자
    @iend_time      CHAR(8)             = ''       -- 종료일자
AS
/*
	 가입통계 조회
*/

    SET NOCOUNT ON

    IF @iGu = 'A'        -- 임시 통계 자료 만들기
    BEGIN

        TRUNCATE TABLE TMP_SA

        -- Make Temp Data
        INSERT INTO TMP_SA
        SELECT substring(s_date, 1, 6) mon, DATENAME(wk, s_date) day, DATEPART(dw, s_date)-1 dw, s_date, region,
               SUM(join_cnt) join_cnt, SUM(chr_cnt) chr_cnt,
               SUM( CASE WHEN sex = '1' THEN join_cnt ELSE 0 END ) sex_1, 
               SUM( CASE WHEN sex = '2' THEN join_cnt ELSE 0 END ) sex_2,
               SUM( CASE WHEN sex = '1' AND gubun = 'A' THEN join_cnt ELSE 0 END ) a_1, 
               SUM( CASE WHEN sex = '2' AND gubun = 'A' THEN join_cnt ELSE 0 END ) a_2,
               SUM( CASE WHEN sex = '1' AND gubun = 'B' THEN join_cnt ELSE 0 END ) b_1, 
               SUM( CASE WHEN sex = '2' AND gubun = 'B' THEN join_cnt ELSE 0 END ) b_2,
               SUM( CASE WHEN sex = '1' AND gubun = 'C' THEN join_cnt ELSE 0 END ) c_1, 
               SUM( CASE WHEN sex = '2' AND gubun = 'C' THEN join_cnt ELSE 0 END ) c_2,
               SUM( CASE WHEN sex = '1' AND gubun = 'D' THEN join_cnt ELSE 0 END ) d_1, 
               SUM( CASE WHEN sex = '2' AND gubun = 'D' THEN join_cnt ELSE 0 END ) d_2,
               SUM( CASE WHEN sex = '1' AND gubun = 'E' THEN join_cnt ELSE 0 END ) e_1, 
               SUM( CASE WHEN sex = '2' AND gubun = 'E' THEN join_cnt ELSE 0 END ) e_2,
               SUM( CASE WHEN sex = '1' AND gubun = 'F' THEN join_cnt ELSE 0 END ) f_1, 
               SUM( CASE WHEN sex = '2' AND gubun = 'F' THEN join_cnt ELSE 0 END ) f_2,
               SUM( CASE WHEN sex = '1' AND gubun = 'F' THEN join_cnt ELSE 0 END ) n_1, 
               SUM( CASE WHEN sex = '2' AND gubun = 'F' THEN join_cnt ELSE 0 END ) n_2
        FROM TBL_STAT_JOIN 
        WHERE s_date BETWEEN @istart_time AND @iend_time
        GROUP BY s_date, region

        -- Query 
        SELECT mon, day, wk, dw, region, join_cnt, chr_cnt, 
               sex_1, sex_2, a_1, a_2, b_1, b_2, c_1, c_2, d_1, d_2, e_1, e_2, f_1, f_2 
        FROM
        (
            -- 월 통계
            SELECT substring(s_date, 1, 6) mon, '' wk, '' dw, '010' day, '*' region, SUM(join_cnt) join_cnt, SUM(chr_cnt) chr_cnt, SUM(sex_1) sex_1, SUM(sex_2) sex_2, SUM(a_1) a_1, SUM(a_2) a_2, SUM(b_1) b_1, SUM(b_2) b_2, SUM(c_1) c_1, SUM(c_2) c_2, SUM(d_1) d_1, SUM(d_2) d_2, SUM(e_1) e_1, SUM(e_2) e_2, SUM(f_1) f_1, SUM(f_2) f_2
            FROM   TMP_SA   WHERE  s_date BETWEEN @istart_time AND @iend_time
            GROUP BY substring(s_date, 1, 6)
            UNION ALL
            -- 월 지역별 통계
            SELECT substring(s_date, 1, 6) mon, '' wk, '' dw, '020' day, region, SUM(join_cnt) join_cnt, SUM(chr_cnt) chr_cnt, SUM(sex_1) sex_1, SUM(sex_2) sex_2, SUM(a_1) a_1, SUM(a_2) a_2, SUM(b_1) b_1, SUM(b_2) b_2, SUM(c_1) c_1, SUM(c_2) c_2, SUM(d_1) d_1, SUM(d_2) d_2, SUM(e_1) e_1, SUM(e_2) e_2, SUM(f_1) f_1, SUM(f_2) f_2
            FROM   TMP_SA   WHERE  s_date BETWEEN @istart_time AND @iend_time
            GROUP BY substring(s_date, 1, 6), region
            UNION ALL
            -- 주 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), '', '030', '*', SUM(join_cnt), SUM(chr_cnt), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2) 
            FROM   TMP_SA   WHERE  s_date BETWEEN @istart_time AND @iend_time
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date)
            UNION ALL
            -- 주 지역별 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), '', '030', region, SUM(join_cnt), SUM(chr_cnt), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2) 
            FROM   TMP_SA   WHERE  s_date BETWEEN @istart_time AND @iend_time
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date), region
            UNION ALL
            -- 요일 통계
            SELECT substring(s_date, 1, 6), '', DATEPART(dw, s_date)-1, '040', '*', SUM(join_cnt), SUM(chr_cnt), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2) 
            FROM   TMP_SA   WHERE  s_date BETWEEN @istart_time AND @iend_time
            GROUP BY substring(s_date, 1, 6), DATEPART(dw, s_date)-1
            UNION ALL
            -- 요일 지역별 통계
            SELECT substring(s_date, 1, 6), '', DATEPART(dw, s_date)-1, '040', region, SUM(join_cnt), SUM(chr_cnt), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2) 
            FROM   TMP_SA   WHERE  s_date BETWEEN @istart_time AND @iend_time
            GROUP BY substring(s_date, 1, 6), DATEPART(dw, s_date)-1, region
            UNION ALL
            -- 일 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date, '*', SUM(join_cnt), SUM(chr_cnt), SUM(sex_1), SUM(sex_2), SUM(a_1), SUM(a_2), SUM(b_1), SUM(b_2), SUM(c_1), SUM(c_2), SUM(d_1), SUM(d_2), SUM(e_1), SUM(e_2), SUM(f_1), SUM(f_2) 
            FROM   TMP_SA   WHERE  s_date BETWEEN @istart_time AND @iend_time
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date
            UNION ALL
            -- 일 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date, region, join_cnt, chr_cnt, sex_1, sex_2, a_1, a_2, b_1, b_2, c_1, c_2, d_1, d_2, e_1, e_2, f_1, f_2
            FROM   TMP_SA   WHERE  s_date BETWEEN @istart_time AND @iend_time
        ) A
        ORDER BY mon, day, wk, dw, region

    END

    SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--EXEC PROC_STAT_MAIL_ACCEPT 'A', '20040404', '20040505'


CREATE   PROC [dbo].[PROC_STAT_CHR_CREATE]
	@iGu       		CHAR(1) 		    = 'A',     -- A :  
    @istart_time    CHAR(8)             = '',      -- 시작일자
    @iend_time      CHAR(8)             = ''       -- 종료일자
AS
/*
	 캐릭터 생성 통계 조회 (SG)
*/

    SET NOCOUNT ON

    IF @iGu = 'A'        -- 
    BEGIN

        -- Query 
        SELECT mon, day, wk, dw, number, s1, s2, s3, '*' region
        FROM
        (
            -- 월 통계
            SELECT substring(s_date, 1, 6) mon, '' wk, '' dw, '010' day, 
                   SUM(cnt) number,
                   SUM( CASE serverindex WHEN '01' THEN cnt ELSE 0 END ) s1,
                   SUM( CASE serverindex WHEN '02' THEN cnt ELSE 0 END ) s2,
                   SUM( CASE serverindex WHEN '03' THEN cnt ELSE 0 END ) s3
            FROM   TBL_STAT_CHR_CREATE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6)
            UNION ALL
            -- 주 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), '', '030', 
                   SUM(cnt), 
                   SUM( CASE serverindex WHEN '01' THEN cnt ELSE 0 END ),
                   SUM( CASE serverindex WHEN '02' THEN cnt ELSE 0 END ),
                   SUM( CASE serverindex WHEN '03' THEN cnt ELSE 0 END )
            FROM   TBL_STAT_CHR_CREATE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date)
            UNION ALL
            -- 요일 통계
            SELECT substring(s_date, 1, 6), '', DATEPART(dw, s_date)-1, '040', 
                   SUM(cnt), 
                   SUM( CASE serverindex WHEN '01' THEN cnt ELSE 0 END ),
                   SUM( CASE serverindex WHEN '02' THEN cnt ELSE 0 END ),
                   SUM( CASE serverindex WHEN '03' THEN cnt ELSE 0 END )
            FROM   TBL_STAT_CHR_CREATE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATEPART(dw, s_date)-1
            UNION ALL
            -- 일 통계
            SELECT substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date, 
                   SUM(cnt), 
                   SUM( CASE serverindex WHEN '01' THEN cnt ELSE 0 END ),
                   SUM( CASE serverindex WHEN '02' THEN cnt ELSE 0 END ),
                   SUM( CASE serverindex WHEN '03' THEN cnt ELSE 0 END )
            FROM   TBL_STAT_CHR_CREATE   WHERE  s_date BETWEEN @istart_time AND @iend_time 
            GROUP BY substring(s_date, 1, 6), DATENAME(wk, s_date), DATEPART(dw, s_date)-1, s_date
        ) A
        ORDER BY mon, day, wk, dw

    END

    SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--EXEC PROC_STAT_MAIL_ACCEPT 'A', '20040404', '20040505'


CREATE PROC [dbo].[PROC_OPER_SET_CLASS]
	@iGu       		CHAR(1) 		    = 'A',     -- A :  
    @iId            VARCHAR(32)         = '',      -- 운영자 아이디
    @iInputId       VARCHAR(32)         = '',      -- 등록 운영자
    @iClass         SMALLINT            = 9
AS
/*
	 운영자 클래스 설정 통계 조회 (SG)
*/

    SET NOCOUNT ON

    IF @iGu = 'A'        -- 
    BEGIN

        -- 기존에 있는 클래스 세팅을 지워야지요.
        DELETE FROM TBL_OPER_AUTH 
        WHERE  oper_id = @iId

        -- 이제 클래스를 세팅해야겠지요.
        INSERT INTO TBL_OPER_AUTH
        SELECT @iId, code, auth, GETDATE(), @iInputId
        FROM   TBL_CODE_CLASS
        WHERE  class = @iClass

    END

    SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE      PROC [dbo].[PROC_ME]
	@iGu       		CHAR(1) 		    = 'Z',     -- A:Account   B:Mail Code C: Operator   D:Work Day   E : Start Day
    @iValue          VARCHAR(100)        = ''       -- 입력값

AS
/*
	 
*/

    SET NOCOUNT ON

    IF @iGu = 'A'        -- Account
    BEGIN
            SELECT num, input_day, end_day, account, m_szName, mail_code, 
                   oper_id, title
            FROM   TBL_MAIL_PAST
            WHERE  account = @iValue
            ORDER BY num 
	END
    IF @iGu = 'B'        -- Mail Code
    BEGIN
            SELECT num, input_day, end_day, account, m_szName, mail_code, 
                   oper_id, title
            FROM   TBL_MAIL_PAST
            WHERE  mail_code = @iValue
            ORDER BY num 
    END
    IF @iGu = 'C'        -- Operator
    BEGIN
            SELECT num, input_day, end_day, account, m_szName, mail_code, 
                   oper_id, title
            FROM   TBL_MAIL_PAST
            WHERE  oper_id = @iValue
            ORDER BY num 
    END
    IF @iGu = 'D'        -- Work Day
    BEGIN
            SELECT num, input_day, end_day, account, m_szName, mail_code, 
                   oper_id, title
            FROM   TBL_MAIL_PAST
            WHERE  working_day >= @iValue + ' 00:00:00' AND working_day <= @iValue + ' 23:59:59'
            ORDER BY num 
    END
    IF @iGu = 'E'        -- Start Day
    BEGIN
            SELECT num, input_day, '', account, m_szName, mail_code, 
                   oper_id, title
            FROM   TBL_MAIL_CUR
            WHERE  input_day >= @iValue + ' 00:00:00' AND input_day <= @iValue + ' 23:59:59'
            UNION  ALL
            SELECT num, input_day, end_day, account, m_szName, mail_code, 
                   oper_id, title
            FROM   TBL_MAIL_PAST
            WHERE  input_day >= @iValue + ' 00:00:00' AND input_day <= @iValue + ' 23:59:59'
            ORDER BY num 
    END

    SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--EXEC PROC_STAT_SECESSION 'A', '20040404', '20040505'


CREATE     PROC [dbo].[PROC_CA]
	@iGu       		CHAR(1) 		    = 'Z',     -- I:Insert U:Update D:Delete
    @ioper_id       VARCHAR(32)         = '',      -- 운영자
    @icode          VARCHAR(32)         = '',      -- 코드
    @isection       VARCHAR(32)         = '',      -- 섹션
    @ikey           VARCHAR(32)         = '',      -- 키
    @ivalue         VARCHAR(2000)       = '',      -- 값
    @iUoper_id      VARCHAR(32)         = '',      -- 수정시 사항
    @iUcode         VARCHAR(32)         = '',      -- 수정시 사항
    @iUsection      VARCHAR(32)         = '',      -- 수정시 사항
    @iUkey          VARCHAR(32)         = ''       -- 수정시 사항

AS
/*
	 공통 사항 (INI) 설정 부분
*/

    SET NOCOUNT ON

    IF @iGu = 'I'        -- Insert
    BEGIN
        -- Query 
		INSERT INTO TBL_CODE_INI ( code, [section], [key], value, input_day, input_id )
        VALUES ( @icode, @isection, @ikey, @ivalue, GETDATE(), @ioper_id )
    END
    
	ELSE
    IF @iGu = 'U'        -- Update
    BEGIN
        -- Query 
		UPDATE TBL_CODE_INI 
		SET code      = @icode,
			[section] = @isection,
			[key]     = @ikey,
			value     = @ivalue,
			input_id  = @ioper_id, 
			input_day = GETDATE()
		WHERE code      = @iUcode
          AND [section] = @iUsection
          AND [key]     = @iUkey
    END

    IF @iGu = 'D'        -- Delete
    BEGIN
        -- Query 
		DELETE FROM TBL_CODE_INI
		WHERE code      = @icode
          AND [section] = @isection
          AND [key]     = @ikey
    END

    SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE       PROC [dbo].[PROC_BU]
	@iGu       CHAR(1) 		    = 'Z'     -- 
AS
/*
        CCU	 
*/

    SET NOCOUNT ON

    IF @iGu = 'A'        -- 전체일자에서 제일 맥스값 읽어오기.
    BEGIN
                SELECT '00', MAX(number)
                FROM   TBL_STAT_USER_CNT
                UNION  ALL
                SELECT '01', MAX(svr01)
                FROM   TBL_STAT_USER_CNT
                UNION  ALL
                SELECT '02', MAX(svr01)
                FROM   TBL_STAT_USER_CNT
                UNION  ALL
                SELECT '03', MAX(svr01)
                FROM   TBL_STAT_USER_CNT
	END

    SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MESSENGER_STR]
	@iGu        		  				CHAR(2) 			= 'S1', 
	@im_idPlayer   				CHAR(7) 			= '0000001',
	@iserverindex  				CHAR(2) 			= '01',
	@if_idPlayer 					CHAR(7)				=	'',
	@im_dwSex 					INT						= 0,
	@im_nJob						INT						= 0,
	@iState 							CHAR(1)				=	'',
	@im_dwState					INT						= 0
AS
set nocount on

IF 	@iGu = 'A1'
	BEGIN
		IF EXISTS(SELECT * FROM  MESSENGER_TBL  WHERE m_idPlayer = @im_idPlayer  AND serverindex = @iserverindex  AND f_idPlayer = @if_idPlayer)
		UPDATE MESSENGER_TBL
			SET State = 'T',
					m_dwState = @im_dwState
		WHERE m_idPlayer = @im_idPlayer
		    AND serverindex = @iserverindex
		    AND f_idPlayer = @if_idPlayer
		ELSE
		INSERT MESSENGER_TBL
			(m_idPlayer,serverindex,f_idPlayer,m_nJob,m_dwSex,m_dwState,State,CreateTime)
		VALUES
			(@im_idPlayer,@iserverindex,@if_idPlayer,@im_nJob,@im_dwSex,0,'T',GETDATE())	
		RETURN
	END
/*
	
	 메신저 친구 저장하기
	 ex ) 
	 MESSENGER_STR 'A1',@im_idPlayer,@iserverindex,@if_idPlayer,@im_nJob,@im_dwSex
	 MESSENGER_STR 'A1','000001','01','000002',1,1
*/
ELSE
IF @iGu = 'S1'
	BEGIN
		SELECT a.f_idPlayer, b.m_nJob, b.m_dwSex,a.m_dwState
		   FROM MESSENGER_TBL a, CHARACTER_TBL b
		WHERE a.m_idPlayer = @im_idPlayer
		    AND a.serverindex = @iserverindex
			AND b.m_idPlayer = a.f_idPlayer 
		   AND  b.serverindex =  a.serverindex
			AND a.State = 'T'
		ORDER BY a.CreateTime
		RETURN
	END
/*
	
	 메신저 리스트 가져오기
	 ex ) 

     MESSENGER_STR 'S1',@im_idPlayer,@iserverindex
	  MESSENGER_STR 'S1','475471','01'



*/

ELSE
IF @iGu = 'S2'
	BEGIN
		SELECT a.f_idPlayer, count(a.f_idPlayer)
				FROM MESSENGER_TBL a, MESSENGER_TBL b
			WHERE a.m_idPlayer = @im_idPlayer
			   	  AND a.serverindex = @iserverindex
				  AND a.f_idPlayer = b.m_idPlayer
				  AND a.State = 'T'
		GROUP BY a.f_idPlayer

		RETURN
	END
/*
	
	 나를 등록한 메신저 리스트 가져오기
	 ex ) 
	 MESSENGER_STR 'S2',@im_idPlayer,@iserverindex
	 MESSENGER_STR 'S2','000001','02'

*/

ELSE
IF	@iGu = 'D1'
	BEGIN
		UPDATE MESSENGER_TBL
			SET State = 'D'
		WHERE m_idPlayer = @im_idPlayer
		    AND serverindex = @iserverindex
		    AND f_idPlayer = @if_idPlayer
			AND State = 'T'
		RETURN
	END

/*
	
	 메신저 친구 삭제하기
	 ex ) 
	 MESSENGER_STR 'D1',@im_idPlayer,@iserverindex,@if_idPlayer
	 MESSENGER_STR 'D1','000001','01','000002'

*/

ELSE
IF @iGu = 'D2'
	BEGIN
		DELETE MESSENGER_TBL
		WHERE m_idPlayer NOT IN
		   (SELECT m_idPlayer 
			FROM CHARACTER_TBL where serverindex = @iserverindex)
			and  serverindex = @iserverindex

		DELETE MESSENGER_TBL
		WHERE f_idPlayer NOT IN
		   (SELECT m_idPlayer 
			FROM CHARACTER_TBL where serverindex = @iserverindex)
			and  serverindex = @iserverindex

		DELETE MESSENGER_TBL
		WHERE State = 'D'
		and  serverindex = @iserverindex
		RETURN
	END


/*
	 메신저 삭제하기( 캐릭터 삭제했을시, 메신저에서 삭제했을시 )
	 ex ) 
	 MESSENGER_STR 'D2'
	 MESSENGER_STR 'D2'

*/

set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [dbo].[make_quest_tbl_str]
as
set nocount on
declare @m_lpQuestCntArray varchar(3072)
declare @pos_s int,@pos_e int,@property varchar(255)

declare @m_idPlayer char(7)
declare @serverindex char(2)

--declare quest_cursor cursor for
create table #temp (id int identity(1,1),m_idPlayer char(7),serverindex char(2),m_lpQuestCntArray varchar(3072))


insert #temp
(m_idPlayer,serverindex,m_lpQuestCntArray )
select m_idPlayer,serverindex,m_lpQuestCntArray 
from CHARACTER_TBL 
--where m_lpQuestCntArray <> '$'
order by m_idPlayer,serverindex

create unique clustered index temp_idx ON #temp(id)

-- open quest_cursor
-- 
-- fetch next from quest_cursor
-- into @m_idPlayer,@serverindex,@m_lpQuestCntArray

declare @i int,@j int 

select @i = 1
select @j = max(id) from #temp

while @i <= @j
		begin
					select @m_idPlayer = m_idPlayer ,@serverindex = serverindex,@m_lpQuestCntArray = m_lpQuestCntArray from #temp where id = @i
					if @m_lpQuestCntArray<> '' and @m_lpQuestCntArray <> '$' and @m_lpQuestCntArray is not null
							begin
								set @pos_s = 1
								set @pos_e = charindex('/',@m_lpQuestCntArray,@pos_s)
								declare @idx int
								while 1=1
									begin
										set @pos_e = charindex('/',@m_lpQuestCntArray,@pos_s)
										set @property = substring(@m_lpQuestCntArray,@pos_s,@pos_e-@pos_s)
										exec('insert  QUEST_TBL values(''' + @m_idPlayer + ''',''' + @serverindex + ''',' + @property + ')')
										--print (@i)
										set @pos_s =  @pos_e + 1
										if charindex('/',@m_lpQuestCntArray,@pos_s) = 0
										break
									end
							end
		
		
-- 		fetch next from quest_cursor
-- 		into @m_idPlayer,@serverindex,@m_lpQuestCntArray
			set @i = @i + 1
		end
-- close quest_cursor
-- deallocate quest_cursor

set nocount off
return
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCampusMember](
	[idCampus] [int] NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_idPlayer] [char](7) NOT NULL,
	[nMemberLv] [int] NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_tblCampusMember] PRIMARY KEY NONCLUSTERED 
(
	[m_idPlayer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사제 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampusMember', @level2type=N'COLUMN',@level2name=N'idCampus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampusMember', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플레이어 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampusMember', @level2type=N'COLUMN',@level2name=N'm_idPlayer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'해당 사제에서 자신의 등급' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampusMember', @level2type=N'COLUMN',@level2name=N'nMemberLv'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'해당 사제의 멤버가 된 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampusMember', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TAG_STR]
	@iGu        		  				CHAR(2) 			= 'S1', 
	@im_idPlayer   				CHAR(7) 			= '0000001',
	@iserverindex  				CHAR(2) 			= '01',
	@if_idPlayer 					CHAR(7)				=	'',
	@im_Message 				VARCHAR(255)	=	''
AS
set nocount on

IF 	@iGu = 'A1'
	BEGIN
	DECLARE @count int
	SELECT @count = COUNT(*) 
      FROM TAG_TBL
	WHERE  m_idPlayer = @im_idPlayer
	     AND serverindex = @iserverindex
		 AND State = 'T'

	IF @count < 20 
	 BEGIN
		INSERT TAG_TBL
			(m_idPlayer,serverindex,f_idPlayer,m_Message,State,CreateTime)
		VALUES
			(@im_idPlayer,@iserverindex,@if_idPlayer,@im_Message,'T',GETDATE())	
		SELECT fError='0'
		RETURN
	 END
	ELSE
	 BEGIN
		SELECT fError='1'
		RETURN
	 END
	END
/*
	
	 쪽지 저장하기
	 ex ) 
	 TAG_STR 'A1',@im_idPlayer,@iserverindex,@if_idPlayer,@im_Message
	 TAG_STR 'A1','000001','01','000002','안녕하세요?'
*/
ELSE
IF @iGu = 'S1'
	BEGIN
		SELECT a.f_idPlayer, b.m_szName, a.m_Message,CreateTime=CONVERT(CHAR(8),a.CreateTime,112)
		   FROM TAG_TBL a, CHARACTER_TBL b
		WHERE a.m_idPlayer = @im_idPlayer
			AND a.m_idPlayer = b.m_idPlayer
		    AND a.serverindex = @iserverindex
		   AND  a.serverindex =  b.serverindex
			AND a.State = 'T'
		ORDER BY a.CreateTime
		
		UPDATE TAG_TBL
		      SET State = 'D'
		 WHERE m_idPlayer = @im_idPlayer
			  AND serverindex = @iserverindex

		SELECT fError='0'
		RETURN
	END
/*
	
	 쪽지 가져오기
	 ex ) 
	 TAG_STR 'S1',@im_idPlayer,@iserverindex
	 TAG_STR 'S1','000001','01'


*/


ELSE
IF	@iGu = 'D1'
	BEGIN
		DELETE TAG_TBL
		WHERE m_idPlayer NOT IN
		   (SELECT m_idPlayer 
			FROM CHARACTER_TBL)

		DELETE TAG_TBL
		WHERE f_idPlayer NOT IN
		   (SELECT m_idPlayer 
			FROM CHARACTER_TBL)

		DELETE TAG_TBL
		WHERE State = 'D'
			AND CreateTime < DATEADD(d,-7,GETDATE())
		RETURN
	END

/*
	
	 쪽지 삭제하기( 캐릭터 삭제했을시, 일정시간이 지났을때 )
	 ex ) 
	 TAG_STR 'D1'
	 TAG_STR 'D1'

*/
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCombatJoinGuild](
	[CombatID] [int] NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[GuildID] [char](6) NOT NULL,
	[Status] [varchar](3) NOT NULL,
	[ApplyDt] [datetime] NOT NULL,
	[CombatFee] [bigint] NOT NULL,
	[ReturnCombatFee] [bigint] NOT NULL,
	[Reward] [bigint] NOT NULL,
	[Point] [int] NOT NULL,
	[RewardDt] [datetime] NULL,
	[CancelDt] [datetime] NULL,
	[StraightWin] [int] NOT NULL,
 CONSTRAINT [PK_tblCombatJoinGuild] PRIMARY KEY CLUSTERED 
(
	[CombatID] ASC,
	[serverindex] ASC,
	[GuildID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCombatJoinPlayer](
	[CombatID] [int] NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[GuildID] [char](6) NOT NULL,
	[PlayerID] [char](7) NULL,
	[Status] [varchar](3) NOT NULL,
	[Point] [int] NOT NULL,
	[Reward] [bigint] NOT NULL,
	[RewardDt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [tblCombatJoinPlayer_ID1] ON [dbo].[tblCombatJoinPlayer] 
(
	[CombatID] ASC,
	[serverindex] ASC,
	[GuildID] ASC,
	[PlayerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[MAIL_STR_REALTIME]
        @iGu            CHAR(2),
        @serverindex    CHAR(2),
        @nMail_Before   INT = 0,
        @nMail_After    INT = 0,
        @idPlayer       CHAR(7) = '0000000',
        @nLevel         INT = 0,
        @iaccount       VARCHAR(32) = '',
        @tmCreate       INT = 0,
        @dwSerialNumber INT = 0,
        @nHitPoint      INT = 0
as
set nocount on

declare @sdate datetime
declare @edate datetime
declare @iserverindex char(2)

set @sdate = '2007-07-18 00:00:00'--'2007-07-10 00:00:00'       -- '2007-07-18 00:00:00'
set @edate = '2007-08-31 23:59:00'--'2007-07-10 23:00:00'  -- '2007-08-31 23:59:00'
set @iserverindex = cast((cast(@serverindex as int) + 50) as char(2))

IF @iGu = 'S1'
        BEGIN
                SELECT * FROM MAIL_TBL 
                WHERE serverindex = @iserverindex AND byRead<90  
                ORDER BY nMail
        RETURN
        END
ELSE
IF @iGu = 'U1'
        BEGIN
                UPDATE MAIL_TBL SET nMail = @nMail_After, serverindex = @serverindex, dwSerialNumber = @dwSerialNumber, nHitPoint = @nHitPoint
                WHERE serverindex = @iserverindex and nMail = @nMail_Before
        RETURN
        END
ELSE
IF @iGu  = 'I1'
        BEGIN
                -- 추천 이벤트 기간인지 확인
                IF(getdate() < @sdate or getdate() > @edate) BEGIN
                        RETURN
                END
                -- 추천인 인지 확인            -- select top 10 * from ACCOUNT_DBF.dbo.tblEventRecommend
--                IF( NOT EXISTS(SELECT * FROM ACCOUNT_DBF.dbo.tblEventRecommend where  byaccount  = @iaccount ) )        BEGIN
--                        RETURN
--                END

                -- 받을수 있는 아이템이 있는지 확인
                DECLARE @ItemID int
                DECLARE @ItemNum int
                DECLARE @bBinds int
                SET @ItemID = 0
                SET @ItemNum = 1
                SET @bBinds = 2
                

                IF( @nLevel = 20 ) BEGIN
                        SET @ItemID = 26112
                END
                ELSE IF( @nLevel = 40 ) BEGIN
                        SET @ItemID = 26211
                END
                ELSE IF( @nLevel = 60 ) BEGIN
                        SET @ItemID = 26103
                END
                ELSE IF( @nLevel = 80 ) BEGIN
                        SET @ItemID = 30135
                END
                ELSE IF( @nLevel = 100 ) BEGIN
                        SET @ItemID = 5800
                        SET @bBinds = 0
                END
                ELSE IF( @nLevel = 120 ) BEGIN
                        SET @ItemID = 4703
                        SET @bBinds = 0
                END
                
                IF( @ItemID = 0 ) BEGIN
                        RETURN
                END

                -- 메일 아이디 할당 하기
                DECLARE @nMaxMailID int
                SELECT @nMaxMailID = MAX(nMail)+1 from MAIL_TBL where serverindex = @iserverindex
                SET @nMaxMailID = ISNULL( @nMaxMailID, 0 )

                -- 아이템 주기
                DECLARE @szTitle                VARCHAR(128)
                DECLARE @szText         VARCHAR(1024)
                SET @szTitle = '레벨 업을 축하 드립니다!'
                SET @szText = '캐릭터 레벨 업 기념 상품을 보내드립니다 ^ㅁ^* 프리프와 함께 즐거운 하루 보내시기 바랍니다. 감사합니다.'

                EXEC dbo.MAIL_STR 'A1', @nMaxMailID, @iserverindex, @idPlayer, '0000000', 0, @tmCreate, 0, @szTitle, @szText,@ItemID, @ItemNum, 0, 0, 0, 0, @bBinds
                RETURN
        END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[CHARACTER_STR]
	@iGu        		  				CHAR(2) 			= 'S1', 
	@im_idPlayer   				CHAR(7) 			= '0000001',
	@iserverindex  				CHAR(2) 			= '01',
	/**********************************************
	 INSERT ?
	**********************************************/
	-- CHARACTER_TBL
	@iaccount 						VARCHAR(32)	= '',
	@im_szName 				VARCHAR(32)	= '',
	@iplayerslot 					INT						= 0,
	@idwWorldID 				INT 						= 0,
	@im_dwIndex 				INT 						= 0,
	@im_vPos_x 					REAL 					= 0,
	@im_vPos_y 					REAL 					= 0,
	@im_vPos_z 					REAL 					= 0,
	@im_szCharacterKey 	VARCHAR(32)	= '',
	@im_dwSkinSet 			INT						= 0,
	@im_dwHairMesh 		INT						= 0,
	@im_dwHairColor 		INT						= 0,
	@im_dwHeadMesh 		INT						= 0,
	@im_dwSex 					INT						= 0,
	/**********************************************
	 UPDATE ?
	**********************************************/
	-- CHARACTER_TBL
	@im_vScale_x				REAL					=	0,
	@im_dwMotion				INT						=	0,
	@im_fAngle					REAL					=	0,
	@im_nHitPoint				INT						=	0,
	@im_nManaPoint			INT						=	0,
	@im_nFatiguePoint		INT						=	0,
	@im_dwRideItemIdx		INT						=	0,
	@im_dwGold					INT						=	0,
	@im_nJob						INT						=	0,
	@im_pActMover				VARCHAR(50)	=	'',
	@im_nStr						INT						=	0,
	@im_nSta						INT						=	0,
	@im_nDex						INT						=	0,
	@im_nInt							INT						=	0,
	@im_nLevel					INT						=	0,
	@im_nExp1					BIGINT						=	0,
	@im_nExp2					BIGINT						=	0,
	@im_aJobSkill				VARCHAR(500)	='',
	@im_aLicenseSkill		VARCHAR(500)	='',
	@im_aJobLv					VARCHAR(500)	='',
	@im_dwExpertLv			INT						=	0,
	@im_idMarkingWorld	INT						=	0,
	@im_vMarkingPos_x	REAL					=	0,
	@im_vMarkingPos_y	REAL					=	0,
	@im_vMarkingPos_z	REAL					=	0,
	@im_nRemainGP			INT						=	0,
	@im_nRemainLP			INT						=	0,
	@im_nFlightLv				INT						=	0,
	@im_nFxp						INT						=	0,
	@im_nTxp						INT						=	0,
	@im_lpQuestCntArray	VARCHAR(3072)= '',
	@im_chAuthority			CHAR(1)				= '',
	@im_dwMode				INT						=	0,
	@im_idparty					INT						=	0,
	@im_nNumKill				INT						=	0,
	@im_idMuerderer			INT						=	0,
	@im_nSlaughter			INT						=	0,
	@im_nFame					INT						=	0,
	@im_nDeathExp				BIGINT					=  0,
	@im_nDeathLevel				INT					=  0,
	@im_dwFlyTime					INT					=  0,
	@im_nMessengerState 	INT					=  0,
	@iTotalPlayTime			INT						= 	0,

	
	-------------- (ADD : Version8-PK System)
	 --@im_nPKValue    int=0,
	 --@im_dwPKPropensity      int=0,
	 --@im_dwPKExp     int=0,
	 ---------- ?? ? ----------
	-- CARD_CUBE_TBL
	@im_Card 						VARCHAR(1980)= '',
	@im_Index_Card 			VARCHAR(215) 	= '',
	@im_ObjIndex_Card 	VARCHAR(215) 	= '',
	@im_Cube 						VARCHAR(1980)= '',
	@im_Index_Cube 			VARCHAR(215) 	= '',
	@im_ObjIndex_Cube 	VARCHAR(215) 	= '',
	-- INVENTORY_TBL
	@im_Inventory 				VARCHAR(6940)= '',
	@im_apIndex 				VARCHAR(345) 	= '',
	@im_adwEquipment 	VARCHAR(135) 	= '',
	@im_dwObjIndex 			VARCHAR(345) 	= '',
	-- TASKBAR_TBL
	@im_aSlotApplet 			VARCHAR(3100)= '',
	-- TASKBAR_ITEM_TBL
	@im_aSlotItem 				VARCHAR(6885)= '',
	-- TASKBAR_TBL
	@im_aSlotQueue 			VARCHAR(225)= '',
	@im_SkillBar					SMALLINT			= 0,
	-- BANK_TBL
	@im_Bank						VARCHAR(4290)= '',
	@im_apIndex_Bank		VARCHAR(215)= '',
	@im_dwObjIndex_Bank VARCHAR(215)= '',
	@im_dwGoldBank			INT						= 0,
	@im_nFuel						INT						= -1,
	@im_tmAccFuel				INT 						= 0,
	@im_dwSMTime			VARCHAR(2560)='',
	@iSkillInfluence				varchar(2048) ='',
	@im_dwSkillPoint			INT 						= 0,
	@im_aCompleteQuest	varchar(1024) = '',
	@im_extInventory			varchar(2000) = '',
	@im_extBank					varchar(2000) = '',
	@im_InventoryPiercing varchar(8000) = '',
	@im_BankPiercing		varchar(8000) = '',
	@im_dwReturnWorldID INT		 				= 1,
	@im_vReturnPos_x 		REAL					= 0,
	@im_vReturnPos_y 		REAL					= 0,
	@im_vReturnPos_z 		REAL					= 0
	-------------- ( Version 7 : Skill Update)
	, @im_SkillPoint        int=0
	, @im_SkillLv   int=0
	, @im_SkillExp  bigint=0
      -------------- (?? ??)
        , @idwEventFlag                   bigint=0,
        @idwEventTime                   int=0,
        @idwEventElapsed                int=0
      -------------- (?? ??)
        ----------?? ?? ----------
        -- PVP (?? ??)
        ,@im_nAngelExp                  bigint=0
        ,@im_nAngelLevel                        int=0
        ----------?? ? ----------
	--------------- Version 9 ?? ?? Pet??
	,@iszInventoryPet       varchar(4200)     = '$'
	,@iszBankPet    varchar(4200)     = '$'
	,@im_dwPetId int = -1
	,@im_nExpLog int = 0
	,@im_nAngelExpLog int = 0
	---------------- Ver.11 Coupon
	, @im_nCoupon int = 0
	---------------- Ver.13 Housing
	, @im_nHonor int = -1	--Master
	, @im_nLayer int = 0	--Housing
	---------- Ver 15
	, @im_aCheckedQuest varchar(100) =''
	, @im_nCampusPoint int = 0
	, @im_idCampus int = 0


/*******************************************************
	Gu ??
    S : SELECT
    I  : INSERT
    U : UPDATE
    D : DELETE


2005.04.11 updated

ALTER TABLE  CHARACTER_TBL  ADD   m_aCompleteQuest  varchar(1024) NULL
ALTER TABLE CHARACTER_TBL  ALTER COLUMN   m_lpQuestCntArray	VARCHAR(3072) NULL

*******************************************************/
AS
set nocount on
declare @last_connect tinyint
-- if (convert(char(10),getdate(),120) between '2005-07-05' and '2005-07-19')
-- begin
-- IF @iGu IN ('S1','S2','S8')
-- 	BEGIN
-- 		if exists(SELECT * from RANKING.RANKING_DBF.dbo.last_1_month_tbl where account=(select account from CHARACTER_TBL WHERE m_idPlayer=@im_idPlayer and serverindex = @iserverindex))
-- 			select @last_connect = 1
-- 		else
-- 		if exists(SELECT * from RANKING.RANKING_DBF.dbo.last_3_month_tbl where account=(select account from CHARACTER_TBL WHERE m_idPlayer=@im_idPlayer and serverindex = @iserverindex))
-- 			select @last_connect = 3
-- 		else
--            begin
-- 			select @last_connect = 0
--            if not exists(select * from RANKING.RANKING_DBF.dbo.event_200507_tbl where account = (select account from CHARACTER_TBL WHERE m_idPlayer=@im_idPlayer and serverindex = @iserverindex))
--              begin                  
--                   IF NOT EXISTS(SELECT * FROM CHARACTER_TBL WHERE m_idPlayer=@im_idPlayer and serverindex = @iserverindex and CreateTime > '2005-07-05')
--                    BEGIN
-- 						INSERT ITEM_SEND_TBL
-- 								(m_idPlayer, serverindex, Item_Name, Item_count, m_nAbilityOption,  End_Time, m_bItemResist, m_nResistAbilityOption, m_bCharged)
-- 							VALUES
-- 								(@im_idPlayer,@iserverindex,'??? ??',1,0,NULL,0,0,0)
-- 						INSERT RANKING.RANKING_DBF.dbo.event_200507_tbl 
-- 						SELECT account,getdate() FROM CHARACTER_TBL WHERE m_idPlayer=@im_idPlayer and serverindex = @iserverindex
--                    END                 
--              end
--            end
-- 	END
-- end
-- else
set @last_connect = 1

IF @iGu = 'S2' -- ??? ?? ??????? ??????  ????
	BEGIN
		IF @iaccount = '' OR @im_szName  = ''
 		BEGIN
 			SELECT m_chAuthority = '',fError = '1', fText = '????'
 			RETURN
 		END
			SELECT	A.dwWorldID, 
							A.m_szName,
					 		A.playerslot,
							A.End_Time, 
							A.BlockTime,
							A.m_dwIndex, 
							A.m_idPlayer, 
							A.m_idparty,
							A.m_dwSkinSet, 
							A.m_dwHairMesh, 
							A.m_dwHeadMesh, 
							A.m_dwHairColor, 
							A.m_dwSex, 
							A.m_nJob, 
							A.m_nLevel, 
							A.m_vPos_x, 
							A.m_vPos_y, 
							A.m_vPos_z, 
							A.m_nStr,
							A.m_nSta,
							A.m_nDex,
							A.m_nInt,
							--A.m_nSlaughter,                   -- raiders?? 2005.5.11
							A.m_aJobLv,
							A.m_chAuthority,
							A.m_idCompany,
							A.m_nMessengerState,
							A.m_nNumKill,
							A.m_nSlaughter,
							B.m_Inventory, 
							B.m_apIndex,
							B.m_adwEquipment,
							B.m_dwObjIndex,
							m_idGuild = CASE WHEN C.m_idGuild  IS NULL THEN '0' ELSE C.m_idGuild END	,
							m_idWar = CASE WHEN C.m_idWar  IS NULL THEN '0' ELSE C.m_idWar END,
							D.m_extInventory,
							D.m_InventoryPiercing,
							m_nHonor,  -- 13 Ver. Master
							last_connect = @last_connect
			  FROM 	CHARACTER_TBL as A inner join INVENTORY_TBL as B on A.serverindex = B.serverindex and A.m_idPlayer = B.m_idPlayer
									left outer join GUILD_MEMBER_TBL as C on A.serverindex = C.serverindex and A.m_idPlayer = C.m_idPlayer
									inner join INVENTORY_EXT_TBL as D on A.serverindex = D.serverindex and A.m_idPlayer = D.m_idPlayer
			WHERE 	A.m_idPlayer = B.m_idPlayer
				  /*AND 	A.serverindex= B.serverindex	
				  AND  B.m_idPlayer = D.m_idPlayer
				  AND  B.serverindex = D.serverindex
				  AND  D.m_idPlayer *= C.m_idPlayer
				  AND  D.serverindex *= C.serverindex*/
				  AND  A.isblock = 'F'
				  AND  A.account   	= @iaccount  
				  AND 	A.serverindex= @iserverindex
			 ORDER BY A.playerslot

insert into CHARACTER_TBL_penya_check (account, m_szName, m_dwGold, check_sec, serverindex)
select @iaccount, m_szName, m_dwGold, 9, @iserverindex
from CHARACTER_TBL (nolock)
where account = @iaccount and serverindex = @iserverindex and TotalPlayTime < 1 and m_dwGold >= 1


/*			from CHARACTER_TBL as a inner join INVENTORY_TBL as B on a.serverindex = B.serverindex and a.m_idPlayer = b.m_idPlayer
									inner join INVENTOTY_EXT_TBL as d on b.serverindex = d.serverindex and b.m_idPlayer = d.m_idPlayer
									left outer join GUILD_MEMBER_TBL as c on d.serverindex = c.serverindex and d.m_idPlayer = c.m_idPlayer
			where a.account = @iaccount and a.serverindex = @iserverindex and a.isblock = 'F'
			order by a.playerslot*/
				RETURN
 	END
/*
	
	 ??? ?? ??????? ??????  ????
	 ex ) 
	 CHARACTER_STR 'S2',@im_idPlayer (iMode),@iserverindex,@iaccount,@im_szName (iPassword)
	 CHARACTER_STR 'S2','0','02','seghope','1234'


*/

ELSE
IF @iGu = 'S3' -- ??? ????? ?? ???? idPlayer? ? ????
	BEGIN
		 SELECT m_szName, m_idPlayer,m_idCompany
			FROM CHARACTER_TBL 
		 WHERE serverindex = @iserverindex 
--			  AND  isblock = 'F'
		 ORDER BY m_idPlayer
		RETURN
	END
/*
	
	 ??? ????? ?? ???? idPlayer? ? ????
	 ex ) 
	 CHARACTER_STR 'S3','',@iserverindex
	 CHARACTER_STR 'S3','','02'



*/

ELSE
IF @iGu = 'S4' -- ??? ??? ??
	BEGIN
		declare @q1 nvarchar(4000)

		/* ------------ Valentine Event Start -------------*/
		IF getdate() >='2010-01-29 15:00:00' and getdate()<='2010-02-23 11:00:00' 
		begin 

			declare @S4_Create_Time datetime

			select @S4_Create_Time = CreateTime from CHARACTER_TBL (nolock) 
			where m_idPlayer = @im_idPlayer and serverindex=@iserverindex

			IF @S4_Create_Time < '2010-02-05 09:00:00.000'
			begin 

				declare @count_event char(1)

				select @count_event=count(*) 
				from TB_VALENTINE_EVENT with (nolock)
				where Prodate = convert(char(8) ,getdate(),112) and m_idPlayer =@im_idPlayer 
	
		
				IF @count_event = 0 
				Begin
		
					declare @int_sex int

					select @int_sex=m_dwSex from CHARACTER_TBL	with (nolock)
					where m_idPlayer=@im_idPlayer 
					and serverindex=@iserverindex

						IF @int_sex = 0 -- male  26916 item , Female 26915
							begin

							insert into ITEM_SEND_TBL (m_idPlayer, serverindex, Item_Name, Item_count, m_bCharged, idSender)
							select @im_idPlayer, @iserverindex, '26916', 2, 1, '0000000'

							end
						ELSE 
							begin
							insert into ITEM_SEND_TBL (m_idPlayer, serverindex, Item_Name, Item_count, m_bCharged, idSender)
							select @im_idPlayer, @iserverindex, '26915', 2, 1, '0000000'
							END



						insert into TB_VALENTINE_EVENT values (  convert(char(8) ,getdate(),112),@im_idPlayer,getdate())
				END
			END
		END

									/*
										CREATE TABLE dbo.TB_VALENTINE_EVENT
										(
											Prodate char(8) NOT NULL,
											m_idPlayer char(7) not null,
											regdate datetime NOT NULL
										)  ON [PRIMARY]

									*/

		/* ------------ Valentine Event END -------------*/

		set @q1 = '
				SELECT Item_Name, Item_count, m_nAbilityOption, m_nNo, m_bItemResist, m_nResistAbilityOption,
						m_bCharged, nPiercedSize, adwItemId0, adwItemId1, adwItemId2, adwItemId3, m_dwKeepTime, nRandomOptItemId,
						isnull(adwItemId5, 0) as adwItemId5, isnull(adwItemId6, 0) as adwItemId6, isnull(adwItemId7, 0) as adwItemId7, isnull(adwItemId8, 0) as adwItemId8, isnull(adwItemId9, 0) as adwItemId9, isnull(nUMPiercedSize, 0) as nUMPiercedSize,
						isnull(adwUMItemId0, 0) as adwUMItemId0, isnull(adwUMItemId1, 0) as adwUMItemId1, isnull(adwUMItemId2, 0) as adwUMItemId2, isnull(adwUMItemId3, 0) as adwUMItemId3, isnull(adwUMItemId4, 0) as adwUMItemId4
				FROM ITEM_SEND_TBL
				WHERE m_idPlayer = @im_idPlayer AND serverindex = @iserverindex AND ItemFlag = 0'
		exec sp_executesql @q1, N'@im_idPlayer char(7), @iserverindex char(2)', @im_idPlayer, @iserverindex
/*
		SELECT 	Item_Name, 
						Item_count,
						m_nAbilityOption,
						m_nNo,
						m_bItemResist,

						m_nResistAbilityOption,
						m_bCharged,
						nPiercedSize,
						adwItemId0,
						adwItemId1,
						adwItemId2,
						adwItemId3,
						m_dwKeepTime
		  FROM ITEM_SEND_TBL 
 		 WHERE	m_idPlayer   				= @im_idPlayer 	
			  AND 	serverindex 				= @iserverindex
			  AND   ItemFlag = 0
*/
		RETURN
	END
/*
	

	 ??? ??
	 ex ) 
	 CHARACTER_STR 'S4',@im_idPlayer,@iserverindex
	 CHARACTER_STR 'S4','000001','01'

*/

ELSE
IF @iGu = 'S5' -- ??? ??? ????? ??? ??
	BEGIN
--		DELETE ITEM_SEND_TBL 
		UPDATE ITEM_SEND_TBL SET ItemFlag=1, ProvideDt=getdate()
 		 WHERE	m_nNo  = @iplayerslot
		IF @@ROWCOUNT = 0
		SELECT fError = '0'
		ELSE
		SELECT fError = '1'
		RETURN
	END
/*
	
	 ??? ??? ????? ??? ??
	 ex ) 
	 CHARACTER_STR 'S5',@im_idPlayer,@iserverindex,@iaccount
	 CHARACTER_STR 'S5','000001','01','???',1,1
*/

ELSE
IF @iGu = 'S6' -- ??? ??? ??
	BEGIN
		SELECT 	Item_Name, 
						Item_count,
						m_nAbilityOption,
						m_nNo,
						State,
						m_bItemResist,
						m_nResistAbilityOption
			FROM ITEM_REMOVE_TBL 
 		 WHERE	m_idPlayer   				= @im_idPlayer 	
			  AND 	serverindex 				= @iserverindex
              AND   ItemFlag = 0
	RETURN
	END
/*
	??? ??
	ex )
	 CHARACTER_STR 'S6',@im_idPlayer,@iserverindex
	 CHARACTER_STR 'S6','000001','01'
*/	

ELSE
IF @iGu = 'S7' -- ??? ??? ????? ??? ??
	BEGIN
--		DELETE  ITEM_REMOVE_TBL 
		UPDATE ITEM_REMOVE_TBL SET ItemFlag=1, DeleteDt=getdate()
 		 WHERE	m_nNo = @iplayerslot
		IF @@ROWCOUNT = 0
		SELECT fError = '0'
		ELSE
		SELECT fError = '1'
		RETURN
	END
/*
	 ??? ??? ????? ??? ??
	 ex ) 
	 CHARACTER_STR 'S7',@im_idPlayer,@iserverindex,@iaccount
	 CHARACTER_STR 'S7','000001','01','???',1,1
*/

IF @iGu = 'S8' -- ??? ?? ????
	BEGIN

				-- ?? ?? ???? character ?
				DECLARE @om_chLoginAuthority CHAR(1)
				SELECT @om_chLoginAuthority = m_chLoginAuthority
				  FROM  ACCOUNT_DBF.dbo.ACCOUNT_TBL_DETAIL 
				WHERE account   = @iaccount
				
				SELECT	m_chLoginAuthority = @om_chLoginAuthority,
								A.account,
								A.m_idPlayer,
								A.playerslot,
								A.serverindex,
								A.dwWorldID,
								A.m_szName,
								A.m_dwIndex,
								A.m_vScale_x,
								A.m_dwMotion,
								A.m_vPos_x,
								A.m_vPos_y,
								A.m_vPos_z,
								A.m_fAngle,
								A.m_szCharacterKey,
								A.m_idPlayer,
								A.m_nHitPoint,
								A.m_nManaPoint,
								A.m_nFatiguePoint,
								A.m_nFuel,
								A.m_dwSkinSet,
								A.m_dwHairMesh,
								A.m_dwHairColor,
								A.m_dwHeadMesh,
								A.m_dwSex,
								A.m_dwRideItemIdx,
								A.m_dwGold,
								A.m_nJob,
								A.m_pActMover,
								A.m_nStr,
								A.m_nSta,
								A.m_nDex,
								A.m_nInt,
								A.m_nLevel,
								A.m_nMaximumLevel,
								A.m_nExp1,
								A.m_nExp2,
								A.m_aJobSkill,
								A.m_aLicenseSkill,
								A.m_aJobLv,
								A.m_dwExpertLv,
								A.m_idMarkingWorld,
								A.m_vMarkingPos_x,
								A.m_vMarkingPos_y,
								A.m_vMarkingPos_z,
								A.m_nRemainGP,
								A.m_nRemainLP,
								A.m_nFlightLv,
								A.m_nFxp,
								A.m_nTxp,
								A.m_lpQuestCntArray,
								m_aCompleteQuest = ISNULL(A.m_aCompleteQuest,'$'),
								A.m_chAuthority,
								A.m_dwMode,
								A.m_idparty,
								A.m_idCompany,						

								A.m_idMuerderer,						

								A.m_nFame,
								A.m_nDeathExp,
								A.m_nDeathLevel,
								A.m_dwFlyTime,
								A.m_nMessengerState,
								A.End_Time,
								A.BlockTime,
								A.blockby,
								A.isblock,
								A.TotalPlayTime,
								A.CreateTime,
								A.m_dwSkillPoint,
								B.m_aSlotApplet,								
								B.m_aSlotQueue,
								B.m_SkillBar,
								C.m_aSlotItem,
								D.m_Inventory,
								D.m_apIndex,
								D.m_adwEquipment,
								D.m_dwObjIndex,
								m_idGuild = ISNULL(G.m_idGuild,'0'),

								m_idWar = ISNULL(G.m_idWar,'0'),
								A.m_tmAccFuel,

								A.m_tGuildMember,		
								m_dwSMTime = ISNULL(H.m_dwSMTime,'NULL')	,
								SkillInfluence = ISNULL(E.SkillInfluence,'$'),
								F.m_extInventory,																						 		
								F.m_InventoryPiercing,
								A.m_dwReturnWorldID,
								A.m_vReturnPos_x,
								A.m_vReturnPos_y,
								A.m_vReturnPos_z
								------------------ ( ADD : Version7-Skill System)
								, m_SkillPoint  =       SkillPoint
								, m_SkillLv             =       SkillLv
								, m_SkillExp    =       SkillExp
							      -------------- (?? ??)
							        ,A.dwEventFlag,
							        A.dwEventTime,
							        A.dwEventElapsed
								-------------- (Version8 : PK System)


								,A.m_nNumKill-- as m_nNumKill
								,A.m_nSlaughter-- as m_nSlaughter
						--		,A.PKValue 		as m_nPKValue
						--		,A.PKPropensity as m_dwPKPropensity
						--		,A.PKExp 		as m_dwPKExp
							        ----------?? ? ----------
							        ----------?? ?? ----------
							        ,AngelExp as m_nAngelExp
							        ,AngelLevel as m_nAngelLevel
							        ----------?? ? ----------
								------------------- Version9 Pet
								, F.szInventoryPet as szInventoryPet
								, A.m_dwPetId
								, A.m_nExpLog, A.m_nAngelExpLog
								------------- Ver.11 Coupon
								--, m_nCoupon
								------------- Ver.13 Housing
								, A.m_nLayer  --
								, last_connect = @last_connect
								---------- Ver 15
								, A.m_aCheckedQuest	
								, A.m_nCampusPoint
								, A.idCampus
								, isnull(R.m_nRestPoint, 0) m_nRestPoint
								, isnull(R.m_LogOutTime, 0) m_LogOutTime
				   FROM 	CHARACTER_TBL as A inner join TASKBAR_TBL as B on A.serverindex = B.serverindex and A.m_idPlayer = B.m_idPlayer
											inner join TASKBAR_ITEM_TBL as C on A.serverindex = C.serverindex and A.m_idPlayer = C.m_idPlayer
											inner join INVENTORY_TBL as D on A.serverindex = D.serverindex and A.m_idPlayer = D.m_idPlayer
											inner join SKILLINFLUENCE_TBL as E on A.serverindex = E.serverindex and A.m_idPlayer = E.m_idPlayer
											inner join INVENTORY_EXT_TBL as F on A.serverindex = F.serverindex and A.m_idPlayer = F.m_idPlayer
											left outer join GUILD_MEMBER_TBL as G on A.serverindex = G.serverindex and A.m_idPlayer = G.m_idPlayer
											left outer join BILING_ITEM_TBL as H on A.serverindex = H.serverindex and A.m_idPlayer = H.m_idPlayer
											left outer join tblRestPoint as R on  A.serverindex = R.serverindex and A.m_idPlayer = R.m_idPlayer
				WHERE  A.m_idPlayer   = @im_idPlayer
				     AND 	A.serverindex  = @iserverindex
					  /*AND	A.m_idPlayer   = B.m_idPlayer
				     AND 	A.serverindex  = B.serverindex
				     AND 	B.m_idPlayer   = C.m_idPlayer
				     AND 	B.serverindex  = C.serverindex
				     AND 	C.m_idPlayer   = D.m_idPlayer
				     AND 	C.serverindex  = D.serverindex
				     AND 	D.m_idPlayer   = E.m_idPlayer
				     AND 	D.serverindex  = E.serverindex
				     AND 	E.m_idPlayer   = F.m_idPlayer
				     AND 	E.serverindex  = F.serverindex
					  AND  F.serverindex *= G.serverindex
					  AND  F.m_idPlayer *= G.m_idPlayer
					  AND  F.serverindex *= H.serverindex
					  AND  F.m_idPlayer *= H.m_idPlayer*/
					AND		A.account	= lower(@iaccount)

				-- ?? ?? ???? account ?
	
-- 				DECLARE @bank TABLE (m_idPlayer CHAR(6),serverindex CHAR(2),playerslot INT)
-- 
-- 				INSERT @bank
-- 				(m_idPlayer,serverindex,playerslot)
--               SELECT m_idPlayer,serverindex,playerslot 
--               FROM CHARACTER_TBL 
--               WHERE account = @iaccount 
--               AND isblock = 'F'
--               ORDER BY playerslot

				SELECT  a.m_idPlayer,
								c.playerslot,
 								a.m_Bank,
								a.m_apIndex_Bank,
								a.m_dwObjIndex_Bank,
								a.m_dwGoldBank,
								a.m_BankPw,				 		
								b.m_extBank,
                            b.m_BankPiercing, b.szBankPet
				   FROM 	dbo.BANK_TBL a,
                            dbo.BANK_EXT_TBL b,	
                            dbo.CHARACTER_TBL  c
               WHERE 	a.m_idPlayer = b.m_idPlayer
                    AND a.serverindex = b.serverindex
                    AND b.m_idPlayer = c.m_idPlayer
                    AND b.serverindex = c.serverindex
 					  AND c.account = @iaccount 
                    AND c.isblock = 'F'
				ORDER BY c.playerslot

		---------- Ver.11 Pocket
		SELECT  a.nPocket,
		        a.szItem,
		        a.szIndex,
		        a.szObjIndex,
		        a.bExpired,
		        a.tExpirationDate,
		        b.szExt,
		        b.szPiercing,
		        b.szPet
		FROM    tblPocket as a inner join tblPocketExt as b
		                on a.serverindex = b.serverindex AND a.idPlayer = b.idPlayer AND a.nPocket = b.nPocket
		WHERE a.serverindex = @iserverindex AND a.idPlayer = @im_idPlayer
		ORDER BY a.nPocket

		RETURN
	END

/*
	
	 ??? ?? ???? New
	 ex ) 
	 CHARACTER_STR 'S8',@im_idPlayer,@iserverindex,@iaccount
	 CHARACTER_STR 'S8','425120','01','ata3k'
*/
ELSE
IF @iGu = 'U1' -- ??? ??
	BEGIN
		UPDATE CHARACTER_TBL
		      SET	dwWorldID 				= @idwWorldID,
						m_dwIndex 				= @im_dwIndex,			
						m_dwSex	 				= @im_dwSex,
						m_vScale_x 				= @im_vScale_x,						
						m_dwMotion 				= @im_dwMotion,
						m_vPos_x 					= @im_vPos_x,
						m_vPos_y 					= @im_vPos_y,
						m_vPos_z 					= @im_vPos_z,
						m_dwHairMesh    	= @im_dwHairMesh,
						m_dwHairColor	    	= @im_dwHairColor,
						m_dwHeadMesh	   	= @im_dwHeadMesh,  -- 2004/11/08   ??  
						m_fAngle 					= 0, --@im_fAngle,
						m_szCharacterKey 	= @im_szCharacterKey,

						m_nHitPoint 				= @im_nHitPoint,
						m_nManaPoint 			= @im_nManaPoint,
						m_nFatiguePoint 		= @im_nFatiguePoint,
						m_nFuel						= @im_nFuel,
						m_dwRideItemIdx 		= @im_dwRideItemIdx,
						m_dwGold 					= @im_dwGold,
						m_nJob 						= @im_nJob,
						m_pActMover 			= @im_pActMover,
						m_nStr 						= @im_nStr,
						m_nSta 						= @im_nSta,
						m_nDex 						= @im_nDex,
						m_nInt 						= @im_nInt,
						m_nLevel 					= @im_nLevel,
						m_nMaximumLevel	= CASE WHEN m_nMaximumLevel < @im_nLevel THEN @im_nLevel ELSE m_nMaximumLevel END,
						m_nExp1	 				= @im_nExp1,
						m_nExp2 					= @im_nExp2,
						m_aJobSkill 				= @im_aJobSkill,
						m_aLicenseSkill 		= @im_aLicenseSkill,
						m_aJobLv 					= @im_aJobLv,
						m_dwExpertLv 			= @im_dwExpertLv,
						m_idMarkingWorld 	= @im_idMarkingWorld,
						m_vMarkingPos_x 	= @im_vMarkingPos_x,
						m_vMarkingPos_y 	= @im_vMarkingPos_y,
						m_vMarkingPos_z 	= @im_vMarkingPos_z,
						m_nRemainGP 			= @im_nRemainGP,
						m_nRemainLP 			= @im_nRemainLP,
						m_nFlightLv 				= @im_nFlightLv,
						m_nFxp 						= @im_nFxp,
						m_nTxp 						= @im_nTxp,
						m_lpQuestCntArray 	= @im_lpQuestCntArray,
						m_aCompleteQuest = @im_aCompleteQuest,
						m_dwMode 				= @im_dwMode,
						m_idparty 					= @im_idparty,

						m_idMuerderer 		= @im_idMuerderer,	


						m_nFame 					= @im_nFame,	
						m_nDeathExp			= @im_nDeathExp,
						m_nDeathLevel			= @im_nDeathLevel,

						m_dwFlyTime				= m_dwFlyTime + @im_dwFlyTime,
						m_nMessengerState = @im_nMessengerState,
						TotalPlayTime 			= TotalPlayTime + @iTotalPlayTime,
						m_tmAccFuel 			= @im_tmAccFuel,
						m_dwSkillPoint			= @im_dwSkillPoint,
						m_dwReturnWorldID= @im_dwReturnWorldID,
						m_vReturnPos_x		= @im_vReturnPos_x,
						m_vReturnPos_y		= @im_vReturnPos_y,
						m_vReturnPos_z		= @im_vReturnPos_z
						-------------- (ADD: Version7-SkillSystem)
						, SkillPoint    = @im_SkillPoint
						, SkillLv               = @im_SkillLv
						, SkillExp      = @im_SkillExp
					      -------------- (?? ??)
					        , dwEventFlag                     =@idwEventFlag,
					        dwEventTime                     =@idwEventTime,
					        dwEventElapsed          =@idwEventElapsed
					      -------------- (?? ??)




				      -------------- (ADD: Version8-PK System)
								,m_nNumKill = @im_nNumKill
								,m_nSlaughter = @im_nSlaughter
						--		,A.PKValue 		as m_nPKValue
						--		,A.PKPropensity as m_dwPKPropensity
						--		,A.PKExp 		as m_dwPKExp
					        ----------?? ? ----------
					        ----------?? ?? ----------
					        , AngelExp= @im_nAngelExp
					        , AngelLevel= @im_nAngelLevel
					        ----------?? ? ----------
						--------------------- Version9 Pet
						, m_dwPetId = @im_dwPetId
					--	, m_nExpLog = @im_nExpLog
					--	, m_nAngelExpLog = @im_nAngelExpLog
						---------- Ver.11 Coupon
						, m_nCoupon = @im_nCoupon
						---------- Ver.14 
						, m_nLayer = @im_nLayer  --Housing
						, m_nHonor = @im_nHonor  --Master
						---------- Ver 15
						, m_aCheckedQuest = @im_aCheckedQuest
						, m_nCampusPoint = @im_nCampusPoint
						, idCampus = @im_idCampus
		 WHERE	m_idPlayer   				= @im_idPlayer 	
			  AND 	serverindex 				= @iserverindex

-- 		if object_id('QUEST_TBL') is not null
-- 			EXEC QUEST_STR 'A1',@im_idPlayer,@iserverindex,@im_lpQuestCntArray

		--??? ???? ?? ??
		IF @im_dwSMTime > '' 
			BEGIN
				IF EXISTS(SELECT * FROM BILING_ITEM_TBL WHERE m_idPlayer= @im_idPlayer  AND serverindex 	= @iserverindex)
				UPDATE BILING_ITEM_TBL
						SET m_dwSMTime = @im_dwSMTime
				 WHERE	m_idPlayer   				= @im_idPlayer 	
					  AND 	serverindex 				= @iserverindex
				ELSE
				INSERT BILING_ITEM_TBL
					(m_idPlayer,serverindex,m_dwSMTime)
				VALUES
					(@im_idPlayer,@iserverindex,@im_dwSMTime)
			END
		ELSE
			 DELETE BILING_ITEM_TBL
			 WHERE	m_idPlayer   				= @im_idPlayer 	
			      AND 	serverindex 				= @iserverindex

			
 		UPDATE 	CARD_CUBE_TBL 
 				SET m_Card 						= @im_Card,
						m_apIndex_Card 		= @im_Index_Card,
						m_dwObjIndex_Card= @im_ObjIndex_Card,
		     			m_Cube 						= @im_Cube,
 						m_apIndex_Cube 	= @im_Index_Cube,
 						m_dwObjIndex_Cube=@im_ObjIndex_Cube 
 		 WHERE	m_idPlayer   				= @im_idPlayer 	
 			  AND 	serverindex 				= @iserverindex
		
		UPDATE INVENTORY_TBL 
		      SET 	m_Inventory 				= @im_Inventory,
						m_apIndex 				= @im_apIndex,
						m_adwEquipment 	= @im_adwEquipment,
						m_dwObjIndex 			= @im_dwObjIndex
		 WHERE 	m_idPlayer   				= @im_idPlayer 	
			  AND 	serverindex 				= @iserverindex
		
		
		UPDATE TASKBAR_TBL 
			  SET 	m_aSlotApplet 			= @im_aSlotApplet,
						m_aSlotQueue 			= @im_aSlotQueue,
						m_SkillBar					= @im_SkillBar
		 WHERE 	m_idPlayer   				= @im_idPlayer 	
			  AND 	serverindex 				= @iserverindex


		UPDATE TASKBAR_ITEM_TBL 
			  SET 	m_aSlotItem 				= @im_aSlotItem						
		 WHERE 	m_idPlayer   				= @im_idPlayer 	
			  AND 	serverindex 				= @iserverindex

		UPDATE BANK_TBL 
			  SET 	m_Bank 						= @im_Bank,
						m_apIndex_Bank 		= @im_apIndex_Bank, 
						m_dwObjIndex_Bank = @im_dwObjIndex_Bank, 
						m_dwGoldBank 		= @im_dwGoldBank
		 WHERE 	m_idPlayer   				= @im_idPlayer 	
			  AND 	serverindex 				= @iserverindex

		UPDATE SKILLINFLUENCE_TBL
			 SET SkillInfluence = @iSkillInfluence
		 WHERE 	m_idPlayer   				= @im_idPlayer 	
			  AND 	serverindex 				= @iserverindex

		UPDATE INVENTORY_EXT_TBL 
		SET m_extInventory = @im_extInventory,
		    m_InventoryPiercing = @im_InventoryPiercing
		    , szInventoryPet = @iszInventoryPet
		WHERE m_idPlayer = @im_idPlayer AND serverindex = @iserverindex
		
		UPDATE BANK_EXT_TBL 
		SET m_extBank = @im_extBank,
		    m_BankPiercing = @im_BankPiercing
		    , szBankPet = @iszBankPet
		WHERE m_idPlayer = @im_idPlayer AND serverindex = @iserverindex

		SELECT fError = '1', fText = 'OK'
		RETURN
	END
/*
	
	??????
	 ex ) 
	 CHARACTER_STR 'U1', ALL ...
	 CHARACTER_STR 'U1','000001','01' ...
*/

ELSE
IF @iGu = 'U2' --? ???? ??
	BEGIN
		UPDATE CHARACTER_TBL
		      SET	TotalPlayTime 			= TotalPlayTime + @iplayerslot 
		 WHERE	m_szName  				= @im_szName 	
			  AND 	serverindex 				= @iserverindex
		RETURN
	END
/*

	? ???? ??
	 ex ) 
	 CHARACTER_STR 'U2','',@iserverindex,'',@im_szName,@iplayerslot (@iTotalPlayTime)
	 CHARACTER_STR 'U2','','01','','beat',10234
*/

ELSE
IF @iGu = 'U3' --? ???? ?? new
	BEGIN
		UPDATE CHARACTER_TBL
		      SET	TotalPlayTime 			= TotalPlayTime + @iplayerslot 
		 WHERE 	m_idPlayer   				= @im_idPlayer 	
			  AND 	serverindex 				= @iserverindex
		RETURN
	END
/*

	? ???? ?? (new)
	 ex ) 
	 CHARACTER_STR 'U3',@im_idPlayer,@iserverindex,'','',@iplayerslot (@iTotalPlayTime)
	 CHARACTER_STR 'U3','000001','01','','',10234
*/

ELSE
IF @iGu = 'U4' --??? ? ??
	BEGIN
		IF EXISTS(SELECT m_idPlayer FROM CHARACTER_TBL WHERE m_szName  = @im_szName  AND serverindex	= @iserverindex)
			BEGIN
				SELECT fError = '0'
			END
		ELSE
			BEGIN
				UPDATE CHARACTER_TBL
				      SET	m_szName			= @im_szName
				 WHERE 	m_idPlayer   				= @im_idPlayer 	
					  AND 	serverindex 				= @iserverindex
				SELECT fError = '1'
			END
		RETURN
	END

/*


	??? ? ??
	 ex ) 
	 CHARACTER_STR 'U4',@im_idPlayer,@iserverindex,@iaccount,@im_szName
	 CHARACTER_STR 'U4','000001','01','','????'
*/
-- Ver 15
ELSE
IF @iGu = 'U5' --?? ??? ???? ??
	BEGIN
		IF EXISTS(SELECT m_idPlayer FROM CHARACTER_TBL WHERE m_idPlayer = @im_idPlayer AND serverindex	= @iserverindex)
			BEGIN
				UPDATE CHARACTER_TBL
				      SET	m_nCampusPoint			= m_nCampusPoint + @iplayerslot
				 WHERE 	m_idPlayer   				= @im_idPlayer 	
					  AND 	serverindex 				= @iserverindex

				declare @u5m_nCampusPoint int

				select @u5m_nCampusPoint = m_nCampusPoint from CHARACTER_TBL (nolock) WHERE  m_idPlayer = @im_idPlayer AND serverindex	= @iserverindex
				SELECT fError = '1', @u5m_nCampusPoint  m_nCampusPoint
			END
		ELSE
		RETURN
	END
ELSE
IF @iGu = 'U6' -- ?? ID ???? ??
	BEGIN
		IF EXISTS(SELECT m_idPlayer FROM CHARACTER_TBL WHERE  m_idPlayer = @im_idPlayer AND serverindex	= @iserverindex)
			BEGIN
				UPDATE CHARACTER_TBL
				      SET	idCampus			= @iplayerslot
				 WHERE 	m_idPlayer   				= @im_idPlayer 	
					  AND 	serverindex 				= @iserverindex
				SELECT fError = '1'
			END
		ELSE
			BEGIN
				SELECT fError = '0'
			END
		RETURN
	END

ELSE
IF @iGu = 'D1' -- ??? ??
	BEGIN
		IF @im_szName = ''
		BEGIN
			SELECT fError = '1', fText = '??????'
			RETURN
		END

			DECLARE @Exists int
	
			IF EXISTS(SELECT name  from syscolumns where name='m_idPlayer' AND collation= 'Latin1_General_BIN')
				BEGIN
					IF EXISTS(SELECT * FROM ACCOUNT_DBF.dbo.ACCOUNT_TBL WHERE account = @iaccount) -- AND [password] =  @im_szName ) -- rev2
		              SET @Exists = 1
					ELSE
						SET @Exists = 0				
				END
			ELSE
				BEGIN
					IF EXISTS(SELECT *  FROM ACCOUNT_DBF.dbo.ACCOUNT_TBL  WHERE account = @iaccount) -- AND (id_no2 =  @im_szName OR member = 'B' )) -- rev2
		              SET @Exists = 1
					ELSE
						SET @Exists = 0		
				END

			IF @Exists > 0
				BEGIN
					DECLARE @currDate char(12)				
					SET @currDate = CONVERT(CHAR(8),GETDATE(),112) 
											   + RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,GETDATE())),2) 
											   + RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,GETDATE())),2)



					IF EXISTS(SELECT m_idPlayer FROM GUILD_MEMBER_TBL WHERE 	m_idPlayer = @im_idPlayer AND serverindex = @iserverindex	AND m_idWar > 0)
						BEGIN
						SELECT fError = '3', fText = '????'
						RETURN
						END
					ELSE
						BEGIN
						UPDATE CHARACTER_TBL

							  SET isblock 						= 'D',
									  End_Time						= @currDate ,
	
									  BlockTime					= LEFT(@currDate,8)
						WHERE 	m_idPlayer   				= @im_idPlayer 	
							  AND 	serverindex 				= @iserverindex	

	
						UPDATE MESSENGER_TBL
							   SET State = 'D'
						 WHERE 	m_idPlayer   				= @im_idPlayer 	
							  AND 	serverindex 				= @iserverindex	
	
						UPDATE MESSENGER_TBL
							   SET State = 'D'
						 WHERE 	f_idPlayer   				= @im_idPlayer 	
							  AND 	serverindex 				= @iserverindex	



                     /****************************************************************************************/
                     /**                     200506 event                                                                                                          **/
                     /****************************************************************************************/


-- 						if (not exists(select account from RANKING.RANKING_DBF.dbo.last_1_month_tbl where account = @iaccount)
--                           and convert(char(10),getdate(),120) between '2005-07-05' and '2005-07-12')
-- 
--                      begin  --: 1?? ?? ????? ?? ???? ?? 
-- 							declare @cash int,@get_cach int
-- 							select @cash = case when m_nLevel between 10 and 19 then 500
-- 	                                                       when m_nLevel between 20 and 39 then 1000 
-- 	                                                       when m_nLevel between 40 and 49 then 1500 
-- 	                                                       when m_nLevel between 50 and 59 then 2000
-- 	                                                       when m_nLevel between 60 and 69 then 2500
-- 	                                                       when m_nLevel >=	70 then 3000
-- 	                                                       else 0 end
-- 	                     from CHARACTER_TBL
-- 	                     where m_idPlayer = @im_idPlayer and serverindex = @iserverindex
-- 	
-- 	                     select @get_cach = isnull(sum(amount),0)
-- 	                     from  RANKING.RANKING_DBF.dbo.event_member_tbl  
-- 	                     where account = @iaccount
-- 	                     group by account
-- 	
-- 							if @cash + @get_cach > 5000
-- 	                     set @cash = 5000 - @get_cach
-- 	                    
-- 	                     if @cash > 0
-- 	
-- 	                     begin
-- 								declare @retcode int
-- 	
-- 			                 if not exists(select * from BILLING.QLORD_MASTER.dbo.BX_TG_USERINFO where USER_ID = @iaccount)
-- 			                 exec BILLING.QLORD_MASTER.dbo.BX_SP_PROCESS_USERINFO @iaccount,@iaccount,'FLYF',' ','1111111111118',' ',' ',''
-- 		
-- 			                 exec @retcode = BILLING.QLORD_MASTER.dbo.BX_SP_INSERT_BONUS_IN @iaccount,@iaccount,'FLYF','IN00000004',@cash,'??? ?? ???',0,''
-- 	
-- 								if @retcode <> 1
--                             set @cash = 0
-- 
-- 		 					   insert  RANKING.RANKING_DBF.dbo.event_member_tbl 
-- 								 (account,amount,m_idPlayer,serverindex,retcode,date)
-- 					          values
-- 		                      (@iaccount,@cash,@im_idPlayer,@iserverindex,@retcode,getdate())  
-- 	                        
-- 	                     end
--                      end
                     /****************************************************************************************/
                     /****************************************************************************************/
                     /****************************************************************************************/					


						IF EXISTS(SELECT m_idPlayer FROM GUILD_MEMBER_TBL   WHERE 	m_idPlayer = @im_idPlayer AND serverindex = @iserverindex) 
							BEGIN
								SELECT fError = '4', fText = m_idGuild FROM GUILD_MEMBER_TBL   WHERE 	m_idPlayer = @im_idPlayer AND serverindex = @iserverindex
								RETURN
							END
						ELSE
							BEGIN
								SELECT fError = '0', fText = 'DELETE OK'
								RETURN
							END
							

						END
				END
			ELSE
				BEGIN
					SELECT fError = '1', fText = '??????'
					RETURN
				END
	END
/*

	??? ??
	 ex ) 
	 CHARACTER_STR 'D1',@im_idPlayer,@iserverindex,@iaccount (isblock)
	 CHARACTER_STR 'D1','001068','01','ata3k','1019311'

*/

ELSE
IF @iGu = 'I1' -- ?? ?? ??
	BEGIN
	IF EXISTS(SELECT m_szName FROM CHARACTER_TBL
		  WHERE  lower(m_szName) = lower(@im_szName) AND serverindex = @iserverindex)
		BEGIN
			SELECT  fError = '0', fText = '??? ??!' 
			RETURN
		END
	ELSE
		BEGIN
			DECLARE
								@om_idPlayer 					CHAR		(7)		,
								@om_vScale_x					REAL					,
								@om_dwMotion					INT						,
								@om_fAngle						REAL					,
								@om_nHitPoint					INT						,
								@om_nManaPoint				INT						,
								@om_nFatiguePoint			INT						,
								@om_dwRideItemIdx		INT						,
								@om_dwGold					INT						,
								@om_nJob							INT						,
								@om_pActMover				VARCHAR(50)	,
								@om_nStr							INT						,
								@om_nSta							INT						,
								@om_nDex							INT						,
								@om_nInt							INT						,
								@om_nLevel						INT						,

								@om_nExp1						BIGINT						,
								@om_nExp2						BIGINT						,	
								@om_aJobSkill					VARCHAR	(500),
								@om_aLicenseSkill			VARCHAR	(500),
								@om_aJobLv						VARCHAR	(500),
								@om_dwExpertLv				INT						,
								@om_idMarkingWorld		INT						,
								@om_vMarkingPos_x		REAL					,
								@om_vMarkingPos_y		REAL					,
								@om_vMarkingPos_z		REAL					,
								@om_nRemainGP				INT						,
								@om_nRemainLP				INT						,
								@om_nFlightLv					INT						,
								@om_nFxp							INT						,
								@om_nTxp							INT						,

								@om_lpQuestCntArray		VARCHAR(1024),
								@om_chAuthority				CHAR(1)				,
								@om_dwMode					INT						,
								@oblockby							VARCHAR(32)	,
								@oTotalPlayTime				INT						,
								@oisblock							CHAR(1)				,
								@oEnd_Time						CHAR(12)	,
								@om_Inventory					VARCHAR(6940),
								@om_apIndex					VARCHAR(345)	,
								@om_adwEquipment		VARCHAR(135)	,
								@om_aSlotApplet				VARCHAR(3100),
								@om_aSlotItem					VARCHAR(6885),
								@om_aSlotQueue				VARCHAR(225),
								@om_SkillBar						SMALLINT,
								@om_dwObjIndex				VARCHAR(345)	,
								@om_Card							VARCHAR(1980),
								@om_Cube						VARCHAR(1980),
								@om_apIndex_Card			VARCHAR(215)	,
								@om_dwObjIndex_Card	VARCHAR(215)	,
								@om_apIndex_Cube		VARCHAR(215)	,
								@om_dwObjIndex_Cube	VARCHAR(215)	,
								@om_idparty						INT						,

								@om_idMuerderer			INT						,

								@om_nFame						INT						,
								@om_nDeathExp				BIGINT						,
								@om_nDeathLevel			INT						,
								@om_dwFlyTime				INT						,
								@om_nMessengerState	INT						,
								@om_Bank							VARCHAR(4290),
								@om_apIndex_Bank		 	VARCHAR(215)	,
								@om_dwObjIndex_Bank VARCHAR(215)	,
								@om_dwGoldBank			INT						
								---------- Ver 15
								, @om_aCheckedQuest varchar(100) 
								, @om_nCampusPoint int 
								, @om_idCampus int
								--V6 PK
								, @om_nNumKill int
								, @om_nSlaughter int

				 IF EXISTS (SELECT * FROM CHARACTER_TBL WHERE  serverindex = @iserverindex)
				 SELECT @om_idPlayer = RIGHT('0000000' + CONVERT(VARCHAR(7),MAX(m_idPlayer)+1),7)
			       FROM CHARACTER_TBL
				  WHERE  serverindex = @iserverindex
				ELSE		
				SELECT @om_idPlayer = '0000001'	
			
				 SELECT @om_vScale_x 				= m_vScale_x,
								@om_dwMotion 				= m_dwMotion,
								@om_fAngle 						= m_fAngle,
								@om_nHitPoint 					= m_nHitPoint,
								@om_nManaPoint 			= m_nManaPoint,
								@om_nFatiguePoint 			= m_nFatiguePoint,
								@om_dwRideItemIdx 		= m_dwRideItemIdx,
								@om_dwGold 					= m_dwGold,
								@om_nJob 						= m_nJob,
								@om_pActMover 				= m_pActMover,
								@om_nStr 							= m_nStr,
								@om_nSta 							= m_nSta,
								@om_nDex 						= m_nDex,
								@om_nInt 							= m_nInt,
								@om_nLevel 						= m_nLevel,
								@om_nExp1 						= m_nExp1,
								@om_nExp2 						= m_nExp2,
								@om_aJobSkill 					= m_aJobSkill,
								@om_aLicenseSkill 			= m_aLicenseSkill,
								@om_aJobLv 					= m_aJobLv,

								@om_dwExpertLv 				= m_dwExpertLv,
								@om_idMarkingWorld 		= m_idMarkingWorld,
								@om_vMarkingPos_x 		= m_vMarkingPos_x,
								@om_vMarkingPos_y 		= m_vMarkingPos_y,
								@om_vMarkingPos_z 		= m_vMarkingPos_z,
								@om_nRemainGP 			= m_nRemainGP,
								@om_nRemainLP 			= m_nRemainLP,
								@om_nFlightLv 					= m_nFlightLv,
								@om_nFxp 						= m_nFxp,
								@om_nTxp 						= m_nTxp,
								@om_lpQuestCntArray		= m_lpQuestCntArray,
								@om_chAuthority 				= m_chAuthority,
								@om_dwMode 					= m_dwMode,
								@oblockby 						= blockby,
								@oTotalPlayTime 				= TotalPlayTime,
								@oisblock 							= isblock,
								@oEnd_Time 					= CONVERT(CHAR(8),DATEADD(yy,3,GETDATE()),112) + '0000',
								@om_Inventory 					= m_Inventory,
								@om_apIndex 					= m_apIndex,
								@om_adwEquipment 		= m_adwEquipment,
								@om_aSlotApplet 				= m_aSlotApplet,
								@om_aSlotItem 					= m_aSlotItem,
								@om_aSlotQueue 			= m_aSlotQueue,
								@om_SkillBar						= m_SkillBar,
								@om_dwObjIndex 			= m_dwObjIndex,
								@om_Card 						= m_Card,
								@om_Cube 						= m_Cube,
								@om_apIndex_Card 		= m_apIndex_Card,
								@om_dwObjIndex_Card	= m_dwObjIndex_Card,
								@om_apIndex_Cube 		= m_apIndex_Cube,

								@om_dwObjIndex_Cube = m_dwObjIndex_Cube,
								@om_idparty 						= m_idparty,			

								@om_idMuerderer 			= m_idMuerderer,

								@om_nFame 						= m_nFame,
								@om_nDeathExp				= m_nDeathExp,
								@om_nDeathLevel			= m_nDeathLevel,
								@om_dwFlyTime				= m_dwFlyTime,
								@om_nMessengerState 	= m_nMessengerState,
								@om_Bank							= m_Bank,
								@om_apIndex_Bank		 	= m_apIndex_Bank,
								@om_dwObjIndex_Bank 	= m_dwObjIndex_Bank,
								@om_dwGoldBank			= m_dwGoldBank,			

									--V6 PK
								@om_nNumKill = 0,
								@om_nSlaughter = 0
			       FROM BASE_VALUE_TBL
				 WHERE g_nSex 								= @im_dwSex
			


				INSERT CHARACTER_TBL
							(
								m_idPlayer,
								serverindex,
								account,
								m_szName,
								playerslot,
								dwWorldID,
								m_dwIndex,
								m_vScale_x,
								m_dwMotion,
								m_vPos_x,

								m_vPos_y,
								m_vPos_z,
								m_fAngle,
								m_szCharacterKey,

								m_nHitPoint,
								m_nManaPoint,
								m_nFatiguePoint,
								m_nFuel,
								m_dwSkinSet,
								m_dwHairMesh,
								m_dwHairColor,
								m_dwHeadMesh,
								m_dwSex,
								m_dwRideItemIdx,
								m_dwGold,
								m_nJob,
								m_pActMover,
								m_nStr,
								m_nSta,
								m_nDex,
								m_nInt,
								m_nLevel,
								m_nMaximumLevel,
								m_nExp1,
								m_nExp2,
								m_aJobSkill,
								m_aLicenseSkill,
								m_aJobLv,
								m_dwExpertLv,
								m_idMarkingWorld,
								m_vMarkingPos_x,
								m_vMarkingPos_y,
								m_vMarkingPos_z,
								m_nRemainGP,
								m_nRemainLP,

								m_nFlightLv,
								m_nFxp,
								m_nTxp,
								m_lpQuestCntArray,
								m_aCompleteQuest,
								m_chAuthority,
								m_dwMode,
								m_idparty,
								m_idCompany,


								m_idMuerderer,


								m_nFame,
								m_nDeathExp,
								m_nDeathLevel,

								m_dwFlyTime,
								m_nMessengerState,
								blockby,
								TotalPlayTime,
								isblock,
								End_Time,
								BlockTime,
								CreateTime,
								m_tmAccFuel,
								m_tGuildMember,
								m_dwSkillPoint,
								m_dwReturnWorldID,
								m_vReturnPos_x,
								m_vReturnPos_y,
								m_vReturnPos_z
								-- m_SkillPoint,
								-- m_SkillLv,
								-- m_SkillExp
								---------- Ver 15
								, m_aCheckedQuest
								, m_nCampusPoint
								, idCampus
								, m_nNumKill
								, m_nSlaughter
							)
				VALUES
							(
								@om_idPlayer,
								@iserverindex,
								@iaccount,
								@im_szName,
								@iplayerslot,
								@idwWorldID,
								@im_dwIndex,
								@om_vScale_x,

								@om_dwMotion,
								@im_vPos_x,
								@im_vPos_y,
								@im_vPos_z,
								@om_fAngle,
								@im_szCharacterKey,
								@om_nHitPoint,
								@om_nManaPoint,
								@om_nFatiguePoint,
								-1, --m_nFuel
								@im_dwSkinSet,
								@im_dwHairMesh,
								@im_dwHairColor,
								@im_dwHeadMesh,
								@im_dwSex,
								@om_dwRideItemIdx,
								@om_dwGold,
								@om_nJob,
								@om_pActMover,
								@om_nStr,
								@om_nSta,
								@om_nDex,
								@om_nInt,
								@om_nLevel,
								1, --m_nMaximumLevel
								@om_nExp1,
								@om_nExp2,
								@om_aJobSkill,
								@om_aLicenseSkill,
								@om_aJobLv,
								@om_dwExpertLv,
								@om_idMarkingWorld,
								@om_vMarkingPos_x,
								@om_vMarkingPos_y,
								@om_vMarkingPos_z,
								@om_nRemainGP,
								@om_nRemainLP,
								@om_nFlightLv,
								@om_nFxp,
								@om_nTxp,
								@om_lpQuestCntArray,
								'$', -- m_aCompleteQuest
								@om_chAuthority,
								@om_dwMode,
								@om_idparty,
								'000000', -- m_idCompany

								@om_idMuerderer,

								@om_nFame,
								@om_nDeathExp,
								@om_nDeathLevel,
								@om_dwFlyTime	,
								@om_nMessengerState,
								@oblockby,
								@oTotalPlayTime,
								@oisblock,
								@oEnd_Time,
								CONVERT(CHAR(8),DATEADD(d,-1,GETDATE()),112),
								GETDATE(),
								0,
								CONVERT(CHAR(8),DATEADD(d,-1,GETDATE()),112) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,DATEADD(d,-1,GETDATE()))),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,DATEADD(d,-1,GETDATE()))),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,DATEADD(d,-1,GETDATE()))),2),
								0, --m_dwSkillPoint
                            1,
                            0, 
                            0,
							0
							-- @im_SkillPoint,
							-- @im_SkillLv,
							-- @im_SkillExp
							-- Ver 15
							, '$'
							, 0
							, 0
							-- V6 PK
							, 0
							, 0
							)


				INSERT INVENTORY_TBL
							(
								m_idPlayer,
								serverindex,
								m_Inventory,
								m_apIndex,
								m_adwEquipment,
								m_dwObjIndex
							)
				VALUES 
							(
								@om_idPlayer,
								@iserverindex,
								@om_Inventory,
								@om_apIndex,
								@om_adwEquipment,
								@om_dwObjIndex
							)


				IF @@SERVERNAME = 'WEB' OR  @@SERVERNAME = 'SERVER4'
				SET @om_aSlotApplet = '0,2,400,0,0,0,0/1,2,398,0,1,0,0/2,2,2010,0,2,0,0/3,2,1005,0,3,0,0/4,3,25,0,4,0,0/$'

				INSERT TASKBAR_TBL
							(
								m_idPlayer,
								serverindex,
								m_aSlotApplet,
								m_aSlotQueue,
								m_SkillBar

							)
				VALUES 
							(
								@om_idPlayer,
								@iserverindex,
								@om_aSlotApplet,
								@om_aSlotQueue,
								@om_SkillBar
							)


				INSERT TASKBAR_ITEM_TBL
							(
								m_idPlayer,
								serverindex,
								m_aSlotItem
							)

				VALUES 
							(
								@om_idPlayer,
								@iserverindex,
								@om_aSlotItem
							)

			INSERT BANK_TBL
							(
								m_idPlayer,
								serverindex,
								m_Bank,
								m_BankPw,
								m_apIndex_Bank, 
								m_dwObjIndex_Bank ,
								m_dwGoldBank
							)
				VALUES 
							(
								@om_idPlayer,
								@iserverindex,
								@om_Bank,
								'0000', -- m_BankPw
								@om_apIndex_Bank, 
								@om_dwObjIndex_Bank,
								@om_dwGoldBank 
							)

		INSERT SKILLINFLUENCE_TBL
							( 								
								m_idPlayer,
								serverindex,
								SkillInfluence
							)
				VALUES 
							(
								@om_idPlayer,
								@iserverindex,
								'$'
							)

		INSERT INVENTORY_EXT_TBL
							( 								
								m_idPlayer,
								serverindex,
								m_extInventory,
								m_InventoryPiercing
							)
				VALUES 
							(
								@om_idPlayer,
								@iserverindex,
								'$','$'
							)

		INSERT BANK_EXT_TBL
							( 								
								m_idPlayer,
								serverindex,
								m_extBank,
								m_BankPiercing
							)
				VALUES 
							(
								@om_idPlayer,
								@iserverindex,
								'$','$'
							)

		INSERT INTO tblMultiServerInfo(serverindex, m_idPlayer, MultiServer)
				VALUES (@iserverindex, @om_idPlayer, 0)

		INSERT INTO tblSkillPoint(serverindex, PlayerID, SkillID, SkillLv, SkillPosition)
		        VALUES (@iserverindex, @om_idPlayer, 1, 0, 0)
		INSERT INTO tblSkillPoint(serverindex, PlayerID, SkillID, SkillLv, SkillPosition)
		        VALUES (@iserverindex, @om_idPlayer, 2, 0, 1)
		INSERT INTO tblSkillPoint(serverindex, PlayerID, SkillID, SkillLv, SkillPosition)
		        VALUES (@iserverindex, @om_idPlayer, 3, 0, 2)

		------------ Ver.11 Pocket
		INSERT  tblPocket ( serverindex, idPlayer, nPocket, szItem, szIndex, szObjIndex, bExpired, tExpirationDate )
		VALUES ( @iserverindex, @om_idPlayer, 0, '$', '$', '$', 0, 0 )
		
		INSERT  tblPocketExt ( serverindex, idPlayer, nPocket, szExt, szPiercing, szPet )
		VALUES ( @iserverindex, @om_idPlayer, 0, '$', '$', '$' )
		
		INSERT  tblPocket ( serverindex, idPlayer, nPocket, szItem, szIndex, szObjIndex, bExpired, tExpirationDate )
		VALUES ( @iserverindex, @om_idPlayer, 1, '$', '$', '$', 1, 0 )
		
		INSERT  tblPocketExt ( serverindex, idPlayer, nPocket, szExt, szPiercing, szPet )
		VALUES ( @iserverindex, @om_idPlayer, 1, '$', '$', '$' )
		
		INSERT  tblPocket ( serverindex, idPlayer, nPocket, szItem, szIndex, szObjIndex, bExpired, tExpirationDate )
		VALUES ( @iserverindex, @om_idPlayer, 2, '$', '$', '$', 1, 0 )
		
		INSERT  tblPocketExt ( serverindex, idPlayer, nPocket, szExt, szPiercing, szPet )
		VALUES ( @iserverindex, @om_idPlayer, 2, '$', '$', '$' )
		------------ Ver.13 Master
		insert into tblMaster_all (serverindex, m_idPlayer, sec)  --??
		select @iserverindex, @om_idPlayer, 1
		insert into tblMaster_all (serverindex, m_idPlayer, sec)
		select @iserverindex, @om_idPlayer, 2
		insert into tblMaster_all (serverindex, m_idPlayer, sec)
		select @iserverindex, @om_idPlayer, 3

		------------------- ver. 15
		insert into tblRestPoint (serverindex, m_idPlayer)
		select @iserverindex, @om_idPlayer

		SELECT fError = '1', fText = 'OK',m_idPlayer=@om_idPlayer
		RETURN
		END
	END

/*
	
	?? ?? ??
	 ex ) 
	 CHARACTER_STR 'I1','',@iserverindex,@iaccount,@im_szName,@iplayerslot,@idwWorldID,
											@im_dwIndex,@im_vPos_x,@im_vPos_y,@im_vPos_z,@im_szCharacterKey,
											@im_dwSkinSet,@im_dwHairMesh,@im_dwHairColor,@im_dwHeadMesh,@im_dwSex
	 CHARACTER_STR 'I1','','01','beat','????3',0,0,
											0,0,0,0,'',
											0,0,0,0,0

*/
set nocount off
RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_item2row]
as
set nocount on
truncate table tblitem2row

declare @m_idPlayer char(7), @serverindex char(2), @m_Inventory varchar(6000), @m_Bank varchar(6000), @szItem0 varchar(6000), @szItem1 varchar(6000), @szItem2 varchar(6000)

declare item2row_cursor cursor fast_forward for 
select m_idPlayer, serverindex, m_Inventory, m_Bank, szItem0, szItem1, szItem2
from viw_Item_Info with (nolock)
order by m_idPlayer

open item2row_cursor

fetch next from item2row_cursor 
into @m_idPlayer, @serverindex, @m_Inventory, @m_Bank, @szItem0, @szItem1, @szItem2

while @@fetch_status = 0
begin	
   if @m_Inventory <> '$'
	insert tblitem2row
		(m_idPlayer, serverindex, m_dwObjId, m_dwItemId, m_nUniqueNo, m_nItemNum, m_nAbilityOption, ItemResist, ResistAbilityOpt, m_position)
	select m_idPlayer, serverindex, m_dwObjId, m_dwItemId, m_nUniqueNo, m_nItemNum, isnull(m_nAbilityOption,0), isnull(ItemResist, 0), isnull(ResistAbilityOpt, 0), 'I'
	from dbo.fn_item2row (@m_idPlayer, @serverindex, @m_Inventory)

   if @m_Bank <> '$'
	insert tblitem2row
		(m_idPlayer, serverindex, m_dwObjId, m_dwItemId, m_nUniqueNo, m_nItemNum, m_nAbilityOption, ItemResist, ResistAbilityOpt, m_position)
	select m_idPlayer, serverindex, m_dwObjId, m_dwItemId, m_nUniqueNo, m_nItemNum, isnull(m_nAbilityOption,0), isnull(ItemResist, 0), isnull(ResistAbilityOpt, 0), 'B'
	from dbo.fn_item2row (@m_idPlayer, @serverindex, @m_Bank)

   if @szItem0 <> '$'
	insert tblitem2row
		(m_idPlayer, serverindex, m_dwObjId, m_dwItemId, m_nUniqueNo, m_nItemNum, m_nAbilityOption, ItemResist, ResistAbilityOpt, m_position)
	select m_idPlayer, serverindex, m_dwObjId, m_dwItemId, m_nUniqueNo, m_nItemNum, isnull(m_nAbilityOption,0), isnull(ItemResist, 0), isnull(ResistAbilityOpt, 0), 'P'
	from dbo.fn_item2row (@m_idPlayer, @serverindex, @szItem0)

   if @szItem1 <> '$'
	insert tblitem2row
		(m_idPlayer, serverindex, m_dwObjId, m_dwItemId, m_nUniqueNo, m_nItemNum, m_nAbilityOption, ItemResist, ResistAbilityOpt, m_position)
	select m_idPlayer, serverindex, m_dwObjId, m_dwItemId, m_nUniqueNo, m_nItemNum, isnull(m_nAbilityOption,0), isnull(ItemResist, 0), isnull(ResistAbilityOpt, 0), 'P'
	from dbo.fn_item2row (@m_idPlayer, @serverindex, @szItem1)

   if @szItem2 <> '$'
	insert tblitem2row
		(m_idPlayer, serverindex, m_dwObjId, m_dwItemId, m_nUniqueNo, m_nItemNum, m_nAbilityOption, ItemResist, ResistAbilityOpt, m_position)
	select m_idPlayer, serverindex, m_dwObjId, m_dwItemId, m_nUniqueNo, m_nItemNum, isnull(m_nAbilityOption,0), isnull(ItemResist, 0), isnull(ResistAbilityOpt, 0), 'P'
	from dbo.fn_item2row (@m_idPlayer, @serverindex, @szItem2)

	fetch next from item2row_cursor 
	into  @m_idPlayer, @serverindex, @m_Inventory, @m_Bank, @szItem0, @szItem1, @szItem2
end
close item2row_cursor
deallocate item2row_cursor
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_CampusMember_Load    Script Date: 2009-12-01 오후 2:41:44 ******/


/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.11.20
3. 스크립트 명 : usp_CampusMember_Load
4. 스크립트 목적 : 사제 맴버 리스트 호출
5. 매개변수
	@serverindex	char(2)		: 서버군
6. 리턴값 	
7. 수정 내역
8. 샘플 실행 코드
    EXEC usp_CampusMember_Load '05'
9. 조회 및 ident 값 초기화
	select * from tblCampusMember
	delete tblCampusMember
============================================================*/

CREATE       proc [dbo].[usp_CampusMember_Load]

	@serverindex char(2)
as

set nocount on
set xact_abort on

	select idCampus, serverindex, m_idPlayer, nMemberLv 
	from tblCampusMember (nolock)
	where serverindex = @serverindex
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_CampusMember_Insert    Script Date: 2009-12-01 오후 2:41:44 ******/


/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.11.20
3. 스크립트 명 : usp_CampusMember_Insert
4. 스크립트 목적 : 사제 맴버 리스트 입력
5. 매개변수
	@idCampus		int			: 사제 ID
	@serverindex	char(2)		: 서버군
	@m_idPlayer		char(7)		: 플레이어 ID
	@nMemberLv		int			: 해당 사제에서 자신의 등급
6. 리턴값 	
7. 수정 내역
8. 샘플 실행 코드
    EXEC usp_Campus_Insert 123, '05'
    EXEC usp_CampusMember_Insert 123, '05', '0745479', 2
9. 조회 및 ident 값 초기화
	select * from tblCampus
	select * from tblCampusMember
    EXEC usp_Campus_Delete 123, '05'
============================================================*/

CREATE       proc [dbo].[usp_CampusMember_Insert]

	@idCampus	int,
	@serverindex	char(2),
	@m_idPlayer	char(7),
	@nMemberLv	int

as

set nocount on
set xact_abort on

	if not exists (select * from tblCampusMember (nolock) where m_idPlayer = @m_idPlayer)
		begin
			INSERT INTO tblCampusMember(idCampus, serverindex, m_idPlayer, nMemberLv)
			select @idCampus, @serverindex, @m_idPlayer, @nMemberLv
		end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_CampusMember_Delete    Script Date: 2009-12-01 오후 2:41:44 ******/





/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.11.20
3. 스크립트 명 : usp_CampusMember_Delete
4. 스크립트 목적 : 사제 맴버 리스트 삭제
5. 매개변수
	@serverindex	char(2)		: 서버군
	@m_idPlayer		char(7)		: 플레이어 ID
	@nMemberLv		int			: 해당 사제에서 나의 등급
6. 리턴값 	
7. 수정 내역
8. 샘플 실행 코드
    EXEC usp_CampusMember_Delete 123, '0745479'
9. 조회 및 ident 값 초기화
	select * from tblCampus
	select * from tblCampusMember
    EXEC usp_Campus_Delete '05', '0745479', 2
============================================================*/

CREATE         proc [dbo].[usp_CampusMember_Delete]

	@serverindex	char(2),
	@m_idPlayer		char(7),
	@nMemberLv		int

as

set nocount on
set xact_abort on

declare @idCampus int

	select @idCampus = idCampus from tblCampusMember (nolock)
		where m_idPlayer = @m_idPlayer and serverindex = @serverindex

	if @nMemberLv = 1
		begin
			exec usp_Campus_Delete @idCampus, @serverindex
		end
	else if @nMemberLv = 2
		begin
			delete tblCampusMember
			where m_idPlayer = @m_idPlayer and serverindex = @serverindex and nMemberLv = @nMemberLv
		end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_aac_update]

@blockTime char(8),
@webTime char(8),
@account varchar(32),
@inputID varchar(32),
@reason varchar(500),
@num int

as

set nocount on
set xact_abort on

UPDATE ACCOUNT_DBF.dbo.ACCOUNT_TBL_DETAIL
SET BlockTime = @blockTime, WebTime   = @webTime
WHERE account = @account

UPDATE TBL_LOG_BLOCK_ACCOUNT
SET r_block_day = @blockTime, r_web_day = @webTime,  r_input_id = @inputID,  r_input_day = GETDATE(),  r_reason = @reason
WHERE  num = @num

if @@error <> 0
begin
	select result = -1
end
else
begin
	select result = 1
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE proc [dbo].[usp_aab_account]

@account varchar(32)

as

set nocount on

select BlockTime, WebTime, EndTime
from ACCOUNT_DBF.dbo.ACCOUNT_TBL_DETAIL
where account = @account
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_bbb_seed]

@serverindex char(2),
@lpenya int,
@hpenya int

as

set nocount on

SELECT a.m_nLevel as m_nLevel, a.m_szName as m_szName, cast(a.m_dwGold as bigint) + cast(b.m_dwGoldBank as bigint) as total,
       a.m_dwGold as m_dwGold, b.m_dwGoldBank as m_dwGoldBank
FROM   CHARACTER_TBL a, BANK_TBL b
WHERE  a.serverindex = @serverindex
	AND    cast(a.m_dwGold as bigint) + cast(b.m_dwGoldBank as bigint) >= @lpenya AND cast(a.m_dwGold as bigint) + cast(b.m_dwGoldBank as bigint) <= @hpenya
	AND    a.serverindex = b.serverindex AND a.m_idPlayer = b.m_idPlayer
	AND    a.account not in ( SELECT account 
				FROM   ACCOUNT_DBF.dbo.ACCOUNT_TBL_DETAIL 
				WHERE  m_chLoginAuthority <> 'F' ) 
ORDER BY cast(a.m_dwGold as bigint) + cast(b.m_dwGoldBank as bigint) DESC
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_bbb_level]

@serverindex char(2),
@llevel int,
@hlevel int

as

set nocount on

SELECT a.m_nLevel as m_nLevel, a.m_szName as m_szName, cast(a.m_dwGold as bigint) + cast(b.m_dwGoldBank as bigint) as total,
       a.m_dwGold as m_dwGold, b.m_dwGoldBank as m_dwGoldBank
FROM   CHARACTER_TBL a, BANK_TBL b
WHERE  a.serverindex = @serverindex
	AND    a.m_nLevel >= @llevel AND a.m_nLevel <= @hlevel
	AND    a.serverindex = b.serverindex AND a.m_idPlayer = b.m_idPlayer
	AND    a.account not in ( SELECT account 
				FROM   ACCOUNT_DBF.dbo.ACCOUNT_TBL_DETAIL 
				WHERE  m_chLoginAuthority <> 'F' ) 
ORDER BY a.m_nLevel DESC
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspRewardCombatGuild]
		@pCombatID		int,
		@pserverindex	char(2),
		@pGuildID		char(6)
AS
SET NOCOUNT ON

	UPDATE	tblCombatJoinGuild
	   SET	RewardDt=getdate(),
			Status='31'
	 WHERE	CombatID=@pCombatID
	   AND	serverindex=@pserverindex
	   AND	GuildID=@pGuildID
	   
	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001 as retValue
		RETURN
	END

	SELECT 1 as retValue	
	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspStartCombat]
		@pCombatID		int,
		@pserverindex	char(2)
AS
SET NOCOUNT ON

	UPDATE tblCombatInfo SET Status='20' WHERE CombatID=@pCombatID AND serverindex=@pserverindex AND Status='10'
	
	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001 as retValue
		RETURN
	END
		
	UPDATE tblCombatJoinGuild SET Status='20' WHERE CombatID=@pCombatID AND serverindex=@pserverindex AND Status='10'
	
	IF @@ROWCOUNT=0 BEGIN
		SELECT 9002 as retValue
		RETURN
	END

	SELECT 1 as retValue
	RETURN
		
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[uspDeleteCouple]
@nServer int,
@idPlayer int
as
set nocount on

declare @id int, @idPartner int

select @id =cid from tblCouplePlayer where nServer = @nServer and idPlayer = @idPlayer

select @idPartner = idPlayer from tblCouplePlayer where nServer = @nServer and cid = @id and idPlayer <> @idPlayer

insert into tblCouple_deleted (cid, nServer, nExperience, add_Date)
select cid, nServer, nExperience, add_Date from tblCouple where nServer = @nServer and cid = @id

insert into tblCouplePlayer_deleted (nServer, idPlayer, cid)
select  nServer, idPlayer, cid from tblCouplePlayer where nServer = @nServer and cid = @id

delete tblCouple where nServer = @nServer and cid = @id

delete tblCouplePlayer where nServer = @nServer and cid = @id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspAddCoupleExperience]
@nServer int,
@idPlayer int,
@nExperience int
as
set nocount on 

declare @id int

select @id =cid from tblCouplePlayer where nServer = @nServer and idPlayer = @idPlayer
update tblCouple set nExperience = nExperience + @nExperience where nServer = @nServer and cid = @id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspAddCouple]
@nServer int,
@idFirst int,
@idSecond int
as
set nocount on

declare @id int

insert into tblCouple (nServer, nExperience)
select @nServer, 0

select @id = @@identity from tblCouple where nServer = @nServer

insert into tblCouplePlayer (nServer, idPlayer, cid)
select @nServer, @idFirst, @id

insert into tblCouplePlayer (nServer, idPlayer, cid)
select @nServer, @idSecond, @id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspCancelGuildToCombat]
		@pCombatID		int,
		@pserverindex	char(2),
		@pGuildID		char(6)
AS
SET NOCOUNT ON

	UPDATE tblCombatJoinGuild SET Status='11' WHERE CombatID=@pCombatID AND serverindex=@pserverindex AND GuildID=@pGuildID
		
	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001 as retValue
		RETURN
	END

	SELECT 1 retValue
	RETURN 

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspCombatContinue]
		@pCombatID		int,
		@pserverindex		char(2),
		@pGuildID		char(6),
		@pStraightWin		int
AS
SET NOCOUNT ON

	UPDATE dbo.tblCombatJoinGuild
	SET	StraightWin = @pStraightWin
	WHERE	CombatID=@pCombatID
	   AND	serverindex=@pserverindex
	   AND	GuildID=@pGuildID

	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001 as retValue
		RETURN
	END

	SELECT 1 as retValue	
	RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspJoinGuildToCombat]
		@pCombatID		int,
		@pserverindex	char(2),
		@pGuildID		char(6),
		@pCombatFee		bigint = 0,
		@pStraightWin	int = 0
AS
SET NOCOUNT ON

	IF EXISTS ( SELECT * FROM tblCombatJoinGuild WHERE CombatID=@pCombatID and GuildID=@pGuildID and serverindex=@pserverindex) BEGIN
		UPDATE	tblCombatJoinGuild SET Status='12', CombatFee=@pCombatFee, ApplyDt=getdate(), CancelDt=getdate(), StraightWin=@pStraightWin 
		WHERE	CombatID=@pCombatID
		AND		serverindex=@pserverindex
		AND		GuildID=@pGuildID
		
		IF @@ROWCOUNT=0 BEGIN
			SELECT 9003 as retValue
			RETURN
		END
	END
	ELSE BEGIN
		INSERT INTO tblCombatJoinGuild(CombatID, serverindex, GuildID, Status, ApplyDt, CombatFee, ReturnCombatFee, Reward, Point, RewardDt, CancelDt, StraightWin)
			VALUES (@pCombatID, @pserverindex, @pGuildID, '10', getdate(), @pCombatFee, 0, 0, 0, NULL, NULL, @pStraightWin)
	END
			
	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001 as retValue
		RETURN
	END
	
	SELECT 1 as retValue
	RETURN
				

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspGradeCombatGuild]
		@pCombatID		int,
		@pserverindex	char(2),
		@pGuildID		char(6),
		@pPoint			int,
		@pReturnCombatFee	bigint=0,
		@pReward		bigint=0,
		@pStraightWin	int=0
AS
SET NOCOUNT ON

	DECLARE @Status	varchar(3)
	
	IF @pReward=0 AND @pReturnCombatFee=0 
		SET @Status='31'
	ELSE
		SET @Status='30'
	
	UPDATE	tblCombatJoinGuild 
	   SET	Point=@pPoint,
			ReturnCombatFee=@pReturnCombatFee,
			Reward=@pReward,
			StraightWin=@pStraightWin,
			Status=@Status
	 WHERE	CombatID=@pCombatID
	   AND	serverindex=@pserverindex
	   AND	GuildID=@pGuildID
	
	
	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001 as retValue
		RETURN
	END
	
	SELECT 1 as retValue
	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspLoadCombatGuildList]
		@pCombatID		int,
		@pserverindex	char(2)
AS
SET NOCOUNT ON

	SELECT	CombatID, serverindex, GuildID, Status, ApplyDt, CombatFee, StraightWin, Reward, Point
	  FROM	tblCombatJoinGuild
	 WHERE	CombatID=@pCombatID
	   AND	serverindex=@pserverindex

	RETURN
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspLoadCombatGuildInfo]
		@pserverindex	char(2),
		@pGuildID		char(6)
AS
SET NOCOUNT ON

	SELECT	a.CombatID, a.GuildID, a.Status, a.CombatFee, a.ReturnCombatFee, a.Point, a.Reward
	  FROM	tblCombatJoinGuild a 
	 WHERE	a.serverindex=@pserverindex
	   AND  a.GuildID=@pGuildID
	   AND	a.RewardDt is NULL

	RETURN
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspLoadWinnerGuildInfo]
		@pCombatID		int,
		@pserverindex	char(2)
AS
SET NOCOUNT ON

	SELECT	CombatID, serverindex, GuildID, Status, ApplyDt, CombatFee, StraightWin, Reward, Point
	  FROM	tblCombatJoinGuild
	 WHERE	CombatID=@pCombatID
	   AND	serverindex=@pserverindex
	   AND	StraightWin>0
	   
	RETURN
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspRestoreCouple]
@nServer int
as
set nocount on

select  C.cid, C.nExperience,
	idFirst = (select max(idPlayer) from tblCouplePlayer where C.cid = cid and C.nServer = nServer  ),
	idSecond = (select min(idPlayer) from tblCouplePlayer where C.cid = cid and C.nServer = nServer  )
from tblCouple C
where nServer = @nServer
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspRewardCombatPlayer]
		@pCombatID		int,
		@pserverindex	char(2),
		@pGuildID		char(6),
		@pPlayerID		char(7)
AS
SET NOCOUNT ON

	UPDATE	tblCombatJoinPlayer 
		SET	RewardDt=getdate(),
			Status='31'
	  WHERE	CombatID=@pCombatID
	  AND	serverindex=@pserverindex
	  AND	GuildID=@pGuildID
	  AND	PlayerID=@pPlayerID
			
	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001 as retValue
		RETURN
	END

	SELECT 1 as retValue
	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[uspRankGuildCombatPlayer]
		@pserverindex	char(2)
AS
SET NOCOUNT ON

	SELECT	a.PlayerID, max(b.m_nJob) as Job, sum(a.Point) as PointSummary
	  FROM	tblCombatJoinPlayer a INNER JOIN CHARACTER_TBL b ON (a.PlayerID=b.m_idPlayer)
	GROUP BY	a.PlayerID
	HAVING sum(a.Point)>0
	ORDER BY sum(a.Point)

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspLoadCombatUnpaidList]
		@pserverindex	char(2)
AS
SET NOCOUNT ON

		SELECT	'G' as Flag, CombatID, serverindex, GuildID, Status, '0000000' as PlayerID, CombatFee, ReturnCombatFee, Reward
		FROM 	tblCombatJoinGuild
		WHERE serverindex=@pserverindex
		AND  Status='30'
	UNION ALL
		SELECT  'P' as Flag, CombatID, serverindex, GuildID, Status, PlayerID, 0 as CombatFee, 0 as ReturnCombatFee,Reward
		FROM tblCombatJoinPlayer 
		WHERE serverindex=@pserverindex
		AND Status='30'
		AND Reward>0
	ORDER BY CombatID, Flag, Reward, ReturnCombatFee, GuildID

	RETURN
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspLoadCombatBestPlayer]
		@pCombatID		int,
		@pserverindex	char(2)
AS
SET NOCOUNT ON

	SELECT	TOP 1 PlayerID
	  FROM	tblCombatJoinPlayer
	 WHERE	CombatID=@pCombatID
	   AND	serverindex=@pserverindex
	   AND	Reward>0
	   
	RETURN
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[uspGradeCombatPlayer]
		@pCombatID		int,
		@pserverindex	char(2),
		@pGuildID		char(6),
		@pPlayerID		char(7),
		@pPoint			int,
		@pReward		bigint=0
AS
SET NOCOUNT ON

	INSERT INTO tblCombatJoinPlayer(CombatID, serverindex, GuildID, PlayerID, Point, Reward, Status)
			VALUES (@pCombatID, @pserverindex, @pGuildID, @pPlayerID, @pPoint, @pReward, DEFAULT)

	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001 as retValue
		RETURN
	END

	SELECT 1 as retValue
	RETURN

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspExpireCombatReward]
		@pCombatID		int,
		@pserverindex	char(2),
		@pGuildID		char(6),
		@pPlayerID		char(7)='0000000'
AS
SET NOCOUNT ON

	IF @pPlayerID='0000000' BEGIN
		UPDATE	tblCombatJoinGuild SET Status='32' 
		WHERE	CombatID=@pCombatID
		  AND	serverindex=@pserverindex
		  AND	GuildID=@pGuildID
		
		IF @@ROWCOUNT=0 BEGIN
			SELECT 9001 as retValue
			RETURN
		END
	END
	ELSE BEGIN
		UPDATE	tblCombatJoinPlayer SET Status='32' 
		WHERE	CombatID=@pCombatID
		  AND	serverindex=@pserverindex
		  AND	GuildID=@pGuildID
		  AND	PlayerID=@pPlayerID
		  
		IF @@ROWCOUNT=0 BEGIN
			SELECT 9002 as retValue
			RETURN
		END
	END

	SELECT 1 as retValue

SET NOCOUNT OFF
GO
ALTER TABLE [dbo].[tblCouple_deleted] ADD  CONSTRAINT [DF_tblCouple_deleted_del_Date]  DEFAULT (getdate()) FOR [del_Date]
GO
ALTER TABLE [dbo].[tblCouple] ADD  CONSTRAINT [DF_tblCouple_add_Date]  DEFAULT (getdate()) FOR [add_Date]
GO
ALTER TABLE [dbo].[TAG_TBL] ADD  CONSTRAINT [DF_TAG_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[tblCombatInfo] ADD  CONSTRAINT [DF_tblCombatInfo_Comment]  DEFAULT ('') FOR [Comment]
GO
ALTER TABLE [dbo].[tblChangeBankPW] ADD  CONSTRAINT [DF_tblChangeBankPW_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblCampus] ADD  CONSTRAINT [DF_tblCampus_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[TBL_TOP_FAQ] ADD  CONSTRAINT [DF_TOP_FAQ_TBL_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_TOP_FAQ] ADD  CONSTRAINT [DF_TOP_FAQ_TBL_view_cnt]  DEFAULT ((0)) FOR [view_cnt]
GO
ALTER TABLE [dbo].[TBL_STAT_USER_CNT] ADD  CONSTRAINT [DF_LOG_STAT_USER_CNT_num]  DEFAULT ((0)) FOR [number]
GO
ALTER TABLE [dbo].[TBL_STAT_USER_CNT] ADD  CONSTRAINT [DF_LOG_STAT_USER_CNT_svr01]  DEFAULT ((0)) FOR [svr01]
GO
ALTER TABLE [dbo].[TBL_STAT_USER_CNT] ADD  CONSTRAINT [DF_TBL_STAT_USER_CNT_svr02]  DEFAULT ((0)) FOR [svr02]
GO
ALTER TABLE [dbo].[TBL_STAT_USER_CNT] ADD  CONSTRAINT [DF_TBL_STAT_USER_CNT_svr03]  DEFAULT ((0)) FOR [svr03]
GO
ALTER TABLE [dbo].[TBL_STAT_USER_CNT] ADD  CONSTRAINT [DF_TBL_STAT_USER_CNT_svr04]  DEFAULT ((0)) FOR [svr04]
GO
ALTER TABLE [dbo].[TBL_STAT_USER_CNT] ADD  CONSTRAINT [DF__TBL_STAT___svr05__1B7E091A]  DEFAULT ((0)) FOR [svr05]
GO
ALTER TABLE [dbo].[TBL_STAT_TOTAL_SEED] ADD  CONSTRAINT [DF_TBL_STAT_TOTAL_SEED_total_gold]  DEFAULT ((0)) FOR [total_gold]
GO
ALTER TABLE [dbo].[TBL_STAT_TOTAL_SEED] ADD  CONSTRAINT [DF_TBL_STAT_TOTAL_SEED_gold]  DEFAULT ((0)) FOR [gold]
GO
ALTER TABLE [dbo].[TBL_STAT_TOTAL_SEED] ADD  CONSTRAINT [DF_TBL_STAT_TOTAL_SEED_bank_gold]  DEFAULT ((0)) FOR [bank_gold]
GO
ALTER TABLE [dbo].[TBL_STAT_TOP_SEED] ADD  CONSTRAINT [DF_TBL_STAT_TOP_SEED_m_dwGold]  DEFAULT ((0)) FOR [m_dwGold]
GO
ALTER TABLE [dbo].[TBL_STAT_TOP_SEED] ADD  CONSTRAINT [DF_TBL_STAT_TOP_SEED_m_dwBank]  DEFAULT ((0)) FOR [m_dwBank]
GO
ALTER TABLE [dbo].[TBL_STAT_TOP_SEED] ADD  CONSTRAINT [DF_TBL_STAT_TOP_SEED_total_Gold]  DEFAULT ((0)) FOR [total_Gold]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_number]  DEFAULT ((0)) FOR [number]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_sex_1]  DEFAULT ((0)) FOR [sex_1]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_sex_2]  DEFAULT ((0)) FOR [sex_2]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_a_1]  DEFAULT ((0)) FOR [a_1]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_a_2]  DEFAULT ((0)) FOR [a_2]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_b_1]  DEFAULT ((0)) FOR [b_1]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_b_2]  DEFAULT ((0)) FOR [b_2]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_c_1]  DEFAULT ((0)) FOR [c_1]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_c_2]  DEFAULT ((0)) FOR [c_2]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_d_1]  DEFAULT ((0)) FOR [d_1]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_d_2]  DEFAULT ((0)) FOR [d_2]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_e_1]  DEFAULT ((0)) FOR [e_1]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_e_2]  DEFAULT ((0)) FOR [e_2]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_f_1]  DEFAULT ((0)) FOR [f_1]
GO
ALTER TABLE [dbo].[TBL_STAT_SECESSION] ADD  CONSTRAINT [DF_TBL_STAT_SECESSION_f_2]  DEFAULT ((0)) FOR [f_2]
GO
ALTER TABLE [dbo].[TBL_STAT_PLAY_TIME] ADD  CONSTRAINT [DF_TBL_STAT_PLAY_TIME_etc]  DEFAULT ((0)) FOR [etc]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_MANAGE] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_MANAGE_number]  DEFAULT ((0)) FOR [number]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_MANAGE] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_MANAGE_c01]  DEFAULT ((0)) FOR [c01]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_MANAGE] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_MANAGE_c02]  DEFAULT ((0)) FOR [c02]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_MANAGE] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_MANAGE_c03]  DEFAULT ((0)) FOR [c03]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_MANAGE] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_MANAGE_c04]  DEFAULT ((0)) FOR [c04]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_MANAGE] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_MANAGE_c05]  DEFAULT ((0)) FOR [c05]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_MANAGE] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_MANAGE_c06]  DEFAULT ((0)) FOR [c06]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_MANAGE] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_MANAGE_c07]  DEFAULT ((0)) FOR [c07]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_MANAGE] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_MANAGE_c08]  DEFAULT ((0)) FOR [c08]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_ACCEPT] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_ACCEPT_number]  DEFAULT ((0)) FOR [number]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_ACCEPT] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_ACCEPT_c01]  DEFAULT ((0)) FOR [c01]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_ACCEPT] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_ACCEPT_c02]  DEFAULT ((0)) FOR [c02]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_ACCEPT] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_ACCEPT_c03]  DEFAULT ((0)) FOR [c03]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_ACCEPT] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_ACCEPT_c04]  DEFAULT ((0)) FOR [c04]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_ACCEPT] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_ACCEPT_c05]  DEFAULT ((0)) FOR [c05]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_ACCEPT] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_ACCEPT_c06]  DEFAULT ((0)) FOR [c06]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_ACCEPT] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_ACCEPT_c07]  DEFAULT ((0)) FOR [c07]
GO
ALTER TABLE [dbo].[TBL_STAT_MAIL_ACCEPT] ADD  CONSTRAINT [DF_TBL_STAT_MAIL_ACCEPT_c08]  DEFAULT ((0)) FOR [c08]
GO
ALTER TABLE [dbo].[TBL_STAT_JOB_PLAY_TIME] ADD  CONSTRAINT [DF_TBL_STAT_JOB_PLAY_TIME_playtime]  DEFAULT ((0)) FOR [playtime]
GO
ALTER TABLE [dbo].[TBL_STAT_JOB] ADD  CONSTRAINT [DF_TBL_STAT_JOB_cnt]  DEFAULT ((0)) FOR [cnt]
GO
ALTER TABLE [dbo].[TBL_STAT_JOB] ADD  CONSTRAINT [DF_TBL_STAT_JOB_avg_level]  DEFAULT ((0)) FOR [level]
GO
ALTER TABLE [dbo].[TBL_SERVER_LIST] ADD  CONSTRAINT [DF_TBL_SERVER_LIST_cnt]  DEFAULT ((0)) FOR [cnt]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_MEN__Am__29CC2871]  DEFAULT ((0)) FOR [Am]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Am1__2AC04CAA]  DEFAULT ((0)) FOR [Am1]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Am2__2BB470E3]  DEFAULT ((0)) FOR [Am2]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Am3__2CA8951C]  DEFAULT ((0)) FOR [Am3]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Am4__2D9CB955]  DEFAULT ((0)) FOR [Am4]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Am5]  DEFAULT ((0)) FOR [Am5]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_MEN__Bm__2E90DD8E]  DEFAULT ((0)) FOR [Bm]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Bm1__2F8501C7]  DEFAULT ((0)) FOR [Bm1]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Bm2__30792600]  DEFAULT ((0)) FOR [Bm2]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Bm3__316D4A39]  DEFAULT ((0)) FOR [Bm3]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Bm4__32616E72]  DEFAULT ((0)) FOR [Bm4]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Bm5__335592AB]  DEFAULT ((0)) FOR [Bm5]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Bm6__3449B6E4]  DEFAULT ((0)) FOR [Bm6]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_MEN__Cm__353DDB1D]  DEFAULT ((0)) FOR [Cm]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Cm1__3631FF56]  DEFAULT ((0)) FOR [Cm1]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Cm2__3726238F]  DEFAULT ((0)) FOR [Cm2]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Cm3]  DEFAULT ((0)) FOR [Cm3]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Cm4]  DEFAULT ((0)) FOR [Cm4]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Cm5]  DEFAULT ((0)) FOR [Cm5]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Cm6]  DEFAULT ((0)) FOR [Cm6]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Cm7]  DEFAULT ((0)) FOR [Cm7]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Cm8]  DEFAULT ((0)) FOR [Cm8]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_MEN__Dm__381A47C8]  DEFAULT ((0)) FOR [Dm]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Dm1__390E6C01]  DEFAULT ((0)) FOR [Dm1]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Dm2__3A02903A]  DEFAULT ((0)) FOR [Dm2]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Dm3__3AF6B473]  DEFAULT ((0)) FOR [Dm3]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Dm4__3BEAD8AC]  DEFAULT ((0)) FOR [Dm4]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Dm5]  DEFAULT ((0)) FOR [Dm5]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Dm6]  DEFAULT ((0)) FOR [Dm6]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Dm7]  DEFAULT ((0)) FOR [Dm7]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Dm8]  DEFAULT ((0)) FOR [Dm8]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_MEN__Em__3CDEFCE5]  DEFAULT ((0)) FOR [Em]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Em1__3DD3211E]  DEFAULT ((0)) FOR [Em1]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Em11__3EC74557]  DEFAULT ((0)) FOR [Em11]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Em12__3FBB6990]  DEFAULT ((0)) FOR [Em12]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Em13__40AF8DC9]  DEFAULT ((0)) FOR [Em13]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Em14__41A3B202]  DEFAULT ((0)) FOR [Em14]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Em2__4297D63B]  DEFAULT ((0)) FOR [Em2]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Em21__438BFA74]  DEFAULT ((0)) FOR [Em21]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Em22__44801EAD]  DEFAULT ((0)) FOR [Em22]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Em23__457442E6]  DEFAULT ((0)) FOR [Em23]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Em24__4668671F]  DEFAULT ((0)) FOR [Em24]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Em25__475C8B58]  DEFAULT ((0)) FOR [Em25]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Em26__4850AF91]  DEFAULT ((0)) FOR [Em26]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_MEN__Fm__4944D3CA]  DEFAULT ((0)) FOR [Fm]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Fm1__4A38F803]  DEFAULT ((0)) FOR [Fm1]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm11__4B2D1C3C]  DEFAULT ((0)) FOR [Fm11]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm12__4C214075]  DEFAULT ((0)) FOR [Fm12]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm13__4D1564AE]  DEFAULT ((0)) FOR [Fm13]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm14__4E0988E7]  DEFAULT ((0)) FOR [Fm14]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm15__4EFDAD20]  DEFAULT ((0)) FOR [Fm15]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm16__4FF1D159]  DEFAULT ((0)) FOR [Fm16]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Fm2__50E5F592]  DEFAULT ((0)) FOR [Fm2]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm21__51DA19CB]  DEFAULT ((0)) FOR [Fm21]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm22__52CE3E04]  DEFAULT ((0)) FOR [Fm22]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Fm3__53C2623D]  DEFAULT ((0)) FOR [Fm3]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm31__54B68676]  DEFAULT ((0)) FOR [Fm31]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm32__55AAAAAF]  DEFAULT ((0)) FOR [Fm32]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm33__569ECEE8]  DEFAULT ((0)) FOR [Fm33]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Fm4__5792F321]  DEFAULT ((0)) FOR [Fm4]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm41__5887175A]  DEFAULT ((0)) FOR [Fm41]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm42__597B3B93]  DEFAULT ((0)) FOR [Fm42]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_M__Fm43__5A6F5FCC]  DEFAULT ((0)) FOR [Fm43]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_MEN__Gm__5B638405]  DEFAULT ((0)) FOR [Gm]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER_ME__Gm1__5C57A83E]  DEFAULT ((0)) FOR [Gm1]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Gm2]  DEFAULT ((0)) FOR [Gm2]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Hm]  DEFAULT ((0)) FOR [Hm]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Hm1]  DEFAULT ((0)) FOR [Hm1]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Hm2]  DEFAULT ((0)) FOR [Hm2]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Hm3]  DEFAULT ((0)) FOR [Hm3]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Im]  DEFAULT ((0)) FOR [Im]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Im1]  DEFAULT ((0)) FOR [Im1]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Im2]  DEFAULT ((0)) FOR [Im2]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Im3]  DEFAULT ((0)) FOR [Im3]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Im4]  DEFAULT ((0)) FOR [Im4]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Im5]  DEFAULT ((0)) FOR [Im5]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Im6]  DEFAULT ((0)) FOR [Im6]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Im7]  DEFAULT ((0)) FOR [Im7]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Im8]  DEFAULT ((0)) FOR [Im8]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF_TBL_OPER_MENU_Im9]  DEFAULT ((0)) FOR [Im9]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER___regid__5D4BCC77]  DEFAULT (getdate()) FOR [regidate]
GO
ALTER TABLE [dbo].[TBL_OPER_MENU] ADD  CONSTRAINT [DF__TBL_OPER___delch__5E3FF0B0]  DEFAULT ((0)) FOR [delchk]
GO
ALTER TABLE [dbo].[TBL_OPER_AUTH] ADD  CONSTRAINT [DF_TBL_OPER_AUTH_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_MAIL_TEMPLET] ADD  CONSTRAINT [DF_TBL_MAIL_TEMPLET_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_MAIL_TEMPLET] ADD  CONSTRAINT [DF_TBL_MAIL_TEMPLET_stat]  DEFAULT ('G') FOR [stat]
GO
ALTER TABLE [dbo].[TBL_MAIL_PAST] ADD  CONSTRAINT [DF_TBL_MAIL_PAST_var_data]  DEFAULT ('') FOR [var_data]
GO
ALTER TABLE [dbo].[TBL_MAIL_FORM] ADD  CONSTRAINT [DF_MAIL_FORM_TBL_code]  DEFAULT ('000000') FOR [code]
GO
ALTER TABLE [dbo].[TBL_MAIL_FORM] ADD  CONSTRAINT [DF_MAIL_FORM_TBL_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_MAIL_CUR] ADD  CONSTRAINT [DF_TBL_MAIL_CUR_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_MAIL_CUR] ADD  CONSTRAINT [DF_TBL_MAIL_CUR_stat]  DEFAULT ('S') FOR [stat]
GO
ALTER TABLE [dbo].[TBL_MAIL_CUR] ADD  CONSTRAINT [DF_TBL_MAIL_CUR_oper_id]  DEFAULT ('') FOR [oper_id]
GO
ALTER TABLE [dbo].[TBL_MAIL_CUR] ADD  CONSTRAINT [DF_TBL_MAIL_CUR_var_data]  DEFAULT ('') FOR [var_data]
GO
ALTER TABLE [dbo].[TBL_LOG_SECESSION_CHARACTER] ADD  CONSTRAINT [DF_TBL_LOG_RECOVERY_CHARACTER_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_LOG_SECESSION_ACCOUNT] ADD  CONSTRAINT [DF_TBL_LOG_SECESSION_ACCOUNT_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_LOG_REAL_NAME] ADD  CONSTRAINT [DF_LOG_REAL_NAME_code]  DEFAULT ('2') FOR [code]
GO
ALTER TABLE [dbo].[TBL_LOG_REAL_NAME] ADD  CONSTRAINT [DF_LOG_REAL_NAME_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_LOG_ITEM_SEND] ADD  CONSTRAINT [DF_TBL_LOG_ITEM_SEND_item_count]  DEFAULT ((1)) FOR [item_count]
GO
ALTER TABLE [dbo].[TBL_LOG_ITEM_SEND] ADD  CONSTRAINT [DF_TBL_LOG_ITEM_SEND_m_nResist]  DEFAULT ((0)) FOR [m_bItemResist]
GO
ALTER TABLE [dbo].[TBL_LOG_ITEM_SEND] ADD  CONSTRAINT [DF_TBL_LOG_ITEM_SEND_m_nResistAbilityOption]  DEFAULT ((0)) FOR [m_nResistAbilityOption]
GO
ALTER TABLE [dbo].[TBL_LOG_ITEM_SEND] ADD  CONSTRAINT [DF_TBL_LOG_ITEM_SEND_isEvent]  DEFAULT ('N') FOR [isEvent]
GO
ALTER TABLE [dbo].[TBL_LOG_ITEM_SEND] ADD  CONSTRAINT [DF_TBL_LOG_ITEM_SEND_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_LOG_ITEM_SEND] ADD  CONSTRAINT [DF_TBL_LOG_ITEM_SEND_cancel]  DEFAULT ('N') FOR [cancel]
GO
ALTER TABLE [dbo].[TBL_LOG_ITEM_REMOVE] ADD  CONSTRAINT [DF_TBL_LOG_ITEM_REMOVE_m_bItemResist]  DEFAULT ((0)) FOR [m_bItemResist]
GO
ALTER TABLE [dbo].[TBL_LOG_ITEM_REMOVE] ADD  CONSTRAINT [DF_TBL_LOG_ITEM_REMOVE_m_nResistAbilityOption]  DEFAULT ((0)) FOR [m_nResistAbilityOption]
GO
ALTER TABLE [dbo].[TBL_LOG_ITEM_REMOVE] ADD  CONSTRAINT [DF_TBL_ITEM_REMOVE_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_LOG_ITEM_REMOVE] ADD  CONSTRAINT [DF_TBL_LOG_ITEM_REMOVE_RandomOption]  DEFAULT ((0)) FOR [RandomOpt]
GO
ALTER TABLE [dbo].[TBL_LOG_BLOCK_ACCOUNT] ADD  CONSTRAINT [DF_TBL_LOG_BLOCK_ACCOUNT_start_day]  DEFAULT (getdate()) FOR [old_block_day]
GO
ALTER TABLE [dbo].[TBL_FAQ] ADD  CONSTRAINT [DF_FAQ_TBL_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_FAQ] ADD  CONSTRAINT [DF_FAQ_TBL_view_cnt]  DEFAULT ((0)) FOR [view_cnt]
GO
ALTER TABLE [dbo].[TBL_FAQ] ADD  CONSTRAINT [DF_FAQ_TBL_email_code]  DEFAULT ('000000') FOR [email_code]
GO
ALTER TABLE [dbo].[TBL_CODE_INI] ADD  CONSTRAINT [DF_TBL_CODE_INI_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_CODE_COMMON] ADD  CONSTRAINT [DF_TBL_CODE_COMMON_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_CODE_BLOCK] ADD  CONSTRAINT [DF_TBL_CODE_BLOCK_code3_1]  DEFAULT ('') FOR [code3_1]
GO
ALTER TABLE [dbo].[TBL_CODE_BLOCK] ADD  CONSTRAINT [DF_TBL_CODE_BLOCK_code3_2]  DEFAULT ('') FOR [code3_2]
GO
ALTER TABLE [dbo].[TBL_CODE_BLOCK] ADD  CONSTRAINT [DF_TBL_CODE_BLOCK_code3_3]  DEFAULT ('') FOR [code3_3]
GO
ALTER TABLE [dbo].[TBL_CODE_BLOCK] ADD  CONSTRAINT [DF_TBL_CODE_BLOCK_code3_4]  DEFAULT ('') FOR [code3_4]
GO
ALTER TABLE [dbo].[TBL_CODE_BLOCK] ADD  CONSTRAINT [DF_TBL_CODE_BLOCK_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[TBL_CODE] ADD  CONSTRAINT [DF_TBL_GAME_CODE_input_day]  DEFAULT (getdate()) FOR [input_day]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_tmCreate]  DEFAULT ((0)) FOR [tmCreate]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_byRead]  DEFAULT ((0)) FOR [byRead]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_ItemFlag]  DEFAULT ((0)) FOR [ItemFlag]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_GoldFag]  DEFAULT ((0)) FOR [GoldFlag]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__bPet__498EEC8D]  DEFAULT ((0)) FOR [bPet]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__nKind__4A8310C6]  DEFAULT ((0)) FOR [nKind]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__nLevel__4B7734FF]  DEFAULT ((0)) FOR [nLevel]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__dwExp__4C6B5938]  DEFAULT ((0)) FOR [dwExp]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__wEnerg__4D5F7D71]  DEFAULT ((0)) FOR [wEnergy]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__wLife__4E53A1AA]  DEFAULT ((0)) FOR [wLife]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__anAvai__4F47C5E3]  DEFAULT ((0)) FOR [anAvailLevel_D]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__anAvai__503BEA1C]  DEFAULT ((0)) FOR [anAvailLevel_C]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__anAvai__51300E55]  DEFAULT ((0)) FOR [anAvailLevel_B]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__anAvai__5224328E]  DEFAULT ((0)) FOR [anAvailLevel_A]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__anAvai__531856C7]  DEFAULT ((0)) FOR [anAvailLevel_S]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF__MAIL_TBL__dwItem__55009F39]  DEFAULT ((0)) FOR [dwItemId5]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_dwItemId6]  DEFAULT ((0)) FOR [dwItemId6]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_dwItemId7]  DEFAULT ((0)) FOR [dwItemId7]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_dwItemId8]  DEFAULT ((0)) FOR [dwItemId8]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_dwItemId9]  DEFAULT ((0)) FOR [dwItemId9]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_dwItemId10]  DEFAULT ((0)) FOR [dwItemId10]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_dwItemId11]  DEFAULT ((0)) FOR [dwItemId11]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_dwItemId12]  DEFAULT ((0)) FOR [dwItemId12]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_dwItemId13]  DEFAULT ((0)) FOR [dwItemId13]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_dwItemId14]  DEFAULT ((0)) FOR [dwItemId14]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_dwItemId15]  DEFAULT ((0)) FOR [dwItemId15]
GO
ALTER TABLE [dbo].[MAIL_TBL] ADD  CONSTRAINT [DF_MAIL_TBL_nPiercedSize2]  DEFAULT ((0)) FOR [nPiercedSize2]
GO
ALTER TABLE [dbo].[Event_20090604] ADD  CONSTRAINT [DF_Event_20090604_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_Item_count]  DEFAULT ((0)) FOR [Item_count]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_m_nAbilityOption]  DEFAULT ((0)) FOR [m_nAbilityOption]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND m_bItemResist]  DEFAULT ((0)) FOR [m_bItemResist]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_m_nResistAbilityOption]  DEFAULT ((0)) FOR [m_nResistAbilityOption]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_m_bCharged]  DEFAULT ((0)) FOR [m_bCharged]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_idRecvd]  DEFAULT ('000000') FOR [idSender]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_nPiercedSize]  DEFAULT ((0)) FOR [nPiercedSize]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwItemId0]  DEFAULT ((0)) FOR [adwItemId0]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwItemId1]  DEFAULT ((0)) FOR [adwItemId1]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwItemId2]  DEFAULT ((0)) FOR [adwItemId2]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwItemId3]  DEFAULT ((0)) FOR [adwItemId3]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_m_dwKeepTime]  DEFAULT ((0)) FOR [m_dwKeepTime]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_nRandomOptIOtemId]  DEFAULT ((0)) FOR [nRandomOptItemId]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_ItemFlag]  DEFAULT ((0)) FOR [ItemFlag]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_ReceiveDt]  DEFAULT (getdate()) FOR [ReceiveDt]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_SendComment]  DEFAULT ('') FOR [SendComment]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwItemId5]  DEFAULT ((0)) FOR [adwItemId5]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwItemId6]  DEFAULT ((0)) FOR [adwItemId6]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwItemId7]  DEFAULT ((0)) FOR [adwItemId7]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwItemId8]  DEFAULT ((0)) FOR [adwItemId8]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwItemId9]  DEFAULT ((0)) FOR [adwItemId9]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_nUMPiercedSize]  DEFAULT ((0)) FOR [nUMPiercedSize]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwUMItemId0]  DEFAULT ((0)) FOR [adwUMItemId0]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwUMItemId1]  DEFAULT ((0)) FOR [adwUMItemId1]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwUMItemId2]  DEFAULT ((0)) FOR [adwUMItemId2]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwUMItemId3]  DEFAULT ((0)) FOR [adwUMItemId3]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwUMItemId4]  DEFAULT ((0)) FOR [adwUMItemId4]
GO
ALTER TABLE [dbo].[ITEM_SEND_TBL] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_adwItemId4]  DEFAULT ((0)) FOR [adwItemId4]
GO
ALTER TABLE [dbo].[ITEM_REMOVE_TBL] ADD  CONSTRAINT [DF_ITEM_REMOVE_TBL_AbilityOpt]  DEFAULT ((0)) FOR [m_nAbilityOption]
GO
ALTER TABLE [dbo].[ITEM_REMOVE_TBL] ADD  CONSTRAINT [DF_ITEM_REMOVE_TBL_Item_count]  DEFAULT ((0)) FOR [Item_count]
GO
ALTER TABLE [dbo].[ITEM_REMOVE_TBL] ADD  CONSTRAINT [DF_ITEM_REMOVE_TBL_State]  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[ITEM_REMOVE_TBL] ADD  CONSTRAINT [DF_ITEM_REMOVE_TBL_End_Time]  DEFAULT ('') FOR [End_Time]
GO
ALTER TABLE [dbo].[ITEM_REMOVE_TBL] ADD  CONSTRAINT [DF_ITEM_REMOVE_TBL_m_bItemResist]  DEFAULT ('') FOR [m_bItemResist]
GO
ALTER TABLE [dbo].[ITEM_REMOVE_TBL] ADD  CONSTRAINT [DF_ITEM_REMOVE_TBL_m_nResistAbilityOption]  DEFAULT ('') FOR [m_nResistAbilityOption]
GO
ALTER TABLE [dbo].[ITEM_REMOVE_TBL] ADD  CONSTRAINT [DF_ITEM_REMOVE_TBL_ItemFlag]  DEFAULT ((0)) FOR [ItemFlag]
GO
ALTER TABLE [dbo].[ITEM_REMOVE_TBL] ADD  CONSTRAINT [DF_ITEM_REMOVE_TBL_ReceiveDt]  DEFAULT (getdate()) FOR [ReceiveDt]
GO
ALTER TABLE [dbo].[ITEM_REMOVE_TBL] ADD  CONSTRAINT [DF_ITEM_REMOVE_TBL_RequestUser]  DEFAULT ((0)) FOR [RequestUser]
GO
ALTER TABLE [dbo].[ITEM_REMOVE_TBL] ADD  CONSTRAINT [DF_ITEM_REMOVE_TBL_RandomOption]  DEFAULT ((0)) FOR [RandomOption]
GO
ALTER TABLE [dbo].[INVENTORY_EXT_TBL] ADD  CONSTRAINT [DF_INVENTORY_EXT_TBL_szInventoryPet]  DEFAULT ('$') FOR [szInventoryPet]
GO
ALTER TABLE [dbo].[GUILD_BANK_EXT_TBL] ADD  CONSTRAINT [DF_GUILD_BANK_EXT_TBL_szGuildBankPet]  DEFAULT ('$') FOR [szGuildBankPet]
GO
ALTER TABLE [dbo].[GUILD_COMBAT_1TO1_TENDER_TBL] ADD  CONSTRAINT [DF__GUILD_COM__m_nPe__7167D3BD]  DEFAULT ((0)) FOR [m_nPenya]
GO
ALTER TABLE [dbo].[GUILD_COMBAT_1TO1_TENDER_TBL] ADD  CONSTRAINT [DF__GUILD_COM__s_dat__725BF7F6]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[GUILD_COMBAT_1TO1_BATTLE_TBL] ADD  CONSTRAINT [DF__GUILD_COM__Start__74444068]  DEFAULT (getdate()) FOR [Start_Time]
GO
ALTER TABLE [dbo].[CHARACTER_TBL_validity_check] ADD  CONSTRAINT [DF_CHARACTER_TBL_validity_check_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[CHARACTER_TBL_penya_check] ADD  CONSTRAINT [DF_CHARACTER_TBL_penya_check_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[CHARACTER_TBL_DEL] ADD  CONSTRAINT [DF__CHARACTER__delda__3572E547]  DEFAULT (getdate()) FOR [deldate]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_TBL_m_nFuel]  DEFAULT ((-1)) FOR [m_nFuel]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF__CHARACTER__m_szN__2739D489]  DEFAULT ('' collate SQL_Latin1_General_Cp1_CI_AS) FOR [m_szNameCol]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_MultiServer]  DEFAULT ((0)) FOR [MultiServer]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_SkillPoint]  DEFAULT ((0)) FOR [SkillPoint]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_SkillLv]  DEFAULT ((0)) FOR [SkillLv]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_SkillExp]  DEFAULT ((0)) FOR [SkillExp]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_dwEventFlag]  DEFAULT ((0)) FOR [dwEventFlag]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_dwEventTime]  DEFAULT ((0)) FOR [dwEventTime]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_dwEventElapsed]  DEFAULT ((0)) FOR [dwEventElapsed]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_AngelExp]  DEFAULT ((0)) FOR [AngelExp]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_AngelLevel]  DEFAULT ((0)) FOR [AngelLevel]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_PKValue]  DEFAULT ((0)) FOR [PKValue]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_PKPropensity]  DEFAULT ((0)) FOR [PKPropensity]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_PKExp]  DEFAULT ((0)) FOR [PKExp]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF__CHARACTER__m_dwP__489AC854]  DEFAULT ((-1)) FOR [m_dwPetId]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF__CHARACTER__m_nEx__55F4C372]  DEFAULT ((0)) FOR [m_nExpLog]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF__CHARACTER__m_nAn__56E8E7AB]  DEFAULT ((0)) FOR [m_nAngelExpLog]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF__CHARACTER__m_nCo__607251E5]  DEFAULT ((0)) FOR [m_nCoupon]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_TBL_m_nLayer]  DEFAULT ((0)) FOR [m_nLayer]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_TBL_m_nHonor]  DEFAULT ((-1)) FOR [m_nHonor]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_TBL_m_aCheckedQuest]  DEFAULT ('$') FOR [m_aCheckedQuest]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_TBL_idCampus]  DEFAULT ((0)) FOR [idCampus]
GO
ALTER TABLE [dbo].[CHARACTER_TBL] ADD  CONSTRAINT [DF_CHARACTER_TBL_m_nCampusPoint]  DEFAULT ((0)) FOR [m_nCampusPoint]
GO
ALTER TABLE [dbo].[BANK_TBL] ADD  CONSTRAINT [DF_BANK_m_BankPw]  DEFAULT ('0000') FOR [m_BankPw]
GO
ALTER TABLE [dbo].[BANK_TBL] ADD  CONSTRAINT [DF_BANK_m_Bank]  DEFAULT ('$') FOR [m_Bank]
GO
ALTER TABLE [dbo].[BANK_TBL] ADD  CONSTRAINT [DF_BANK_m_apIndex_Bank]  DEFAULT ('$') FOR [m_apIndex_Bank]
GO
ALTER TABLE [dbo].[BANK_TBL] ADD  CONSTRAINT [DF_BANK_m_dwObjIndex_Bank]  DEFAULT ('$') FOR [m_dwObjIndex_Bank]
GO
ALTER TABLE [dbo].[BANK_TBL] ADD  CONSTRAINT [DF_BANK_m_dwGoldBank]  DEFAULT ((0)) FOR [m_dwGoldBank]
GO
ALTER TABLE [dbo].[_#tmpSendCheck] ADD  CONSTRAINT [DF___#tmpSend__sdate__5F5EFD72]  DEFAULT (getdate()) FOR [sdate]
GO
ALTER TABLE [dbo].[BANK_EXT_TBL] ADD  CONSTRAINT [DF_BANK_EXT_m_extBank]  DEFAULT ('$') FOR [m_extBank]
GO
ALTER TABLE [dbo].[BANK_EXT_TBL] ADD  CONSTRAINT [DF_BANK_EXT_m_BankPiercing]  DEFAULT ('$') FOR [m_BankPiercing]
GO
ALTER TABLE [dbo].[BANK_EXT_TBL] ADD  CONSTRAINT [DF_BANK_EXT_TBL_szBankPet]  DEFAULT ('$') FOR [szBankPet]
GO
ALTER TABLE [dbo].[TMP_SA] ADD  CONSTRAINT [DF_TMP_SA_n_1]  DEFAULT ((0)) FOR [n_1]
GO
ALTER TABLE [dbo].[TMP_SA] ADD  CONSTRAINT [DF_TMP_SA_n_2]  DEFAULT ((0)) FOR [n_2]
GO
ALTER TABLE [dbo].[tblRemoveItemFromGuildBank] ADD  CONSTRAINT [DF_tblRemoveItemFromGuildBank_ItemCnt]  DEFAULT ((0)) FOR [ItemCnt]
GO
ALTER TABLE [dbo].[tblRemoveItemFromGuildBank] ADD  CONSTRAINT [DF_tblRemoveItemFromGuildBank_DeleteRequestCnt]  DEFAULT ((0)) FOR [DeleteRequestCnt]
GO
ALTER TABLE [dbo].[tblRemoveItemFromGuildBank] ADD  CONSTRAINT [DF_tblRemoveItemFromGuildBank_DeleteCnt]  DEFAULT ((0)) FOR [DeleteCnt]
GO
ALTER TABLE [dbo].[tblRemoveItemFromGuildBank] ADD  CONSTRAINT [DF_tblRemoveItemFromGuildBank_ItemFlag]  DEFAULT ((0)) FOR [ItemFlag]
GO
ALTER TABLE [dbo].[tblRemoveItemFromGuildBank] ADD  CONSTRAINT [DF_tblRemoveItemFromGuildBank_RegisterDt]  DEFAULT (getdate()) FOR [RegisterDt]
GO
ALTER TABLE [dbo].[tblMessenger] ADD  CONSTRAINT [DF_tblMessenger_dwState]  DEFAULT ((0)) FOR [bBlock]
GO
ALTER TABLE [dbo].[tblMessenger] ADD  CONSTRAINT [DF_tblMessenger_chUse]  DEFAULT ('T') FOR [chUse]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c01]  DEFAULT ((0)) FOR [c01]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c02]  DEFAULT ((0)) FOR [c02]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c03]  DEFAULT ((0)) FOR [c03]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c04]  DEFAULT ((0)) FOR [c04]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c05]  DEFAULT ((0)) FOR [c05]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c06]  DEFAULT ((0)) FOR [c06]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c07]  DEFAULT ((0)) FOR [c07]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c08]  DEFAULT ((0)) FOR [c08]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c09]  DEFAULT ((0)) FOR [c09]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c10]  DEFAULT ((0)) FOR [c10]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c11]  DEFAULT ((0)) FOR [c11]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c12]  DEFAULT ((0)) FOR [c12]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c13]  DEFAULT ((0)) FOR [c13]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c14]  DEFAULT ((0)) FOR [c14]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c15]  DEFAULT ((0)) FOR [c15]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c16]  DEFAULT ((0)) FOR [c16]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c17]  DEFAULT ((0)) FOR [c17]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c18]  DEFAULT ((0)) FOR [c18]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c19]  DEFAULT ((0)) FOR [c19]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c20]  DEFAULT ((0)) FOR [c20]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c21]  DEFAULT ((0)) FOR [c21]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c22]  DEFAULT ((0)) FOR [c22]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c23]  DEFAULT ((0)) FOR [c23]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c24]  DEFAULT ((0)) FOR [c24]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c25]  DEFAULT ((0)) FOR [c25]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c26]  DEFAULT ((0)) FOR [c26]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c27]  DEFAULT ((0)) FOR [c27]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c28]  DEFAULT ((0)) FOR [c28]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c29]  DEFAULT ((0)) FOR [c29]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c30]  DEFAULT ((0)) FOR [c30]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c31]  DEFAULT ((0)) FOR [c31]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c32]  DEFAULT ((0)) FOR [c32]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c33]  DEFAULT ((0)) FOR [c33]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c34]  DEFAULT ((0)) FOR [c34]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c35]  DEFAULT ((0)) FOR [c35]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c36]  DEFAULT ((0)) FOR [c36]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c37]  DEFAULT ((0)) FOR [c37]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c38]  DEFAULT ((0)) FOR [c38]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c39]  DEFAULT ((0)) FOR [c39]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c40]  DEFAULT ((0)) FOR [c40]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c41]  DEFAULT ((0)) FOR [c41]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c42]  DEFAULT ((0)) FOR [c42]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c43]  DEFAULT ((0)) FOR [c43]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c44]  DEFAULT ((0)) FOR [c44]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c45]  DEFAULT ((0)) FOR [c45]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c46]  DEFAULT ((0)) FOR [c46]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c47]  DEFAULT ((0)) FOR [c47]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c48]  DEFAULT ((0)) FOR [c48]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c49]  DEFAULT ((0)) FOR [c49]
GO
ALTER TABLE [dbo].[tblMaster_all] ADD  CONSTRAINT [DF_tblMaster_all_c50]  DEFAULT ((0)) FOR [c50]
GO
ALTER TABLE [dbo].[tblLordSkill] ADD  CONSTRAINT [DF_tblLordSkill_nTick]  DEFAULT ((0)) FOR [nTick]
GO
ALTER TABLE [dbo].[tblLordSkill] ADD  CONSTRAINT [DF_tblLordSkill_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblLordEvent] ADD  CONSTRAINT [DF_tblLordEvent_nTick]  DEFAULT ((0)) FOR [nTick]
GO
ALTER TABLE [dbo].[tblLordEvent] ADD  CONSTRAINT [DF_tblLordEvent_fEFactor]  DEFAULT ((0.0)) FOR [fEFactor]
GO
ALTER TABLE [dbo].[tblLordEvent] ADD  CONSTRAINT [DF_tblLordEvent_fIFactor]  DEFAULT ((0.0)) FOR [fIFactor]
GO
ALTER TABLE [dbo].[tblLordEvent] ADD  CONSTRAINT [DF_tblLordEvent_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblLordElector] ADD  CONSTRAINT [DF_tblLordElector_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblLordElection] ADD  CONSTRAINT [DF_tblLordElection_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblLordCandidates] ADD  CONSTRAINT [DF_tblLordCandidates_iDeposit]  DEFAULT ((0)) FOR [iDeposit]
GO
ALTER TABLE [dbo].[tblLordCandidates] ADD  CONSTRAINT [DF_tblLordCandidates_nVote]  DEFAULT ((0)) FOR [nVote]
GO
ALTER TABLE [dbo].[tblLordCandidates] ADD  CONSTRAINT [DF_tblLordCandidates_szPledge]  DEFAULT ('') FOR [szPledge]
GO
ALTER TABLE [dbo].[tblLordCandidates] ADD  CONSTRAINT [DF_tblLordCandidates_IsLeftOut]  DEFAULT ('F') FOR [IsLeftOut]
GO
ALTER TABLE [dbo].[tblLordCandidates] ADD  CONSTRAINT [DF_tblLordCandidates_tCreate]  DEFAULT ((0)) FOR [tCreate]
GO
ALTER TABLE [dbo].[tblLordCandidates] ADD  CONSTRAINT [DF_tblLordCandidates_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblLord] ADD  CONSTRAINT [DF_tblLod_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblLogout_Penya_Diff_Log] ADD  CONSTRAINT [DF_tblLogout_Penya_Diff_Log_regdate]  DEFAULT (getdate()) FOR [regdate_now]
GO
ALTER TABLE [dbo].[tblLogout_Penya] ADD  CONSTRAINT [DF_tblLogout_Penya_m_dwGold]  DEFAULT ((0)) FOR [m_dwGold]
GO
ALTER TABLE [dbo].[tblLogout_Penya] ADD  CONSTRAINT [DF_tblLogout_Penya_regdate]  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[tblitem2row] ADD  CONSTRAINT [DF_tblitem2row_ItemResist]  DEFAULT ((0)) FOR [ItemResist]
GO
ALTER TABLE [dbo].[tblitem2row] ADD  CONSTRAINT [DF_tblitem2row_ResistAbilityOpt]  DEFAULT ((0)) FOR [ResistAbilityOpt]
GO
ALTER TABLE [dbo].[tblHousing] ADD  CONSTRAINT [DF_tblHousing_bSetup]  DEFAULT ((0)) FOR [bSetup]
GO
ALTER TABLE [dbo].[tblHousing] ADD  CONSTRAINT [DF_tblHousing_x_Pos]  DEFAULT ((0)) FOR [x_Pos]
GO
ALTER TABLE [dbo].[tblHousing] ADD  CONSTRAINT [DF_tblHousing_y_Pos]  DEFAULT ((0)) FOR [y_Pos]
GO
ALTER TABLE [dbo].[tblHousing] ADD  CONSTRAINT [DF_tblHousing_z_Pos]  DEFAULT ((0)) FOR [z_Pos]
GO
ALTER TABLE [dbo].[tblHousing] ADD  CONSTRAINT [DF_tblHousing_fAngle]  DEFAULT ((0)) FOR [fAngle]
GO
ALTER TABLE [dbo].[tblHousing] ADD  CONSTRAINT [DF_tblHousing_Start_Time]  DEFAULT (getdate()) FOR [Start_Time]
GO
ALTER TABLE [dbo].[tblGuildHouse_Furniture] ADD  CONSTRAINT [DF_tblGuildHoues_Furniture_tKeepTime]  DEFAULT ((0)) FOR [tKeepTime]
GO
ALTER TABLE [dbo].[tblGuildHouse_Furniture] ADD  CONSTRAINT [DF_tblGuildHoues_Furniture_bSetup]  DEFAULT ((0)) FOR [bSetup]
GO
ALTER TABLE [dbo].[tblGuildHouse_Furniture] ADD  CONSTRAINT [DF_tblGuildHoues_Furniture_x_Pos]  DEFAULT ((0)) FOR [x_pos]
GO
ALTER TABLE [dbo].[tblGuildHouse_Furniture] ADD  CONSTRAINT [DF_tblGuildHoues_Furniture_y_Pos]  DEFAULT ((0)) FOR [y_pos]
GO
ALTER TABLE [dbo].[tblGuildHouse_Furniture] ADD  CONSTRAINT [DF_tblGuildHoues_Furniture_z_Pos]  DEFAULT ((0)) FOR [z_pos]
GO
ALTER TABLE [dbo].[tblGuildHouse_Furniture] ADD  CONSTRAINT [DF_tblGuildHoues_Furniture_fAngle]  DEFAULT ((0)) FOR [fAngle]
GO
ALTER TABLE [dbo].[tblFunnyCoin] ADD  CONSTRAINT [DF_tblFunnyCoin_ItemFlag]  DEFAULT ((0)) FOR [ItemFlag]
GO
ALTER TABLE [dbo].[tblEvent_Board_Provide] ADD  DEFAULT (getdate()) FOR [regdate]
GO
ALTER TABLE [dbo].[tblElection] ADD  CONSTRAINT [DF_tblElection_chrcount]  DEFAULT ((0)) FOR [chrcount]
GO
ALTER TABLE [dbo].[tblCampusMember] ADD  CONSTRAINT [DF_tblCampusMember_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[tblCombatJoinGuild] ADD  CONSTRAINT [DF_tblCombatJoinGuild_StraightWin]  DEFAULT ((0)) FOR [StraightWin]
GO
ALTER TABLE [dbo].[tblCombatJoinPlayer] ADD  CONSTRAINT [DF_tblCombatJoinPlayer_Status]  DEFAULT ('30') FOR [Status]
GO
ALTER TABLE [dbo].[tblCombatJoinPlayer] ADD  CONSTRAINT [DF_tblCombatJoinPlayer_Point]  DEFAULT ((0)) FOR [Point]
GO
ALTER TABLE [dbo].[tblCombatJoinPlayer] ADD  CONSTRAINT [DF_tblCombatJoinPlayer_Reward]  DEFAULT ((0)) FOR [Reward]
GO
ALTER TABLE [dbo].[tblCouplePlayer]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCouplePlayer] FOREIGN KEY([cid], [nServer])
REFERENCES [dbo].[tblCouple] ([cid], [nServer])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblCouplePlayer] CHECK CONSTRAINT [FK_tblCouplePlayer]
GO
ALTER TABLE [dbo].[tblCampusMember]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCampusMember_tblCampus] FOREIGN KEY([idCampus], [serverindex])
REFERENCES [dbo].[tblCampus] ([idCampus], [serverindex])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblCampusMember] CHECK CONSTRAINT [FK_tblCampusMember_tblCampus]
GO
ALTER TABLE [dbo].[tblCombatJoinGuild]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCombatJoinGuild] FOREIGN KEY([CombatID], [serverindex])
REFERENCES [dbo].[tblCombatInfo] ([CombatID], [serverindex])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tblCombatJoinGuild] CHECK CONSTRAINT [FK_tblCombatJoinGuild]
GO
ALTER TABLE [dbo].[tblCombatJoinPlayer]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCombatJoinPlayer] FOREIGN KEY([CombatID], [serverindex], [GuildID])
REFERENCES [dbo].[tblCombatJoinGuild] ([CombatID], [serverindex], [GuildID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tblCombatJoinPlayer] CHECK CONSTRAINT [FK_tblCombatJoinPlayer]
GO
-- End CHARACTER_01_DBF creation

-- Start LOGGING_01_DBF creation
USE [master]
GO
CREATE DATABASE [LOGGING_01_DBF] --ON  PRIMARY 
--( NAME = N'LOGGING_01_DBF', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL\MSSQL\DATA\LOGGING_01_DBF.mdf' , SIZE = 6336KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
-- LOG ON 
--( NAME = N'LOGGING_01_DBF_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL\MSSQL\DATA\LOGGING_01_DBF_1.LDF' , SIZE = 6400KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'LOGGING_01_DBF', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LOGGING_01_DBF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LOGGING_01_DBF] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET ANSI_NULLS OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET ANSI_PADDING OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET ARITHABORT OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [LOGGING_01_DBF] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [LOGGING_01_DBF] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [LOGGING_01_DBF] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET  DISABLE_BROKER
GO
ALTER DATABASE [LOGGING_01_DBF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [LOGGING_01_DBF] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [LOGGING_01_DBF] SET  READ_WRITE
GO
ALTER DATABASE [LOGGING_01_DBF] SET RECOVERY SIMPLE
GO
ALTER DATABASE [LOGGING_01_DBF] SET  MULTI_USER
GO
ALTER DATABASE [LOGGING_01_DBF] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [LOGGING_01_DBF] SET DB_CHAINING OFF
GO
USE [LOGGING_01_DBF]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_DEATH_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[dwWorldID] [int] NULL,
	[killed_m_szName] [varchar](32) NULL,
	[m_vPos_x] [real] NULL,
	[m_vPos_y] [real] NULL,
	[m_vPos_z] [real] NULL,
	[m_nLevel] [int] NULL,
	[attackPower] [int] NULL,
	[max_HP] [int] NULL,
	[s_date] [char](14) NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_CHARACTER_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[account] [varchar](32) NULL,
	[m_szName] [varchar](32) NULL,
	[CreateTime] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_BILLING_ITEM_TBL](
	[m_szName] [varchar](32) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_GetszName] [varchar](32) NULL,
	[dwWorldID] [int] NULL,
	[m_dwGold] [int] NULL,
	[m_nRemainGold] [int] NULL,
	[Item_UniqueNo] [int] NULL,
	[Item_Name] [varchar](32) NULL,
	[Item_durability] [int] NULL,
	[m_nAbilityOption] [int] NULL,
	[m_GetdwGold] [int] NULL,
	[Item_count] [int] NULL,
	[State] [char](1) NULL,
	[s_date] [char](14) NULL,
	[m_nSlot0] [int] NULL,
	[m_nSlot1] [int] NULL,
	[m_bItemResist] [int] NULL,
	[m_nResistAbilityOption] [int] NULL,
	[m_bCharged] [int] NULL,
	[m_dwKeepTime] [int] NULL,
	[m_nRandomOptItemId] [bigint] NULL,
	[nPiercedSize] [int] NULL,
	[adwItemId0] [int] NULL,
	[adwItemId1] [int] NULL,
	[adwItemId2] [int] NULL,
	[adwItemId3] [int] NULL,
	[MaxDurability] [int] NULL,
	[adwItemId4] [int] NULL,
	[nPetKind] [int] NULL,
	[nPetLevel] [int] NULL,
	[dwPetExp] [int] NULL,
	[wPetEnergy] [int] NULL,
	[wPetLife] [int] NULL,
	[nPetAL_D] [int] NULL,
	[nPetAL_C] [int] NULL,
	[nPetAL_B] [int] NULL,
	[nPetAL_A] [int] NULL,
	[nPetAL_S] [int] NULL,
	[adwItemId5] [int] NULL,
	[adwItemId6] [int] NULL,
	[adwItemId7] [int] NULL,
	[adwItemId8] [int] NULL,
	[adwItemId9] [int] NULL,
	[nUMPiercedSize] [int] NULL,
	[adwUMItemId0] [int] NULL,
	[adwUMItemId1] [int] NULL,
	[adwUMItemId2] [int] NULL,
	[adwUMItemId3] [int] NULL,
	[adwUMItemId4] [int] NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE	 function  [dbo].[gethmstime]
( 
		 @date		int
)  
returns varchar(50)
as

begin

declare @c_date varchar(50)
	select @c_date = RIGHT('00' + convert(varchar(44),@date / 3600),2) + ':' + right('00' + convert(varchar(2),(@date % 3600) / 60),2) + ':'  +  right('00' + convert(varchar(2),@date % 60),2)  
	return @c_date 
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE	 function  [dbo].[getdatetime]
( 
		 @s_date		varchar(14)
)  
returns datetime
as

begin

declare @c_date datetime

	select @c_date = convert(datetime,substring(@s_date,1,4) + '-' +  substring(@s_date,5,2) + '-' +  substring(@s_date,7,2) + ' ' 
							  +  substring(@s_date,9,2) + ':' +  substring(@s_date,11,2) + ':' +  CASE substring(@s_date,13,2) WHEN '' THEN '00' ELSE substring(@s_date,13,2) END  + '.000' )
	return @c_date 
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHARACTER_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[account] [varchar](32) NULL,
	[m_szName] [varchar](32) NULL,
	[isblock] [char](1) NULL,
	[m_nLevel] [int] NULL,
	[m_nJob] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_GUILD_SERVICE_TBL](
	[m_idGuild] [char](6) NOT NULL,
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[m_nLevel] [int] NULL,
	[m_GuildLv] [int] NULL,
	[GuildPoint] [int] NULL,
	[Gold] [int] NULL,
	[State] [char](1) NULL,
	[s_date] [char](14) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_GUILD_DISPERSION_TBL](
	[m_idGuild] [char](6) NOT NULL,
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[State] [char](1) NULL,
	[s_date] [char](14) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_GUILD_BANK_TBL](
	[m_idGuild] [char](6) NOT NULL,
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[m_nGuildGold] [int] NULL,
	[m_GuildBank] [text] NULL,
	[m_Item] [int] NULL,
	[State] [char](1) NULL,
	[s_date] [char](14) NULL,
	[m_nAbilityOption] [int] NULL,
	[Item_count] [int] NULL,
	[Item_UniqueNo] [int] NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_GAMEMASTER_TBL](
	[serverindex] [char](2) NOT NULL,
	[m_idPlayer] [char](7) NULL,
	[m_szWords] [char](1030) NULL,
	[s_date] [char](14) NULL,
	[m_idGuild] [char](6) NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_SKILL_FREQUENCY_TBL](
	[m_nid] [int] NULL,
	[m_nFrequency] [int] NULL,
	[s_date] [char](14) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_RESPAWN_TBL](
	[m_nid] [int] NULL,
	[m_nFrequency] [int] NULL,
	[s_date] [char](14) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[LOG_RESET_STR]
AS
DECLARE @name varchar(128)
DECLARE LogReset_Cursor CURSOR FOR 
SELECT name 
   FROM sysobjects 
 WHERE  type= 'U'
      AND category = 0 
  ORDER BY name

OPEN LogReset_Cursor

FETCH NEXT FROM LogReset_Cursor 
INTO @name

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT 'DELETE ' + @name
	EXEC('DELETE ' + @name)
   FETCH NEXT FROM LogReset_Cursor 
   INTO @name
END

CLOSE LogReset_Cursor
DEALLOCATE LogReset_Cursor
RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_QUEST_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[Quest_Index] [int] NULL,
	[State] [char](1) NULL,
	[Start_Time] [char](14) NULL,
	[End_Time] [char](14) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_PK_PVP_TBL](
	[serverindex] [char](2) NOT NULL,
	[m_idPlayer] [char](7) NULL,
	[m_nLevel] [int] NULL,
	[m_vPos_x] [real] NULL,
	[m_vPos_z] [real] NULL,
	[killed_m_idPlayer] [char](7) NULL,
	[killed_m_nLevel] [int] NULL,
	[m_GetPoint] [int] NULL,
	[m_nSlaughter] [int] NULL,
	[m_nFame] [int] NULL,
	[killed_m_nSlaughter] [int] NULL,
	[killed_m_nFame] [int] NULL,
	[m_KillNum] [int] NULL,
	[State] [char](1) NULL,
	[s_date] [char](14) NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_LOGIN_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[dwWorldID] [int] NULL,
	[Start_Time] [char](14) NULL,
	[End_Time] [char](14) NULL,
	[TotalPlayTime] [int] NULL,
	[m_dwGold] [int] NULL,
	[remoteIP] [varchar](15) NULL,
	[account] [varchar](32) NULL,
	[CharLevel] [int] NULL,
	[Job] [int] NULL,
	[State] [tinyint] NOT NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_LEVELUP_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[m_nExp1] [bigint] NULL,
	[m_nLevel] [int] NULL,
	[m_nJob] [int] NULL,
	[m_nJobLv] [int] NULL,
	[m_nFlightLv] [int] NULL,
	[m_nStr] [int] NULL,
	[m_nDex] [int] NULL,
	[m_nInt] [int] NULL,
	[m_nSta] [int] NULL,
	[m_nRemainGP] [int] NULL,
	[m_nRemainLP] [int] NULL,
	[m_dwGold] [int] NULL,
	[TotalPlayTime] [int] NULL,
	[State] [char](1) NULL,
	[s_date] [char](14) NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_ITEM_TBL](
	[m_szName] [varchar](32) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_GetszName] [varchar](32) NULL,
	[dwWorldID] [int] NULL,
	[m_dwGold] [int] NULL,
	[m_nRemainGold] [int] NULL,
	[Item_UniqueNo] [int] NULL,
	[Item_Name] [varchar](32) NULL,
	[Item_durability] [int] NULL,
	[m_nAbilityOption] [int] NULL,
	[m_GetdwGold] [int] NULL,
	[Item_count] [int] NULL,
	[State] [char](1) NULL,
	[s_date] [char](14) NULL,
	[m_nSlot0] [int] NULL,
	[m_nSlot1] [int] NULL,
	[m_bItemResist] [int] NULL,
	[m_nResistAbilityOption] [int] NULL,
	[m_bCharged] [int] NULL,
	[m_dwKeepTime] [int] NULL,
	[m_nRandomOptItemId] [bigint] NULL,
	[nPiercedSize] [int] NULL,
	[adwItemId0] [int] NULL,
	[adwItemId1] [int] NULL,
	[adwItemId2] [int] NULL,
	[adwItemId3] [int] NULL,
	[MaxDurability] [int] NULL,
	[adwItemId4] [int] NULL,
	[nPetKind] [int] NULL,
	[nPetLevel] [int] NULL,
	[dwPetExp] [int] NULL,
	[wPetEnergy] [int] NULL,
	[wPetLife] [int] NULL,
	[nPetAL_D] [int] NULL,
	[nPetAL_C] [int] NULL,
	[nPetAL_B] [int] NULL,
	[nPetAL_A] [int] NULL,
	[nPetAL_S] [int] NULL,
	[adwItemId5] [int] NULL,
	[adwItemId6] [int] NULL,
	[adwItemId7] [int] NULL,
	[adwItemId8] [int] NULL,
	[adwItemId9] [int] NULL,
	[nUMPiercedSize] [int] NULL,
	[adwUMItemId0] [int] NULL,
	[adwUMItemId1] [int] NULL,
	[adwUMItemId2] [int] NULL,
	[adwUMItemId3] [int] NULL,
	[adwUMItemId4] [int] NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTradeLog](
	[TradeID] [int] NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[WorldID] [int] NOT NULL,
	[TradeDt] [datetime] NOT NULL,
 CONSTRAINT [PK_tblTradeLog] PRIMARY KEY CLUSTERED 
(
	[TradeID] ASC,
	[serverindex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTradeItemLog](
	[TradeID] [int] NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[idPlayer] [char](7) NOT NULL,
	[ItemIndex] [int] NOT NULL,
	[ItemSerialNum] [int] NOT NULL,
	[ItemCnt] [int] NOT NULL,
	[AbilityOpt] [int] NOT NULL,
	[ItemResist] [int] NOT NULL,
	[ResistAbilityOpt] [int] NOT NULL,
	[RandomOpt] [int] NOT NULL,
 CONSTRAINT [PK_tblTradeItemLog] PRIMARY KEY CLUSTERED 
(
	[TradeID] ASC,
	[serverindex] ASC,
	[idPlayer] ASC,
	[ItemIndex] ASC,
	[ItemSerialNum] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTradeDetailLog](
	[TradeID] [int] NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[idPlayer] [char](7) NOT NULL,
	[Job] [int] NOT NULL,
	[Level] [int] NOT NULL,
	[TradeGold] [bigint] NOT NULL,
	[PlayerIP] [varchar](15) NOT NULL,
 CONSTRAINT [PK_tblTradeDetailLog] PRIMARY KEY CLUSTERED 
(
	[TradeID] ASC,
	[serverindex] ASC,
	[idPlayer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblSystemErrorLog](
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL,
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NULL,
	[account] [varchar](32) NULL,
	[nChannel] [int] NULL,
	[chType] [char](1) NULL,
	[szError] [varchar](1024) NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sequence Number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSystemErrorLog', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플레이어 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSystemErrorLog', @level2type=N'COLUMN',@level2name=N'm_idPlayer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSystemErrorLog', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플레이어 계정' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSystemErrorLog', @level2type=N'COLUMN',@level2name=N'account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'체널 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSystemErrorLog', @level2type=N'COLUMN',@level2name=N'nChannel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'에러 타입' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSystemErrorLog', @level2type=N'COLUMN',@level2name=N'chType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'에러 내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSystemErrorLog', @level2type=N'COLUMN',@level2name=N'szError'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입력된 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSystemErrorLog', @level2type=N'COLUMN',@level2name=N's_date'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblSkillPointLog](
	[serverindex] [char](2) NULL,
	[PlayerID] [char](7) NULL,
	[SkillID] [int] NULL,
	[SkillLevel] [int] NULL,
	[SkillPoint] [int] NULL,
	[HoldingSkillPoint] [int] NULL,
	[TotalSkillPoint] [int] NULL,
	[SkillExp] [bigint] NULL,
	[UsingBy] [int] NULL,
	[ActionDt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblQuizUserLog](
	[SEQ] [int] IDENTITY(1,1) NOT NULL,
	[m_idQuizEvent] [int] NOT NULL,
	[m_idPlayer] [char](7) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_nChannel] [int] NOT NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEQ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizUserLog', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀴즈이벤트 회차' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizUserLog', @level2type=N'COLUMN',@level2name=N'm_idQuizEvent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플레이어 아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizUserLog', @level2type=N'COLUMN',@level2name=N'm_idPlayer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizUserLog', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군 상세체널' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizUserLog', @level2type=N'COLUMN',@level2name=N'm_nChannel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입력된 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizUserLog', @level2type=N'COLUMN',@level2name=N's_date'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblQuizLog](
	[SEQ] [int] IDENTITY(1,1) NOT NULL,
	[m_idQuizEvent] [int] NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_nChannel] [int] NOT NULL,
	[m_nQuizType] [int] NOT NULL,
	[Start_Time] [datetime] NOT NULL,
	[End_Time] [datetime] NULL,
	[m_nWinnerCount] [int] NULL,
	[m_nQuizCount] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEQ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizLog', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀴즈이벤트 회차' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizLog', @level2type=N'COLUMN',@level2name=N'm_idQuizEvent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizLog', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군 상세채널' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizLog', @level2type=N'COLUMN',@level2name=N'm_nChannel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀴즈 타입 (OX : 1, 객관식 : 2)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizLog', @level2type=N'COLUMN',@level2name=N'm_nQuizType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀴즈 이벤트 시작 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizLog', @level2type=N'COLUMN',@level2name=N'Start_Time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀴즈 이벤트 종료 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizLog', @level2type=N'COLUMN',@level2name=N'End_Time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'우승자 수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizLog', @level2type=N'COLUMN',@level2name=N'm_nWinnerCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'풀이한 총 문제 수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizLog', @level2type=N'COLUMN',@level2name=N'm_nQuizCount'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblQuizAnswerLog](
	[SEQ] [int] IDENTITY(1,1) NOT NULL,
	[m_idQuizEvent] [int] NOT NULL,
	[m_idPlayer] [char](7) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_nChannel] [int] NOT NULL,
	[m_nQuizNum] [int] NOT NULL,
	[m_nSelect] [int] NULL,
	[m_nAnswer] [int] NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEQ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswerLog', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀴즈이벤트회차' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswerLog', @level2type=N'COLUMN',@level2name=N'm_idQuizEvent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플레이어 아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswerLog', @level2type=N'COLUMN',@level2name=N'm_idPlayer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군 상세체널' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswerLog', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군 상세체널' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswerLog', @level2type=N'COLUMN',@level2name=N'm_nChannel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문제의 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswerLog', @level2type=N'COLUMN',@level2name=N'm_nQuizNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저가 선택한 문제의 보기' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswerLog', @level2type=N'COLUMN',@level2name=N'm_nSelect'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'문제의 정답' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswerLog', @level2type=N'COLUMN',@level2name=N'm_nAnswer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입력된 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblQuizAnswerLog', @level2type=N'COLUMN',@level2name=N's_date'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblQuestLog](
	[serverindex] [char](2) NOT NULL,
	[idPlayer] [char](7) NULL,
	[QuestIndex] [int] NOT NULL,
	[State] [varchar](3) NOT NULL,
	[LogDt] [datetime] NOT NULL,
	[Comment] [varchar](20) NOT NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPetLog](
	[serverindex] [char](2) NOT NULL,
	[idPlayer] [char](7) NOT NULL,
	[iSerial] [bigint] NOT NULL,
	[nType] [int] NOT NULL,
	[dwData] [int] NOT NULL,
	[nKind] [int] NOT NULL,
	[nLevel] [int] NOT NULL,
	[wLife] [int] NOT NULL,
	[wEnergy] [int] NOT NULL,
	[dwExp] [int] NOT NULL,
	[nAvailParam1] [int] NOT NULL,
	[nAvailParam2] [int] NOT NULL,
	[nAvailParam3] [int] NOT NULL,
	[nAvailParam4] [int] NOT NULL,
	[nAvailParam5] [int] NOT NULL,
	[LogDt] [datetime] NOT NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLogExpBox](
	[serverindex] [char](2) NULL,
	[idPlayer] [char](7) NULL,
	[objid] [bigint] NOT NULL,
	[iExp] [bigint] NOT NULL,
	[State] [char](1) NULL,
	[s_date] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblGuildHouseLog](
	[SEQ] [int] IDENTITY(1,1) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_idGuild] [char](6) NOT NULL,
	[dwWorldID] [int] NULL,
	[tKeepTime] [int] NOT NULL,
	[m_szGuild] [varchar](32) NULL,
	[s_date] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouseLog', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouseLog', @level2type=N'COLUMN',@level2name=N'm_idGuild'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'월드 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouseLog', @level2type=N'COLUMN',@level2name=N'dwWorldID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 하우스 자체 유지시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouseLog', @level2type=N'COLUMN',@level2name=N'tKeepTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouseLog', @level2type=N'COLUMN',@level2name=N'm_szGuild'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생성시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouseLog', @level2type=N'COLUMN',@level2name=N's_date'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblGuildHouse_FurnitureLog](
	[serverindex] [char](2) NOT NULL,
	[m_idGuild] [char](6) NOT NULL,
	[SEQ] [int] NOT NULL,
	[ItemIndex] [int] NULL,
	[bSetup] [int] NULL,
	[Del_date] [datetime] NULL,
	[s_date] [datetime] NULL,
	[set_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_FurnitureLog', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_FurnitureLog', @level2type=N'COLUMN',@level2name=N'm_idGuild'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시퀸스 넘버' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_FurnitureLog', @level2type=N'COLUMN',@level2name=N'SEQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용 ITEM ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_FurnitureLog', @level2type=N'COLUMN',@level2name=N'ItemIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 설치 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_FurnitureLog', @level2type=N'COLUMN',@level2name=N'bSetup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 삭제시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_FurnitureLog', @level2type=N'COLUMN',@level2name=N'Del_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 사용시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_FurnitureLog', @level2type=N'COLUMN',@level2name=N's_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 최초 설치 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblGuildHouse_FurnitureLog', @level2type=N'COLUMN',@level2name=N'set_date'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblChangeNameLog](
	[ChangeID] [int] IDENTITY(1,1) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[StartDt] [datetime] NOT NULL,
	[EndDt] [datetime] NOT NULL,
	[idPlayer] [char](7) NULL,
	[CharName] [varchar](32) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblChangeNameHistoryLog](
	[serverindex] [char](2) NOT NULL,
	[idPlayer] [char](7) NULL,
	[OldCharName] [varchar](32) NOT NULL,
	[NewCharName] [varchar](32) NOT NULL,
	[ChangeDt] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCampusLog](
	[SEQ] [int] IDENTITY(1,1) NOT NULL,
	[m_idMaster] [char](7) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_idPupil] [char](7) NULL,
	[idCampus] [int] NULL,
	[chState] [char](1) NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'스승 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampusLog', @level2type=N'COLUMN',@level2name=N'm_idMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampusLog', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제자 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampusLog', @level2type=N'COLUMN',@level2name=N'm_idPupil'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사제 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampusLog', @level2type=N'COLUMN',@level2name=N'idCampus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태값 (T: 맺음, F: 끊음)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampusLog', @level2type=N'COLUMN',@level2name=N'chState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입력된 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampusLog', @level2type=N'COLUMN',@level2name=N's_date'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCampus_PointLog](
	[SEQ] [int] IDENTITY(1,1) NOT NULL,
	[m_idPlayer] [char](7) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[chState] [char](1) NULL,
	[nPrevPoint] [int] NULL,
	[nCurrPoint] [int] NULL,
	[s_date] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플레이어 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampus_PointLog', @level2type=N'COLUMN',@level2name=N'm_idPlayer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버군' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampus_PointLog', @level2type=N'COLUMN',@level2name=N'serverindex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태값 (Q: 퀘스트, P: 플레이어)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampus_PointLog', @level2type=N'COLUMN',@level2name=N'chState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'변경 전 사제 포인트' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampus_PointLog', @level2type=N'COLUMN',@level2name=N'nPrevPoint'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'변경 후 사제 포인트(현재포인트)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampus_PointLog', @level2type=N'COLUMN',@level2name=N'nCurrPoint'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입력된 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblCampus_PointLog', @level2type=N'COLUMN',@level2name=N's_date'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_USER_CNT_TBL](
	[serverindex] [char](2) NOT NULL,
	[s_date] [char](14) NULL,
	[number] [int] NULL,
	[m_01] [int] NULL,
	[m_02] [int] NULL,
	[m_03] [int] NULL,
	[m_04] [int] NULL,
	[m_05] [int] NULL,
	[m_06] [int] NULL,
	[m_07] [int] NULL,
	[m_08] [int] NULL,
	[m_09] [int] NULL,
	[m_10] [int] NULL,
	[m_11] [int] NULL,
	[m_12] [int] NULL,
	[m_13] [int] NULL,
	[m_14] [int] NULL,
	[m_15] [int] NULL,
	[m_16] [int] NULL,
	[m_17] [int] NULL,
	[m_18] [int] NULL,
	[m_19] [int] NULL,
	[m_20] [int] NULL,
	[m_channel] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_ITEM_SEND_TBL](
	[serverindex] [char](2) NOT NULL,
	[m_idPlayer] [char](7) NULL,
	[m_nNo] [int] NULL,
	[m_szItemName] [varchar](32) NULL,
	[m_nItemNum] [int] NULL,
	[s_date] [char](14) NULL,
	[m_bItemResist] [int] NULL,
	[m_nResistAbilityOption] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_ITEM_REMOVE_TBL](
	[serverindex] [char](2) NOT NULL,
	[m_idPlayer] [char](7) NULL,
	[m_nNo] [int] NULL,
	[m_szItemName] [varchar](32) NULL,
	[m_nItemNum] [int] NULL,
	[s_date] [char](14) NULL,
	[m_bItemResist] [int] NULL,
	[m_nResistAbilityOption] [int] NULL,
	[RandomOption] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_ITEM_EVENT_TBL](
	[m_szName] [varchar](32) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_GetszName] [varchar](32) NULL,
	[dwWorldID] [int] NULL,
	[m_dwGold] [int] NULL,
	[m_nRemainGold] [int] NULL,
	[Item_UniqueNo] [int] NULL,
	[Item_Name] [varchar](32) NULL,
	[Item_durability] [int] NULL,
	[m_nAbilityOption] [int] NULL,
	[m_GetdwGold] [int] NULL,
	[Item_count] [int] NULL,
	[State] [char](1) NULL,
	[s_date] [char](14) NULL,
	[m_nSlot0] [int] NULL,
	[m_nSlot1] [int] NULL,
	[m_bItemResist] [int] NULL,
	[m_nResistAbilityOption] [int] NULL,
	[m_bCharged] [int] NULL,
	[m_dwKeepTime] [int] NULL,
	[m_nRandomOptItemId] [bigint] NULL,
	[nPiercedSize] [int] NULL,
	[adwItemId0] [int] NULL,
	[adwItemId1] [int] NULL,
	[adwItemId2] [int] NULL,
	[adwItemId3] [int] NULL,
	[MaxDurability] [int] NULL,
	[adwItemId4] [int] NULL,
	[nPetKind] [int] NULL,
	[nPetLevel] [int] NULL,
	[dwPetExp] [int] NULL,
	[wPetEnergy] [int] NULL,
	[wPetLife] [int] NULL,
	[nPetAL_D] [int] NULL,
	[nPetAL_C] [int] NULL,
	[nPetAL_B] [int] NULL,
	[nPetAL_A] [int] NULL,
	[nPetAL_S] [int] NULL,
	[adwItemId5] [int] NULL,
	[adwItemId6] [int] NULL,
	[adwItemId7] [int] NULL,
	[adwItemId8] [int] NULL,
	[adwItemId9] [int] NULL,
	[nUMPiercedSize] [int] NULL,
	[adwUMItemId0] [int] NULL,
	[adwUMItemId1] [int] NULL,
	[adwUMItemId2] [int] NULL,
	[adwUMItemId3] [int] NULL,
	[adwUMItemId4] [int] NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_INS_DUNGEON_TBL](
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_DungeonID] [char](7) NOT NULL,
	[m_WorldID] [int] NOT NULL,
	[m_channel] [int] NULL,
	[m_Type] [int] NULL,
	[m_State] [char](1) NULL,
	[m_Date] [datetime] NULL,
 CONSTRAINT [PK_LOG_INS_DUNGEON_TBL] PRIMARY KEY NONCLUSTERED 
(
	[SEQ] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_HONOR_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NULL,
	[nHonor] [int] NULL,
	[LogDt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_GUILD_WAR_TBL](
	[m_idGuild] [char](6) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[f_idGuild] [char](7) NULL,
	[m_idWar] [int] NULL,
	[m_nCurExp] [int] NULL,
	[m_nGetExp] [int] NULL,
	[m_nCurPenya] [int] NULL,
	[m_nGetPenya] [int] NULL,
	[State] [char](1) NULL,
	[s_date] [char](14) NULL,
	[e_date] [char](14) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_GUILD_TBL](
	[m_idGuild] [char](6) NOT NULL,
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[Do_m_idPlayer] [char](7) NULL,
	[State] [char](1) NULL,
	[s_date] [char](14) NULL,
	[SEQ] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_UNIQUE_TBL](
	[m_idPlayer] [char](7) NULL,
	[serverindex] [char](2) NOT NULL,
	[dwWorldID] [int] NULL,
	[m_vPos_x] [real] NULL,
	[m_vPos_y] [real] NULL,
	[m_vPos_z] [real] NULL,
	[Item_Name] [varchar](32) NULL,
	[Item_AddLv] [int] NULL,
	[s_date] [char](14) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_SVRDOWN_TBL](
	[serverindex] [char](2) NOT NULL,
	[Start_Time] [char](14) NULL,
	[End_Time] [char](14) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.08.10
3. 스크립트 명 : usp_Log_Ins_Dungeon_Insert
4. 스크립트 목적 : 인스턴스 던전 로그 기록
5. 매개변수
	@serverindex char(2),		: 서버인덱스
	@m_DungeonID char(7),		: 인스턴스 던전 고유 ID
	@m_WorldID int,				: 월드 ID
	@m_channel int, 			: 각 군 체널
	@m_Type int, 				: 던전 타입
	@m_State char(1)			: 던전 상태값 ( 생성, 완료)
6. 리턴값 						: 없음
7. 수정 내역
    2009. 08.10 / 박혜민 / 최초 작성
8. 샘플 실행 코드
    EXEC usp_Log_Ins_Dungeon_Insert '01', 'TEST_01', 0000, 01, 1111, 'Y'
9. 조회 및 ident 값 초기화
	select * from LOG_INS_DUNGEON_TBL
	delete LOG_INS_DUNGEON_TBL
	DBCC checkident(LOG_INS_DUNGEON_TBL,reseed, 0)
============================================================*/


CREATE         proc [dbo].[usp_Log_Ins_Dungeon_Insert]
@serverindex char(2),
@m_DungeonID char(7),
@m_WorldID int,
@m_channel int,
@m_Type int,
@m_State char(1)

AS
set nocount on


declare @q1 nvarchar(4000), @q2 nvarchar(4000)

set @q1 = '
			INSERT INTO LOGGING_[&serverindex&]_DBF.dbo.LOG_INS_DUNGEON_TBL(serverindex, m_DungeonID, m_WorldID, m_channel, m_Type, m_State)
			VALUES(@serverindex, @m_DungeonID, @m_WorldID, @m_channel, @m_Type, @m_State)'
set @q2 = replace(@q1, '[&serverindex&]', @serverindex)
exec sp_executesql @q2, N'@serverindex char(2), @m_DungeonID char(7), @m_WorldID int, @m_channel int, @m_Type int, @m_State char(1)', @serverindex = @serverindex, @m_DungeonID = @m_DungeonID, @m_WorldID = @m_WorldID, @m_channel = @m_channel, @m_Type = @m_Type, @m_State = @m_State

/*
			INSERT INTO LOG_INS_DUNGEON_TBL(serverindex, m_DungeonID, m_WorldID, m_channel, m_Type, m_State)
			VALUES(@serverindex, @m_DungeonID, @m_WorldID, @m_channel, @m_Type, @m_State)
*/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ElectionStat]
@serverindex char(2)
as
set nocount on

declare @q1 nvarchar(4000), @q2 nvarchar(4000)

set @q1 = '
delete CHARACTER_[&serverindex&]_DBF.dbo.tblElection
where s_week = cast(datepart(yy, getdate()) as varchar(10)) + right(''00'' + cast(datepart(ww, getdate()) as varchar(30)), 2)'
set @q2 = replace(@q1, '[&serverindex&]', @serverindex)
exec sp_executesql @q2

set @q1 = '
insert into CHARACTER_[&serverindex&]_DBF.dbo.tblElection (s_week, chrcount)
select cast(datepart(yy, getdate()) as varchar(10)) + right(''00'' + cast(datepart(ww, getdate()) as varchar(30)), 2), count(distinct m_idPlayer)
from LOGGING_[&serverindex&]_DBF.dbo.LOG_LOGIN_TBL
where Start_Time >= convert(varchar(20), dateadd(m, -1, getdate()), 112) and CharLevel >= 60'
set @q2 = replace(@q1, '[&serverindex&]', @serverindex)
exec sp_executesql @q2
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  PROCEDURE [dbo].[uspTransferLoginLog]
		@pserverindex		char(2),
		@debug				bit=0
AS
SET NOCOUNT ON


	IF @pserverindex<>SUBSTRING(DB_NAME(), CHARINDEX('_', DB_NAME())+1, 2) BEGIN
		RAISERROR('Wrong Database.', 16, 10)
		RETURN
	END
	
	DECLARE		@os_date CHAR(14),
				@preDate datetime

	SELECT @preDate = DATEADD(mi,-5,GETDATE())

	SELECT @os_date = CONVERT(CHAR(8),@preDate,112) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,@preDate)),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,@preDate)),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,@preDate)),2)


	/* LOG_LOGIN_TBL *********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_LOGIN_TBL
		(
			m_idPlayer,serverindex,dwWorldID,Start_Time,End_Time,TotalPlayTime,m_dwGold,remoteIP,account
		)
	SELECT
			m_idPlayer,serverindex,dwWorldID,Start_Time,End_Time,TotalPlayTime,m_dwGold,remoteIP,account
	FROM LOG_LOGIN_TBL,
				(SELECT max_date = CASE WHEN max(End_Time)  IS NULL THEN ''00000000000000'' ELSE max(End_Time) END
					FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_LOGIN_TBL  
					WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE End_Time > x.max_date
		AND End_Time <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_LOGIN_TBL WHERE End_Time <= ''' + @os_date + '''')


SET NOCOUNT OFF
RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  proc [dbo].[uspTransferLog]
		@pserverindex		char(2),
		@debug				bit=0
AS
SET NOCOUNT ON

	IF @pserverindex<>SUBSTRING(DB_NAME(), CHARINDEX('_', DB_NAME())+1, 2) BEGIN
		RAISERROR('Wrong Database.', 16, 10)
		RETURN
	END
	
	DECLARE @os_date CHAR(14),@preDate datetime
	
	SELECT @preDate = DATEADD(mi,-5,GETDATE())
	
	SELECT @os_date = CONVERT(CHAR(8),@preDate,112) 
									  + RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,@preDate)),2) 
									  + RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,@preDate)),2) 
									  + RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,@preDate)),2)
	
	
	/* LOG_DEATH_TBL*********************************************************************************/
	
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_DEATH_TBL 
		(
			m_idPlayer,serverindex,dwWorldID,killed_m_szName,m_vPos_x,m_vPos_y,m_vPos_z,
			m_nLevel,attackPower,max_HP,s_date
		)
	SELECT 
			m_idPlayer,serverindex,dwWorldID,killed_m_szName,m_vPos_x,m_vPos_y,m_vPos_z,
			m_nLevel,attackPower,max_HP,s_date
	   FROM LOG_DEATH_TBL,
				 (SELECT max_date  = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
				     FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_DEATH_TBL  
	 			  WHERE serverindex = ''' + @pserverindex + ''') x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_DEATH_TBL WHERE s_date <= ''' + @os_date + '''')
	
	/* LOG_LOGIN_TBL*********************************************************************************/
	/*
	EXEC('
	INSERT CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_LOGIN_TBL
		(
			m_idPlayer,serverindex,dwWorldID,Start_Time,End_Time,TotalPlayTime,m_dwGold,remoteIP
		)
	SELECT
			m_idPlayer,serverindex,dwWorldID,Start_Time,End_Time,TotalPlayTime,m_dwGold,remoteIP 
	   FROM LOG_LOGIN_TBL,
				 (SELECT max_date = CASE WHEN max(End_Time)  IS NULL THEN ''00000000000000'' ELSE max(End_Time) END
					  FROM CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_LOGIN_TBL  
					WHERE serverindex = ''' + @pserverindex + ''') x
	 WHERE End_Time > x.max_date
	      AND End_Time <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_LOGIN_TBL WHERE End_Time <= ''' + @os_date + '''')
	*/
	
	
	/* LOG_QUEST_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_QUEST_TBL 
		(
			m_idPlayer,serverindex,Quest_Index,State,Start_Time,End_Time
		)
	SELECT
			m_idPlayer,serverindex,Quest_Index,State,Start_Time,End_Time
	   FROM LOG_QUEST_TBL,
				 (SELECT max_date = CASE WHEN max(End_Time)  IS NULL THEN ''00000000000000'' ELSE max(End_Time) END
	  				FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_QUEST_TBL  
				 WHERE serverindex = ''' + @pserverindex + ''') x
	 WHERE End_Time > x.max_date
	      AND End_Time <= ''' + @os_date +  '''
	IF @@ROWCOUNT > 0
	DELETE LOG_QUEST_TBL WHERE End_Time <= ''' + @os_date + '''')
	
	/* LOG_SVRDOWN_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_SVRDOWN_TBL 
		(
			serverindex,Start_Time,End_Time
		)
	SELECT
			serverindex,Start_Time,End_Time
	   FROM LOG_SVRDOWN_TBL,
				 (SELECT max_date = CASE WHEN max(End_Time)  IS NULL THEN ''00000000000000'' ELSE max(End_Time) END
				     FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_SVRDOWN_TBL 
				  WHERE serverindex = ''' + @pserverindex + ''') x
	 WHERE End_Time > x.max_date
	      AND End_Time <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_SVRDOWN_TBL WHERE End_Time <= ''' + @os_date + '''')
	
	/* LOG_UNIQUE_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_UNIQUE_TBL 
		(
			m_idPlayer,serverindex,dwWorldID,m_vPos_x,m_vPos_y,m_vPos_z,Item_Name,Item_AddLv,s_date
		)	
	SELECT
			m_idPlayer,serverindex,dwWorldID,m_vPos_x,m_vPos_y,m_vPos_z,Item_Name,Item_AddLv,s_date
	   FROM LOG_UNIQUE_TBL,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
	  				FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_UNIQUE_TBL  
				 WHERE serverindex = ''' + @pserverindex + ''') x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_UNIQUE_TBL WHERE s_date <= ''' + @os_date + '''')
	
	/* LOG_USER_CNT_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_USER_CNT_TBL 
		(
			serverindex,s_date,number,m_01,m_02,m_03,m_04,m_05,m_06,m_07,m_08,m_09,m_10,
			m_11,m_12,m_13,m_14,m_15,m_16,m_17,m_18,m_19,m_20
		)
	SELECT
			serverindex,s_date,number,m_01,m_02,m_03,m_04,m_05,m_06,m_07,m_08,m_09,m_10,
			m_11,m_12,m_13,m_14,m_15,m_16,m_17,m_18,m_19,m_20
	   FROM LOG_USER_CNT_TBL,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
	 				FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_USER_CNT_TBL  
				 WHERE serverindex = ''' + @pserverindex + ''') x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date +  '''
	IF @@ROWCOUNT > 0
	DELETE LOG_USER_CNT_TBL WHERE s_date <= ''' + @os_date + '''')
	
	/* LOG_LEVELUP_TBL*********************************************************************************/
	/*	EXEC('
	INSERT CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_LEVELUP_TBL
		(
			m_idPlayer,serverindex,m_nExp1,m_nLevel,m_nJob,m_nJobLv,m_nFlightLv,
			m_nStr,m_nDex,m_nInt,m_nSta,	m_nRemainGP,m_nRemainLP,m_dwGold,TotalPlayTime,State,s_date
		)
	SELECT
			m_idPlayer,serverindex,m_nExp1,m_nLevel,m_nJob,m_nJobLv,m_nFlightLv,
			m_nStr,m_nDex,m_nInt,m_nSta,	m_nRemainGP,m_nRemainLP,m_dwGold,TotalPlayTime,State,s_date
	   FROM LOG_LEVELUP_TBL,
				(SELECT max_date = CASE WHEN max(s_date) IS NULL THEN ''00000000000000'' ELSE max(s_date) END
					FROM CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_LEVELUP_TBL  
				 WHERE serverindex = ''' + @pserverindex + ''') x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_LEVELUP_TBL WHERE s_date  <= ''' + @os_date + '''')
	*/
	/* LOG_GAMEMASTER_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_GAMEMASTER_TBL 
		(
			serverindex,m_idPlayer,m_szWords,s_date,m_idGuild
		)
	SELECT 
			serverindex,m_idPlayer,m_szWords,s_date,m_idGuild
	   FROM LOG_GAMEMASTER_TBL,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
				     FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_GAMEMASTER_TBL  
				 WHERE serverindex = ''' + @pserverindex + ''' ) x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_GAMEMASTER_TBL WHERE s_date  <= ''' + @os_date + '''')
	
	
	/* LOG_ITEM_SEND_TBL*********************************************************************************/
	/*
	EXEC('
	INSERT CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_SEND_TBL 
		(
			serverindex,m_idPlayer,m_nNo,m_szItemName,m_nItemNum,s_date,m_bItemResist,m_nResistAbilityOption
		)
	SELECT 
			serverindex,m_idPlayer,m_nNo,m_szItemName,m_nItemNum,s_date,m_bItemResist,m_nResistAbilityOption
	   FROM LOG_ITEM_SEND_TBL,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
	  				FROM CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_SEND_TBL 
				 WHERE serverindex = ''' + @pserverindex + ''' ) x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_ITEM_SEND_TBL WHERE s_date <= ''' + @os_date + '''')
	
	
	EXEC('
	INSERT CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_REMOVE_TBL 
		(
			serverindex,m_idPlayer,m_nNo,m_szItemName,m_nItemNum,s_date,m_bItemResist,m_nResistAbilityOption
		)
	SELECT
			serverindex,m_idPlayer,m_nNo,m_szItemName,m_nItemNum,s_date,m_bItemResist,m_nResistAbilityOption
	   FROM LOG_ITEM_REMOVE_TBL,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
	 				FROM CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_REMOVE_TBL  
				 WHERE serverindex = ''' + @pserverindex + ''' ) x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_ITEM_REMOVE_TBL WHERE s_date  <= ''' + @os_date + '''')
	
	EXEC('
	INSERT CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_TBL 
		(
			m_szName,serverindex,m_GetszName,dwWorldID,m_dwGold,m_nRemainGold,Item_UniqueNo,
			Item_Name,Item_durability,m_nAbilityOption,m_GetdwGold,Item_count,State,s_date,
			m_nSlot0,m_nSlot1,m_bItemResist ,	m_nResistAbilityOption, 
	       m_bCharged,m_dwKeepTime,m_nRandomOptItemId,nPiercedSize,adwItemId0,adwItemId1,adwItemId2,adwItemId3
		)
	SELECT 
			m_szName,serverindex,m_GetszName,dwWorldID,m_dwGold,m_nRemainGold,Item_UniqueNo,
			Item_Name,Item_durability,m_nAbilityOption,m_GetdwGold,Item_count,State,s_date,
			m_nSlot0,m_nSlot1,m_bItemResist ,	m_nResistAbilityOption, 
	       m_bCharged,m_dwKeepTime,m_nRandomOptItemId,nPiercedSize,adwItemId0,adwItemId1,adwItemId2,adwItemId3
	   FROM LOG_ITEM_TBL,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
					  FROM CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_TBL   
				  WHERE serverindex = ''' + @pserverindex + ''') x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date +'''
	IF @@ROWCOUNT > 0
	DELETE LOG_ITEM_TBL WHERE s_date <= ''' + @os_date + '''')
	
	EXEC('
	INSERT CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_EVENT_TBL 
		(
			m_szName,serverindex,m_GetszName,dwWorldID,m_dwGold,m_nRemainGold,Item_UniqueNo,
			Item_Name,Item_durability,m_nAbilityOption,m_GetdwGold,Item_count,State,s_date,
			m_nSlot0,m_nSlot1,m_bItemResist ,	m_nResistAbilityOption, 
	       m_bCharged,m_dwKeepTime,m_nRandomOptItemId,nPiercedSize,adwItemId0,adwItemId1,adwItemId2,adwItemId3
		)
	SELECT 
			m_szName,serverindex,m_GetszName,dwWorldID,m_dwGold,m_nRemainGold,Item_UniqueNo,
			Item_Name,Item_durability,m_nAbilityOption,m_GetdwGold,Item_count,State,s_date,
			m_nSlot0,m_nSlot1,m_bItemResist ,	m_nResistAbilityOption, 
	       m_bCharged,m_dwKeepTime,m_nRandomOptItemId,nPiercedSize,adwItemId0,adwItemId1,adwItemId2,adwItemId3
	   FROM LOG_ITEM_EVENT_TBL,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
					  FROM CRM'+@pserverindex+'.LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_EVENT_TBL  
					WHERE serverindex = ''' + @pserverindex + ''') x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date +'''
	IF @@ROWCOUNT > 0
	DELETE LOG_ITEM_EVENT_TBL WHERE s_date  <= ''' + @os_date + '''')
	*/

	/* LOG_SKILL_FREQUENCY_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_SKILL_FREQUENCY_TBL 	
		(	
			m_nid,m_nFrequency,s_date
		)
	SELECT
			m_nid,m_nFrequency,s_date
	   FROM LOG_SKILL_FREQUENCY_TBL,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
	  				FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_SKILL_FREQUENCY_TBL 
			 --  WHERE serverindex = ''' + @pserverindex + '''
				  ) x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date +''' 
	IF @@ROWCOUNT > 0
	DELETE LOG_SKILL_FREQUENCY_TBL WHERE s_date <= ''' + @os_date + '''')
	
	/* LOG_RESPAWN_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_RESPAWN_TBL 
		(
			m_nid,m_nFrequency,s_date
		)
	SELECT
			m_nid,m_nFrequency,s_date
	   FROM LOG_RESPAWN_TBL,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
					  FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_RESPAWN_TBL 
				-- WHERE serverindex = ''' + @pserverindex + '''
				  ) x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date +''' 
	IF @@ROWCOUNT > 0
	DELETE LOG_RESPAWN_TBL WHERE s_date  <= ''' + @os_date + '''')
	
	/* LOG_PK_PVP_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_PK_PVP_TBL 
		(
			serverindex,m_idPlayer,m_nLevel,m_vPos_x,m_vPos_z,killed_m_idPlayer,killed_m_nLevel,m_GetPoint,
			m_nSlaughter,m_nFame,killed_m_nSlaughter,killed_m_nFame,m_KillNum,State,s_date
		)
	SELECT
			serverindex,m_idPlayer,m_nLevel,m_vPos_x,m_vPos_z,killed_m_idPlayer,killed_m_nLevel,m_GetPoint,
			m_nSlaughter,m_nFame,killed_m_nSlaughter,killed_m_nFame,m_KillNum,State,s_date
	   FROM LOG_PK_PVP_TBL ,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
					  FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_PK_PVP_TBL  
					WHERE serverindex = ''' + @pserverindex + ''') x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date +''' 
	IF @@ROWCOUNT > 0
	DELETE LOG_PK_PVP_TBL WHERE s_date <= ''' + @os_date + '''')
	
	
	/* LOG_GUILD_BANK_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_GUILD_BANK_TBL
		(
			m_idGuild,m_idPlayer,serverindex,m_nGuildGold,m_GuildBank,m_Item,m_nAbilityOption,Item_count,Item_UniqueNo,State,s_date
		)
	SELECT 
			m_idGuild,m_idPlayer,serverindex,m_nGuildGold,m_GuildBank,m_Item,m_nAbilityOption,Item_count,Item_UniqueNo,State,s_date
	  FROM LOG_GUILD_BANK_TBL,
				(SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
				   FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_GUILD_BANK_TBL  
				WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE  s_date > x.max_date
	      AND s_date <= ''' + @os_date +'''
	IF @@ROWCOUNT > 0
	DELETE LOG_GUILD_BANK_TBL WHERE s_date  <= ''' + @os_date + '''')
	
	/* LOG_GUILD_DISPERSION_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_GUILD_DISPERSION_TBL
		(
			m_idGuild,m_idPlayer,serverindex,State,s_date
		)
	SELECT 
			m_idGuild,m_idPlayer,serverindex,State,s_date
	  FROM LOG_GUILD_DISPERSION_TBL,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
				     FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_GUILD_DISPERSION_TBL  
				  WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE  s_date > x.max_date
	      AND s_date <= ''' + @os_date +'''
	IF @@ROWCOUNT > 0
	DELETE LOG_GUILD_DISPERSION_TBL WHERE s_date <= ''' + @os_date + '''')
	
	/* LOG_GUILD_SERVICE_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_GUILD_SERVICE_TBL
		(
			m_idGuild,m_idPlayer,serverindex,m_nLevel,m_GuildLv,GuildPoint,Gold,State,s_date
		)
	SELECT 
			m_idGuild,m_idPlayer,serverindex,m_nLevel,m_GuildLv,GuildPoint,Gold,State,s_date
	  FROM LOG_GUILD_SERVICE_TBL,
				(SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
				    FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_GUILD_SERVICE_TBL  
				WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE  s_date > x.max_date
	      AND s_date <= ''' + @os_date +'''
	IF @@ROWCOUNT > 0
	DELETE LOG_GUILD_SERVICE_TBL WHERE s_date  <= ''' + @os_date + '''')
	
	
	/* LOG_GUILD_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_GUILD_TBL
		(
			m_idGuild,m_idPlayer,serverindex,Do_m_idPlayer,State,s_date
		)
	SELECT 
			m_idGuild,m_idPlayer,serverindex,Do_m_idPlayer,State,s_date
	  FROM LOG_GUILD_TBL,
				(SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
				    FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_GUILD_TBL  
				WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE  s_date > x.max_date
	      AND s_date <= ''' + @os_date +'''
	IF @@ROWCOUNT > 0
	DELETE LOG_GUILD_TBL WHERE s_date  <= ''' + @os_date + '''')
	
	/* LOG_GUILD_WAR_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_GUILD_WAR_TBL
		(
			m_idGuild,serverindex,f_idGuild,m_idWar,m_nCurExp,m_nGetExp,m_nCurPenya,m_nGetPenya,State,s_date,e_date
		)
	SELECT 
			m_idGuild,serverindex,f_idGuild,m_idWar,m_nCurExp,m_nGetExp,m_nCurPenya,m_nGetPenya,State,s_date,e_date
	  FROM LOG_GUILD_WAR_TBL,
				(SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
				    FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_GUILD_WAR_TBL  
				WHERE serverindex = ''' + @pserverindex + ''') x
	
	WHERE  s_date > x.max_date
	      AND s_date <= ''' + @os_date +'''
	IF @@ROWCOUNT > 0
	DELETE LOG_GUILD_WAR_TBL WHERE s_date <= ''' + @os_date + '''')
	
	/* LOG_BILLING_ITEM_TBL*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_BILLING_ITEM_TBL 
		(
			m_szName,serverindex,m_GetszName,dwWorldID,m_dwGold,m_nRemainGold,Item_UniqueNo,
			Item_Name,Item_durability,m_nAbilityOption,m_GetdwGold,Item_count,State,s_date,
			m_nSlot0,m_nSlot1,m_bItemResist ,	m_nResistAbilityOption, 
	       m_bCharged,m_dwKeepTime,m_nRandomOptItemId,nPiercedSize,adwItemId0,adwItemId1,adwItemId2, adwItemId3, adwItemId4, MaxDurability
		,nPetKind, nPetLevel, dwPetExp, wPetEnergy, wPetLife, nPetAL_D, nPetAL_C, nPetAL_B, nPetAL_A, nPetAL_S
		)
	SELECT 
			m_szName,serverindex,m_GetszName,dwWorldID,m_dwGold,m_nRemainGold,Item_UniqueNo,
			Item_Name,Item_durability,m_nAbilityOption,m_GetdwGold,Item_count,State,s_date,
			m_nSlot0,m_nSlot1,m_bItemResist ,	m_nResistAbilityOption, 
	       m_bCharged,m_dwKeepTime,m_nRandomOptItemId,nPiercedSize,adwItemId0,adwItemId1,adwItemId2,adwItemId3, adwItemId4, MaxDurability
		,nPetKind, nPetLevel, dwPetExp, wPetEnergy, wPetLife, nPetAL_D, nPetAL_C, nPetAL_B, nPetAL_A, nPetAL_S
	   FROM LOG_BILLING_ITEM_TBL,
				 (SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
					  FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_BILLING_ITEM_TBL   
				   WHERE serverindex = ''' + @pserverindex + ''') x
	 WHERE s_date > x.max_date
	      AND s_date <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_BILLING_ITEM_TBL WHERE s_date <= ''' + @os_date + '''')
	
	/* tblChangeNameHistoryLog*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.tblChangeNameHistoryLog
		(
			serverindex, idPlayer, OldCharName, NewCharName, ChangeDt
		)
	SELECT 
			serverindex, idPlayer, OldCharName, NewCharName, ChangeDt
	FROM tblChangeNameHistoryLog,
				(SELECT max_date = CASE WHEN max(ChangeDt)  IS NULL THEN ''1900-01-01'' ELSE max(ChangeDt) END
					FROM LOG_' + @pserverindex + '_DBF.dbo.tblChangeNameHistoryLog  
				WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE  ChangeDt > x.max_date
		AND ChangeDt <= ''' + @preDate +'''
	IF @@ROWCOUNT > 0
	DELETE tblChangeNameHistoryLog WHERE ChangeDt <= ''' + @preDate + '''')

	
	/* tblChangeNameLog*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.tblChangeNameLog
		(
			ChangeID, serverindex, StartDt, EndDt, idPlayer, CharName
		)
	SELECT 
			ChangeID, serverindex, StartDt, EndDt, idPlayer, CharName
	FROM tblChangeNameLog,
				(SELECT max_date = CASE WHEN max(StartDt)  IS NULL THEN ''1900-01-01'' ELSE max(StartDt) END
					FROM LOG_' + @pserverindex + '_DBF.dbo.tblChangeNameLog  
				WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE  StartDt > x.max_date
		AND StartDt <= ''' + @preDate +'''
	IF @@ROWCOUNT > 0
	DELETE tblChangeNameLog WHERE StartDt <= ''' + @preDate + '''')
	
	/* tblLogExpBox*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.tblLogExpBox
		(
			serverindex, idPlayer, objid, iExp, State, s_date
		)
	SELECT 
			serverindex, idPlayer, objid, iExp, State, s_date
	FROM tblLogExpBox, 
				(SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''1900-01-01'' ELSE max(s_date) END
					FROM LOG_' + @pserverindex + '_DBF.dbo.tblLogExpBox
				WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE  s_date > x.max_date
		AND s_date <= ''' + @preDate +'''
	IF @@ROWCOUNT > 0
	DELETE tblLogExpBox WHERE s_date <= ''' + @preDate + '''')

	/* tblQuestLog*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.tblQuestLog
		(
			serverindex, idPlayer, QuestIndex, State, LogDt, Comment
		)
	SELECT 
			serverindex, idPlayer, QuestIndex, State, LogDt, Comment
	FROM tblQuestLog, 
				(SELECT max_date = CASE WHEN max(LogDt)  IS NULL THEN ''1900-01-01'' ELSE max(LogDt) END
					FROM LOG_' + @pserverindex + '_DBF.dbo.tblQuestLog
				WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE  LogDt > x.max_date
		AND LogDt <= ''' + @preDate +'''
	IF @@ROWCOUNT > 0
	DELETE tblQuestLog WHERE LogDt <= ''' + @preDate + '''')
	/* tblPetLog*********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.tblPetLog
		(
			serverindex, idPlayer, iSerial, nType, dwData, nKind, nLevel, wLife, wEnergy, dwExp, nAvailParam1, nAvailParam2, nAvailParam3, nAvailParam4, nAvailParam5, LogDt
		)
	SELECT 
			serverindex, idPlayer, iSerial, nType, dwData, nKind, nLevel, wLife, wEnergy, dwExp, nAvailParam1, nAvailParam2, nAvailParam3, nAvailParam4, nAvailParam5, LogDt
	FROM tblPetLog, 
				(SELECT max_date = CASE WHEN max(LogDt)  IS NULL THEN ''1900-01-01'' ELSE max(LogDt) END
					FROM LOG_' + @pserverindex + '_DBF.dbo.tblPetLog
				WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE  LogDt > x.max_date
		AND LogDt <= ''' + @preDate +'''
	IF @@ROWCOUNT > 0
	DELETE tblPetLog WHERE LogDt <= ''' + @preDate + '''')

SET NOCOUNT OFF
RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  PROCEDURE [dbo].[uspTransferLevelupLog]
@pserverindex	char(2),
@debug		bit=0
AS
SET NOCOUNT ON


	IF @pserverindex<>SUBSTRING(DB_NAME(), CHARINDEX('_', DB_NAME())+1, 2) BEGIN
		RAISERROR('Wrong Database.', 16, 10)
		RETURN
	END
	

	DECLARE @os_date CHAR(14),@preDate datetime

	SELECT @preDate = DATEADD(mi,-5,GETDATE())

	SELECT @os_date = CONVERT(CHAR(8),@preDate,112) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,@preDate)),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,@preDate)),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,@preDate)),2)


	/* LOG_LEVELUP_TBL  *********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_LEVELUP_TBL
		(
			m_idPlayer,serverindex,m_nExp1,m_nLevel,m_nJob,m_nJobLv,m_nFlightLv,
			m_nStr,m_nDex,m_nInt,m_nSta,	m_nRemainGP,m_nRemainLP,m_dwGold,TotalPlayTime,State,s_date
		)
	SELECT
			m_idPlayer,serverindex,m_nExp1,m_nLevel,m_nJob,m_nJobLv,m_nFlightLv,
			m_nStr,m_nDex,m_nInt,m_nSta,	m_nRemainGP,m_nRemainLP,m_dwGold,TotalPlayTime,State,s_date
	FROM LOG_LEVELUP_TBL,
				(SELECT max_date = CASE WHEN max(s_date) IS NULL THEN ''00000000000000'' ELSE max(s_date) END
					FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_LEVELUP_TBL  
				WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE s_date > x.max_date
		AND s_date <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_LEVELUP_TBL WHERE s_date  <= ''' + @os_date + '''')

SET NOCOUNT OFF
RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE proc [dbo].[uspTransferItemLog]
@pserverindex	char(2),
@debug		bit=0

AS

SET NOCOUNT ON

	IF @pserverindex<>SUBSTRING(DB_NAME(), CHARINDEX('_', DB_NAME())+1, 2) BEGIN
		RAISERROR('Wrong Database.', 16, 10)
		RETURN
	END
	
	DECLARE @os_date CHAR(14),@preDate datetime

	SELECT @preDate = DATEADD(mi,-5,GETDATE())

	SELECT @os_date = CONVERT(CHAR(8),@preDate,112) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,@preDate)),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,@preDate)),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,@preDate)),2)

	/* LOG_ITEM_SEND_TBL *********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_SEND_TBL 
		(
			serverindex,m_idPlayer,m_nNo,m_szItemName,m_nItemNum,s_date,m_bItemResist,m_nResistAbilityOption
		)
	SELECT 
			serverindex,m_idPlayer,m_nNo,m_szItemName,m_nItemNum,s_date,m_bItemResist,m_nResistAbilityOption
	FROM LOG_ITEM_SEND_TBL,
				(SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
  					FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_SEND_TBL 
				WHERE serverindex = ''' + @pserverindex + ''' ) x
	WHERE s_date > x.max_date
		AND s_date <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_ITEM_SEND_TBL WHERE s_date <= ''' + @os_date + '''')


	/* LOG_ITEM_REMOVE_TBL *********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_REMOVE_TBL 
		(
			serverindex,m_idPlayer,m_nNo,m_szItemName,m_nItemNum,s_date,m_bItemResist,m_nResistAbilityOption
		)
	SELECT
			serverindex,m_idPlayer,m_nNo,m_szItemName,m_nItemNum,s_date,m_bItemResist,m_nResistAbilityOption
	FROM LOG_ITEM_REMOVE_TBL,
				(SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
 					FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_REMOVE_TBL  
				WHERE serverindex = ''' + @pserverindex + ''' ) x
	WHERE s_date > x.max_date
		AND s_date <= ''' + @os_date + '''
	IF @@ROWCOUNT > 0
	DELETE LOG_ITEM_REMOVE_TBL WHERE s_date  <= ''' + @os_date + '''')

	/* LOG_ITEM_TBL *********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_TBL 
		(
			m_szName,serverindex,m_GetszName,dwWorldID,m_dwGold,m_nRemainGold,Item_UniqueNo,
			Item_Name,Item_durability,m_nAbilityOption,m_GetdwGold,Item_count,State,s_date,
			m_nSlot0,m_nSlot1,m_bItemResist ,	m_nResistAbilityOption, 
		m_bCharged,m_dwKeepTime,m_nRandomOptItemId,nPiercedSize,adwItemId0,adwItemId1,adwItemId2,adwItemId3, adwItemId4, MaxDurability
		,nPetKind, nPetLevel, dwPetExp, wPetEnergy, wPetLife, nPetAL_D, nPetAL_C, nPetAL_B, nPetAL_A, nPetAL_S
		)
	SELECT 
			m_szName,serverindex,m_GetszName,dwWorldID,m_dwGold,m_nRemainGold,Item_UniqueNo,
			Item_Name,Item_durability,m_nAbilityOption,m_GetdwGold,Item_count,State,s_date,
			m_nSlot0,m_nSlot1,m_bItemResist ,	m_nResistAbilityOption, 
		m_bCharged,m_dwKeepTime,m_nRandomOptItemId,nPiercedSize,adwItemId0,adwItemId1,adwItemId2,adwItemId3, adwItemId4, MaxDurability
		,nPetKind, nPetLevel, dwPetExp, wPetEnergy, wPetLife, nPetAL_D, nPetAL_C, nPetAL_B, nPetAL_A, nPetAL_S
	FROM LOG_ITEM_TBL,
				(SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
					FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_TBL   
				WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE s_date > x.max_date
		AND s_date <= ''' + @os_date +'''
	IF @@ROWCOUNT > 0
	DELETE LOG_ITEM_TBL WHERE s_date <= ''' + @os_date + '''')

	/* LOG_ITEM_EVENT_TBL *********************************************************************************/
	EXEC('
	INSERT LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_EVENT_TBL 
		(
			m_szName,serverindex,m_GetszName,dwWorldID,m_dwGold,m_nRemainGold,Item_UniqueNo,
			Item_Name,Item_durability,m_nAbilityOption,m_GetdwGold,Item_count,State,s_date,
			m_nSlot0,m_nSlot1,m_bItemResist ,	m_nResistAbilityOption, 
		m_bCharged,m_dwKeepTime,m_nRandomOptItemId,nPiercedSize,adwItemId0,adwItemId1,adwItemId2,adwItemId3, adwItemId4, MaxDurability
		,nPetKind, nPetLevel, dwPetExp, wPetEnergy, wPetLife, nPetAL_D, nPetAL_C, nPetAL_B, nPetAL_A, nPetAL_S
		)
	SELECT 
			m_szName,serverindex,m_GetszName,dwWorldID,m_dwGold,m_nRemainGold,Item_UniqueNo,
			Item_Name,Item_durability,m_nAbilityOption,m_GetdwGold,Item_count,State,s_date,
			m_nSlot0,m_nSlot1,m_bItemResist ,	m_nResistAbilityOption, 
		m_bCharged,m_dwKeepTime,m_nRandomOptItemId,nPiercedSize,adwItemId0,adwItemId1,adwItemId2,adwItemId3, adwItemId4, MaxDurability
		,nPetKind, nPetLevel, dwPetExp, wPetEnergy, wPetLife, nPetAL_D, nPetAL_C, nPetAL_B, nPetAL_A, nPetAL_S
	FROM LOG_ITEM_EVENT_TBL,
				(SELECT max_date = CASE WHEN max(s_date)  IS NULL THEN ''00000000000000'' ELSE max(s_date) END
					FROM LOG_' + @pserverindex + '_DBF.dbo.LOG_ITEM_EVENT_TBL  
					WHERE serverindex = ''' + @pserverindex + ''') x
	WHERE s_date > x.max_date
		AND s_date <= ''' + @os_date +'''
	IF @@ROWCOUNT > 0
	DELETE LOG_ITEM_EVENT_TBL WHERE s_date  <= ''' + @os_date + '''')

SET NOCOUNT OFF
RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspTransferTradeLog]
		@pserverindex		char(2),
		@debug				bit=0
AS
SET NOCOUNT ON

	IF @pserverindex<>SUBSTRING(DB_NAME(), CHARINDEX('_', DB_NAME())+1, 2) BEGIN
		RAISERROR('Wrong Database.', 16, 10)
		RETURN
	END
	
	DECLARE @TodayMidnight char(10)
	DECLARE @sql	nvarchar(4000)
	
	SET @TodayMidnight=CONVERT(char(10), GETDATE(), 102)

	--SELECT TradeID INTO #TEMP_TradeID FROM tblTradeLog WHERE TradeDt < @TodayMidnight

	SET @sql =
		'	
		INSERT INTO LOG_' + @pserverindex + '_DBF.dbo.tblTradeLog
			SELECT a.* FROM dbo.tblTradeLog a WHERE a.TradeDt<@date
		'
	
	EXEC sp_executesql @sql, N'@date char(10)', @TodayMidnight

	SET @sql=
		'
		INSERT INTO LOG_' + @pserverindex + '_DBF.dbo.tblTradeDetailLog
			SELECT	a.* 
			FROM	dbo.tblTradeDetailLog a 
					INNER JOIN dbo.tblTradeLog b 
					ON (a.TradeID=b.TradeID) 
			WHERE b.TradeDt<@date
		'
	EXEC sp_executesql @sql, N'@date char(10)', @TodayMidnight


	SET @sql=
		'	
		INSERT INTO LOG_' + @pserverindex + '_DBF.dbo.tblTradeItemLog
			SELECT	a.* 
			FROM	dbo.tblTradeItemLog a 
					INNER JOIN dbo.tblTradeLog b 
						ON (a.TradeID=b.TradeID) 
			WHERE b.TradeDt<@date
		'
	EXEC sp_executesql @sql, N'@date char(10)', @TodayMidnight
		
	DELETE dbo.tblTradeItemLog FROM dbo.tblTradeItemLog a INNER JOIN dbo.tblTradeLog b ON (a.TradeID=b.TradeID) WHERE b.TradeDt<@TodayMidnight
	DELETE dbo.tblTradeDetailLog FROM dbo.tblTradeDetailLog a INNER JOIN dbo.tblTradeLog b ON (a.TradeID=b.TradeID) WHERE b.TradeDt<@TodayMidnight
	DELETE dbo.tblTradeLog FROM dbo.tblTradeLog WHERE TradeDt<@TodayMidnight

	RETURN 
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspPetLog]
	@serverindex	char(2),
	@idPlayer	char(7),
	@iSerial		bigint,
	@nType		int,
	@dwData	int,
	@nKind		int,
	@nLevel		int,
	@wLife		int,
	@wEnergy	int,
	@dwExp		int,
	@nAvailParam1	int,
	@nAvailParam2	int,
	@nAvailParam3	int,
	@nAvailParam4	int,
	@nAvailParam5	int

AS
SET NOCOUNT ON
	
	INSERT INTO tblPetLog(serverindex, idPlayer, iSerial, nType, dwData, nKind, nLevel, wLife, wEnergy, dwExp, nAvailParam1, nAvailParam2, nAvailParam3, nAvailParam4, nAvailParam5, LogDt)
							    VALUES (@serverindex, @idPlayer, @iSerial, @nType, @dwData, @nKind, @nLevel, @wLife, @wEnergy, @dwExp, @nAvailParam1, @nAvailParam2, @nAvailParam3, @nAvailParam4, @nAvailParam5, getdate())

	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[uspLoggingUsingSkillPoint]
	@pserverindex	char(2),
	@pPlayerID		char(7),
	@pSkillID		int,
	@pSkillLevel	int,
	@pSkillPoint		int,
	@pHoldingSkillPoint	int,
	@pTotalSkillPoint	int,
	@pSkillExp		bigint,
	@pUsingBy		int
AS
SET NOCOUNT ON

	INSERT INTO tblSkillPointLog(serverindex, PlayerID, SkillID, SkillLevel, SkillPoint, HoldingSkillPoint, TotalSkillPoint, SkillExp, UsingBy, ActionDt)
		VALUES (@pserverindex, @pPlayerID, @pSkillID, @pSkillLevel, @pSkillPoint, @pHoldingSkillPoint, @pTotalSkillPoint, @pSkillExp, @pUsingBy, getdate())
	

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE   Procedure [dbo].[uspLoggingTrade]
@pFlag		int,
@pTradeID	int,
@pserverindex	char(2),
@pWorldID	int=0,
@pidPlayer	char(7)='0000000',
@pTradeGold	int=0,
@pPlayerIP	varchar(15)='',
@pLevel		int=0,
@pJob		int=0,
@pItemIndex	int=0,
@pItemSerialNum	int=0,
@pItemCnt	int=0,
@pAbilityOpt	int=0,
@pItemResist	int=0,
@pResistAbilityOpt	int=0,
@pRandomOpt	bigint=0
AS
SET NOCOUNT ON

	IF @pFlag=0 BEGIN
		INSERT INTO tblTradeLog(TradeID, serverindex, WorldID, TradeDt)
				VALUES (@pTradeID, @pserverindex, @pWorldID, getdate())
				
		IF @@ROWCOUNT=0 BEGIN
			SELECT 9001
			RETURN
		END
	END
	ELSE IF @pFlag=1 BEGIN
		INSERT INTO tblTradeDetailLog(TradeID, serverindex, idPlayer, Job, Level, TradeGold, PlayerIP)
				VALUES (@pTradeID, @pserverindex, @pidPlayer, @pJob, @pLevel, @pTradeGold, @pPlayerIP)
				
		IF @@ROWCOUNT=0 BEGIN
			SELECT 9002
			RETURN
		END
	END
	ELSE IF @pFlag=2 BEGIN
		INSERT INTO tblTradeItemLog(TradeID, serverindex, idPlayer, ItemIndex, ItemSerialNum, ItemCnt, AbilityOpt, ItemResist, ResistAbilityOpt, RandomOpt)
				VALUES (@pTradeID, @pserverindex, @pidPlayer, @pItemIndex, @pItemSerialNum, @pItemCnt, @pAbilityOpt, @pItemResist, @pResistAbilityOpt, @pRandomOpt)

		IF @@ROWCOUNT=0 BEGIN
			SELECT 9003
			RETURN
		END
	END
	ELSE BEGIN
		SELECT 9004
		RETURN
	END
	
	SELECT 1
	RETURN 

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspLoggingQuest]
		@pserverindex	char(2),
		@pidPlayer		char(7),
		@pQuestIndex	int,
		@pState			varchar(3),
		@pComment		varchar(100)=''
AS
SET NOCOUNT ON

	INSERT INTO tblQuestLog(serverindex, idPlayer, QuestIndex, State, LogDt, Comment)
			VALUES (@pserverindex, @pidPlayer, @pQuestIndex, @pState, getdate(), @pComment)
			
	IF @@ROWCOUNT=0 BEGIN
		SELECT 9001
		RETURN
	END
	
	SELECt 1
	RETURN
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    Procedure [dbo].[uspLoggingLogin]
		@pPlayerID		char(7),
		@pserverindex	char(2),
		@pAccount		varchar(32),
		@pWorldID		int,
		@pGold			bigint,
		@pLevel			int,
		@pJob			int,
		@pStartDt		char(14),
		@pTotalPlayTime	int,
		@pRemoteIP		varchar(16),
		@i_State tinyint = 0
		
AS
SET NOCOUNT ON
	DECLARE @os_date CHAR(14)
	SELECT @os_date = CONVERT(CHAR(8),GETDATE(),112) 
										+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,GETDATE())),2) 
										+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,GETDATE())),2) 
										+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,GETDATE())),2)


	INSERT  LOG_LOGIN_TBL 
		(
			m_idPlayer,
			serverindex,
			account,
			dwWorldID,
			m_dwGold,
			CharLevel,
			Job,
			Start_Time,
			End_Time,
			TotalPlayTime,
			remoteIP,
			State
		)
	VALUES 
		(
			@pPlayerID,
			@pserverindex,
			@pAccount,
			@pWorldID,
			@pGold,
			@pLevel,
			@pJob,
			@pStartDt,
			@os_date,
			@pTotalPlayTime,
			@pRemoteIP,
			@i_State				
		)

	RETURN



SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[uspLoggingAcquireSkillPoint]
	@pserverindex	char(2),
	@pPlayerID		char(7),
	@pSkillID		int,
	@pSkillLevel	int,
	@pSkillPoint		int,
	@pHoldingSkillPoint	int,
	@pTotalSkillPoint	int,
	@pSkillExp		bigint,
	@pUsingBy		int
AS
SET NOCOUNT ON

	INSERT INTO tblSkillPointLog(serverindex, PlayerID, SkillID, SkillLevel, SkillPoint, HoldingSkillPoint, TotalSkillPoint, SkillExp, UsingBy, ActionDt)
		VALUES (@pserverindex, @pPlayerID, 0, 0, @pSkillPoint, @pHoldingSkillPoint, @pTotalSkillPoint, @pSkillExp, @pUsingBy, getdate())
	

SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  Procedure [dbo].[uspLogExpBox]
		@pserverindex	char(2),
		@pidPlayer		char(7),
		@pobjid		bigint,
		@piExp		bigint,
		@pState	char(1)
AS
SET NOCOUNT ON
	
	INSERT INTO tblLogExpBox(serverindex, idPlayer, objid, iExp, State, s_date)
							    VALUES (@pserverindex, @pidPlayer, @pobjid, @piExp, @pState, getdate())

	IF @@ROWCOUNT=0 BEGIN
		RETURN
	END
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspHonorLog]
@serverindex char(2),
@idPlayer char(7),
@nHonor int
as
set nocount on

insert into LOG_HONOR_TBL(serverindex, m_idPlayer, nHonor)
select @serverindex, @idPlayer, @nHonor
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure [dbo].[uspChangeNameLog]
		@pserverindex	char(2),
		@pidPlayer		char(7),
		@pOldName		varchar(32),
		@pNewName		varchar(32)
AS
SET NOCOUNT ON
	
	DECLARE @ChangeID int
	
	INSERT INTO tblChangeNameHistoryLog(serverindex, idPlayer, OldCharName, NewCharName, ChangeDt) 
							    VALUES (@pserverindex, @pidPlayer, @pOldName, @pNewName, getdate())

	IF @@ROWCOUNT=0 BEGIN
		RETURN
	END
	
	-- FOR LINEAR EXECUTION
	SELECT @ChangeID=ChangeID FROM tblChangeNameLog  WHERE idPlayer=@pidPlayer
	
	IF @@ROWCOUNT>0 BEGIN
		UPDATE tblChangeNameLog SET EndDt=getdate() WHERE ChangeID=@ChangeID
	END
	
	INSERT INTO tblChangeNameLog(serverindex, StartDt, EndDt, idPlayer, CharName) VALUES (@pserverindex, getdate(), DEFAULT, @pidPlayer, @pNewName)
	
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.12.11
3. 스크립트 명 : usp_SystemError_Insert
4. 스크립트 목적 : 게임 내 특정 에러 로그 작업 기록
5. 매개변수
	@m_idPlayer char(7)			: 플레이어 ID
	@serverindex char(2)		: 서버군
	@account varchar(32)		: 플레이어 계정
	@nChannel int				: 체널 정보
	@chType char(1)				: 에러 타입
	@szError varchar(1024)		: 에러 내용
6. 리턴값 						: 없음
7. 수정 내역
    2009.12.11 / 박혜민 / 최초 작성
8. 샘플 실행 코드
    EXEC usp_SystemError_Insert '1452294', '75', 'igen0904', 1, 'A', 'test'
9. 조회 및 ident 값 초기화
	select * from tblSystemErrorLog
	delete tblSystemErrorLog
	DBCC checkident(tblSystemErrorLog ,reseed, 0)
============================================================*/


create proc [dbo].[usp_SystemError_Insert]
	@m_idPlayer char(7),
	@serverindex char(2),
	@account varchar(32),
	@nChannel int,
	@chType char(1), 
	@szError varchar(1024)
as
set nocount on

/*
	declare @q1 nvarchar(4000), @q2 nvarchar(4000)

	set @q1 = '
			INSERT INTO LOGGING_[&serverindex&]_DBF.dbo.tblSystemErrorLog(m_idPlayer, serverindex, account, nChannel, chType, szError)
			select @m_idPlayer, @serverindex, @account, @nChannel, @chType, @szError'
	set @q2 = replace(@q1, '[&serverindex&]', @serverindex)

	exec sp_executesql @q2, N'@m_idPlayer char(7), @serverindex char(2), @account varchar(32), @nChannel int, @chType char(1), @szError varchar(1024)', @m_idPlayer = @m_idPlayer, @serverindex = @serverindex, @account = @account, @nChannel = @nChannel, @chType = @chType, @szError = @szError

*/

	INSERT INTO tblSystemErrorLog(m_idPlayer, serverindex, account, nChannel, chType, szError)
	select @m_idPlayer, @serverindex, @account, @nChannel, @chType, @szError

RETURN
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.10.12
3. 스크립트 명 : usp_QuizUserLog_Insert
4. 스크립트 목적 : 퀴즈 이벤트 유저 입장 로그 Insert
5. 매개변수
	@m_idQuizEvent	int			: 퀴즈이벤트 회차
	@m_idPlayer		char(7)		: 플레이어 ID 
	@serverindex	char(2)		: 서버군
	@m_nChannel		int			: 서버군 상세체널
6. 리턴값 						: 없음
7. 수정 내역
    2009. 09.12 / 박혜민 / 최초 작성
8. 샘플 실행 코드
    EXEC usp_QuizUserLog_Insert '1', '0000002', '01', 2, 4
9. 조회 및 ident 값 초기화
	select * from tblQuizUserLog
	delete tblQuizUserLog
	DBCC checkident(tblQuizUserLog ,reseed, 0)
============================================================*/


CREATE proc [dbo].[usp_QuizUserLog_Insert]
	@m_idQuizEvent int,
	@m_idPlayer char(7),
	@serverindex char(2),
	@m_nChannel int

AS
set nocount on

/*
	declare @q1 nvarchar(4000), @q2 nvarchar(4000)

	set @q1 = '
			INSERT INTO LOGGIN_&serverindex&_DBF.dbo.tblQuizUserLog(m_idQuizEvent, m_idPlayer, serverindex, m_nChannel)
				select @m_idQuizEvent, @m_idPlayer, @serverindex, @m_nChannel '
	set @q2 = replace(@q1, '&serverindex&', @serverindex)

	exec sp_executesql @q2, N' @m_idQuizEvent int, @m_idPlayer char(7), @serverindex char(2), @m_nChannel int, @m_chState char(1)', @m_idQuizEvent = @m_idQuizEvent, @m_idPlayer = @m_idPlayer, @serverindex = @serverindex, @m_nChannel = @m_nChannel, @m_chState = @m_chState

*/

	insert into tblQuizUserLog(m_idQuizEvent, m_idPlayer, serverindex, m_nChannel)
	select @m_idQuizEvent, @m_idPlayer, @serverindex, @m_nChannel


RETURN
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.10.09
3. 스크립트 명 : usp_QuizLog_Update
4. 스크립트 목적 : 퀴즈 이벤트 진행 관련 로그 Update
5. 매개변수
	@serverindex	char(2)			: 서버군
	@idQuizEvent	int				: 퀴즈이벤트 회차
	@nChannel		int				: 서버군 상세체널
	@nWinnerCount	int				: 우승자 수
	@nQuizCount		int				: 풀이한 총 문제 수

6. 리턴값 							: 없음
7. 수정 내역
    2009. 09.09 / 박혜민 / 최초 작성
8. 샘플 실행 코드
    EXEC usp_QuizLog_Insert 1, '01', 6, 1
    EXEC usp_QuizLog_Update 1, '01', 6, 500, 5
9. 조회 및 ident 값 초기화
	select * from tblQuizLog
	delete tblQuizLog
	DBCC checkident(tblQuizLog ,reseed, 0)
============================================================*/


CREATE proc [dbo].[usp_QuizLog_Update]
	@idQuizEvent	int,
	@serverindex	char(2),
	@nChannel		int,
	@nWinnerCount	int,
	@nQuizCount		int
AS
set nocount on

/*
declare @q1 nvarchar(4000), @q2 nvarchar(4000)

set @q1 = '
	if exists (select * from LOGGIN_[&serverindex&]_DBF.dbo.tblQuizLog where serverindex = @serverindex and m_nChannel = @nChannel and m_idQuizEvent = @idQuizEvent and End_Time is NULL)
		begin
			update LOGGIN_[&serverindex&]_DBF.dbo.tblQuizLog
			set End_Time = getdate(), m_nWinnerCount = @nWinnerCount, m_nQuizCount = @nQuizCount
			where serverindex = @serverindex and m_nChannel = @nChannel and m_idQuizEvent = @idQuizEvent and End_Time is NULL
		end
	else
		begin
			update LOG_[&serverindex&]_DBF.dbo.tblQuizLog
			set End_Time = getdate(), m_nWinnerCount = @nWinnerCount, m_nQuizCount = @nQuizCount
			where serverindex = @serverindex and m_nChannel = @nChannel and m_idQuizEvent = @idQuizEvent and End_Time is NULL
		end '
set @q2 = replace(@q1, '[&serverindex&]', @serverindex)

exec sp_executesql @q2, N'@serverindex char(2), @idQuizEvent int, @nChannel int, @nWinnerCount int, @nQuizCount int', @serverindex = @serverindex, @idQuizEvent = @idQuizEvent, @nChannel = @nChannel, @nWinnerCount = @nWinnerCount, @nQuizCount = @nQuizCount
*/

	if exists (select * from tblQuizLog (nolock) where serverindex = @serverindex and m_nChannel = @nChannel and m_idQuizEvent = @idQuizEvent and End_Time is NULL)
		begin
			update tblQuizLog
			set End_Time = getdate(), m_nWinnerCount = @nWinnerCount, m_nQuizCount = @nQuizCount
			where serverindex = @serverindex and m_nChannel = @nChannel and m_idQuizEvent = @idQuizEvent and End_Time is NULL
		end

RETURN
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.10.09
3. 스크립트 명 : usp_QuizLog_Insert
4. 스크립트 목적 : 퀴즈 이벤트 진행 관련 로그 Insert
5. 매개변수
	@serverindex	char(2)				: 서버군
	@idQuizEvent	int				: 퀴즈이벤트 회차
	@nChannel	int				: 서버군 상세체널
	@nQuizType	int				: 퀴즈타입
6. 리턴값 						: 없음
7. 수정 내역
    2009. 09.09 / 박혜민 / 최초 작성
8. 샘플 실행 코드
    EXEC usp_QuizLog_Insert '01', '1', 1, 1
9. 조회 및 ident 값 초기화
	select * from tblQuizLog
	delete tblQuizLog
	DBCC checkident(tblQuizLog ,reseed, 0)
============================================================*/


CREATE proc [dbo].[usp_QuizLog_Insert]
	@idQuizEvent	int,
	@serverindex	char(2),
	@nChannel	int,
	@nQuizType	int
AS
set nocount on

/*
	declare @q1 nvarchar(4000), @q2 nvarchar(4000)

	set @q1 = '
			INSERT INTO LOGGING_[&serverindex&]_DBF.dbo.tblQuizLog(m_idQuizEvent, serverindex, m_nChannel, m_nQuizType)
			select @idQuizEvent, @serverindex, @nChannel, @nQuizType'
	set @q2 = replace(@q1, '[&serverindex&]', @serverindex)

	exec sp_executesql @q2, N'@serverindex char(2), @idQuizEvent int, @nChannel int, @nQuizType int ', @serverindex = @serverindex, @idQuizEvent = @idQuizEvent, @nChannel = @nChannel, @nQuizType = @nQuizType

*/

	INSERT INTO tblQuizLog(m_idQuizEvent, serverindex, m_nChannel, m_nQuizType)
	select @idQuizEvent, @serverindex, @nChannel, @nQuizType

RETURN
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[usp_QuizID_Select] 
	@serverindex char(2)

as 
set nocount on

	declare @m_idQuizEvent int
	
	select @m_idQuizEvent = isnull(max(m_idQuizEvent),0) from dbo.tblQuizLog (nolock)
	where serverindex = @serverindex 

	select QuizID = @m_idQuizEvent
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.10.12
3. 스크립트 명 : usp_QuizAnswerLog_Insert
4. 스크립트 목적 : 퀴즈 이벤트 진행 관련 로그 Insert
5. 매개변수
	@m_idQuizEvent	int					퀴즈이벤트 회차
	@m_idPlayer		char (7)			서버군
	@serverindex	char (2)			플레이어 아이디
	@m_nChannel		int					서버군 상세체널
	@m_nQuizNum		int					문제 번호
	@m_nSelect		int					유저가 선택한 문제의 보기
	@m_nAnswer		int					문제의 정답

6. 리턴값 						: 없음
7. 수정 내역
    2009. 09.12 / 박혜민 / 최초 작성
8. 샘플 실행 코드
    EXEC usp_QuizAnswerLog_Insert '1', '0000002', '01', 1, 2, 2, 2
9. 조회 및 ident 값 초기화
	select * from tblQuizAnswerLog
	delete tblQuizAnswerLog
	DBCC checkident(tblQuizAnswerLog ,reseed, 0)
============================================================*/


CREATE proc [dbo].[usp_QuizAnswerLog_Insert]
	@m_idQuizEvent	int,
	@m_idPlayer		char (7),
	@serverindex	char (2),
	@m_nChannel		int,
	@m_nQuizNum		int,
	@m_nSelect		int,
	@m_nAnswer		int

AS
set nocount on

/*
	declare @q1 nvarchar(4000), @q2 nvarchar(4000)

	set @q1 = '
			INSERT INTO LOG_&serverindex&_DBF.dbo.tblQuizAnswerLog(m_idQuizEvent, m_idPlayer, serverindex, m_nChannel, m_nQuizNum, m_nSelect, m_nAnswer)
			select @m_idQuizEvent, @m_idPlayer, @serverindex, @m_nChannel, @m_nQuizNum, @m_nSelect, @m_nAnswer'
	set @q2 = replace(@q1, '&serverindex&', @serverindex)

	exec sp_executesql @q2, N'@serverindex char(2), @m_idQuizEvent int, @m_idPlayer char(7), @m_nChannel int, @m_nQuizNum int, @m_nSelect int, @m_nAnswer int', @serverindex = @serverindex, @m_idQuizEvent = @m_idQuizEvent, @m_idPlayer = @m_idPlayer, @m_nChannel = @m_nChannel, @m_nQuizNum = @m_nQuizNum, @m_nSelect = @m_nSelect, @m_nAnswer = @m_nAnswer
*/


	insert into tblQuizAnswerLog(m_idQuizEvent, m_idPlayer, serverindex, m_nChannel, m_nQuizNum, m_nSelect, m_nAnswer)
	select @m_idQuizEvent, @m_idPlayer, @serverindex, @m_nChannel, @m_nQuizNum, @m_nSelect, @m_nAnswer


RETURN
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_CampusPointLog_Insert    Script Date: 2009-12-01 오후 3:04:25 ******/

/*============================================================
1. 작성자 : 박혜민
2. 작성일 : 2009.11.24
3. 스크립트 명 : usp_CampusPointLog_Insert
4. 스크립트 목적 : 사제 포인트에 대한 기록
5. 매개변수
	@m_idPlayer		char(7)		: 플레이어 ID
	@serverindex	char(2)		: 서버군
	@chState		char(1)		: 상태값 (Q: 퀘스트, P: 플레이어)
	@nPrevPoint		int			: 변경 전 사제 포인트
	@nCurrPoint		int			: 변경 후 사제 포인트(현재포인트)
6. 리턴값 						: 없음
7. 수정 내역
8. 샘플 실행 코드
    EXEC usp_CampusPointLog_Insert '0000001', '01', 'Q', 0, 10 
9. 조회 및 ident 값 초기화
	select * from tblCampus_PointLog
	delete tblCampus_PointLog
	DBCC checkident(tblCampus_PointLog ,reseed, 0)
============================================================*/


CREATE proc [dbo].[usp_CampusPointLog_Insert]
	@m_idPlayer	char(7),
	@serverindex	char(2),
	@chState	char(1),
	@nPrevPoint	int,
	@nCurrPoint	int
AS
set nocount on

/*
	declare @q1 nvarchar(4000), @q2 nvarchar(4000)

	set @q1 = '
			INSERT INTO LOGGING_[&serverindex&]_DBF.dbo.tblCampus_PointLog(m_idPlayer, serverindex, chState, nPrevPoint, nCurrPoint)
			select @m_idPlayer, @serverindex, @chState, @nPrevPoint, @nCurrPoint'
	set @q2 = replace(@q1, '[&serverindex&]', @serverindex)

	exec sp_executesql @q2, N'@m_idPlayer char(7), @serverindex char(2), @chState char(1), @nPrevPoint int, @nCurrPoint int', @m_idPlayer = @m_idPlayer, @serverindex = @serverindex, @chState = @chState, @nPrevPoint = @nPrevPoint, @nCurrPoint = @nCurrPoint

*/

	INSERT INTO tblCampus_PointLog(m_idPlayer, serverindex, chState, nPrevPoint, nCurrPoint)
	select @m_idPlayer, @serverindex, @chState, @nPrevPoint, @nCurrPoint

RETURN
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_CampusLog_Insert    Script Date: 2009-12-01 오후 3:04:25 ******/  
  
/*============================================================  
1. 작성자 : 박혜민  
2. 작성일 : 2009.11.24  
3. 스크립트 명 : usp_CampusLog_Insert  
4. 스크립트 목적 : 사제 관계 생성에 대한 기록  
5. 매개변수  
 @m_idMaster  char(7)    : 스승 ID  
 @serverindex char(2)    : 서버군  
 @idCampus  int     : 사제 ID  
 @m_idPupil  char(7)    : 상대방 ID  
 @chState  char(1)    : 상태값 (T: 맺음, F: 끊음)  
6. 리턴값       : 없음  
7. 수정 내역  
8. 샘플 실행 코드  
    EXEC usp_CampusLog_Insert '0000005', '01', 1, '0000006', 'T'   
9. 조회 및 ident 값 초기화  
 select * from tblCampusLog  
 delete tblCampusLog  
 DBCC checkident(tblCampusLog ,reseed, 0)  
============================================================*/  
  
  
CREATE proc [dbo].[usp_CampusLog_Insert]  
 @m_idMaster  char(7),  
 @serverindex char(2),    
 @idCampus  int,   
 @m_idPupil  char(7),  
 @chState  char(1)  
AS  
set nocount on  
  
/*  
 declare @q1 nvarchar(4000), @q2 nvarchar(4000)  
  
 set @q1 = '  
   INSERT INTO LOGGING_[&serverindex&]_DBF.dbo.tblCampusLog(m_idMaster, serverindex, m_idPupil, idCampus, chState)  
   select @m_idMaster, @serverindex, @idCampus, @m_idPupil, @chState'  
 set @q2 = replace(@q1, '[&serverindex&]', @serverindex)  
  
 exec sp_executesql @q2, N'@serverindex char(2), @m_idMaster char(7), @m_idPupil char(7), @idCampus int, @chState char(1)', @serverindex = @serverindex, @m_idMaster = @m_idMaster, @idCampus = @idCampus, @m_idPupil = @m_idPupil, @chState = @chState  
  
*/  
  
 INSERT INTO tblCampusLog(m_idMaster, serverindex, idCampus, m_idPupil, chState)  
 select @m_idMaster, @serverindex, @idCampus, @m_idPupil, @chState  
  
RETURN  
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LOG_STR]
	@iGu 								CHAR(2),
	@im_idPlayer 				CHAR(7),
	@iserverindex				CHAR(2),
	--1:LOG_LEVELUP_TBL
	@im_nExp1					BIGINT 					= 0,
	@im_nLevel					INT 							= 0,
	@im_nJob						INT 							= 0,
	@im_nJobLv					INT 							= 0,
	@im_nFlightLv				INT 							= 0,
	@im_nStr						INT 							= 0,
	@im_nDex						INT 							= 0,
	@im_nInt 						INT 							= 0,
	@im_nSta						INT 							= 0,
	@im_nRemainGP			INT 							= 0,
	@im_nRemainLP			INT 							= 0,
	@iState							CHAR(1)					= '',
	--2:LOG_DEATH_TBL
	@idwWorldID					INT 							= 0,
	@ikilled_m_szName		VARCHAR(32) 		= '',
	@im_vPos_x					REAL 						= 0,
	@im_vPos_y					REAL 						= 0,
	@im_vPos_z					REAL						= 0,
	@iattackPower				INT 							= 0,
	@imax_HP						INT 							= 0,
	--3:LOG_ITEM_TBL
	@im_GetszName			VARCHAR(32) 		= '',
	@im_dwGold					INT 							= 0,
	@im_nRemainGold		INT 							= 0,
	@iItem_UniqueNo			INT 							= 0,
	@iItem_Name					VARCHAR(32) 		= '',
	@iItem_durability			INT 							= 0,
	@iItem_count					INT 							= 0,
	--4:LOG_UNIQUE_TBL
	@iItem_AddLv 				INT 							= 0,
	--5:LOG_LOGIN_TBL
	@iStart_Time					CHAR(14) 				= '',
	@iTotalPlayTime			INT 							= 0,	
	@iremoteIP						VARCHAR(16) 		= '',
	--6:LOG_QUEST_TBL
	@iQuest_Index				INT 							= 0,
	--8:LOG_SVRDOWN_TBL
	--9:LOG_USER_CNT_TBL
	--A:LOG_PVP_TBL
	@ikilled_m_idPlayer   	CHAR(7)					=''
	--B:LOG_PK_TBL


/*******************************************************
	Gu 구분
   L1 : 로그 레벨업
   L2 : 로그 사망
   L3 : 로그 아이템
   L4 : 로그 유니크
   L5 : 로그 접속
   L6 : 로그 퀘스트 시작
   L7 : 로그 퀘스트 종료
   L8 : 로그 서버다운
   L9 : 로그 동시접속

*******************************************************/
AS
set nocount on
/***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************



	LOG 관련 스토어드
	작성자 : 최석준
	작성일 : 2003.10.17 



***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************/

DECLARE @os_date CHAR(14)
  SELECT @os_date = CONVERT(CHAR(8),GETDATE(),112) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,GETDATE())),2)

IF @iGu = 'L1'
	BEGIN
			/*************************************************************
			
				로그 레벨업
				@iGu = 'L1'
			
			*************************************************************/
			

			
			INSERT LOG_LEVELUP_TBL
				(
					m_idPlayer,
					serverindex,
					m_nExp1,
					m_nLevel,
					m_nJob,
					m_nJobLv,
					m_nFlightLv,
					m_nStr,
					m_nDex,
					m_nInt,
					m_nSta,
					m_nRemainGP,
					m_nRemainLP,
					m_dwGold,
					TotalPlayTime,
					State,
					s_date
				)
			VALUES
				(
					@im_idPlayer,
					@iserverindex,
					@im_nExp1,
					@im_nLevel,
					@im_nJob,
					@im_nJobLv,
					@im_nFlightLv,
					@im_nStr,
					@im_nDex,
					@im_nInt,
					@im_nSta,
					@im_nRemainGP,
					@im_nRemainLP,
					@iattackPower,	
					@imax_HP,
					@iState,
					@os_date

			)
			RETURN
	END

/*
  	로그 레벨업
	 ex ) 
   	LOG_STR 'L1', @im_idPlayer,@iserverindex,@im_nExp1,@im_nLevel,@im_nJob,@im_nJobLv,@im_nFlightLv,
							  @im_nStr,@im_nDex,@im_nInt,@im_nSta,@im_nRemainGP,@im_nRemainLP,@iState,
							  0,'',0,0,0,	@iattackPower	(m_dwGold),	@imax_HP			(TotalPlayTime)

   	LOG_STR 'L1', '000001','01',0,1,0,1,1,
							  15,15,15,15,0,0,'0'
							  0,'',0,0,0,0,0
*/
ELSE
IF @iGu = 'L2'
	BEGIN
			/*************************************************************
			
				로그 사망
				@iGu = 'L2'
			
			*************************************************************/
			INSERT  LOG_DEATH_TBL 
				(
					m_idPlayer,
					serverindex,
					dwWorldID,		
					killed_m_szName,
					m_vPos_x,
					m_vPos_y,
					m_vPos_z,
					m_nLevel,
					attackPower,
					max_HP,
					s_date
				)
			VALUES 
				(
					@im_idPlayer,
					@iserverindex,
					@idwWorldID,		
					@ikilled_m_szName,
					@im_vPos_x,
					@im_vPos_y,
					@im_vPos_z,
					@im_nLevel,
					@iattackPower,
					@imax_HP,
					@os_date
				)
			RETURN
	END
/*
  	로그 사망
	 ex ) 
   	LOG_STR 'L2', @im_idPlayer,@iserverindex,0,@im_nLevel,0,0,0,
							  0,0,0,0,0,0,'',
							  @idwWorldID,@ikilled_m_szName,@im_vPos_x,@im_vPos_y,@im_vPos_z,@iattackPower,@imax_HP

   	LOG_STR 'L2', '000001','01',0,10,0,0,0,
							  0,0,0,0,0,0,'0'
							  1,'라울프',0.0,0.0,0.0,1,1	
*/

ELSE
IF @iGu = 'L3'
	BEGIN
			/*************************************************************
			
				로그 아이템
				@iGu = 'L3'
			
			*************************************************************/
		IF @iState = 'E'
			BEGIN
					INSERT  LOG_ITEM_EVENT_TBL 
						(
							m_szName,
							serverindex,
							m_GetszName,
							dwWorldID,
							m_dwGold,
							m_nRemainGold,
							Item_UniqueNo,
							Item_Name,
							Item_durability,
							m_nAbilityOption,
							m_GetdwGold,
							Item_count,
							State,
							s_date
						)
					VALUES 
						(
							@ikilled_m_szName,
							@iserverindex,
							@im_GetszName,
							@idwWorldID,
							@im_dwGold,
							@im_nRemainGold,
							@iItem_UniqueNo,
							@iItem_Name,
							@iItem_durability,
							@iItem_AddLv ,
							@im_nExp1,
							@iItem_count,
							@iState,
							@os_date
						)
			END
		ELSE
		IF @iState in ('1','2','3','4','5','6','7','8','9','0')
			BEGIN
					INSERT  LOG_BILLING_ITEM_TBL 
						(
							m_szName,
							serverindex,
							m_GetszName,
							dwWorldID,
							m_dwGold,
							m_nRemainGold,
							Item_UniqueNo,
							Item_Name,
							Item_durability,
							m_nAbilityOption,
							m_GetdwGold,
							Item_count,
							State,
							s_date
						)
					VALUES 
						(
							@ikilled_m_szName,
							@iserverindex,
							@im_GetszName,
							@idwWorldID,
							@im_dwGold,
							@im_nRemainGold,
							@iItem_UniqueNo,
							@iItem_Name,
							@iItem_durability,
							@iItem_AddLv ,
							@im_nExp1,
							@iItem_count,
							@iState,
							@os_date
						)
			END
		ELSE
			BEGIN
					INSERT  LOG_ITEM_TBL 
						(
							m_szName,
							serverindex,
							m_GetszName,
							dwWorldID,
							m_dwGold,
							m_nRemainGold,
							Item_UniqueNo,
							Item_Name,
							Item_durability,
							m_nAbilityOption,
							m_GetdwGold,
							Item_count,
							State,
							s_date
						)
					VALUES 
						(
							@ikilled_m_szName,
							@iserverindex,
							@im_GetszName,
							@idwWorldID,
							@im_dwGold,
							@im_nRemainGold,
							@iItem_UniqueNo,
							@iItem_Name,
							@iItem_durability,
							@iItem_AddLv ,
							@im_nExp1,
							@iItem_count,
							@iState,
							@os_date
						)					
			END

			RETURN
	END

/*
  	로그 아이템
	 ex ) 
   	LOG_STR 'L3', @im_idPlayer,@iserverindex,0,0,0,0,0,
							  0,0,0,0,0,0,@iState,
							    @idwWorldID,@ikilled_m_szName(m_szName),0,0,0,0,0,
							  @im_GetszName,@im_dwGold,@im_nRemainGold,@iItem_UniqueNo,@iItem_Name,@iItem_durability,@iItem_count

   	LOG_STR 'L3', '000001','01',0,0,0,0,0,
							  0,0,0,0,0,0,'0'
							  0,'샛별공주',0,0,0,0,0,
							  '마르쉐',100,100,1,'우드소드',1,1
*/
ELSE
IF @iGu = 'L4'
	BEGIN
			/*************************************************************
			
				로그 유니크
				@iGu = 'L4'
			
			*************************************************************/
			INSERT  LOG_UNIQUE_TBL 
				(
					m_idPlayer,
					serverindex,
					dwWorldID,
					m_vPos_x,
					m_vPos_y,
					m_vPos_z,
					Item_Name,
					Item_AddLv,
					s_date
				)
			VALUES 
				(
					@im_idPlayer,
					@iserverindex,
					@idwWorldID,
					@im_vPos_x,
					@im_vPos_y,
					@im_vPos_z,
					@iItem_Name,
					@iItem_AddLv,
					@os_date
				)
			RETURN
	END

/*
  	로그 유니크
	 ex ) 
   	LOG_STR 'L4', @im_idPlayer,@iserverindex,0,0,0,0,0,
								  0,0,0,0,0,0,'0',
								 @idwWorldID,'',@im_vPos_x,@im_vPos_y,@im_vPos_z,0,0,
								 '',0,0,0,@iItem_Name,0,0
								  @iItem_AddLv

   	LOG_STR 'L4', '000001','01',0,0,0,0,0,
							  	0,0,0,0,0,0,'0'
							  	0,'',0,0,0,0,0,
							  	'',0,0,0,'',0,0,
								10
*/

ELSE
IF @iGu = 'L5'
	BEGIN
			/*************************************************************
			
				로그 접속 
				@iGu = 'L5'
			
			*************************************************************/
			INSERT  LOG_LOGIN_TBL 
				(
					m_idPlayer,
					serverindex,
					dwWorldID,
					Start_Time,
					End_Time,
					TotalPlayTime,
					m_dwGold,
					remoteIP
				)
			VALUES 
				(
					@im_idPlayer,
					@iserverindex,
					@idwWorldID,
					@iStart_Time,					
					@os_date, 

					@iTotalPlayTime,
					@im_dwGold,
					@iremoteIP
				)
			RETURN
	END
/*
  	로그 접속
	 ex ) 
   	LOG_STR 'L5', @im_idPlayer,@iserverindex,0,0,0,0,0,
								  0,0,0,0,0,0,'',
								  @idwWorldID,'',0,0,0,0,0,
								  '',@im_dwGold,0,0,'',0,0,
								0,
								@iStart_Time,@iTotalPlayTime,@iremoteIP

   	LOG_STR 'L5', '000001','01',0,0,0,0,0,
							  	0,0,0,0,0,0,'0'
							  	0,'',0,0,0,0,0,
							  	'',10000,0,0,'',0,0,
								0,
								'20030930123123',100,'61.33.151.12'

*/

ELSE
IF @iGu = 'L6'
	BEGIN
			/*************************************************************
			
				로그 퀘스트 시작
				@iGu = 'L6'
			
			*************************************************************/
			INSERT  LOG_QUEST_TBL 
				(
					m_idPlayer,
					serverindex,
					Quest_Index,
					State,
					Start_Time,
					End_Time
				)
			VALUES 
				(
					@im_idPlayer,
					@iserverindex,
					@iQuest_Index,
					@iState,
					@os_date,
					@iStart_Time  -- End_Time 대치 
				)
			RETURN
	END

/*
  	로그 퀘스트 시작
	 ex ) 
   	LOG_STR 'L6', @im_idPlayer,@iserverindex,0,0,0,0,0,
								  0,0,0,0,0,0,@iState,
								  0,'',0,0,0,0,0,
								  '',0,0,0,'',0,0,
								0,
								@iStart_Time,	0,'',
								@iQuest_Index

   	LOG_STR 'L6', '000001','01',0,0,0,0,0,
							  	0,0,0,0,0,0,'0'
							  	0,'',0,0,0,0,0,
							  	'',0,0,0,'',0,0,
								0,
								'20030930123123',0,'0',
								1

*/

ELSE
IF @iGu = 'L7'
	BEGIN
			/*************************************************************
			
				로그 퀘스트 종료
				@iGu = 'L7'
			
			*************************************************************/
			UPDATE  LOG_QUEST_TBL 
					SET State = 'Q',
							End_Time = @os_date
			 WHERE 	m_idPlayer = @im_idPlayer
				   AND	serverindex = @iserverindex
				   AND	Quest_Index = @iQuest_Index
			RETURN
	END
/*
  	로그 퀘스트 종료
	 ex ) 
   	LOG_STR 'L7', @im_idPlayer,@iserverindex,0,0,0,0,0,
								  0,0,0,0,0,0,'',
								  0,'',0,0,0,0,0,
								  '',0,0,0,'',0,0,
								0,
								'',	0,'',
								@iQuest_Index

   	LOG_STR 'L7', '000001','01',0,0,0,0,0,
							  	0,0,0,0,0,0,''
							  	0,'',0,0,0,0,0,
							  	'',0,0,0,'',0,0,
								0,
								'',0,'0',
								1
*/

ELSE
IF @iGu = 'L8'
	BEGIN
			/*************************************************************
			
				로그 서버다운
				@iGu = 'L8'
			
			*************************************************************/
			INSERT  LOG_SVRDOWN_TBL 
				(
					serverindex,
					Start_Time,
					End_Time
				)
			VALUES 
				(
					@iserverindex,
					@iStart_Time,

					@os_date

				)
			RETURN
	END

/*
  	로그 서버다운
	 ex ) 
   	LOG_STR 'L8', '',@iserverindex,0,0,0,0,0,
								  0,0,0,0,0,0,'',
								  0,'',0,0,0,0,0,
								  '',0,0,0,'',0,0,
								0,
								@iStart_Time

   	LOG_STR 'L8', ''','01',0,0,0,0,0,
							  	0,0,0,0,0,0,''
							  	0,'',0,0,0,0,0,
							  	'',0,0,0,'',0,0,
								0,
								'20030923122312'
*/

ELSE
IF @iGu = 'L9'
	BEGIN
			/*************************************************************
			
				로그 동시 접속
				@iGu = 'L9'
			
			*************************************************************/
			INSERT  LOG_USER_CNT_TBL 
				(
					serverindex,
					s_date,
					number
				)
			VALUES 
				(
					@iserverindex,
					@os_date,
					@im_nExp1

				)
			RETURN
	END

/*
  	로그 동시 접속
	 ex ) 
   	LOG_STR 'L9','',@iserverindex,@im_nExp1 --(number)

   	LOG_STR 'L9','',@iserverindex,234
*/


ELSE
IF @iGu = 'LA'
	BEGIN
			/*************************************************************
			
				로그 PVP
				@iGu = 'LA'
			
			*************************************************************/
			INSERT  LOG_PK_PVP_TBL 
				(
					m_idPlayer,
					serverindex,
					m_nLevel,
					m_vPos_x,
					m_vPos_z,
					killed_m_idPlayer,
					killed_m_nLevel,
					m_GetPoint,
					m_nSlaughter,
					m_nFame,
					killed_m_nSlaughter,
					killed_m_nFame,
					m_KillNum,
					State,
					s_date
				)
			VALUES 
				(
					@im_idPlayer,
					@iserverindex,
					@im_nLevel,
					@im_vPos_x,
					@im_vPos_z,
					@ikilled_m_idPlayer,

					@im_nExp1, 	--killed_m_nLevel,
					@im_nJob, 	--m_GetPoint,
					@im_nJobLv, 	--m_nSlaughter,
					@im_nStr, --m_nFame,
					@im_nDex, --killed_m_nSlaughter,
					@im_nInt, --killed_m_nFame,
					@im_nFlightLv, -- m_KillNum,
					@iState, --State,
					@os_date
				)
			RETURN
	END

/*
  	로그 PK, PVP
	 ex ) 
   	LOG_STR 'LA', @im_idPlayer,@iserverindex,@im_nExp1(killed_m_nLevel),@im_nLevel,@im_nJob(m_GetnSlaughter),@im_nJobLv(m_nSlaughter),@im_nFlightLv(m_KillNum),
							   @im_nStr(m_nFame),@im_nDex(killed_m_nSlaughter),@im_nInt(killed_m_nFame),0,0,0,'@iState',
							  0,'',@im_vPos_x,0,@im_vPos_z,0,0,
							  '',0,0,0,'',0,0,
							  0,
							  '',0,'',0,@ikilled_m_idPlayer


   	LOG_STR 'LA', '000001','01',15,20,10,100,200,
							   300,400,500,0,0,0,'K',
							  0,'',0.0,0,0.0,0,0,
							  '',0,0,0,'',0,0,
							  0,
							  '',0,'',0,'000002'
*/

ELSE
IF @iGu = 'LC'
	BEGIN
			INSERT  LOG_ITEM_SEND_TBL
				(
					m_idPlayer,
					serverindex,
					m_nNo,
					m_szItemName,
					m_nItemNum,
					s_date,
					m_bItemResist,
					m_nResistAbilityOption
				)
			VALUES 
				(
					@im_idPlayer,
					@iserverindex,
					@im_nExp1,
					@iItem_Name,
					@iItem_count,
					@os_date,
					@im_nStr, --m_bItemResist
					@im_nDex -- m_nResistAbilityOption
				)
			RETURN
	END

/*
	 아이템 지급 현황

   	LOG_STR 'LC', @im_idPlayer,@iserverindex,@im_nExp1(m_nNo),0,0,0,0,
							   @im_nStr(m_bItemResist),@im_nDex(m_nResistAbilityOption),0,0,0,0,'',
							  0,'',0,0,0,0,0,
							  '',0,0,0,@iItem_Name,0,@iItem_count

   	LOG_STR 'LC', '000001','01',1,0,0,0,0,
							   0,0,0,0,0,0,'',
							  0,'',0,0,0,0,0,
							  '',0,0,0,'우든소드',0,1



*/

ELSE
IF @iGu = 'LD'
	BEGIN
			INSERT  LOG_ITEM_REMOVE_TBL
				(
					m_idPlayer,
					serverindex,
					m_nNo,
					m_szItemName,
					m_nItemNum,
					s_date,
					m_bItemResist,
					m_nResistAbilityOption
				)
			VALUES 
				(
					@im_idPlayer,
					@iserverindex,
					@im_nExp1,
					@iItem_Name,
					@iItem_count,
					@os_date,
					@im_nStr, --m_bItemResist
					@im_nDex -- m_nResistAbilityOption
				)
			RETURN
	END

/*


	 아이템 삭제 현황

   	LOG_STR 'LD', @im_idPlayer,@iserverindex,@im_nExp1(m_nNo),0,0,0,0,
							   @im_nStr(m_bItemResist),@im_nDex(m_nResistAbilityOption),0,0,0,0,'',
							  0,'',0,0,0,0,0,
							  '',0,0,0,@iItem_Name,0,@iItem_count

   	LOG_STR 'LD', '000001','01',1,0,0,0,0,
							   0,0,0,0,0,0,'',
							  0,'',0,0,0,0,0,
							  '',0,0,0,'우든소드',0,1
*/

ELSE
IF @iGu = 'LE'
	BEGIN
			INSERT  LOG_RESPAWN_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nExp1,
					@im_nLevel,
					@os_date
				)
			INSERT  LOG_RESPAWN_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nJob,
					@im_nJobLv,
					@os_date
				)
			INSERT  LOG_RESPAWN_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nFlightLv,
					@im_nStr,
					@os_date
				)
			INSERT  LOG_RESPAWN_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nDex,
					@im_nInt,
					@os_date
				)
			INSERT  LOG_RESPAWN_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nSta,
					@im_nRemainGP,
					@os_date
				)
			INSERT  LOG_RESPAWN_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nRemainLP,
					@idwWorldID,
					@os_date
				)
			INSERT  LOG_RESPAWN_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@iattackPower,
					@imax_HP,
					@os_date
				)
			INSERT  LOG_RESPAWN_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_dwGold,
					@im_nRemainGold,
					@os_date
				)
			INSERT  LOG_RESPAWN_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@iItem_UniqueNo,
					@iItem_durability,
					@os_date
				)
			INSERT  LOG_RESPAWN_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@iItem_count,
					@iItem_AddLv,
					@os_date
				)
			RETURN
	END

/*
	 리스폰 현황

   	LOG_STR 'LE', 0,0,@im_nExp1,@im_nLevel,@im_nJob,@im_nJobLv,@im_nFlightLv,
							   @im_nStr,@im_nDex,@im_nInt,@im_nSta,@im_nRemainGP,@im_nRemainLP,'',
							  @idwWorldID,'',0,0,0,@iattackPower,@imax_HP,
							  '',@im_dwGold,@im_nRemainGold,@iItem_UniqueNo,'',@iItem_durability,@iItem_count,@iItem_AddLv

   	LOG_STR 'LE', '','',1,1,1,1,1,
							   1,1,1,1,1,1,'',
							  1,'',0,0,0,1,1,
							  '',1,1,1,'',1,1,1
*/

ELSE
IF @iGu = 'LF'
	BEGIN
			INSERT  LOG_SKILL_FREQUENCY_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nExp1,
					@im_nLevel,
					@os_date
				)
			INSERT  LOG_SKILL_FREQUENCY_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nJob,
					@im_nJobLv,
					@os_date
				)
			INSERT  LOG_SKILL_FREQUENCY_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nFlightLv,
					@im_nStr,
					@os_date
				)
			INSERT  LOG_SKILL_FREQUENCY_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nDex,
					@im_nInt,
					@os_date
				)
			INSERT  LOG_SKILL_FREQUENCY_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nSta,
					@im_nRemainGP,
					@os_date
				)
			INSERT  LOG_SKILL_FREQUENCY_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_nRemainLP,
					@idwWorldID,
					@os_date
				)
			INSERT  LOG_SKILL_FREQUENCY_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@iattackPower,
					@imax_HP,
					@os_date
				)
			INSERT  LOG_SKILL_FREQUENCY_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@im_dwGold,
					@im_nRemainGold,
					@os_date
				)
			INSERT  LOG_SKILL_FREQUENCY_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@iItem_UniqueNo,
					@iItem_durability,
					@os_date
				)
			INSERT  LOG_SKILL_FREQUENCY_TBL
				(
					m_nid,
					m_nFrequency,
					s_date
				)
			VALUES 
				(
					@iItem_count,
					@iItem_AddLv,
					@os_date
				)
			RETURN
	END

/*
	 스킬사용 현황

   	LOG_STR 'LF', 0,0,@im_nExp1,@im_nLevel,@im_nJob,@im_nJobLv,@im_nFlightLv,
							   @im_nStr,@im_nDex,@im_nInt,@im_nSta,@im_nRemainGP,@im_nRemainLP,'',
							  @idwWorldID,'',0,0,0,@iattackPower,@imax_HP,
							  '',@im_dwGold,@im_nRemainGold,@iItem_UniqueNo,'',@iItem_durability,@iItem_count,@iItem_AddLv

   	LOG_STR 'LF', '','',1,1,1,1,1,
							   1,1,1,1,1,1,'',
							  1,'',0,0,0,1,1,
							  '',1,1,1,'',1,1,1
*/

set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE    PROC [dbo].[LOG_GUILD_STR]
@iGu CHAR(2)  = 'L1',
@im_idGuild CHAR(6)  = '000001',
@im_idPlayer CHAR(7)  = '0000001',
@iserverindex CHAR(2)  = '01',
@im_nGuildGold INT = 0,
@im_nLevel INT = 0,
@im_GuildLv INT = 0,
@iGuildPoint INT = 0,
@iDo_m_idPlayer CHAR(7)  = '',
@iState CHAR(1)  = '',
@im_Item INT = 0,
@im_GuildBank TEXT = '',
@im_nAbilityOption INT = 0,
@iItem_count INT = 0,
@iItem_UniqueNo INT = 0,
@is_date char(14) = ''
AS
set nocount on

DECLARE @os_date CHAR(14)
  SELECT @os_date = CONVERT(CHAR(8),GETDATE(),112) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,GETDATE())),2)

IF @iGu = 'L1'
	BEGIN
		INSERT LOG_GUILD_TBL
			(m_idGuild,m_idPlayer,serverindex,Do_m_idPlayer,State,s_date)
		VALUES
			(@im_idGuild,@im_idPlayer,@iserverindex,@iDo_m_idPlayer,@iState,@os_date)
	RETURN
	END

/*
  	길드 가입/탈퇴 로그
	 ex ) 
   	LOG_GUILD_STR 'L1', @im_idGuild,@im_idPlayer,@iserverindex,@im_nGuildGold,@im_nLevel,@im_GuildLv,@iGuildPoint,@iDo_m_idPlayer,@iState
   	LOG_GUILD_STR 'L1', '000001', '000001','01',0,0,0,0,'000002','J'

	@iState : 가입 J 탈퇴 L 퇴출 R

*/
ELSE
IF  @iGu = 'L2'
	BEGIN
		INSERT LOG_GUILD_BANK_TBL
			(m_idGuild,m_idPlayer,serverindex,m_nGuildGold,m_GuildBank,State,m_Item,m_nAbilityOption,Item_count ,Item_UniqueNo,s_date)
		VALUES
			(@im_idGuild,@im_idPlayer,@iserverindex,@im_nGuildGold,@im_GuildBank,@iState,@im_Item,@im_nAbilityOption,@iItem_count ,@iItem_UniqueNo,@os_date)
	RETURN
	END
/*
  	길드 창고 로그
	 ex ) 
   	LOG_GUILD_STR 'L2', @im_idGuild,@im_idPlayer,@iserverindex,@im_nGuildGold,@im_nLevel,@im_GuildLv,@iGuildPoint,@iDo_m_idPlayer,@iState,@im_Item,@im_GuildBank,@im_nAbilityOption,@iItem_count ,@iItem_UniqueNo
   	LOG_GUILD_STR 'L2', '000001', '000001','01',0,0,0,0,'000002','A','9,9,9''$',0,0,0


	@iState : 넣기 A 빼기 D 돈넣기 I 돈빼기 O 레벨업 L

*/
ELSE
IF  @iGu = 'L3'
	BEGIN
		INSERT LOG_GUILD_DISPERSION_TBL
			(m_idGuild,m_idPlayer,serverindex,State,s_date)
		VALUES
			(@im_idGuild,@im_idPlayer,@iserverindex,@iState,@os_date)
	RETURN
	END
/*
  	길드 해산 로그
	 ex ) 
   	LOG_GUILD_STR 'L3', @im_idGuild,@im_idPlayer,@iserverindex,@im_nGuildGold,@im_nLevel,@im_GuildLv,@iGuildPoint,@iDo_m_idPlayer,@iState
   	LOG_GUILD_STR 'L3', '000001', '000001','01',0,0,0,0,'','S'

	@iState : 시작일 S 해산일 E

*/
ELSE
IF  @iGu = 'L4'
	BEGIN
		INSERT LOG_GUILD_SERVICE_TBL
			(m_idGuild,m_idPlayer,serverindex,m_nLevel,m_GuildLv,GuildPoint,Gold,State,s_date)
		VALUES
			(@im_idGuild,@im_idPlayer,@iserverindex,@im_nLevel,@im_GuildLv,@iGuildPoint,@im_nGuildGold,@iState,@os_date)
	RETURN
	END
/*
  	길드 공헌 로그
	 ex ) 
   	LOG_GUILD_STR 'L4', @im_idGuild,@im_idPlayer,@iserverindex,@im_nGuildGold,@im_nLevel,@im_GuildLv,@iGuildPoint,@iDo_m_idPlayer,@iState
   	LOG_GUILD_STR 'L4', '000001', '000001','01',15,3,4,0,'','G'

	@iState : G 돈공헌 P PXP공헌
*/
ELSE
IF  @iGu = 'L5'
	BEGIN
		INSERT LOG_GUILD_WAR_TBL
			(m_idGuild,serverindex,f_idGuild,m_idWar,m_nCurExp,m_nGetExp,m_nCurPenya,m_nGetPenya,State,s_date,e_date)
		VALUES
			(@im_idGuild,@iserverindex,@im_idPlayer,@im_Item,@im_nGuildGold,@im_nLevel,@im_GuildLv,@iGuildPoint,@iState,@is_date,@os_date)
	RETURN
	END
/*
SELECT * FROM  LOG_GUILD_WAR_TBL
   길드전 로그
	 ex ) 
   	LOG_GUILD_STR 'L5', @im_idGuild,@im_idPlayer(f_idPlayer),@iserverindex,@im_nGuildGold(m_nCurExp),@im_nLevel(m_nGetExp),
											@im_GuildLv(m_nCurPenya),@iGuildPoint(m_nGetPenya),'',@iState,@im_Item(m_idWar),'',0,0,0,@is_date
   	LOG_GUILD_STR 'L5','000001', '000001','01',100,10,100,10,'','1',9,'',0,0,0,'20040717123012'

	@iState : 1 승 2 기권승 3 패 4 기권패
*/
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[LOG_USER_CNT_STR]
@iserverindex  	CHAR(2),
@im_channel int,
@im_01 INT = 0,
@im_02 INT = 0,
@im_03 INT = 0,
@im_04 INT = 0,
@im_05 INT = 0,
@im_06 INT = 0,
@im_07 INT = 0,
@im_08 INT = 0,
@im_09 INT = 0,
@im_10 INT = 0,
@im_11 INT = 0,
@im_12 INT = 0,
@im_13 INT = 0,
@im_14 INT = 0,
@im_15 INT = 0,
@im_16 INT = 0,
@im_17 INT = 0,
@im_18 INT = 0,
@im_19 INT = 0,
@im_20 INT = 0
/***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************



	LOG_USER_CNT_STR 스토어드
	작성자 : 최석준
	작성일 : 2003.12.19



***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************/
AS
set nocount on
DECLARE @os_date CHAR(14),@onumber INT

  SELECT @os_date = CONVERT(CHAR(8),GETDATE(),112) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,GETDATE())),2)

  SELECT @onumber = @im_01 + @im_02 + @im_03 + @im_04 + @im_05 
									 + @im_06 + @im_07 + @im_08 + @im_09 + @im_10 
									 + @im_11 + @im_12 + @im_13 + @im_14 + @im_15 
									 + @im_16 + @im_17 + @im_18 + @im_19 + @im_20

	INSERT LOG_USER_CNT_TBL
		(
			serverindex,
			s_date,
			number,
			m_channel,
			m_01,
			m_02,
			m_03,
			m_04,
			m_05,
			m_06,
			m_07,
			m_08,
			m_09,
			m_10,
			m_11,
			m_12,
			m_13,
			m_14,
			m_15,
			m_16,
			m_17,
			m_18,
			m_19,
			m_20
		)
	VALUES
		(
			@iserverindex,
			@os_date,
			@onumber,
			@im_channel,
			@im_01,
			@im_02,
			@im_03,
			@im_04,
			@im_05,
			@im_06,
			@im_07,
			@im_08,
			@im_09,
			@im_10,
			@im_11,
			@im_12,
			@im_13,
			@im_14,
			@im_15,
			@im_16,
			@im_17,
			@im_18,
			@im_19,
			@im_20
		)
RETURN
set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE proc [dbo].[LOG_ITEM_STR]
	@im_szName 				VARCHAR(32),
	@iserverindex				CHAR(2),
	@im_GetszName			VARCHAR(32) 		= '',
	@idwWorldID					INT 							= 0,
	@im_dwGold					INT 							= 0,
	@im_nRemainGold		INT 							= 0,
	@iItem_UniqueNo			INT 							= 0,
	@iItem_Name					VARCHAR(32) 		= '',
	@iItem_durability			INT 							= 0,
	@im_nAbilityOption 		INT 							= 0,	
	@Im_GetdwGold			INT 							= 0,	
	@iItem_count					INT 							= 0,
	@iState							CHAR(1)					= '',
	@im_nSlot0  					INT = 0,--: 어느 아이템 뱅크에서 빼냈는지?
	@im_nSlot1  					INT = 0,-- : 어느 아이템 뱅크에 넣었는지?
	@im_bItemResist   		INT = 0,-- : 속성 (예> 불, 물, 바람, 땅 )
	@im_nResistAbilityOption   INT = 0,--: m_bItemResist 옵션값
	@im_bCharged   INT = 0,
	@im_dwKeepTime  INT = 0,
	@im_nRandomOptItemId  BIGINT = 0,
	@inPiercedSize  INT = 0,
	@iadwItemId0  INT = 0,
	@iadwItemId1  INT = 0,
	@iadwItemId2  INT = 0,
	@iadwItemId3  INT = 0,
	@iadwItemId4  INT = 0,
	@iMaxDurability INT = 0
,@inPetKind int = 0, @inPetLevel int = 0, @idwPetExp int = 0, @iwPetEnergy int = 0, @iwPetLife int = 0
,@inPetAL_D int = 0, @inPetAL_C int = 0, @inPetAL_B int = 0, @inPetAL_A int = 0, @inPetAL_S int = 0
------------ ver.12
, @iadwItemId5 int = 0, @iadwItemId6 int = 0,@iadwItemId7 int = 0, @iadwItemId8 int = 0, @iadwItemId9 int = 0
, @inUMPiercedSize int = 0, @iadwUMItemId0 int = 0, @iadwUMItemId1 int = 0, @iadwUMItemId2 int = 0, @iadwUMItemId3 int = 0, @iadwUMItemId4 int = 0

AS
set nocount on
/***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************



	LOG 관련 스토어드
	작성자 : 최석준
	작성일 : 2003.10.17 



--20040908 컬럼추가
-- ALTER TABLE  LOG_ITEM_EVENT_TBL  ADD m_nSlot0  INT NULL, m_nSlot1 INT NULL, m_bItemResist  INT NULL, m_nResistAbilityOption  INT NULL
-- ALTER TABLE  LOG_BILLING_ITEM_TBL  ADD m_nSlot0  INT NULL, m_nSlot1 INT NULL, m_bItemResist  INT NULL, m_nResistAbilityOption  INT NULL
-- ALTER TABLE  LOG_ITEM_TBL  ADD m_nSlot0  INT NULL, m_nSlot1 INT NULL, m_bItemResist  INT NULL, m_nResistAbilityOption  INT NULL


***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************/

DECLARE @os_date CHAR(14)
  SELECT @os_date = CONVERT(CHAR(8),GETDATE(),112) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,GETDATE())),2)

	BEGIN
			/*************************************************************
			
				로그 아이템
				@iGu = 'L3'
			
			*************************************************************/
		IF @iState = 'E'
			BEGIN
					INSERT  LOG_ITEM_EVENT_TBL 
						(
							m_szName,
							serverindex,
							m_GetszName,
							dwWorldID,
							m_dwGold,
							m_nRemainGold,
							Item_UniqueNo,
							Item_Name,
							Item_durability,
							m_nAbilityOption,
							m_GetdwGold,
							Item_count,
							State,
							s_date,
							m_nSlot0,
							m_nSlot1,
							m_bItemResist ,
							m_nResistAbilityOption,
							m_bCharged,
							m_dwKeepTime,
							m_nRandomOptItemId,
							nPiercedSize,
							adwItemId0,
							adwItemId1,
							adwItemId2,
							adwItemId3,
							MaxDurability,
							adwItemId4,
							nPetKind, nPetLevel, dwPetExp, wPetEnergy, wPetLife, nPetAL_D, nPetAL_C, nPetAL_B, nPetAL_A, nPetAL_S
							, adwItemId5, adwItemId6, adwItemId7, adwItemId8, adwItemId9
							, nUMPiercedSize, adwUMItemId0, adwUMItemId1, adwUMItemId2, adwUMItemId3, adwUMItemId4
						)
					VALUES 
						(
							@im_szName,
							@iserverindex,
							@im_GetszName,
							@idwWorldID,
							@im_dwGold,
							@im_nRemainGold,
							@iItem_UniqueNo,
							@iItem_Name,
							@iItem_durability,
							@im_nAbilityOption ,
							@Im_GetdwGold,
							@iItem_count,
							@iState,
							@os_date,
							@im_nSlot0,
							@im_nSlot1,
							@im_bItemResist ,
							@im_nResistAbilityOption,
							@im_bCharged,
							@im_dwKeepTime,
							@im_nRandomOptItemId,
							@inPiercedSize,
							@iadwItemId0,
							@iadwItemId1,
							@iadwItemId2,
							@iadwItemId3,
							@iMaxDurability,
							@iadwItemId4
							,@inPetKind, @inPetLevel, @idwPetExp, @iwPetEnergy, @iwPetLife
							,@inPetAL_D, @inPetAL_C, @inPetAL_B, @inPetAL_A, @inPetAL_S
							, @iadwItemId5, @iadwItemId6, @iadwItemId7, @iadwItemId8, @iadwItemId9
							, @inUMPiercedSize, @iadwUMItemId0, @iadwUMItemId1, @iadwUMItemId2, @iadwUMItemId3, @iadwUMItemId4
						)
			END
		ELSE
		IF @iState in ('1','2','3','4','5','6','7','8','9','0')
			BEGIN
					INSERT  LOG_BILLING_ITEM_TBL 
						(
							m_szName,
							serverindex,
							m_GetszName,
							dwWorldID,
							m_dwGold,
							m_nRemainGold,
							Item_UniqueNo,
							Item_Name,
							Item_durability,
							m_nAbilityOption,
							m_GetdwGold,
							Item_count,
							State,
							s_date,
							m_nSlot0,
							m_nSlot1,
							m_bItemResist ,
							m_nResistAbilityOption,
							m_bCharged,
							m_dwKeepTime,
							m_nRandomOptItemId,
							nPiercedSize,
							adwItemId0,
							adwItemId1,
							adwItemId2,
							adwItemId3,
							MaxDurability,
							adwItemId4,
							nPetKind, nPetLevel, dwPetExp, wPetEnergy, wPetLife, nPetAL_D, nPetAL_C, nPetAL_B, nPetAL_A, nPetAL_S
							, adwItemId5, adwItemId6, adwItemId7, adwItemId8, adwItemId9
							, nUMPiercedSize, adwUMItemId0, adwUMItemId1, adwUMItemId2, adwUMItemId3, adwUMItemId4
						)
					VALUES 
						(
							@im_szName,
							@iserverindex,
							@im_GetszName,
							@idwWorldID,
							@im_dwGold,
							@im_nRemainGold,
							@iItem_UniqueNo,
							@iItem_Name,
							@iItem_durability,
							@im_nAbilityOption ,
							@Im_GetdwGold,
							@iItem_count,
							@iState,
							@os_date,
							@im_nSlot0,
							@im_nSlot1,
							@im_bItemResist ,
							@im_nResistAbilityOption,
							@im_bCharged,
							@im_dwKeepTime,
							@im_nRandomOptItemId,
							@inPiercedSize,
							@iadwItemId0,
							@iadwItemId1,
							@iadwItemId2,
							@iadwItemId3,
							@iMaxDurability,
							@iadwItemId4
							,@inPetKind, @inPetLevel, @idwPetExp, @iwPetEnergy, @iwPetLife
							,@inPetAL_D, @inPetAL_C, @inPetAL_B, @inPetAL_A, @inPetAL_S
							, @iadwItemId5, @iadwItemId6, @iadwItemId7, @iadwItemId8, @iadwItemId9
							, @inUMPiercedSize, @iadwUMItemId0, @iadwUMItemId1, @iadwUMItemId2, @iadwUMItemId3, @iadwUMItemId4
						)
			END
		ELSE
			BEGIN
					INSERT  LOG_ITEM_TBL 
						(
							m_szName,
							serverindex,
							m_GetszName,
							dwWorldID,
							m_dwGold,
							m_nRemainGold,
							Item_UniqueNo,
							Item_Name,
							Item_durability,
							m_nAbilityOption,
							m_GetdwGold,
							Item_count,
							State,
							s_date,
							m_nSlot0,
							m_nSlot1,
							m_bItemResist ,
							m_nResistAbilityOption,
							m_bCharged,
							m_dwKeepTime,
							m_nRandomOptItemId,
							nPiercedSize,
							adwItemId0,
							adwItemId1,
							adwItemId2,
							adwItemId3,
							MaxDurability,
							adwItemId4,
							nPetKind, nPetLevel, dwPetExp, wPetEnergy, wPetLife, nPetAL_D, nPetAL_C, nPetAL_B, nPetAL_A, nPetAL_S
							, adwItemId5, adwItemId6, adwItemId7, adwItemId8, adwItemId9
							, nUMPiercedSize, adwUMItemId0, adwUMItemId1, adwUMItemId2, adwUMItemId3, adwUMItemId4
						)
					VALUES 
						(
							@im_szName,
							@iserverindex,
							@im_GetszName,
							@idwWorldID,
							@im_dwGold,
							@im_nRemainGold,
							@iItem_UniqueNo,
							@iItem_Name,
							@iItem_durability,
							@im_nAbilityOption ,
							@Im_GetdwGold,
							@iItem_count,
							@iState,
							@os_date,
							@im_nSlot0,
							@im_nSlot1,
							@im_bItemResist ,
							@im_nResistAbilityOption,
							@im_bCharged,
							@im_dwKeepTime,
							@im_nRandomOptItemId,
							@inPiercedSize,
							@iadwItemId0,
							@iadwItemId1,
							@iadwItemId2,
							@iadwItemId3,
							@iMaxDurability,
							@iadwItemId4
							,@inPetKind, @inPetLevel, @idwPetExp, @iwPetEnergy, @iwPetLife
							,@inPetAL_D, @inPetAL_C, @inPetAL_B, @inPetAL_A, @inPetAL_S
							, @iadwItemId5, @iadwItemId6, @iadwItemId7, @iadwItemId8, @iadwItemId9
							, @inUMPiercedSize, @iadwUMItemId0, @iadwUMItemId1, @iadwUMItemId2, @iadwUMItemId3, @iadwUMItemId4
						)					
			END

			RETURN
	END

/*
  	로그 아이템
	 ex ) 
   	LOG_ITEM_STR 	@im_szName,
									@iserverindex	,
									@im_GetszName	,
									@idwWorldID,
									@im_dwGold,
									@im_nRemainGold,
									@iItem_UniqueNo,
									@iItem_Name		,
									@iItem_durability		,

									@im_nAbilityOption ,
									@Im_GetdwGold	,
									@iItem_count,
									@iState	,
									@im_nSlot0,
									@im_nSlot1,
									@im_bItemResist,
									@im_nResistAbilityOption
									@im_bCharged,
									@im_dwKeepTime,
									@im_nRandomOptItemId,
									@inPiercedSize,
									@iadwItemId0,
									@iadwItemId1,
									@iadwItemId2,
									@iadwItemId3

	LOG_ITEM_STR 	'세호페',
									'01',
									'제프',
									1,
									0,
									1000,
									-12341,
									'우든소드',
									1,
									3,
									123,
									1,
									'G',
									0,
									0,
									0,
									0,
									0,
									0,
									0,
									0,
									0,
									0,
									0,
									0
*/

set nocount off
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE      PROC [dbo].[LOG_GAMEMASTER_STR]
	@im_idPlayer 				CHAR(7),
	@iserverindex				CHAR(2),
	@iszWords					VARCHAR(256) 		= '',
	@im_idGuild					CHAR(6) = ''

/***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************



	LOG_GAMEMASTER_STR 스토어드
	작성자 : 송현석
	작성일 : 2004.01.20



***********************************************************************************
***********************************************************************************
***********************************************************************************
***********************************************************************************/

AS
set nocount on
DECLARE @os_date CHAR(14)

  SELECT @os_date = CONVERT(CHAR(8),GETDATE(),112) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(hh,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(mi,GETDATE())),2) 
									+ RIGHT('00' + CONVERT(VARCHAR(2),DATEPART(ss,GETDATE())),2)

	INSERT LOG_GAMEMASTER_TBL
		(
			m_idPlayer,
			serverindex,
			m_szWords,
			s_date,
			m_idGuild
		)
	VALUES
		(
			@im_idPlayer,
			@iserverindex,
			@iszWords,
			@os_date,
			@im_idGuild
		)
RETURN
set nocount off
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_BILLI__nPetK__43D61337]  DEFAULT ((0)) FOR [nPetKind]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_BILLI__nPetL__44CA3770]  DEFAULT ((0)) FOR [nPetLevel]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_BILLI__dwPet__45BE5BA9]  DEFAULT ((0)) FOR [dwPetExp]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_BILLI__wPetE__46B27FE2]  DEFAULT ((0)) FOR [wPetEnergy]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_BILLI__wPetL__47A6A41B]  DEFAULT ((0)) FOR [wPetLife]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_BILLI__nPetA__489AC854]  DEFAULT ((0)) FOR [nPetAL_D]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_BILLI__nPetA__498EEC8D]  DEFAULT ((0)) FOR [nPetAL_C]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_BILLI__nPetA__4A8310C6]  DEFAULT ((0)) FOR [nPetAL_B]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_BILLI__nPetA__4B7734FF]  DEFAULT ((0)) FOR [nPetAL_A]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_BILLI__nPetA__4C6B5938]  DEFAULT ((0)) FOR [nPetAL_S]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_BILLING_ITEM_TBL_adwItemId5]  DEFAULT ((0)) FOR [adwItemId5]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_BILLING_ITEM_TBL_adwItemId6]  DEFAULT ((0)) FOR [adwItemId6]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_BILLING_ITEM_TBL_adwItemId7]  DEFAULT ((0)) FOR [adwItemId7]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_BILLING_ITEM_TBL_adwItemId8]  DEFAULT ((0)) FOR [adwItemId8]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_BILLING_ITEM_TBL_adwItemId9]  DEFAULT ((0)) FOR [adwItemId9]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_BILLING_ITEM_TBL_nUMPiercedSize]  DEFAULT ((0)) FOR [nUMPiercedSize]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_BILLING_ITEM_TBL_adwUMItemId0]  DEFAULT ((0)) FOR [adwUMItemId0]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_BILLING_ITEM_TBL_adwUMItemId1]  DEFAULT ((0)) FOR [adwUMItemId1]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_BILLING_ITEM_TBL_adwUMItemId2]  DEFAULT ((0)) FOR [adwUMItemId2]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_BILLING_ITEM_TBL_adwUMItemId3]  DEFAULT ((0)) FOR [adwUMItemId3]
GO
ALTER TABLE [dbo].[LOG_BILLING_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_BILLING_ITEM_TBL_TBL_adwUMItemId4]  DEFAULT ((0)) FOR [adwUMItemId4]
GO
ALTER TABLE [dbo].[LOG_LOGIN_TBL] ADD  CONSTRAINT [DF_LOG_LOGIN_TBL_State]  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetK__30C33EC3]  DEFAULT ((0)) FOR [nPetKind]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetL__31B762FC]  DEFAULT ((0)) FOR [nPetLevel]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___dwPet__32AB8735]  DEFAULT ((0)) FOR [dwPetExp]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___wPetE__339FAB6E]  DEFAULT ((0)) FOR [wPetEnergy]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___wPetL__3493CFA7]  DEFAULT ((0)) FOR [wPetLife]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetA__3587F3E0]  DEFAULT ((0)) FOR [nPetAL_D]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetA__367C1819]  DEFAULT ((0)) FOR [nPetAL_C]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetA__37703C52]  DEFAULT ((0)) FOR [nPetAL_B]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetA__3864608B]  DEFAULT ((0)) FOR [nPetAL_A]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetA__395884C4]  DEFAULT ((0)) FOR [nPetAL_S]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_TBL_adwItemId5]  DEFAULT ((0)) FOR [adwItemId5]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_TBL_adwItemId6]  DEFAULT ((0)) FOR [adwItemId6]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_TBL_adwItemId7]  DEFAULT ((0)) FOR [adwItemId7]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_TBL_adwItemId8]  DEFAULT ((0)) FOR [adwItemId8]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_TBL_adwItemId9]  DEFAULT ((0)) FOR [adwItemId9]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_TBL_nUMPiercedSize]  DEFAULT ((0)) FOR [nUMPiercedSize]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_TBL_adwUMItemId0]  DEFAULT ((0)) FOR [adwUMItemId0]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_TBL_adwUMItemId1]  DEFAULT ((0)) FOR [adwUMItemId1]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_TBL_adwUMItemId2]  DEFAULT ((0)) FOR [adwUMItemId2]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_TBL_adwUMItemId3]  DEFAULT ((0)) FOR [adwUMItemId3]
GO
ALTER TABLE [dbo].[LOG_ITEM_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_TBL_adwUMItemId4]  DEFAULT ((0)) FOR [adwUMItemId4]
GO
ALTER TABLE [dbo].[tblTradeLog] ADD  CONSTRAINT [DF_TradeDt]  DEFAULT (getdate()) FOR [TradeDt]
GO
ALTER TABLE [dbo].[tblTradeItemLog] ADD  CONSTRAINT [DF_tblTradeItemLog_AbilityOpt]  DEFAULT ((0)) FOR [AbilityOpt]
GO
ALTER TABLE [dbo].[tblTradeItemLog] ADD  CONSTRAINT [DF_tblTradeItemLog_ItemResist]  DEFAULT ((0)) FOR [ItemResist]
GO
ALTER TABLE [dbo].[tblTradeItemLog] ADD  CONSTRAINT [DF_tblTradeItemLog_ResistAbilityOpt]  DEFAULT ((0)) FOR [ResistAbilityOpt]
GO
ALTER TABLE [dbo].[tblTradeItemLog] ADD  CONSTRAINT [DF_tblTradeItemLog_RandomOpt]  DEFAULT ((0)) FOR [RandomOpt]
GO
ALTER TABLE [dbo].[tblTradeDetailLog] ADD  CONSTRAINT [DF_tblTradeDetailLog_TradeGold]  DEFAULT ((0)) FOR [TradeGold]
GO
ALTER TABLE [dbo].[tblTradeDetailLog] ADD  CONSTRAINT [DF_tblTradeDetailLog_PlayerIP]  DEFAULT ('0.0.0.0') FOR [PlayerIP]
GO
ALTER TABLE [dbo].[tblSystemErrorLog] ADD  CONSTRAINT [DF_tblSystemErrorLog_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblQuizUserLog] ADD  CONSTRAINT [DF_tblQuizUser_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblQuizLog] ADD  CONSTRAINT [DF_tblQuizLog_Start_Time]  DEFAULT (getdate()) FOR [Start_Time]
GO
ALTER TABLE [dbo].[tblQuizAnswerLog] ADD  CONSTRAINT [DF_ITEM_SEND_TBL_m_bCharged]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblQuestLog] ADD  CONSTRAINT [DF_tblQuestLog_Comment]  DEFAULT ('') FOR [Comment]
GO
ALTER TABLE [dbo].[tblGuildHouseLog] ADD  CONSTRAINT [DF_tblGuildHouseLog_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblGuildHouse_FurnitureLog] ADD  CONSTRAINT [DF_tblGuildHouse_FurnitureLog_s_date]  DEFAULT (getdate()) FOR [Del_date]
GO
ALTER TABLE [dbo].[tblChangeNameLog] ADD  CONSTRAINT [DF_EndDt]  DEFAULT ('2099-12-31') FOR [EndDt]
GO
ALTER TABLE [dbo].[tblChangeNameLog] ADD  CONSTRAINT [DF_CharName]  DEFAULT ('') FOR [CharName]
GO
ALTER TABLE [dbo].[tblChangeNameHistoryLog] ADD  CONSTRAINT [DF_OldCharName]  DEFAULT ('') FOR [OldCharName]
GO
ALTER TABLE [dbo].[tblChangeNameHistoryLog] ADD  CONSTRAINT [DF_NewCharName]  DEFAULT ('') FOR [NewCharName]
GO
ALTER TABLE [dbo].[tblChangeNameHistoryLog] ADD  CONSTRAINT [DF_ChangeDt]  DEFAULT (getdate()) FOR [ChangeDt]
GO
ALTER TABLE [dbo].[tblCampusLog] ADD  CONSTRAINT [DF_tblCampusLog_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[tblCampus_PointLog] ADD  CONSTRAINT [DF_tblCampus_PointLog_s_date]  DEFAULT (getdate()) FOR [s_date]
GO
ALTER TABLE [dbo].[LOG_ITEM_REMOVE_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_REMOVE_TBL_RandomOption]  DEFAULT ((0)) FOR [RandomOption]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetK__3A4CA8FD]  DEFAULT ((0)) FOR [nPetKind]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetL__3B40CD36]  DEFAULT ((0)) FOR [nPetLevel]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___dwPet__3C34F16F]  DEFAULT ((0)) FOR [dwPetExp]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___wPetE__3D2915A8]  DEFAULT ((0)) FOR [wPetEnergy]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___wPetL__3E1D39E1]  DEFAULT ((0)) FOR [wPetLife]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetA__3F115E1A]  DEFAULT ((0)) FOR [nPetAL_D]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetA__40058253]  DEFAULT ((0)) FOR [nPetAL_C]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetA__40F9A68C]  DEFAULT ((0)) FOR [nPetAL_B]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetA__41EDCAC5]  DEFAULT ((0)) FOR [nPetAL_A]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF__LOG_ITEM___nPetA__42E1EEFE]  DEFAULT ((0)) FOR [nPetAL_S]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_EVENT_TBL_adwItemId5]  DEFAULT ((0)) FOR [adwItemId5]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_EVENT_TBL_adwItemId6]  DEFAULT ((0)) FOR [adwItemId6]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_EVENT_TBL_adwItemId7]  DEFAULT ((0)) FOR [adwItemId7]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_EVENT_TBL_adwItemId8]  DEFAULT ((0)) FOR [adwItemId8]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_EVENT_TBL_adwItemId9]  DEFAULT ((0)) FOR [adwItemId9]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_EVENT_TBL_nUMPiercedSize]  DEFAULT ((0)) FOR [nUMPiercedSize]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_EVENT_TBL_adwUMItemId0]  DEFAULT ((0)) FOR [adwUMItemId0]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_EVENT_TBL_adwUMItemId1]  DEFAULT ((0)) FOR [adwUMItemId1]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_EVENT_TBL_adwUMItemId2]  DEFAULT ((0)) FOR [adwUMItemId2]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_EVENT_TBL_adwUMItemId3]  DEFAULT ((0)) FOR [adwUMItemId3]
GO
ALTER TABLE [dbo].[LOG_ITEM_EVENT_TBL] ADD  CONSTRAINT [DF_LOG_ITEM_EVENT_TBL_adwUMItemId4]  DEFAULT ((0)) FOR [adwUMItemId4]
GO
ALTER TABLE [dbo].[LOG_INS_DUNGEON_TBL] ADD  CONSTRAINT [DF_LOG_INS_DUNGEON_TBL_m_Date]  DEFAULT (getdate()) FOR [m_Date]
GO
-- End LOGGING_01_DBF creation

-- Start MANAGE_DBF creation
USE [master]
GO
CREATE DATABASE [MANAGE_DBF] --ON  PRIMARY 
--( NAME = N'MANAGE_DBF', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL\MSSQL\DATA\MANAGE_DBF.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 --LOG ON 
--( NAME = N'MANAGE_DBF_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL\MSSQL\DATA\MANAGE_DBF_1.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'MANAGE_DBF', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MANAGE_DBF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MANAGE_DBF] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [MANAGE_DBF] SET ANSI_NULLS OFF
GO
ALTER DATABASE [MANAGE_DBF] SET ANSI_PADDING OFF
GO
ALTER DATABASE [MANAGE_DBF] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [MANAGE_DBF] SET ARITHABORT OFF
GO
ALTER DATABASE [MANAGE_DBF] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [MANAGE_DBF] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [MANAGE_DBF] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [MANAGE_DBF] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [MANAGE_DBF] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [MANAGE_DBF] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [MANAGE_DBF] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [MANAGE_DBF] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [MANAGE_DBF] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [MANAGE_DBF] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [MANAGE_DBF] SET  DISABLE_BROKER
GO
ALTER DATABASE [MANAGE_DBF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [MANAGE_DBF] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [MANAGE_DBF] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [MANAGE_DBF] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [MANAGE_DBF] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [MANAGE_DBF] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [MANAGE_DBF] SET  READ_WRITE
GO
ALTER DATABASE [MANAGE_DBF] SET RECOVERY SIMPLE
GO
ALTER DATABASE [MANAGE_DBF] SET  MULTI_USER
GO
ALTER DATABASE [MANAGE_DBF] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [MANAGE_DBF] SET DB_CHAINING OFF
GO
USE [MANAGE_DBF]
GO
--CREATE USER [EoCRM]
--GO
CREATE ROLE [character01] AUTHORIZATION [dbo]
GO
CREATE ROLE [man_0ngat3] AUTHORIZATION [dbo]
GO
CREATE SCHEMA [man_0ngat3] AUTHORIZATION [man_0ngat3]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_ProvideItem_Bill]
@m_idPlayer varchar(7),
@serverindex char(2),
@Item_Index varchar(32),
@Item_count int
as
-- set nocount on
set xact_abort on

declare @q1 nvarchar(4000), @q2 nvarchar(4000)
declare @Item_count_tmp varchar(10)

set @m_idPlayer = right(('0000000' + cast(@m_idPlayer as varchar(7))), 7)
set @Item_count_tmp = cast(@Item_count as varchar(10))
set @q1 = '	insert into CHR[&serverindex&].CHARACTER_[&serverindex&]_DBF.dbo.ITEM_SEND_TBL
							(serverindex, m_idPlayer, Item_Name, Item_count, m_bCharged, idSender)
			select @serverindex, @m_idPlayer, @Item_Index, @Item_count, 0, ''BILL'''
set @q2 = replace(@q1, '[&serverindex&]', @serverindex)

exec sp_executesql @q2, N'@serverindex char(2), @m_idPlayer char(7), @Item_Index varchar(32), @Item_count varchar(10)'
					, @serverindex, @m_idPlayer, @Item_Index, @Item_count_tmp
-- print @q2
if @@error <> 0
begin
	select -1
end
else
begin
	select 1
end

-- return @@error
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[viwCharacter]
as

select m_szName, playerslot, m_idPlayer, serverindex, account
from CHARACTER_01_DBF.dbo.CHARACTER_TBL with (nolock)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_character_info]
@account varchar(32)
as
set nocount on

select m_szName, playerslot, m_idPlayer, serverindex
from MANAGE_DBF.dbo.viwCharacter
where account = @account
GO
-- End MANAGE_DBF creation

-- Start RANKING_DBF creation
USE [master]
GO
CREATE DATABASE [RANKING_DBF] --ON  PRIMARY 
--( NAME = N'RANKING', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL\MSSQL\DATA\RANKING_DBF.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
-- LOG ON 
--( NAME = N'RANKING_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL\MSSQL\DATA\RANKING_DBF_1.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'RANKING_DBF', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RANKING_DBF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RANKING_DBF] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [RANKING_DBF] SET ANSI_NULLS OFF
GO
ALTER DATABASE [RANKING_DBF] SET ANSI_PADDING OFF
GO
ALTER DATABASE [RANKING_DBF] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [RANKING_DBF] SET ARITHABORT OFF
GO
ALTER DATABASE [RANKING_DBF] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [RANKING_DBF] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [RANKING_DBF] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [RANKING_DBF] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [RANKING_DBF] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [RANKING_DBF] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [RANKING_DBF] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [RANKING_DBF] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [RANKING_DBF] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [RANKING_DBF] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [RANKING_DBF] SET  DISABLE_BROKER
GO
ALTER DATABASE [RANKING_DBF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [RANKING_DBF] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [RANKING_DBF] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [RANKING_DBF] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [RANKING_DBF] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [RANKING_DBF] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [RANKING_DBF] SET  READ_WRITE
GO
ALTER DATABASE [RANKING_DBF] SET RECOVERY SIMPLE
GO
ALTER DATABASE [RANKING_DBF] SET  MULTI_USER
GO
ALTER DATABASE [RANKING_DBF] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [RANKING_DBF] SET DB_CHAINING OFF
GO
USE [RANKING_DBF]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RANKING_TBL](
	[order] [int] NULL,
	[order_all] [int] NULL,
	[Gu] [char](2) NOT NULL,
	[s_date] [char](10) NOT NULL,
	[serverindex] [char](2) NOT NULL,
	[m_dwLogo] [int] NULL,
	[m_idGuild] [char](6) NOT NULL,
	[m_szGuild] [varchar](48) NULL,
	[m_szName] [varchar](32) NULL,
	[m_nWin] [int] NULL,
	[m_nLose] [int] NULL,
	[m_nSurrender] [int] NULL,
	[m_MaximumUnity] [float] NULL,
	[m_AvgLevel] [float] NULL,
	[m_nGuildGold] [bigint] NULL,
	[m_nWinPoint] [int] NULL,
	[m_nPlayTime] [int] NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_RANKING_TBL] PRIMARY KEY CLUSTERED 
(
	[Gu] ASC,
	[s_date] ASC,
	[serverindex] ASC,
	[m_idGuild] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  PROC [dbo].[usp_guildbank_log_view]
@iGu char(2) = 'S1',
@im_idGuild char(6) = '01',
@iserverindex CHAR(2) = ''
AS
SET NOCOUNT ON
IF @iGu = 'S1'
	BEGIN 
	SELECT TOP 100 m_idPlayer,s_date,m_Item,m_nAbilityOption,Item_count
		   FROM LOGGING_01_DBF.dbo.LOG_GUILD_BANK_TBL 
		 WHERE m_idGuild = @im_idGuild  AND serverindex = @iserverindex AND State='A'  ORDER BY s_date DESC
	END 
/*
넣기 A 빼기 D 돈넣기 I 돈빼기 O
*/
ELSE
IF @iGu = 'S2'
	BEGIN
	SELECT TOP 100 m_idPlayer,s_date,m_Item,m_nAbilityOption,Item_count
		   FROM LOGGING_01_DBF.dbo.LOG_GUILD_BANK_TBL 
		 WHERE m_idGuild = @im_idGuild  AND serverindex = @iserverindex  AND State='D'   ORDER BY s_date DESC
	END
/*
	
*/
ELSE
IF @iGu = 'S3'
	BEGIN
	SELECT TOP 100 m_idPlayer,s_date,m_Item,m_nAbilityOption,Item_count
		   FROM LOGGING_01_DBF.dbo.LOG_GUILD_BANK_TBL 
		 WHERE m_idGuild = @im_idGuild  AND serverindex = @iserverindex  AND State='I'   ORDER BY s_date DESC
	END
/*
	
*/
ELSE
IF @iGu = 'S4'
	BEGIN
	SELECT TOP 100 m_idPlayer,s_date,m_Item,m_nAbilityOption,Item_count
		   FROM LOGGING_01_DBF.dbo.LOG_GUILD_BANK_TBL 
		 WHERE m_idGuild = @im_idGuild  AND serverindex = @iserverindex AND State='O'    ORDER BY s_date DESC
	END
/*
	
*/
RETURN
SET NOCOUNT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     PROC [dbo].[RANKING_STR]
@iGu CHAR(2) = 'R1',
@iserverindex CHAR(2) =  '01'
AS
DECLARE @os_date CHAR(10)
SELECT @os_date = MAX(s_date) FROM RANKING_TBL WHERE Gu = @iGu AND serverindex = @iserverindex

DECLARE @orderby VARCHAR(255)

--R1 : 최강길드
--R2 : 최다승
--R3 : 최다패
--R4 : 최다항복패
--R5 : 최고결속력
--R6 : 최고자금
--R7 : 평균고랩
--R8 : 최대플레이

SELECT @orderby = CASE @iGu 	 WHEN 'R1' THEN ' ORDER BY m_nWinPoint DESC,m_nWin DESC'
	WHEN 'R2' THEN ' ORDER BY m_nWin DESC,CreateTime'
	WHEN 'R3' THEN ' ORDER BY m_nLose DESC,m_nSurrender DESC'
	WHEN 'R4' THEN ' ORDER BY m_nSurrender DESC,m_nLose DESC'
	WHEN 'R5' THEN ' ORDER BY m_MaximumUnity DESC,CreateTime'
	WHEN 'R6' THEN ' ORDER BY m_nGuildGold DESC,CreateTime'
	WHEN 'R7' THEN ' ORDER BY m_AvgLevel DESC,CreateTime'
	WHEN 'R8' THEN ' ORDER BY m_nPlayTime DESC,CreateTime' END

EXEC
(
	'SELECT TOP 20 [order],Gu,s_date,serverindex,m_dwLogo,m_idGuild,m_szGuild,m_szName,
	m_nWin,m_nLose,m_nSurrender,m_MaximumUnity,m_AvgLevel,
	m_nGuildGold,m_nWinPoint,m_nPlayTime,CreateTime
	FROM RANKING_TBL
	WHERE Gu = ''' + @iGu + '''
	AND serverindex = ''' + @iserverindex + '''
	AND s_date =  ''' + @os_date + '''' + @orderby
)
RETURN
GO
-- End RANKING_DBF creation

-- End database creation

-- Start adding default rows to [CHARACTER_01_DBF].[BASE_TBL_VALUE]
USE [CHARACTER_01_DBF]
GO
set nocount on
INSERT [dbo].[BASE_VALUE_TBL] ([g_nSex], [m_vScale_x], [m_dwMotion], [m_fAngle], [m_nHitPoint], [m_nManaPoint], [m_nFatiguePoint], [m_dwRideItemIdx], [m_dwGold], [m_nJob], [m_pActMover], [m_nStr], [m_nSta], [m_nDex], [m_nInt], [m_nLevel], [m_nExp1], [m_nExp2], [m_aJobSkill], [m_aLicenseSkill], [m_aJobLv], [m_dwExpertLv], [m_idMarkingWorld], [m_vMarkingPos_x], [m_vMarkingPos_y], [m_vMarkingPos_z], [m_nRemainGP], [m_nRemainLP], [m_nFlightLv], [m_nFxp], [m_nTxp], [m_lpQuestCntArray], [m_chAuthority], [m_dwMode], [blockby], [TotalPlayTime], [isblock], [m_Inventory], [m_apIndex], [m_adwEquipment], [m_aSlotApplet], [m_aSlotItem], [m_aSlotQueue], [m_SkillBar], [m_dwObjIndex], [m_Card], [m_Cube], [m_apIndex_Card], [m_dwObjIndex_Card], [m_apIndex_Cube], [m_dwObjIndex_Cube], [m_idparty], [m_nNumKill], [m_idMuerderer], [m_nSlaughter], [m_nFame], [m_nDeathExp], [m_nDeathLevel], [m_dwFlyTime], [m_nMessengerState], [m_Bank], [m_apIndex_Bank], [m_dwObjIndex_Bank], [m_dwGoldBank]) VALUES (N'0', 1, 0, 0, 230, 63, 32, 0, 0, 0, N'0,0', 15, 15, 15, 15, 1, 0, 0, N'0,1,1,1/0,1,2,1/0,1,3,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/$', N'0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/$', N'1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/$', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, N'$', N'F', 268566528, NULL, 0, N'F', N'0,502,0,0,,1,0,9000000,0,0,0,0,0/1,2801,0,0,,1,0,0,0,0,0,0,0/2,4805,0,0,,5,0,0,0,0,0,0,0/42,506,0,0,,1,0,5850000,0,0,0,0,0/43,510,0,0,,1,0,4500000,0,0,0,0,0/44,21,0,0,,1,0,7200000,0,0,0,0,0/45,2800,0,0,,3,0,0,0,0,0,0,0/$', N'45/1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/-1/-1/0/-1/42/43/-1/-1/-1/-1/44/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/$', N'-1/-1/0/-1/42/43/-1/-1/-1/-1/44/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/$', N'0,2,400,0,0,0,0/1,2,398,0,1,0,0/2,2,2010,0,2,0,0/3,2,581,0,3,0,0/4,3,25,0,4,0,0/$', N'0,0,5,45,0,0,0,1/0,1,5,1,0,1,0,1/0,2,3,3,0,2,0,1/0,8,3,2,0,8,0,1/$', N'$', 0, N'44/1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/46/47/52/0/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/$', N'$', N'$', N'5/36/37/38/39/40/41/$', N'0/1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/$', N'0/1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/$', N'0/1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/$', 0, 0, 0, 0, 0, 0, 0, 0, 0, N'$', N'$', N'$', 0)
INSERT [dbo].[BASE_VALUE_TBL] ([g_nSex], [m_vScale_x], [m_dwMotion], [m_fAngle], [m_nHitPoint], [m_nManaPoint], [m_nFatiguePoint], [m_dwRideItemIdx], [m_dwGold], [m_nJob], [m_pActMover], [m_nStr], [m_nSta], [m_nDex], [m_nInt], [m_nLevel], [m_nExp1], [m_nExp2], [m_aJobSkill], [m_aLicenseSkill], [m_aJobLv], [m_dwExpertLv], [m_idMarkingWorld], [m_vMarkingPos_x], [m_vMarkingPos_y], [m_vMarkingPos_z], [m_nRemainGP], [m_nRemainLP], [m_nFlightLv], [m_nFxp], [m_nTxp], [m_lpQuestCntArray], [m_chAuthority], [m_dwMode], [blockby], [TotalPlayTime], [isblock], [m_Inventory], [m_apIndex], [m_adwEquipment], [m_aSlotApplet], [m_aSlotItem], [m_aSlotQueue], [m_SkillBar], [m_dwObjIndex], [m_Card], [m_Cube], [m_apIndex_Card], [m_dwObjIndex_Card], [m_apIndex_Cube], [m_dwObjIndex_Cube], [m_idparty], [m_nNumKill], [m_idMuerderer], [m_nSlaughter], [m_nFame], [m_nDeathExp], [m_nDeathLevel], [m_dwFlyTime], [m_nMessengerState], [m_Bank], [m_apIndex_Bank], [m_dwObjIndex_Bank], [m_dwGoldBank]) VALUES (N'1', 1, 0, 0, 230, 63, 32, 0, 0, 0, N'0,0', 15, 15, 15, 15, 1, 0, 0, N'0,1,1,1/0,1,2,1/0,1,3,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/0,1,-1,1/$', N'0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/0,0,0,1/$', N'1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/$', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, N'$', N'F', 268566528, NULL, 0, N'F', N'0,504,0,0,,1,0,9000000,0,0,0,0,0/1,2801,0,0,,1,0,0,0,0,0,0,0/2,4805,0,0,,5,0,0,0,0,0,0,0/42,508,0,0,,1,0,5850000,0,0,0,0,0/43,512,0,0,,1,0,4500000,0,0,0,0,0/44,21,0,0,,1,0,7200000,0,0,0,0,0/45,2800,0,0,,3,0,0,0,0,0,0,0/$', N'45/1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/-1/-1/0/-1/42/43/-1/-1/-1/-1/44/-1/-1/-1/$', N'-1/-1/0/-1/42/43/-1/-1/-1/-1/44/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/$', N'0,2,400,0,0,0,0/1,2,398,0,1,0,0/2,2,2010,0,2,0,0/3,2,581,0,3,0,0/4,3,25,0,4,0,0/$', N'0,0,5,45,0,0,0,1/0,1,5,1,0,1,0,1/0,2,3,3,0,2,0,1/0,8,3,2,0,8,0,1/$', N'$', 0, N'44/1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/46/47/52/0/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/$', N'$', N'$', N'5/36/37/38/39/40/41/$', N'0/1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/$', N'0/1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/$', N'0/1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/$', 0, 0, 0, 0, 0, 0, 0, 0, 0, N'$', N'$', N'$', 0)
set nocount off
GO

USE CHARACTER_01_DBF
GO
UPDATE BASE_VALUE_TBL
SET m_Inventory ='0,523,0,0,,1,0,9000000,0,0,2,722278867,5,0,0,0,0/1,7000,0,0,,1,0,6570000,0,0,2,-480752627,5,0,0,0,0/2,4805,0,0,,5,0,0,0,0,0,-1273387868,0,0,0,0,0/8,2830,0,0,,99,0,-1,0,0,2,-767205874,0,0,0,0,0/9,2830,0,0,,99,0,-1,0,0,2,-767205874,0,0,0,0,0/10,2830,0,0,,99,0,-1,0,0,2,-767205874,0,0,0,0,0/11,2895,0,0,,50,0,-1,0,0,2,-150634449,0,0,0,0,0/12,10270,0,0,,5,0,-1,0,0,2,-306178500,0,0,0,0,0/13,100003,0,0,,1,0,-1,0,0,2,804777925,0,0,0,0,0/14,100000,0,0,,2,0,-1,0,0,2,1862094106,0,0,0,0,0/15,100001,0,0,,1,0,-1,0,0,2,-1418465205,0,0,0,0,0/42,524,0,0,,1,0,5850000,0,0,2,-559646448,5,0,0,0,0/43,525,0,0,,1,0,4500000,0,0,2,-1689609207,5,0,0,0,0/44,522,0,0,,1,0,3600000,0,0,2,-757954622,5,0,0,0,0/45,23,0,0,,1,0,7200000,0,0,2,-947743068,10,2,20,0,0/$'
WHERE g_nSex = '0'

UPDATE BASE_VALUE_TBL
SET m_apIndex= '8/9/10/11/2/12/13/14/15/5/7/6/3/46/47/4/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/-1/-1/0/-1/42/43/44/-1/-1/-1/45/1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/$'
WHERE g_nSex = '0'

UPDATE BASE_VALUE_TBL
SET m_dwObjIndex = '44/53/4/12/15/9/11/10/0/1/2/3/5/6/7/8/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/46/47/48/52/13/14/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/$'
WHERE g_nSex = '0'

UPDATE BASE_VALUE_TBL
SET m_Inventory ='2,4805,0,0,,5,0,0,0,0,0,815460737,0,0,0,0,0/4,23,0,0,,1,0,7200000,0,0,2,450659006,10,2,20,0,0/5,7000,0,0,,1,0,6570000,0,0,2,-55722209,5,0,0,0,0/6,526,0,0,,1,0,3600000,0,0,2,925893228,5,0,0,0,0/7,527,0,0,,1,0,9000000,0,0,2,1807097909,5,0,0,0,0/8,528,0,0,,1,0,5850000,0,0,2,-1202058038,5,0,0,0,0/9,529,0,0,,1,0,4500000,0,0,2,477703739,5,0,0,0,0/10,2830,0,0,,99,0,-1,0,0,2,-934225576,0,0,0,0,0/11,2830,0,0,,99,0,-1,0,0,2,-934225576,0,0,0,0,0/12,2830,0,0,,99,0,-1,0,0,2,-934225576,0,0,0,0,0/13,2895,0,0,,50,0,-1,0,0,2,1588955825,0,0,0,0,0/14,10270,0,0,,5,0,-1,0,0,2,-646698090,0,0,0,0,0/15,100003,0,0,,1,0,-1,0,0,2,-943557865,0,0,0,0,0/16,100000,0,0,,2,0,-1,0,0,2,665203460,0,0,0,0,0/17,100001,0,0,,1,0,-1,0,0,2,-26795795,0,0,0,0,0/$'
WHERE g_nSex = '1'

UPDATE BASE_VALUE_TBL
SET m_apIndex= '10/11/12/13/2/14/15/16/17/47/0/1/44/42/45/43/3/46/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/-1/-1/7/-1/8/9/6/-1/-1/-1/4/5/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/$'
WHERE g_nSex = '1'

UPDATE BASE_VALUE_TBL
SET m_dwObjIndex = '10/11/4/16/52/53/48/44/46/47/0/1/2/3/5/6/7/8/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/13/15/12/14/17/9/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/$'
WHERE g_nSex = '1'
GO
-- End adding default rows to [CHARACTER_01_DBF].[BASE_TBL_VALUE]

/******************************* Création De ITEM_DBF *******************************/

CREATE DATABASE [ITEM_DBF]

GO
EXEC dbo.sp_dbcmptlevel @dbname=N'ITEM_DBF', @new_cmptlevel=90
GO
ALTER DATABASE [ITEM_DBF] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ITEM_DBF] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ITEM_DBF] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ITEM_DBF] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ITEM_DBF] SET ARITHABORT OFF 
GO
ALTER DATABASE [ITEM_DBF] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ITEM_DBF] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ITEM_DBF] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ITEM_DBF] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ITEM_DBF] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ITEM_DBF] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ITEM_DBF] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ITEM_DBF] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ITEM_DBF] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ITEM_DBF] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ITEM_DBF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ITEM_DBF] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ITEM_DBF] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ITEM_DBF] SET  READ_WRITE 
GO
ALTER DATABASE [ITEM_DBF] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ITEM_DBF] SET  MULTI_USER 
GO
ALTER DATABASE [ITEM_DBF] SET PAGE_VERIFY CHECKSUM  
GO
USE [ITEM_DBF]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [ITEM_DBF] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

/****** Object:  User Defined Function dbo.fnDateFormat    Script Date: 4/14/2010 1:30:47 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fnDateFormat]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fnDateFormat]
GO

/****** Object:  User Defined Function dbo.fnGetPattern    Script Date: 4/14/2010 1:30:47 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fnGetPattern]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fnGetPattern]
GO

/****** Object:  User Defined Function dbo.fn_ItemName    Script Date: 4/14/2010 1:30:47 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_ItemName]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_ItemName]
GO

/****** Object:  Stored Procedure dbo.ITEM_STR    Script Date: 4/14/2010 1:30:47 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ITEM_STR]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ITEM_STR]
GO

/****** Object:  Table [dbo].[ITEM_TBL]    Script Date: 4/14/2010 1:30:47 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ITEM_TBL]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ITEM_TBL]
GO

/****** Object:  Table [dbo].[MONSTER_TBL]    Script Date: 4/14/2010 1:30:47 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[MONSTER_TBL]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[MONSTER_TBL]
GO

/****** Object:  Table [dbo].[SKILL_TBL]    Script Date: 4/14/2010 1:30:47 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SKILL_TBL]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SKILL_TBL]
GO


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  User Defined Function dbo.fnDateFormat    Script Date: 4/14/2010 1:30:48 PM ******/

/****** Object:  User Defined Function dbo.fnDateFormat    Script Date: 2010-04-08 ?? 11:39:08 ******/


CREATE    FUNCTION fnDateFormat (
    @iData   VARCHAR(3000),
    @iValue  CHAR(1)
)  
RETURNS INT
AS  
BEGIN 

    DECLARE @len INT, @cur INT, @ret INT
    SET     @cur = 0
    SET     @ret = 0
    SET     @len = LEN(@iData)

                WHILE ( @cur = @len )
                BEGIN
                    IF ( ASCII(SUBSTRING(@iValue, @cur, 1)) = @iValue )
                    BEGIN
                        SET @cur = @cur + 1
                    END
                    SET @cur = @cur + 1
                END

  RETURN @ret
END








GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  User Defined Function dbo.fnGetPattern    Script Date: 4/14/2010 1:30:48 PM ******/

/****** Object:  User Defined Function dbo.fnGetPattern    Script Date: 2010-04-08 ?? 11:39:08 ******/


CREATE    FUNCTION fnGetPattern (
    @iData   VARCHAR(3000),
    @iValue  VARCHAR(1)
)  
RETURNS INT
AS  
BEGIN 

    DECLARE @len INT, @cur INT, @ret INT
    SET     @cur = 1
    SET     @ret = 0
    SET     @len = LEN(@iData)

                WHILE ( @cur <> @len )
                BEGIN
                    IF ( SUBSTRING(@iData, @cur, 1) = @iValue )
                    BEGIN
                        SET @ret = @ret + 1
                    END
                    SET @cur = @cur + 1
                END

  RETURN @ret
END


-- SELECT dbo.fnGetPattern('/1/-1/-1/-1/-1/-1/-1/-1/$', '/')
--SELECT substring('A/1/-1/-1/-1/-1/-1/-1/-1/$', 5, 1)




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  User Defined Function dbo.fn_ItemName    Script Date: 4/14/2010 1:30:48 PM ******/

/****** Object:  User Defined Function dbo.fn_ItemName    Script Date: 2010-04-08 ?? 11:39:08 ******/
CREATE function fn_ItemName (@Index int)
returns varchar(32)
as
begin
	declare @szName varchar(32)

	select @szName = szName from ITEM_TBL where [Index] = @Index

	set @szName = isnull(@szName, @Index)

	return @szName
end


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Table [dbo].[ITEM_TBL]    Script Date: 4/14/2010 1:30:48 PM ******/
CREATE TABLE [dbo].[ITEM_TBL] (
	[Index] [int] NULL ,
	[szName] [nvarchar] (255) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[szNameEn] [nvarchar] (255) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[dwNum] [int] NULL ,
	[dwPackMax] [int] NULL ,
	[dwItemKind1] [int] NULL ,
	[dwItemKind2] [int] NULL ,
	[dwItemKind3] [int] NULL ,
	[dwItemJob] [int] NULL ,
	[bPermanence] [int] NULL ,
	[dwUseable] [int] NULL ,
	[dwItemSex] [int] NULL ,
	[dwWeight] [int] NULL ,
	[dwCost] [int] NULL ,
	[dwCash] [int] NULL ,
	[dwEndurance] [int] NULL ,
	[bRepairUnable] [int] NULL ,
	[bJammed] [int] NULL ,
	[nAbrasion] [int] NULL ,
	[nHardness] [int] NULL ,
	[dwParts] [int] NULL ,
	[dwItemLV] [int] NULL ,
	[dwAddLV] [int] NULL ,
	[dwItemRare] [int] NULL ,
	[bLog] [int] NULL ,
	[dwSpeedPenalty] [int] NULL ,
	[dwLinkItem] [int] NULL ,
	[dwAbilityMin] [int] NULL ,
	[dwAbilityMax] [int] NULL ,
	[dwAddSkillMin] [int] NULL ,
	[dwAddSkillMax] [int] NULL ,
	[dwWeaponType] [int] NULL ,
	[bContinuousPain] [int] NULL ,
	[dwShellQuantity] [int] NULL ,
	[dwRecoil] [int] NULL ,
	[dwCaliber] [int] NULL ,
	[dwBarrageRate] [int] NULL ,
	[dwLoadingTime] [int] NULL ,
	[nAdjHitRate] [int] NULL ,
	[nAdjSpellRate] [int] NULL ,
	[dwAttackSpeed] [int] NULL ,
	[dwDmgShift] [int] NULL ,
	[dwAttackRange] [int] NULL ,
	[dwConnaturalSkill] [int] NULL ,
	[dwAdjRoll] [int] NULL ,
	[dwDestParam1] [int] NULL ,
	[dwDestParam2] [int] NULL ,
	[nAdjParamVal1] [int] NULL ,
	[nAdjParamVal2] [int] NULL ,
	[dwChgParamVal1] [int] NULL ,
	[dwChgParamVal2] [int] NULL ,
	[dwReqJob] [int] NULL ,
	[dwReqStr] [int] NULL ,
	[dwReqSta] [int] NULL ,
	[dwReqDex] [int] NULL ,
	[dwReqInt] [int] NULL ,
	[dwReqMp] [int] NULL ,
	[dwRepFp] [int] NULL ,
	[dwReqJobLV] [int] NULL ,
	[dwReqDisLV] [int] NULL ,
	[dwSkillReadyType] [int] NULL ,
	[dwSkillReady] [int] NULL ,
	[dwSkillRange] [int] NULL ,
	[dwCircleTime] [int] NULL ,
	[dwSkillTime] [int] NULL ,
	[dwExeChance] [int] NULL ,
	[dwExeTarget] [int] NULL ,
	[dwUseChance] [int] NULL ,
	[dwSpellRegion] [int] NULL ,
	[dwSpellType] [int] NULL ,
	[dwSkillType] [int] NULL ,
	[dwItemResistMagic] [int] NULL ,
	[dwItemResistElecricity] [int] NULL ,
	[dwItemResistDark] [int] NULL ,
	[dwItemResistFire] [int] NULL ,
	[dwItemResistWind] [int] NULL ,
	[dwItemResistWater] [int] NULL ,
	[dwItemResistEarth] [int] NULL ,
	[bAmplification] [int] NULL ,
	[bFusion] [int] NULL ,
	[nEvildoing] [int] NULL ,
	[bGrow] [int] NULL ,
	[bCraft] [int] NULL ,
	[dwExpertLV] [int] NULL ,
	[ExpertMax] [int] NULL ,
	[dwSubDefine] [int] NULL ,
	[dwExp] [int] NULL ,
	[LVRatio] [int] NULL ,
	[dwCardType] [int] NULL ,
	[fFlightSpeed] [float] NULL ,
	[dwFlightLimit] [int] NULL ,
	[dwLimitJob1] [int] NULL ,
	[dwLimitLevel1] [int] NULL ,
	[dwLimitJob2] [int] NULL ,
	[dwLimitLevel2] [int] NULL ,
	[dwReflect] [int] NULL ,
	[szComment] [nvarchar] (255) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[MONSTER_TBL]    Script Date: 4/14/2010 1:30:48 PM ******/
CREATE TABLE [dbo].[MONSTER_TBL] (
	[Index] [int] NULL ,
	[szName] [varchar] (256) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[Level] [int] NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[SKILL_TBL]    Script Date: 4/14/2010 1:30:48 PM ******/
CREATE TABLE [dbo].[SKILL_TBL] (
	[Index] [int] NULL ,
	[szName] [varchar] (256) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[job] [int] NULL 
) ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.ITEM_STR    Script Date: 4/14/2010 1:30:48 PM ******/

/****** Object:  Stored Procedure dbo.ITEM_STR    Script Date: 2010-04-08 ?? 11:39:08 ******/


CREATE   PROC ITEM_STR
	@iGu						CHAR(2) 				= 'S1',
	@iIndex					INT							= 0,
	@iszName 				NVARCHAR(255) 	= '',
	@iszNameEn 		NVARCHAR(255) 	= '',
	@idwNum				INT							= 0, 
	@idwPackMax		INT 							= 0, 
	@idwItemKind1	 	INT 							= 0, 
	@idwItemKind2 		INT 							= 0, 
	@idwItemKind3 		INT 							= 0, 
	@idwItemJob 			INT 							= 0, 
	@ibPermanence 	INT 							= 0, 
	@idwUseable 		INT 							= 0, 
	@idwItemSex 		INT 							= 0, 
	@idwWeight			INT 							= 0, 
	@idwCost 				INT 							= 0, 
	@idwCash 				INT 							= 0, 
	@idwEndurance 	INT 							= 0, 
	@ibRepairUnable INT 							= 0, 
	@ibJammed 			INT = 0, 
	@inAbrasion 			INT = 0, 
	@inHardness 		INT = 0, 
	@idwParts 				INT = 0, 
	@idwItemLV 			INT = 0, 
	@idwAddLV 			INT = 0, 
	@idwItemRare 		INT = 0, 
	@ibLog 					INT = 0, 
	@idwSpeedPenalty INT = 0, 
	@idwLinkItem 		INT = 0, 
	@idwAbilityMin 		INT = 0, 
	@idwAbilityMax 		INT = 0, 
	@idwAddSkillMin 	INT = 0, 
	@idwAddSkillMax 	INT = 0, 
	@idwWeaponType INT = 0, 
	@ibContinuousPain INT = 0, 
	@idwShellQuantity INT = 0, 
	@idwRecoil 			INT = 0, 
	@idwCaliber 			INT = 0, 
	@idwBarrageRate INT = 0, 
	@idwLoadingTime INT = 0, 
	@inAdjHitRate 		INT = 0, 
	@inAdjSpellRate 	INT = 0, 
	@idwAttackSpeed	INT = 0, 
	@idwDmgShift 		INT = 0, 
	@idwAttackRange INT = 0, 
	@idwConnaturalSkill INT = 0, 
	@idwAdjRoll 			INT = 0, 
	@idwDestParam1 INT = 0, 
	@idwDestParam2 INT = 0, 
	@inAdjParamVal1 INT = 0, 
	@inAdjParamVal2 INT = 0, 
	@idwChgParamVal1 INT = 0, 
	@idwChgParamVal2 INT = 0, 
	@idwReqJob 			INT = 0, 
	@idwReqStr 			INT = 0, 
	@idwReqSta 			INT = 0, 
	@idwReqDex 		INT = 0, 
	@idwReqInt 			INT = 0, 
	@idwReqMp 			INT = 0, 
	@idwRepFp 			INT = 0, 
	@idwReqJobLV 	INT = 0, 
	@idwReqDisLV 		INT = 0, 
	@idwSkillReadyType INT = 0, 
	@idwSkillReady 	INT = 0, 
	@idwSkillRange 	INT = 0, 
	@idwCircleTime 	INT = 0, 
	@idwSkillTime 		INT = 0, 
	@idwExeChance 	INT = 0, 
	@idwExeTarget 	INT = 0, 
	@idwUseChance 	INT = 0, 
	@idwSpellRegion	INT = 0, 
	@idwSpellType 	INT = 0, 
	@idwSkillType 		INT = 0, 
	@idwItemResistMagic INT = 0, 
	@idwItemResistElecricity INT = 0, 
	@idwItemResistDark INT = 0, 
	@idwItemResistFire INT = 0, 
	@idwItemResistWind INT = 0, 
	@idwItemResistWater INT = 0,  
	@idwItemResistEarthINT INT = 0, 
	@ibAmplification 	INT = 0, 
	@ibFusion 				INT = 0, 
	@inEvildoing 			INT = 0, 
	@ibGrow 				INT = 0, 
	@ibCraft 					INT = 0, 
	@idwExpertLV 		INT = 0, 
	@iExpertMax 			INT = 0, 
	@idwSubDefine 	INT = 0, 
	@idwExp 				INT = 0, 
	@iLVRatio 				INT = 0, 
	@idwCardType 		INT = 0, 
	@ifFlightSpeed 		FLOAT = 0, 
	@idwFlightLimit 		INT = 0, 
	@idwLimitJob1 		INT = 0, 
	@idwLimitLevel1 	INT = 0, 
	@idwLimitJob2 		INT = 0, 
	@idwLimitLevel2 	INT = 0, 
	@idwReflect 			INT = 0, 
	@iszComment NVARCHAR(255) = ''
	
AS
set nocount on
IF @iGu = 'D1'  -- ??? ??
	BEGIN
				TRUNCATE TABLE ITEM_TBL
		RETURN
	END
ELSE
IF @iGu = 'I1' -- ??? Insert
	BEGIN
				INSERT ITEM_TBL
							(
								[Index], 
								[szName],
								[szNameEn],
								[dwNum], 
								[dwPackMax], 
								[dwItemKind1], 
								[dwItemKind2], 
								[dwItemKind3], 
								[dwItemJob], 
								[bPermanence], 
								[dwUseable], 
								[dwItemSex], 
								[dwWeight], 
								[dwCost], 
								[dwCash], 
								[dwEndurance], 
								[bRepairUnable], 
								[bJammed], 
								[nAbrasion], 
								[nHardness], 
								[dwParts], 
								[dwItemLV], 
								[dwAddLV], 
								[dwItemRare], 
								[bLog], 
								[dwSpeedPenalty], 
								[dwLinkItem], 
								[dwAbilityMin], 
								[dwAbilityMax], 
								[dwAddSkillMin], 
								[dwAddSkillMax], 
								[dwWeaponType], 
								[bContinuousPain], 
								[dwShellQuantity], 
								[dwRecoil], 
								[dwCaliber], 
								[dwBarrageRate], 
								[dwLoadingTime], 
								[nAdjHitRate], 
								[nAdjSpellRate], 
								[dwAttackSpeed], 
								[dwDmgShift], 
								[dwAttackRange], 
								[dwConnaturalSkill], 
								[dwAdjRoll], 
								[dwDestParam1], 
								[dwDestParam2], 
								[nAdjParamVal1], 
								[nAdjParamVal2], 
								[dwChgParamVal1], 
								[dwChgParamVal2], 
								[dwReqJob], 
								[dwReqStr], 
								[dwReqSta], 
								[dwReqDex], 
								[dwReqInt], 
								[dwReqMp], 
								[dwRepFp], 
								[dwReqJobLV], 
								[dwReqDisLV], 
								[dwSkillReadyType], 
								[dwSkillReady], 
								[dwSkillRange], 
								[dwCircleTime], 
								[dwSkillTime], 
								[dwExeChance], 
								[dwExeTarget], 
								[dwUseChance], 
								[dwSpellRegion], 
								[dwSpellType], 
								[dwSkillType], 
								[dwItemResistMagic], 
								[dwItemResistElecricity], 
								[dwItemResistDark], 
								[dwItemResistFire], 
								[dwItemResistWind], 
								[dwItemResistWater],  
								[dwItemResistEarth],
								[bAmplification], 
								[bFusion], 
								[nEvildoing], 
								[bGrow], 
								[bCraft], 
								[dwExpertLV], 
								[ExpertMax], 
								[dwSubDefine], 
								[dwExp], 
								[LVRatio], 
								[dwCardType], 
								[fFlightSpeed],
								[dwFlightLimit], 
								[dwLimitJob1], 
								[dwLimitLevel1], 
								[dwLimitJob2], 
								[dwLimitLevel2], 
								[dwReflect], 
								[szComment]
							)
				VALUES
							(
								@iIndex,
								@iszName,
								@iszNameEn,
								@idwNum, 
								@idwPackMax, 
								@idwItemKind1, 
								@idwItemKind2, 
								@idwItemKind3, 
								@idwItemJob, 
								@ibPermanence, 
								@idwUseable, 
								@idwItemSex, 
								@idwWeight, 
								@idwCost, 
								@idwCash, 
								@idwEndurance, 
								@ibRepairUnable, 
								@ibJammed, 
								@inAbrasion, 
								@inHardness, 
								@idwParts, 
								@idwItemLV, 
								@idwAddLV, 
								@idwItemRare, 
								@ibLog, 
								@idwSpeedPenalty, 
								@idwLinkItem, 
								@idwAbilityMin, 
								@idwAbilityMax, 
								@idwAddSkillMin, 
								@idwAddSkillMax, 
								@idwWeaponType, 
								@ibContinuousPain, 
								@idwShellQuantity, 
								@idwRecoil, 
								@idwCaliber, 
								@idwBarrageRate, 
								@idwLoadingTime, 
								@inAdjHitRate, 
								@inAdjSpellRate, 
								@idwAttackSpeed, 
								@idwDmgShift, 
								@idwAttackRange, 
								@idwConnaturalSkill, 
								@idwAdjRoll, 
								@idwDestParam1, 
								@idwDestParam2, 
								@inAdjParamVal1, 
								@inAdjParamVal2, 
								@idwChgParamVal1, 
								@idwChgParamVal2, 
								@idwReqJob, 
								@idwReqStr, 
								@idwReqSta, 
								@idwReqDex, 
								@idwReqInt, 
								@idwReqMp, 
								@idwRepFp, 
								@idwReqJobLV, 
								@idwReqDisLV, 
								@idwSkillReadyType, 
								@idwSkillReady, 
								@idwSkillRange, 
								@idwCircleTime, 
								@idwSkillTime, 
								@idwExeChance, 
								@idwExeTarget, 
								@idwUseChance, 
								@idwSpellRegion, 
								@idwSpellType, 
								@idwSkillType, 
								@idwItemResistMagic, 
								@idwItemResistElecricity, 
								@idwItemResistDark, 
								@idwItemResistFire, 
								@idwItemResistWind, 
								@idwItemResistWater,  
								@idwItemResistEarthINT, 
								@ibAmplification, 
								@ibFusion, 
								@inEvildoing, 
								@ibGrow, 
								@ibCraft, 
								@idwExpertLV, 
								@iExpertMax, 
								@idwSubDefine, 
								@idwExp, 
								@iLVRatio, 
								@idwCardType, 
								@ifFlightSpeed, 
								@idwFlightLimit, 
								@idwLimitJob1, 
								@idwLimitLevel1, 
								@idwLimitJob2, 
								@idwLimitLevel2, 
								@idwReflect, 
								@iszComment
							)
		RETURN
	END
ELSE
IF @iGu = 'D2' -- SKILL_TBL Data ?? ???
	BEGIN
				TRUNCATE TABLE SKILL_TBL
		RETURN
	END
ELSE
IF @iGu = 'I2' -- SKILL_TBL Data Insert
	BEGIN
				INSERT SKILL_TBL
							(
								[Index], 
								[szName],
								[job]
							)
				VALUES
							(
								@iIndex,
								@iszName,
								@idwNum
							)
		RETURN
	END
ELSE
IF @iGu = 'D3' -- MONSTER_TBL Data ?? ???
	BEGIN
				TRUNCATE TABLE MONSTER_TBL
		RETURN
	END
ELSE
IF @iGu = 'I3' -- MONSTER_TBL Data Insert
	BEGIN
				INSERT MONSTER_TBL
							(
								[Index], 
								[szName]
							)
				VALUES
							(
								@iIndex,
								@iszName
							)
		RETURN
	END
ELSE
IF @iGu = 'D4' -- QUEST_TBL Data ?? ???
	BEGIN
				TRUNCATE TABLE QUEST_TBL
		RETURN
	END
ELSE
IF @iGu = 'I4' -- QUEST_TBL Data Insert
	BEGIN
				INSERT QUEST_TBL
							(
								[Index], 
								[szName]
							)
				VALUES
							(
								@iIndex,
								@iszName
							)
		RETURN
	END

set nocount off





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



USE [master]
GO

PRINT N'
Script has been executed completely!

If there are any errors, please fix them before continuting.
If you leave them unfixed, your server may not work!

Thank you for using the v15 Database Script: Project Flight Edition!
'
GO
-- End script