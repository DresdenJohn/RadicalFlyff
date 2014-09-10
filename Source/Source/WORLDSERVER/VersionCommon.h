#ifndef __VERSION_COMMON_H__
#define __VERSION_COMMON_H__ 
#define __MAINSERVER
#define		__VER	15	// 15Â÷

#if !defined( __TESTSERVER ) && !defined( __MAINSERVER )
	#define __INTERNALSERVER
#endif

/**************************************************************************/
//////////////////////////// Rad Fly ///////////////////////////////////////
/**************************************************************************/

#define __SECURITY_FIXES
#define	__NO_SPEEDHACK
#define	__DUPE_FIX
#define	__RESTAT_BUG
#define	__SAVE_AFTER_TRADE
#define __CASTBREAKFIX
#define	__SWITCH_FIX
#define __HACK_FIXXES

#define __FIX_CHEAT
#define __IP_CRYPTION
#define __AUTO_SKILL_MAX
/**************************************************************************/
////////////////////////////////////////////////////////////////////////////
/**************************************************************************/

#if (_MSC_VER > 1200)
#define		__VS2003		// ÄÄÆÄÀÏ·¯º¯°æ.net
#endif

#define		D3DDEVICE	NULL
#define		__SERVER						// Å¬¶óÀÌ¾ðÆ® Àü¿ëÄÚµå¸¦ ºôµåÇÏÁö ¾Ê±â À§ÇÑ define
#define		__X15
#define		__VERIFY_LOOP041010
#define		__S1108_BACK_END_SYSTEM			// ¹é¾Øµå½Ã½ºÅÛ Trans, World, Neuz
//#define		__PROFILE_RUN
#define		__RES0807						// ¸®½ºÆù °³¼±
#define		__CPU_UTILDOWN_060502			// CPU »ç¿ë·ü °¨¼ÒÀÛ¾÷ 
#define		__SLIDE_060502					// ¶¥À¸·Î ²¨Áö´Â ¹®Á¦ ¼öÁ¤ 
#define		__S8_SERVER_PORT				// 2006¿ù 11¿ù 7ÀÏ ¾÷µ¥ÀÌÆ® - World, Cache, CoreServer
#define		__EVENT_1101					// ÃâÃ½ ÀÌº¥Æ®
#define		__NEWYEARDAY_EVENT_COUPON		// ¼³ ÀÌº¥Æ® - Çì¾î˜? ¼ºÇü ¹«·áÀÌ¿ë±Ç °ü·Ã.
// ÇØ¿Ü 6Â÷ ¼öÁ¤ Àû¿ë
#define		__LANG_1013						// ÇØ¿Ü ¹öÀü Ãß°¡ ½Ã ½ºÅ©¸³Æ®·Î Àû¿ë Neuz. World
#define		__HACK_1130						// ¹Ì±¹ ÇØÅ· ¸·±â - °­Á¦ µà¾ó, ½ºÅ©¸³Æ® ½ÇÇà
#define		__QUEST_1208					// ½ºÅ©¸³Æ® ÆÐÅ¶ Ã³¸® Á¦ÇÑ
#define		__TRAFIC_1222					// Áßº¹ ÆÐÅ¶ Àü¼Û ¸·±â
#define		__S_SERVER_UNIFY				// ¼­¹ö ÅëÇÕ Neuz, World

// ÇØ¿Ü 7Â÷ ¼öÁ¤ Àû¿ë
#define		__BUGFIX_0326					// ºñÇà ¸ó½ºÅÍ ¾ÆÀÌÅÛ µå·Ó

// 8.5Â÷
#define		__INFINITE_0227

#define		__LANG_IME_0327					// ±¹°¡º° imeÇ¥½Ã Ã¢ Ãâ·Â ±¸ºÐ
#define		__STL_0402						// stl
// 9Â÷
#define		__TRADESYS						// ±³È¯ ¾ÆÀÌÅÛ ½ºÅ©¸³Æ®(ÀÌº¥Æ®, Äù½ºÆ®, ...) Neuz, World
#define		__EVE_BALLOON					//Ç³¼± ÀÌº¥Æ® °ü·Ã

#define		__ITEMDROPRATE					// ÀÌº¥Æ® ¾ÆÀÌÅÛ µå·Ó·ü Á¶Á¤Á¤

#define		__PK_PVP_SKILL_REGION			// PK±ÝÁö±¸¿ª¿¡¼­ ¾ÇÇà ½ºÅ³Àº PVP»ó´ë¿¡°Ô¸¸ °¡´ÉÇÏµµ·Ï..
#define		__PVPDEBUFSKILL					// PVP Á¾·á ÈÄ µð¹öÇÁ·Î ÀÎÇØ Ä«¿À°¡ µÇ´Â ¹®Á¦ ¼öÁ¤ - World
#define		__EVENT_1101_2					// ÃâÃ½ ÀÌº¥Æ® 64ºñÆ® º¯°æ
#define		__S_RECOMMEND_EVE				// ÃßÃµ ÀÌº¥Æ® Neuz, Trans, World
#define		__EVE_MINIGAME					// ÀÌº¥Æ® ¹Ì´Ï°ÔÀÓ 4Á¾, Neuz, World

#define		__ANGEL_LOG						// ¿£Á© °ü·Ã ·Î±×
#define		__EXP_ANGELEXP_LOG				// °æÇèÄ¡, ¿£Á© °æÇèÄ¡ ·Î±× °ü·Ã CHARACTER_TBL ÄÃ·³ Ãß°¡
#define		__S_ADD_EXP						// EXP_S ¾ÆÀÌÅÛ »ý¼º

#define		__RULE_0615						// ¸í¸í ±ÔÄ¢ Á¤¸®
#define		__S_BUG_GC						// ±æµå´ëÀü ½ÅÃ»½Ã °°Àº ±Ý¾×À» ½ÅÃ»ÇÏ¸é ±æµå¾ÆÀÌµð·Î ¼îÆ® µÇ¼­ ¼øÀ§°¡ ¹Ù²î´Â ¹®Á¦ ¼öÁ¤( map -> vector ) 
#define		__S_ADD_RESTATE					// »ó¿ëÈ­ ¾ÆÀÌÅÛ »ý¼º( ¸®½ºÅ×Æ® Èû, ¹ÎÃ¸, Ã¼·Â, Áö´É )

//	#define		__REMOVE_ATTRIBUTE			// ¼Ó¼ºÁ¦·Ã Á¦°Å(10Â÷·Î º¯°æ)
//	#define		__CHAO_DMGDEC				// Ä«¿À½Ã PKValue¿¡ µû¶ó PVP Damage °¨¼Ò(9Â÷)

#define		__PROP_0827						// ¾ÆÀÌÅÛ ÇÁ·ÎÆÛÆ¼ Àû¿ë ÆÄ¶ó¹ÌÅÍ È®Àå
#define		__RIGHTHAND_SKILL				// ½º¸¶ÀÌÆ® ¿¢½º, ¿¢½º ¸¶½ºÅÍ¸®, ºí·¹ÀÌÂ¡¼Òµå, ¼Òµå ¸¶½ºÅÍ¸® ¿À¸¥¼ÕÀÇ ¹«±â¸¸À» ±âÁØÀ¸·Î ½ºÅ³»ç¿ë
#define		__LOG_MATCHLESS					// ÀÏ¹Ý À¯Àú°¡ ¹«Àû»óÅÂ°¡ µÇ´Â °æ¿ì°¡ °¡²û ¹ß»ýÇÏ¿© ·Î±× ³²±è.

#define		__PKSERVER_USE_ANGEL			// PK¼­¹ö¿¡¼­¸¸ ¿£Á©°ü·Ã ¾ÆÀÌÅÛ,¹öÇÁ »ç¿ë

//	#define		__EVENTLUA_ATKDEF			// ·ç¾Æ ÀÌº¥Æ® - °ø°Ý·Â, ¹æ¾î·Â Áõ°¡(9Â÷·Î º¯°æµÊ)


// 11Â÷
//	#define		__MA_VER11_02				// ¼öÇ¥ °³³ä È­Æä 'Æä¸°' Ãß°¡
//	#define		__MA_VER11_04				// ±æµå Ã¢°í ·Î±× ±â´É world,database
//	#define		__MA_VER11_05				// ÄÉ¸¯ÅÍ ºÀÀÎ °Å·¡ ±â´É world,database,neuz
//	#define		__MA_VER11_06				// È®À²½ºÅ³ È¿°ú¼öÁ¤ world,neuz

//	#define		__CSC_VER11_3				// Ä¨À¸·Î »óÁ¡ ÀÌ¿ë ÇÏ±â (±æµå ´ëÀü °ü·Ã)
//	#define		__CSC_VER11_5				// ÅÂ½ºÅ©¹Ù È®Àå
//	#define		__GUILDCOMBATCHIP			// ±æµå´ëÀü Ä¨º¸»ó ¹× Ä¨À» ÅëÇÑ »óÁ¡ ÀÌ¿ë
//	#define		__GUILD_COMBAT_1TO1			// ÀÏ´ëÀÏ ±æµå ´ëÀü
//	#define		__EXPITEM_TOOLTIP_CHANGE	// °æÇèÄ¡ ¾ÆÀÌÅÛ Ç¥±â ¹æ¹ý º¯°æ

//	#define		__REMOVE_ENDURANCE			// ¾ÆÀÌÅÛ ³»±¸·Â °³³ä Á¦°Å
//	#define		__PIERCING_REMOVE			// ÇÇ¾î½Ì ¿É¼Ç Á¦°Å
#define		__EVENTLUA_COUPON			// ÄíÆù ÀÌº¥Æ®
#define		__NOLIMIT_RIDE_ITEM			// ·¹º§ Á¦ÇÑ ¾ø´Â ºñÇàÃ¼ ¾ÆÀÌÅÛ		// ±¹³»¸¸ Àû¿ë
#define		__NPC_BUFF					// NPC¸¦ ÅëÇØ ¹öÇÁ¹Þ±â
//	#define		__REFLECTDMG_AFTER			// ¹Ý»çµ¥¹ÌÁö¸¦ ³ªÁß¿¡ Àû¿ë
//	#define		__CHIPI_071210				// ±â°£Á¦ ¾ÆÀÌÅÛ ±â°£ ¸¸·á °Ë»ç¸¦ SavePlayer()¿¡¼­ ÇÏµµ·Ï º¯°æ(15ºÐ ÀÌ³»¿¡ Á¢¼Ó Á¾·á½Ã ¹«ÇÑ´ë »ç¿ë ¸·À½) - WORLDSERVER

//	#define		__SYS_POCKET				// ÁÖ¸Ó´Ï
//	#define		__SYS_COLLECTING			// Ã¤Áý
//	#define		__SYS_IDENTIFY				// °¢¼º, Ãàº¹
//	#define		__FIX_COLLISION
//	#define		__MOD_VENDOR

#define		__JEFF_11					// ¸ÔÆê ¾ð´ö¿¡ ÀÖ´Â ¾ÆÀÌÅÛÀ» ÁÞ¾î¸ÔÁö ¸øÇÏ´Â ¹®Á¦µîÀÇ AI °³¼±ÀÌ ÇÊ¿ä
#define		__SYS_TICKET				// ÀÔÀå±Ç
//	#define		__SYS_PLAYER_DATA			// Ä³¸¯ÅÍ ÅëÇÕ Á¤º¸
#define		__HACK_1023					// ¸®¼Ò½º º¯Á¶ // ³¯°Í ¼Óµµ // ¹«±â °ø°Ý ¼Óµµ
#define		__RT_1025					// ¸Þ½ÅÀú
#define		__VENDOR_1106				// °³ÀÎ»óÁ¡ Çã¿ë ¹®ÀÚ

#define		__INVALID_LOGIN_0320		// ÀúÀåÀÌ ¿Ï·á µÇÁö ¾ÊÀº »ç¿ëÀÚÀÇ Á¢¼Ó ¸·±â(º¹»ç ¹æÁö)

#define		__JEFF_9_20					// ºñÇà ½Ã°£À» Ä§¹¬ ½Ã°£À¸·Î Àü¿ë

#define		__EVENTLUA_GIFT				// Æ¯Á¤ ·¹º§·Î ·¹º§¾÷½Ã ¾ÆÀÌÅÛ Áö±Þ

#define		__JEFF_11_4					// ¾Æ·¹³ª
#define		__JEFF_11_5					// ¸Þ¸ð¸® ´©¼ö
#define		__JEFF_11_6					// ¹Ùº¸ ¸ó½ºÅÍ

#define		__DST_GIFTBOX				// Âø¿ë ¾ÆÀÌÅÛ¿¡ ±âÇÁÆ® ¹Ú½º ±â´É Ãß°¡
#define		__EVENT_MONSTER				// ÀÌº¥Æ® ¸ó½ºÅÍ(WorldServer)

#define		__CHIPI_DYO					// NPC¸¦ Æ¯Á¤±¹°¡¿¡¼­¸¸ Ãâ·ÂÇÒ ¼ö ÀÖ°Ô character.inc¿¡ ¼³Á¤ 
#define		__STL_GIFTBOX_VECTOR		// GiftBox Vector·Î º¯°æ(¹Ú½º °¹¼ö Á¦ÇÑ ¹®Á¦)
#define		__CHIPI_ITEMUPDATE_080804	// ±¹³»ÀÇ °æ¿ì g_uKey¿¡ 101ÀÌ ¾ø´Ù. ±×·¡¼­ ¼öÁ¤...

#define		__VM_0820
//#define		__VM_0819	// °¡»ó ¸Þ¸ð¸® ´©¼ö Ã£±â

// 12Â÷	
//	#define 	__ANGEL_NODIE				// Ä³¸¯ÅÍ°¡ »ç¸ÁÇØµµ ¿£Á©Àº »ç¸ÁÇÏÁö ¾Ê´Â´Ù.
//	#define		__SECRET_ROOM				// ºñ¹ÐÀÇ ¹æ
//	#define		__TAX						// ¼¼±Ý
//	#define		__HEAVEN_TOWER				// ½É¿¬ÀÇ Å¾
//	#define		__EXT_PIERCING				// ¹«±â ÇÇ¾î½Ì
//	#define		__MONSTER_SKILL				// ¸ó½ºÅÍ°¡ Ä³¸¯ÅÍ ½ºÅ³ °¡´ÉÇÏµµ·Ï ¼öÁ¤
//	#define		__NEW_SUMMON_RULE			// ¸ó½ºÅÍ ¼ÒÈ¯ ±ÔÄ¢ º¯°æ
//	#define		__LORD		// ±ºÁÖ ½Ã½ºÅÛ
//	#define		__PET_0519	// Æê °¢¼º
//	#define		__J12_0		// °¢¼º, Ãàº¹ °¡´É ÆÄÃ÷ Ãß°¡
//	#define		__RANGDA_0521	// ·£´ý ÀÌº¥Æ® ¸ó½ºÅÍ
//	#define		__MOD_TUTORIAL
//	#define		__JHMA_VER12_1	//12Â÷ ±Ø´ÜÀ¯·á¾ÆÀÌÅÛ  world,core
//	#define		__PARSKILL1001	//12Â÷ ÆÄ½ºÅ³ ¾ÆÀÌÅÛ ¼öÁ¤  world,core,neuz
//	#define		__ITEMCREATEMON_S0602		// ¸ó½ºÅÍ »ý¼º Neuz, World
//	#define		__NEW_ITEMCREATEMON_SERVER	// ¸ó½ºÅÍ »ý¼º ¾ÆÀÌÅÛ(IK3_CREATE_MONSTER) ±ÔÄ¢ º¯°æ(¼­¹ö)
//	#define		__EVENTLUA_0826
//	#define		__LEAK_0827
//	#define		__UPDATE_OPT

// 13Â÷
//	#define		__EXT_ENCHANT				// Á¦·Ã È®Àå(¼Ó¼º, ÀÏ¹Ý)
//	#define		__RAINBOW_RACE				// ·¹ÀÎº¸¿ì ·¹ÀÌ½º
//	#define		__HOUSING					// ÇÏ¿ìÂ¡ ½Ã½ºÅÛ
//	#define		__QUEST_HELPER				// Äù½ºÆ® NPCÀ§Ä¡ ¾Ë¸².
//	#define		__CHIPI_QUESTITEM_FLAG		// Äù½ºÆ® º¸»ó ¾ÆÀÌÅÛ ±Í¼Ó ¼³Á¤
//	#define		__HONORABLE_TITLE			// ´ÞÀÎ
//	#define		__COUPLE_1117				// Ä¿ÇÃ ½Ã½ºÅÛ
//	#define		__COUPLE_1202				// Ä¿ÇÃ º¸»ó

#define		__LAYER_1015		// µ¿Àû °´Ã¼ Ãþ
#define		__LAYER_1020		// __LAYER_1015 Å×½ºÆ®
#define		__LAYER_1021		// __LAYER_1015 ¸®½ºÆù
#define		__AZRIA_1023	// ÀÔÀå±Ç Ãþ Àû¿ë
#define		__PET_1024		// Æê ÀÛ¸í
#define		__BUFF_1107

#define		__OCCUPATION_SHOPITEM	// Á¡·É±æµå Àü¿ë ±¸¸Å °¡´É ¾ÆÀÌÅÛ

#define		__SYNC_1217		// ºñµ¿±â ¼öÁ¤(ÇÊ¸®ÇÉ º¸°í)
#define		__SPEED_SYNC_0108		// ResetDestParam speed ¼öÁ¤ ´À·ÁÁö°Ô º¸ÀÌ´Â°Í ¼öÁ¤ Å¸À¯ÀúÀÇ ÃÊ±â½ºÇÇµåºñµ¿±âµµ ¼öÁ¤ ¿¹Á¤ 
#define		__SYS_ITEMTRANSY			// ¾ÆÀÌÅÛ Æ®·£Áö¸¦ ½Ã½ºÅÛ¿¡¼­ Áö¿ø

#define		__EVENTLUA_CHEEREXP		// ·ç¾Æ ÀÌº¥Æ® - ÀÀ¿ø °æÇèÄ¡ ¼³Á¤

#define		__FUNNY_COIN			// ÆÛ´Ï ÄÚÀÎ

#define		__MAP_SECURITY				// ¸ÊÅø·Î º¯Á¶ÇÑ ¸Ê °Ë»ç

// 14Â÷
//	#define		__NEW_CONTINENT				// 14Â÷ ½Å±Ô´ë·ú ÇÏ¸£¸ð´Ñ Ãß°¡
//	#define		__SMELT_SAFETY				// 14Â÷ ¾ÈÀüÁ¦·Ã
//	#define		__INSTANCE_DUNGEON			// 14Â÷ ÀÎ½ºÅÏ½º ´øÀü ±â¹Ý
//	#define		__PARTY_DUNGEON				// 14Â÷ ±Ø´Ü Àü¿ë ÀÎ½ºÅÏ½º Àü´ø
//	#define		__ANGEL_EXPERIENCE			// 14Â÷ ¿£Á© º¯°æ »çÇ×(°æÇèÄ¡ ½Àµæ)
//	#define		__EQUIP_BIND				// ÀåÂø¾ÆÀÌÅÛ Âø¿ë½Ã ±Í¼Ó
//	#define		__EXT_ATTRIBUTE				// ¼Ó¼ºÁ¦·Ã °ø½Ä È®Àå ¹× º¯°æ
//	#define		__NEW_ITEM_LIMIT_LEVEL		// ¾ÆÀÌÅÛ Âø¿ë·¹º§ ±ÔÄ¢ º¯°æ(MASTER, HEROµµ ·¹º§ Àû¿ëÀ» ¹Þ°í ÇÏÀ§ Å¬·¡½º ¹«±â´Â ¹«Á¶°Ç ÀåÂø °¡´É)
//	#define		__BALLOON_CODE_IMPROVEMENT	// Ç³¼± °ü·Ã ÄÚµå °³¼±
//	#define		__PCBANG					// PC¹æ ÇýÅÃ
	#define		__QUIZ						// ÄûÁî ÀÌº¥Æ® ½Ã½ºÅÛ

#define		__BUFF_TOGIFT				// ¹öÇÁ ½Ã°£ ¸¸·áµÇ¸é ¾ÆÀÌÅÛ Áö±ÞÇÏ´Â ½Ã½ºÅÛ(IK2_BUFF_TOGIFT)
#define		__EVENTLUA_SPAWN			// ¾ÆÀÌÅÛ ¹× ¸ó½ºÅÍ ½ºÆù ÀÌº¥Æ®
#define		__EVENTLUA_KEEPCONNECT		// ´©Àû Á¢¼Ó ¾ÆÀÌÅÛ Áö±Þ ÀÌº¥Æ®

#define		__PERIN_BUY_BUG				// Æä³Ä ¹Ýº¹±¸¸Å ¹ö±× È®ÀÎ¿ë ÄÚµå

#define		__ERROR_LOG_TO_DB		// ¿¡·¯ ·Î±× ½Ã½ºÅÛ

#define		__EVENTLUA_RAIN				// Àå¸¶ ÀÌº¥Æ® -> ·ç¾Æ·Î º¯°æ

#define		__EVENTLUA_SNOW				// °­¼³ ÀÌº¥Æ®

#define		__ADD_RESTATE_LOW			// »ó¿ëÈ­ ¾ÆÀÌÅÛ »ý¼º( ¸®½ºÅ×Æ® ÇÏ±Þ Èû, ¹ÎÃ¸, Ã¼·Â, Áö´É )


// 15Â÷
//	#define		__PETVIS					// 15Â÷ ºñ½ºÆê
//	#define		__GUILD_HOUSE				// 15Â÷ ±æµåÇÏ¿ì½º
//	#define		__TELEPORTER				// 15Â÷ ÅÚ·¹Æ÷ÅÍ 
//	#define		__IMPROVE_QUEST_INTERFACE	// 15Â÷ Çâ»óµÈ Äù½ºÆ® ÀÎÅÍÆäÀÌ½º ½Ã½ºÅÛ
//	#define		__CAMPUS					// 15Â÷ »çÁ¦ ½Ã½ºÅÛ
//	#define		__HERO129_VER15				// 15Â÷ È÷¾î·Î ·¹º§È®Àå
//	#define		__IMPROVE_SYSTEM_VER15		// 15Â÷ ½Ã½ºÅÛ °³¼±»çÇ×
//	#define		__DYNAMIC_MPU				// º¯°æ°¡´ÉÇÑ MPU
//	#define		__USING_CONTINENT_DATA		// ´ë·ú °æ°èÁ¤º¸ ¿ÜºÎµ¥ÀÌÅÍ¿¡¼­ ±Ü¾î¿È
//	#define		__REACTIVATE_EATPET			// À¯Àú¿Í ¸ÔÆêÀÌ ÀÏÁ¤°Å¸® ÀÌ»ó ¸Ö¾îÁö¸é Àç¼ÒÈ¯
//	#define		__15_5TH_ELEMENTAL_SMELT_SAFETY	// 15.5Â÷ ¼Ó¼º ¾ÈÀü Á¦·Ã Ãß°¡
//	end15th


	#define		__FORCE_KILL_SERVER

	#define		__SHOP_COST_RATE			// »óÁ¡ °¡°Ý Á¶Á¤

//	#define		__ITEMTRANSY_PENYA			//	Æä³Ä·Î ¾ÆÀÌÅÛ Æ®·£Áö °¡´ÉÇÏ°Ô ¼³Á¤.
	#define		__PROTECT_AWAKE				//	°¢¼º º¸È£ÀÇ µÎ·ç¸¶¸®.

	#define		__ENVIRONMENT_EFFECT

#if	  defined(__INTERNALSERVER)	// ³»ºÎ »ç¹«½Ç Å×½ºÆ®¼­¹ö 
//	#define	__RULE_0615

//	#define		__VERIFY_MEMPOOL
	#define		__GUILDVOTE					// ±æµå ÅõÇ¥ 
	#define		__IAOBJ0622					// »ó´ë ¸ñÇ¥ ÁÂÇ¥ Àü¼Û	// ¿ùµå, ´ºÁî
	#define		__SKILL0517
//	#define		__S_NEW_SKILL_2				// ½ºÅ³ °³¼± ÆÐÅ¶ Àü¼Û Neuz, World, Trans
	#define		__Y_CASTING_SKIP			// ÄÉ½ºÆÃ ¾øÀÌ ½ºÅ³ ¹ßµ¿ - Neuz, World
	#define		__YAIMONSTER_EX				// AI±â´É Ãß°¡ - Neuz, World
	#define		__Y_PATROL					// ¹èÈ¸ÇÏ±â - Neuz, World
	#define		__V060721_TEXTDRAG			// ±ÛÀÚ¿¡ È¿°úÁÖ±â
	#define		__Y_BEAUTY_SHOP_CHARGE
//	#define		__LUASCRIPT060908			// lua ½ºÅ©¸³Æ®¿£Áø( ¾ÆÀÌÅÛ ) 
	#define		__Y_FLAG_SKILL_BUFF			// ÆÖ, º¯½Å ¾ÆÀÌÅÛ Åä±Û¹öÇÁ Àû¿ë... Neuz, World
//	#define		__EVENT_FALL				// ´ÜÇ³ ÀÌº¥Æ® - ¸ðµ¨±³Ã¼ Neuz, World
//	#define		__LANG_1013					// ÇØ¿Ü ¹öÀü Ãß°¡ ½ºÅ©¸³Æ®
//	#define		__JEFF_VER_8				// 8Â÷ ÀÛ¾÷
//	#define		__JHMA_VER_8_1				// 8Â÷ °ÔÀÓ³»µ·µå·Ó±ÝÁö	Neuz, World 
//	#define		__JHMA_VER_8_2				// 8Â÷ °ÔÀÓ³»¾ÆÀÌÅÛÆÇ¸Å°¡°ÝÁ¦ÇÑÇ®±â	Neuz, World
//	#define		__JHMA_VER_8_5				// 8Â÷ ½ºÅ³°æÇèÄ¡´Ù¿îº¯°æ	Neuz, World
//	#define		__JHMA_VER_8_6				// 8Â÷ Áö»ó¸ó½ºÅÍ°¡ Àú°øºñÇàÀ¯Àú¸¦ °ø°Ý°¡´ÉÇÏ°ÔÇÔ   World
//	#define		__JHMA_VER_8_7				// 8Â÷ µà¾óÁ¸¿¡ °ü°è¾øÀÌ PVP°¡´ÉÇÏ°ÔÇÔ   Neuz, World
//	#define		__JHMA_VER_8_5_1			// 8.5Â÷ °æºñº´ ¹üÀ§½ºÅ³ °ø°ÝÈ¿°ú ºÒ°¡·Î ¼öÁ¤ World
//	#define		__JHMA_VER_8_5_2			// 8.5Â÷ µà¾óÁßÀÎ µÎ±¸·ìÀÌ ¿¬°üµÇÁö¾Ê°Ô ¼öÁ¤  World
//	#define		__CSC_VER8_3				// 8Â÷ BuffÃ¢ °ü·Ã. Neuz, World
//	#define		__CSC_VER8_4				// 8Â÷ Çì¾î˜? ¼ºÇü¼ö¼ú °ü·Ã Neuz, World
//	#define		__CSC_VER8_5				// 8Â÷ ¿£Á© ¼ÒÈ¯ Neuz, World, Trans
//	#define		__CSC_VER8_6				// ¿î¿µÀÚ ¸í·É¾î statall Ãß°¡ World
	#define		__Y_MAX_LEVEL_8				// ¸¸·¦ 120À¸·Î Á¶Á¤... Neuz, World, Trans
	#define		__Y_HAIR_BUG_FIX
	#define		__EVENT_0117				// ±¸Á¤ ÀÌº¥Æ®
//	#define		__NEWYEARDAY_EVENT_COUPON	// ¼³ ÀÌº¥Æ® - Çì¾î˜? ¼ºÇü ¹«·áÀÌ¿ë±Ç °ü·Ã.
	#define		__TRAFIC_1215
//	#define     __Y_NEW_ENCHANT				// Á¦·Ã ¾ÆÀÌÅÛ º¯°æ, Neuz, World

//	#define		__INVALID_LOGIN_0320		// ÀúÀåÀÌ ¿Ï·á µÇÁö ¾ÊÀº »ç¿ëÀÚÀÇ Á¢¼Ó ¸·±â(º¹»ç ¹æÁö)
	#define		__BUGFIX_0326				// ºñÇà ¸ó½ºÅÍ ÀÌº¥Æ® ¾ÆÀÌÅÛ µå·Ó ¼öÁ¤
// 10Â÷
//	#define		__LEGEND					// 10Â÷ Àü½Â½Ã½ºÅÛ	Neuz, World, Trans
// 10Â÷
//	#define		__ULTIMATE					// 9, 10Â÷ ¾óÅÍ¸Ú ¿þÆù Á¦·Ã ½Ã½ºÅÛ
	
//	#define		__PET_0410					// 9, 10Â÷ Æê
//	#define		__JEFF_9					// 9, 10Â÷ Ãß°¡ ÀÛ¾÷
//	#define		__AI_0509					// ¸ó½ºÅÍ ÀÎ°øÁö´É
	#define		__HACK_0516					// ¹Ì±¹ ÇØÅ· 2Â÷
//	#define		__LUASCRIPT					// ·ç¾Æ ½ºÅ©¸³Æ® »ç¿ë (World, Trans, Neuz)
//	#define		__EVENTLUA					// ÀÌº¥Æ® (·ç¾Æ ½ºÅ©¸³Æ® Àû¿ë) - World, Trans, Neuz

//	#define		__FLYBYATTACK0608			// 9th FlyByAttack edit
//	#define		__PVPDEMAGE0608				// 9th PVP DEMAGE edit
//	#define		__BLADELWEAPON0608			// 9th ºí·¹ÀÌµå ¾ç¼Õ¿¡ ¹«±â¸¦ Âø¿ë ½Ã Ãß°¡ ¿É¼ÇÀº ¿À¸¥¼Õ¿¡ µé°í ÀÖ´Â ¹«±âÀÇ °Í¸¸ Àû¿ëÀÌ µÇµµ·Ï ¼öÁ¤
//	#define		__METEONYKER_0608
//	#define		__Y_DRAGON_FIRE
//	#define		__CSC_VER9_5				// 9Â÷ Á¦·Ã°ü·Ã (Ãß°¡ °Ë±¤ ±â´É)

	#define		__GLOBAL_COUNT_0705			// CTime::GetTimer

//	#define		__SKILL_0706				// ´ëÀÎ¿ë AddSkillProp ÄÃ·³ Ãß°¡ ¹× Àû¿ë
//	#define		__AI_0711					// ¸ÞÅ×¿À´ÏÄ¿ AI ¼öÁ¤
//	#define		__HACK_0720					// ¸®¼Ò½º ÇØÅ·
//11
//	#define		__JEFF_11					// ¸ÔÆê ¾ð´ö¿¡ ÀÖ´Â ¾ÆÀÌÅÛÀ» ÁÞ¾î¸ÔÁö ¸øÇÏ´Â ¹®Á¦µîÀÇ AI °³¼±ÀÌ ÇÊ¿ä
	
//	#define		__SYS_TICKET				// ÀÔÀå±Ç
//	#define		__SYS_PLAYER_DATA			// Ä³¸¯ÅÍ ÅëÇÕ Á¤º¸
//	#define		__HACK_1023					// ¸®¼Ò½º º¯Á¶ // ³¯°Í ¼Óµµ // ¹«±â °ø°Ý ¼Óµµ
//	#define		__RT_1025					// ¸Þ½ÅÀú

//	#define		__VENDOR_1106				// °³ÀÎ»óÁ¡ Çã¿ë ¹®ÀÚ

	#define		__JEFF_11_1
	#define		__JEFF_11_3					// ¼­¹ö/Å¬¶óÀÌ¾ðÆ® ¸®¼Ò½º ºÐ¸®
//	#define		__JEFF_11_4					// ¾Æ·¹³ª

//	#define		__JEFF_11_5					// ¸Þ¸ð¸® ´©¼ö

//	#define		__DST_GIFTBOX				// Âø¿ë ¾ÆÀÌÅÛ¿¡ ±âÇÁÆ® ¹Ú½º ±â´É Ãß°¡

	#define		__PERF_0226

	#define		__OPT_MEM_0811
//	#define		__MEM_TRACE
//	#define		__NEW_PROFILE		// »õ·Î¿î ÇÁ·ÎÆÄÀÏ·¯ Àû¿ë	//rev1

	#define		__VTN_TIMELIMIT				// º£Æ®³² ÇÃ·¹ÀÌ ½Ã°£ Á¦ÇÑ

	#define		__PROTECT_AWAKE				//	°¢¼º º¸È£ÀÇ µÎ·ç¸¶¸®.


	#undef		__VER
	#define		__VER 16

	#define		__GUILD_HOUSE_MIDDLE		// ±æµåÇÏ¿ì½º ÁßÇü

	#define		__MOVER_STATE_EFFECT		// ¹«¹ö »óÅÂ°ª º¯È­¿¡ µû¸¥ ÀÌÆåÆ® Àû¿ë

	#define		__NEW_ITEM_VARUNA			// ½Å Á¦·Ã ½Ã½ºÅÛ(¹Ù·ç³ª)


#elif defined(__TESTSERVER)		// ¿ÜºÎ À¯Àú Å×½ºÆ®¼­¹ö 
	
	#define		__GUILDVOTE					// ±æµå ÅõÇ¥ 
//	#define		__SKILL0517					// ½ºÅ³ ·¹º§ ÆÄ¶ó¹ÌÅÍ
	#define		__Y_CASTING_SKIP			// ÄÉ½ºÆÃ ¾øÀÌ ½ºÅ³ ¹ßµ¿ - Neuz, World
	#define		__YAIMONSTER_EX				// AI±â´É Ãß°¡ - Neuz, World
	#define		__Y_PATROL					// ¹èÈ¸ÇÏ±â - Neuz, World
	#define		__V060721_TEXTDRAG			// ±ÛÀÚ¿¡ È¿°úÁÖ±â
	#define		__Y_BEAUTY_SHOP_CHARGE
	#define		__Y_FLAG_SKILL_BUFF			// ÆÖ, º¯½Å ¾ÆÀÌÅÛ Åä±Û¹öÇÁ Àû¿ë... Neuz, World
//	#define		__EVENT_FALL				// ´ÜÇ³ ÀÌº¥Æ® - ¸ðµ¨±³Ã¼ Neuz, World
	#define		__Y_MAX_LEVEL_8				// ¸¸·¦ 120À¸·Î Á¶Á¤... Neuz, World, Trans
	#define		__TRAFIC_1215

	// 10Â÷
//	#define		__LEGEND					// 10Â÷ Àü½Â½Ã½ºÅÛ	Neuz, World, Trans

//	#define		__CSC_VER9_2				// 9Â÷ »óÅÂÃ¢ º¯°æ °ü·Ã Neuz, World

	#define		__HACK_0516					// ¹Ì±¹ ÇØÅ· 2Â÷

//	#define		__FLYBYATTACK0608			// 9th FlyByAttack edit
//	#define		__PVPDEMAGE0608				// 9th PVP DEMAGE edit
//	#define		__BLADELWEAPON0608			// 9th ºí·¹ÀÌµå ¾ç¼Õ¿¡ ¹«±â¸¦ Âø¿ë ½Ã Ãß°¡ ¿É¼ÇÀº ¿À¸¥¼Õ¿¡ µé°í ÀÖ´Â ¹«±âÀÇ °Í¸¸ Àû¿ëÀÌ µÇµµ·Ï ¼öÁ¤

//	#define		__Y_DRAGON_FIRE
//	#define		__LUASCRIPT					// ·ç¾Æ ½ºÅ©¸³Æ® »ç¿ë (World, Trans, Neuz)
//	#define		__EVENTLUA					// ÀÌº¥Æ® (·ç¾Æ ½ºÅ©¸³Æ® Àû¿ë) - World, Trans, Neuz
//	#define		__CSC_VER9_5				// 9Â÷ Á¦·Ã°ü·Ã (Ãß°¡ °Ë±¤ ±â´É)

//	#define		__PET_0410					// 9, 10Â÷ Æê
//	#define		__METEONYKER_0608
//	#define		__SKILL_0706				// ´ëÀÎ¿ë AddSkillProp ÄÃ·³ Ãß°¡ ¹× Àû¿ë
//	#define		__AI_0711					// ¸ÞÅ×¿À´ÏÄ¿ AI ¼öÁ¤
//	#define		__JEFF_9					// 9, 10Â÷ Ãß°¡ ÀÛ¾÷
//	#define		__AI_0509					// ¸ó½ºÅÍ ÀÎ°øÁö´É
	#define		__GLOBAL_COUNT_0705			// CTime::GetTimer

//	#define		__JEFF_11					// ¸ÔÆê ¾ð´ö¿¡ ÀÖ´Â ¾ÆÀÌÅÛÀ» ÁÞ¾î¸ÔÁö ¸øÇÏ´Â ¹®Á¦µîÀÇ AI °³¼±ÀÌ ÇÊ¿ä
//	#define		__SYS_TICKET				// ÀÔÀå±Ç
//	#define		__SYS_PLAYER_DATA			// Ä³¸¯ÅÍ ÅëÇÕ Á¤º¸
//	#define		__HACK_1023					// ¸®¼Ò½º º¯Á¶ // ³¯°Í ¼Óµµ // ¹«±â °ø°Ý ¼Óµµ
//	#define		__RT_1025					// ¸Þ½ÅÀú
//	#define		__VENDOR_1106				// °³ÀÎ»óÁ¡ Çã¿ë ¹®ÀÚ

//	#undef	__VER
//	#define	__VER	11						// 11Â÷

	#define		__JEFF_11_1
	#define		__JEFF_11_3					// ¼­¹ö/Å¬¶óÀÌ¾ðÆ® ¸®¼Ò½º ºÐ¸®
//	#define		__JEFF_11_4					// ¾Æ·¹³ª
//	#define		__JEFF_11_5					// ¸Þ¸ð¸® ´©¼ö

//	#define		__JAPAN_SAKURA				// ¹þ²É ÀÌº¥Æ®

	#define		__OPT_MEM_0811
//	#define		__MEM_TRACE
	
//	#define		__NEW_PROFILE		// »õ·Î¿î ÇÁ·ÎÆÄÀÏ·¯ Àû¿ë	//rev1

	#define		__GUILD_HOUSE_MIDDLE		// ±æµåÇÏ¿ì½º ÁßÇü

#elif defined(__MAINSERVER)	// ¿ÜºÎ º»¼·
 
	#define		__ON_ERROR
	#define		__IDC
	#define		__Y_BEAUTY_SHOP_CHARGE		// ºäÆ¼¼¥, °³ÀÎ»óÁ¡ À¯·á¾ÆÀÌÅÛÈ­..Neuz, World
	#define		__TRAFIC_1215
//	#define		__EVENT_FALL		// ´ÜÇ³

//	#define     __Y_NEW_ENCHANT				// Á¦·Ã ¾ÆÀÌÅÛ º¯°æ, Neuz, World

	#define		__JEFF_11_1
	#define		__JEFF_11_3		// ¼­¹ö/Å¬¶óÀÌ¾ðÆ® ¸®¼Ò½º ºÐ¸®

	#define		__EVENT_0117				// propEvent.inc spawn
//	#define		__JAPAN_SAKURA				// ¹þ²É ÀÌº¥Æ®
//	#define		__RAIN_EVENT		// Àå¸¶ ÀÌº¥Æ®(ºñ¿À´Â µ¿¾È °æÇèÄ¡ 2¹è)

	#define		__OPT_MEM_0811
//	#define		__MEM_TRACE
//	#define		__NEW_PROFILE		// »õ·Î¿î ÇÁ·ÎÆÄÀÏ·¯ Àû¿ë	//rev1
	#define		__GLOBAL_COUNT_0705			// CTime::GetTimer

#endif	// end - ¼­¹öÁ¾·ùº° define 

// ÀÓ½Ã - ¿©±â´Ù ³ÖÁö ¸»°Í 
#if __VER >= 7
	#define		__REMOVE_SCIRPT_060712		 
#endif

#endif