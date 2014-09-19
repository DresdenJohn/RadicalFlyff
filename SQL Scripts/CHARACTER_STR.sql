USE [CHARACTER_01_DBF]
GO
/****** Object:  StoredProcedure [dbo].[CHARACTER_STR]    Script Date: 09/15/2014 00:24:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[CHARACTER_STR]
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
