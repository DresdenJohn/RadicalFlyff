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

