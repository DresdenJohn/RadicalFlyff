#ifndef __VERSION_COMMON_H__
#define __VERSION_COMMON_H__
#define __MAINSERVER
#define		__VER	15		// 15Â÷

#if !defined( __TESTSERVER ) && !defined( __MAINSERVER )
	#define __INTERNALSERVER
#endif

/**************************************************************************/
//////////////////////////// Rad Fly ///////////////////////////////////////
/**************************************************************************/

#define __RES_ENCRYPT
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
// #define __AUTO_SKILL_MAX

/**************************************************************************/
////////////////////////////////////////////////////////////////////////////
/**************************************************************************/

#if (_MSC_VER > 1200)
#define		__VS2003		// ÄÄÆÄÀÏ·¯º¯°æ.net
#endif

// ADDED SYSTEMS


#define		NO_GAMEGUARD	//rev1

#define		__TRANSFER_ERROR_TEXT
#define		__CRC
#define		__PROTOCOL0910
#define		__PROTOCOL1021
#define		__INFO_SOCKLIB0516			// ³×Æ®¿öÅ© ¿¡·¯¾ò±â 
#define		__S1108_BACK_END_SYSTEM		// Trans, World, Neuz : ¹é¾Øµå½Ã½ºÅÛ 
#define		__THROUGHPORTAL0810			// À¥¿¡ ÀÇÇÑ ½ÇÇà
#define		__TWN_LOGIN0816				// ´ë¸¸ ·Î±×ÀÎ ÇÁ·ÎÅäÄÝ º¯°æ	// Å¬¶ó/ÀÎÁõ
#define		__FIX_WND_1109				// Ã¢ »ý¼º ½Ã ºÎ¸ðÃ¢ ÁöÁ¤ ¿À·ù ¼öÁ¤
#define		__EVENT_1101				// ÃâÃ½ ÀÌº¥Æ®
#define		__EVE_NEWYEAR				// ½Å³â È¿°ú

#define		__S_SERVER_UNIFY			// ¼­¹ö ÅëÇÕ Neuz, World
#define		__LANG_IME_0327				// ±¹°¡º° imeÇ¥½Ã Ã¢ Ãâ·Â ±¸ºÐ
#define		__STL_0402					// stl

#define		__NEWYEARDAY_EVENT_COUPON	// ¼³ ÀÌº¥Æ® - Çì¾î˜? ¼ºÇü ¹«·áÀÌ¿ë±Ç °ü·Ã.
// ÇØ¿Ü 6Â÷ Àû¿ë
#define		__LANG_1013					// ÇØ¿Ü ¹öÀü ½Å±Ô Ãß°¡ ½ºÅ©¸³Æ®

#define		__ITEMDROPRATE				// ÀÌº¥Æ® ¾ÆÀÌÅÛ µå·Ó·ü Á¶Á¤


// 10
#define		__TRADESYS					// ±³È¯ ¾ÆÀÌÅÛ ½ºÅ©¸³Æ®(ÀÌº¥Æ®, Äù½ºÆ®, ... ) Neuz, World
#define		__EVE_BALLOON				// Ç³¼± ÀÌº¥Æ® °ü·Ã
#define		__CSC_GAME_GRADE			// °ÔÀÓ¹°µî±Þ°ü·Ã Ã¤ÆÃÃ¢ ¾Ë¸² ¹× ÀÌ¹ÌÁö º¯°æ.

#define		__PK_PVP_SKILL_REGION		// PK±ÝÁö±¸¿ª¿¡¼­ ¾ÇÇà ½ºÅ³Àº PVP»ó´ë¿¡°Ô¸¸ °¡´ÉÇÏµµ·Ï..
#define		__EVENT_1101_2				// ÃâÃ½ ÀÌº¥Æ® 64ºñÆ® º¯°æ
#define		__S_RECOMMEND_EVE			// ÃßÃµ ÀÌº¥Æ® Neuz, Trans, World
#define		__EVE_MINIGAME				// Mini Game 4Á¾ ÀÌº¥Æ® Ãß°¡ °ü·Ã.
#define		__S_ADD_EXP					// EXP_S ¾ÆÀÌÅÛ »ý¼º

#define		__RULE_0615					// ¸í¸í ±ÔÄ¢ Á¤¸®
#define		__FILTER_0705				// ÇÊÅÍ¸µ ±ÔÄ¢ º¯°æ
#define		__S_BUG_GC					// ±æµå´ëÀü ½ÅÃ»½Ã °°Àº ±Ý¾×À» ½ÅÃ»ÇÏ¸é ±æµå¾ÆÀÌµð·Î ¼îÆ® µÇ¼­ ¼øÀ§°¡ ¹Ù²î´Â ¹®Á¦ ¼öÁ¤( map -> vector ) 
#define		__S_ADD_RESTATE				// »ó¿ëÈ­ ¾ÆÀÌÅÛ »ý¼º( ¸®½ºÅ×Æ® Èû, ¹ÎÃ¸, Ã¼·Â, Áö´É )

#define		__PROP_0827					// ¾ÆÀÌÅÛ ÇÁ·ÎÆÛÆ¼ Àû¿ë ÆÄ¶ó¹ÌÅÍ È®Àå

#define		__PKSERVER_USE_ANGEL		// PK¼­¹ö¿¡¼­¸¸ ¿£Á©°ü·Ã ¾ÆÀÌÅÛ,¹öÇÁ »ç¿ë
#define		__CSC_ENCHANT_EFFECT_2		// ±âÁ¸ ÀÌÆåÆ® + Çâ»óµÈ ÀÌÆåÆ®

//11Â÷
//	#define		__MA_VER11_02				// ¼öÇ¥ ±â´É Æä¸° °ü·Ã
//	#define		__MA_VER11_03				// neuz±Ø´ÜÃ¢(B)¿¡¼­ ±Ø´Ü¿øÀÌ ¸Ö¸® ¶³¾îÁ® ÀÖ¾îµµ ·¹º§ÀÌ Ç¥½Ã µÇµµ·Ï
//	#define		__MA_VER11_04				// ±æµå Ã¢°í ·Î±× ±â´É world,database,neuz
//	#define		__MA_VER11_05				// ÄÉ¸¯ÅÍ ºÀÀÎ °Å·¡ ±â´É world,database,neuz
//	#define		__MA_VER11_06				// È®À²½ºÅ³ È¿°ú¼öÁ¤ world,neuz
//	#define		__CSC_VER11_1				// <·¹º§??> »èÁ¦, Ã¤ÆÃÃ¢ ¼öÁ¤, Æä³Ä°Å·¡ Ãë¼Ò¹öÆ° »èÁ¦
//	#define		__CSC_VER11_2				// Å¸°Ù Ç¥½Ã ¹æ¹ý º¯°æ
//	#define		__CSC_VER11_3				// Ä¨À¸·Î »óÁ¡ ÀÌ¿ë ÇÏ±â (±æµå ´ëÀü °ü·Ã)
//	#define		__CSC_VER11_4				// ¸Þ½ÅÀúÃ¢ °³¼±
//	#define		__CSC_VER11_5				// ÅÂ½ºÅ©¹Ù È®Àå
//	#define		__GUILDCOMBATCHIP			// ±æµå´ëÀü Ä¨º¸»ó ¹× Ä¨À» ÅëÇÑ »óÁ¡ ÀÌ¿ë
//	#define		__GUILD_COMBAT_1TO1			// ÀÏ´ëÀÏ ±æµå ´ëÀü
//	#define		__GUILD_BANK_LOG			// ±æµå¹ðÅ© ·Î±×Ã¢ Ãß°¡
//	#define		__EXPITEM_TOOLTIP_CHANGE	// °æÇèÄ¡ ¾ÆÀÌÅÛ Ç¥±â ¹æ¹ý º¯°æ
//	#define		__REMOVE_ENDURANCE			// ¾ÆÀÌÅÛ ³»±¸·Â °³³ä Á¦°Å
//	#define		__PIERCING_REMOVE			// ÇÇ¾î½Ì ¿É¼Ç Á¦°Å
//	#define		__CHIPI_071210				// ±â°£Á¦ ¾ÆÀÌÅÛ Áö¼Ó½Ã°£ ÃÊ´ÜÀ§ Ç¥±â

#define		__EVENTLUA_COUPON			// ÄíÆù ÀÌº¥Æ®
#define		__NOLIMIT_RIDE_ITEM			// ·¹º§ Á¦ÇÑ ¾ø´Â ºñÇàÃ¼ ¾ÆÀÌÅÛ
#define		__NPC_BUFF					// NPC¸¦ ÅëÇØ ¹öÇÁ¹Þ±â

//	#define		__SYS_POCKET				// ÁÖ¸Ó´Ï
//	#define		__SYS_COLLECTING			// Ã¤Áý ½Ã½ºÅÛ
//	#define		__SYS_IDENTIFY				// °¢¼º, Ãàº¹
//	#define		__FIX_ROTATE				// ºñ½ºÆ®¿¡¼­ ¹ß°ßµÈ ¿À·ù ¼öÁ¤
//	#define		__ADD_ZOOMOPT				// ÁÜ¿É¼Ç Ãß°¡ 
//	#define		__MOD_VENDOR				// °³ÀÎ»óÁ¡ °³¼±
//	#define		__FIX_COLLISION				// Ãæµ¹ ¹®Á¦ ¼öÁ¤
//	#define		__FIX_PICKING				// ÇÇÅ· ¹®Á¦ ¼öÁ¤
//	#define		__CAPTURE_JPG				// JPGÆ÷¸ËÀ¸·Î Ä¸ÃÄ

#define		__SYS_TICKET				// ÀÔÀå±Ç
//	#define		__SYS_PLAYER_DATA			// Ä³¸¯ÅÍ Á¤º¸ ÅëÇÕ
#define		__HACK_1023					// ¸®¼Ò½º º¯Á¶ // ³¯°Í ¼Óµµ, ¹«±â °ø°Ý ¼Óµµ
#define		__RT_1025					// ¸Þ½ÅÀú
#define		__VENDOR_1106				// °³ÀÎ»óÁ¡ Çã¿ë ¹®ÀÚ
#define		__JEFF_11

#define		__JEFF_9_20					// ºñÇà ½Ã°£À» Ä§¹¬ ½Ã°£À¸·Î Àü¿ë
#define		__JEFF_11_4					// ¾Æ·¹³ª
#define		__JEFF_11_5					// ¸Þ¸ð¸® ´©¼ö
#define		__JEFF_11_6					// ¹Ùº¸ ¸ó½ºÅÍ
#define		__DST_GIFTBOX				// Âø¿ë ¾ÆÀÌÅÛ¿¡ ±âÇÁÆ® ¹Ú½º ±â´É Ãß°¡ 

#define		__SFX_OPT					// ÀÌÆåÆ®(ÆÄÆ¼Å¬) ÃÖÀûÈ­ °ü·Ã
//#define		__PERF_0229

#define		__HELP_BUG_FIX				// µµ¿ò¸»°ü·Ã ¹ö±× ¼öÁ¤ (µµ¿ò¸» ÇÑ°³¸¸ ¶ç¿ì±â ÀÎ½ºÅÏ½º °ü¸®)

#define		__CHIPI_DYO					// NPC¸¦ Æ¯Á¤±¹°¡¿¡¼­¸¸ Ãâ·ÂÇÒ ¼ö ÀÖ°Ô character.inc¿¡ ¼³Á¤ 

// 12Â÷

//	#define		__SECRET_ROOM				// ºñ¹ÐÀÇ ¹æ
//	#define		__TAX						// ¼¼±Ý
//	#define		__CSC_VER12_1				// °³ÀÎ»óÁ¡ Áß ÇÃ·¹ÀÌ¾î »ìÆìº¸±â ¸Þ´º °¡´ÉÇÏµµ·Ï ¼öÁ¤ & »ìÆìº¸±â Ã¢ À¯ÁöÇÏ±â
//	#define		__CSC_VER12_2				// ±æµå Ã¢ÀÇ ¸â¹ö ÅÜ¿¡ Ç×¸ñº° Á¤·ÄÀÌ °¡´ÉÇÏµµ·Ï Ãß°¡
//	#define		__CSC_VER12_3				// Äù½ºÆ®°¡ ¸¹À» °æ¿ì Äù½ºÆ® Ç×¸ñÀÌ Àß¸®´Â Çö»ó ¶§¹®¿¡ ´ëÈ­Ã¢ ´Ã¸²
//	#define		__CSC_VER12_4				// ÇÇ¾î½Ì Á¦°Å Ã¢ °³¼± ¹× ¾óÅÍ¸Ú º¸¼® Á¦°Å Ã¢ Ãß°¡
//	#define		__CSC_VER12_5				// Æê ¾Ë º¯È¯ ±â´É Ãß°¡
//	#define		__HEAVEN_TOWER				// ½É¿¬ÀÇ Å¾
//	#define		__EXT_PIERCING				// ¹«±â ÇÇ¾î½Ì
//	#define		__NEW_SUMMON_RULE			// ¸ó½ºÅÍ ¼ÒÈ¯ ±ÔÄ¢ º¯°æ
//	#define		__MOD_TUTORIAL				// Æ©Åä¸®¾ó °³¼±
//	#define		__LORD						// ±ºÁÖ
//	#define		__PET_0519	// Æê °¢¼º
//	#define		__J12_0		// °¢¼º, Ãàº¹ °¡´É ÆÄÃ÷ Ãß°¡
//	#define		__UPDATE_OPT				// ¿É¼ÇÃ¢ °³¼±
//	#define		__CAM_FAST_RECOVER			// Ä«¸Þ¶ó º¹¿ø¼Óµµ Áõ°¡
//	#define		__JHMA_VER12_1	//12Â÷ ±Ø´ÜÀ¯·á¾ÆÀÌÅÛ
//	#define		__ITEMCREATEMON_S0602		// ¸ó½ºÅÍ »ý¼º Neuz, World
//	#define		__PARSKILL1001	//12Â÷ ÆÄ½ºÅ³ ¾ÆÀÌÅÛ ¼öÁ¤  world,core,neuz
//	#define		__LEAK_0827


// 13Â÷
//	#define		__EXT_ENCHANT				// Á¦·Ã È®Àå(¼Ó¼º, ÀÏ¹Ý)
//	#define		__RAINBOW_RACE				// ·¹ÀÎº¸¿ì ·¹ÀÌ½º
	#define		__HOUSING					// ÇÏ¿ìÂ¡ ½Ã½ºÅÛ
//	#define		__QUEST_HELPER				// Äù½ºÆ® NPCÀ§Ä¡ ¾Ë¸².
//	#define		__CHIPI_QUESTITEM_FLAG
//	#define		__RENEW_CHARINFO			// Ä³¸¯ÅÍÁ¤º¸Ã¢ ¸®´º¾ó
//	#define		__HONORABLE_TITLE			// ´ÞÀÎ
	#define		__MAX_BUY_ITEM9999			// È­»ìÆ÷½ºÅÍ±¸ÀÔ°¹¼ö9999°³
//	#define		__REMOVE_JOINPARTYMEMBER_ANI			// ÆÄÆ¼¸É¹öÁ¶ÀÎ½Ã ¾Ö´Ï »©±â
//	#define		__CSC_VER13_1				// WorldMap ¸ó½ºÅÍ Ç¥½Ã
//	#define		__CSC_VER13_2				// Ä¿ÇÃ ½Ã½ºÅÛ
//	#define		__COUPLE_1117				// Ä¿ÇÃ ½Ã½ºÅÛ
//	#define		__COUPLE_1202				// Ä¿ÇÃ º¸»ó

#define		__LAYER_1020				// __LAYER_1015 Å×½ºÆ®
#define		__AZRIA_1023				// ÀÔÀå±Ç °èÃþ Àû¿ë
#define		__PET_1024					// Æê ÀÛ¸í
#define		__BUFF_1107
#define		__SYNC_1217					// ºñµ¿±â ¼öÁ¤(ÇÊ¸®ÇÉ º¸°í)
#define		__SYS_ITEMTRANSY			// NPC¸Þ´º ¾ÆÀÌÅÛ Æ®·»Áö ±â´É

#define		__SPEED_SYNC_0108		// ResetDestParam speed ¼öÁ¤ ´À·ÁÁö°Ô º¸ÀÌ´Â°Í ¼öÁ¤ Å¸À¯ÀúÀÇ ÃÊ±â½ºÇÇµåºñµ¿±âµµ ¼öÁ¤ ¿¹Á¤ 
#define		__PARTY_DEBUG_0129		// ±Ø´ÜÀå Æ¨±â´Â Çö»ó µð¹ö±ë neuz

#define		__FUNNY_COIN			// ÆÛ´Ï ÄÚÀÎ

#define		__GPAUTH
#define		__GPAUTH_01
#define		__GPAUTH_02
#define		__EUROPE_0514
#define		__WINDOW_INTERFACE_BUG		// ¿ùµå ÀÌµ¿ »óÈ²¿¡¼­ ¾ÆÀÌÅÛ °É¸° À©µµ¿ì Ã¢ ¶ç¿öÁ® ÀÖÀ¸¸é Å¬¶óÀÌ¾ðÆ® Å©·¡½¬µÇ´Â ¹®Á¦ ¼öÁ¤

#define		__MAP_SECURITY				// ¸ÊÅø·Î º¯Á¶ÇÑ ¸Ê °Ë»ç

// 14Â÷
	#define		__NEW_CONTINENT				// 14Â÷ ½Å±Ô´ë·ú ÇÏ¸£¸ð´Ñ Ãß°¡
	#define		__SMELT_SAFETY				// 14Â÷ ¾ÈÀüÁ¦·Ã
	#define		__INSTANCE_DUNGEON			// 14Â÷ ÀÎ½ºÅÏ½º ´øÀü
	#define		__EQUIP_BIND				// ÀåÂø¾ÆÀÌÅÛ Âø¿ë½Ã ±Í¼Ó
	#define		__EXT_ATTRIBUTE				// ¼Ó¼ºÁ¦·Ã °ø½Ä È®Àå ¹× º¯°æ
	#define		__NEW_ITEM_LIMIT_LEVEL		// ¾ÆÀÌÅÛ Âø¿ë·¹º§ ±ÔÄ¢ º¯°æ(MASTER, HEROµµ ·¹º§ Àû¿ëÀ» ¹Þ°í ÇÏÀ§ Å¬·¡½º ¹«±â´Â ¹«Á¶°Ç ÀåÂø °¡´É)
	#define		__WATER_EXT					// ¹° Ç¥Çö È®Àå (¹° ÅØ½ºÃÄÀÇ Á¾·ù ¹× ÇÁ·¹ÀÓ¼Óµµ º¯°æ Ãß°¡)
	#define		__WND_EDIT_NUMBER_MODE		// ¿¡µðÆ® ÄÁÆ®·Ñ ¼ýÀÚ¸¸ ÀÔ·Â¹Þ°Ô ÇÏ´Â ¸ðµå
#define		__SHIFT_KEY_CORRECTION		// ½¬ÇÁÆ® Å° ÀÔ·Â ¹®Á¦ ¼öÁ¤
	#define		__STATIC_ALIGN				// ½ºÅÂÆ½ ÄÁÆ®·Ñ¿¡ Á¤±³ÇÑ Á¤·Ä ±â´É Ãß°¡
	#define		__ITEM_DROP_SOUND			// ¾ÆÀÌÅÛ µå·Ó ½Ã È¿°úÀ½ ½ºÅ©¸³Æ®·Î Ã³¸®
	#define		__JOB_TEXT					// ¸¶½ºÅÍ, È÷¾î·Î °ü·Ã ¾ÆÀÌÅÛ¿¡ 'ÇÊ¿ä Á÷¾÷' ÅØ½ºÆ® Ãâ·ÂµÇµµ·Ï ¼öÁ¤
	#define		__RESTATE_CONFIRM			// ¸®½ºÅ×Æ® »ç¿ë ½Ã, È®ÀÎ Ã¢ Ãâ·Â
	#define		__PREVENTION_TOOLTIP_BUG	// ÇÁ¸®º¥¼Ç ÅøÆÁ¿¡ ÀÇ¹Ì ¾ø´Â ÅØ½ºÆ® Ãâ·ÂµÇ´Â ¹®Á¦ ¼öÁ¤
	#define		__DROP_CONFIRM_BUG			// ¾ÆÀÌÅÛ °ü·Ã È®ÀÎ Ã¢ÀÌ ¿­¸° »óÅÂ¿¡¼­ ÀÏ¾î³ª´Â °¢Á¾ ¿À·ù ¼öÁ¤
	#define		__CLOUD_ANIMATION_BUG		// ±¸¸§ ¾Ö´Ï¸ÞÀÌ¼ÇÀÌ Æ¯Á¤ ¿µ¿ª¿¡¼­¸¸ ¼öÇàµÇ´Â ¹®Á¦ ¼öÁ¤
	#define		__BUFF_CRASH				// ¹öÇÁ ·»´õ¸µ °ü·ÃÇÏ¿© Å¬¶óÀÌ¾ðÆ® Å©·¡½¬µÇ´Â ¹®Á¦ ¼öÁ¤
	#define		__BS_FIX_SHADOW_ONOBJECT	// ¿ÀºêÁ§Æ® ±×¸²ÀÚ ¸®½Ã¹ö Á¶°Ç°Ë»ç ¼³Á¤ ( ÁÖÀÎ°ø À§ÁÖ, ÀÎ´ø ÃµÁ¤ ±×¸²ÀÚ Á¦°Å )
	#define		__BS_FIX_HAIR_AMBIENT		// Ä³¸¯ÅÍ Çì¾î ambient Á¶Á¤ ( ÀÎ´ø¿¡¼­ ¸Ó¸®Ä«¶ô »ö±ò ±î¸Ä°Ô ³ª¿À´Â ¹®Á¦ ¼öÁ¤ )
	#define		__BALLOON_CODE_IMPROVEMENT	// Ç³¼± °ü·Ã ÄÚµå °³¼±
	#define		__WING_ITEM					// ³¯°³ ¾ÆÀÌÅÛ
	#define		__USE_SOUND_LIB_FMOD		// use FMod sound lib
	#define		__PCBANG					// PC¹æ ÇýÅÃ
//	end 14th

// 15Â÷ ZU TEST ZWECKEN AUSDEKLARIERUNG ENTFERNT!
	#define		__DYNAMIC_MPU				// º¯°æ°¡´ÉÇÑ MPU !!
	#define		__BOUND_BOX_COLLISION		// ¹Ù¿îµå ¹Ú½º Ãæµ¹ ·çÆ¾ °³¼±
	#define		__BS_CHANGING_ENVIR			// ´ë·úº° È¯°æ º¯°æ ( light, fog, sky, weather, 24hours light ... ) <<< ONLY CLIENT!!!! >>>
	#define		__USING_CONTINENT_DATA		// ´ë·ú °æ°èµ¥ÀÌÅÍ ¿ÜºÎ¿¡¼­ ±Ü¾î¿È! 
	#define		__IMPROVE_QUEST_INTERFACE	// 15Â÷ Çâ»óµÈ Äù½ºÆ® ÀÎÅÍÆäÀÌ½º ½Ã½ºÅÛ
	#define		__IMPROVE_SYSTEM_VER15		// 15Â÷ °³¼± »çÇ×
	#define		__15TH_INSTANCE_DUNGEON		// 15Â÷ ÀÎ½ºÅÏ½º ´øÀü
	#define		__PETVIS					// 15Â÷ ºñ½ºÆê
	#define		__GUILD_HOUSE				// 15Â÷ ±æµåÇÏ¿ì½º
	#define		__TELEPORTER				// 15Â÷ ÅÚ·¹Æ÷ÅÍ
	#define		__FIND_OBJ_INSIGHT			// ½Ã¾ß°Å¸® ¾ÈÀÇ µ¿Àû¿ÀºêÁ§Æ® Ãâ·Â( ¹Ì´Ï¸Ê ¿À¸¥ÂÊ¹öÆ° Å¬¸¯ )
	#define		__HERO129_VER15				// 15Â÷ È÷¾î·Î ·¹º§È®Àå
	#define		__MUSIC2					// ¸¶ÀÏÁî 7.2g ver ¾÷µ¥ÀÌÆ® ( OGG Àç»ý °¡´É ¹öÁ¯  ) Â÷ÈÄ Lib¾÷µ¥ÀÌÆ®½Ã¿¡ °°ÀÌ Ç®¾îÁà¾ßÇÔ.
#define		__NEW_CONTINENT15			// Ãß°¡ ´ë·ú ( Çù°î )
	#define		__BS_BBOX_ABS_EXTENT		// BBOX ±æÀÌ Àý´ë°ªÀ¸·Î ¼öÁ¤
	#define		__CAMPUS					// 15Â÷ »çÁ¦ ½Ã½ºÅÛ
	#define		__BS_FIXED_KNOCKBACK		// ³Ë¹é½Ã »óÅÂ ²¿ÀÓÇö»ó ¼öÁ¤ 
	#define		__BS_FIXED_EQUIPMOTION		// ¾ÆÀÌÅÛ Àå/Å» ÂøÁß ±âÁ¸¸ð¼ÇÀÌ À¯ÁöµÇ´ÂÇö»ó ¼öÁ¤ 
	#define		__15_5TH_ELEMENTAL_SMELT_SAFETY	// 15.5Â÷ ¼Ó¼º ¾ÈÀü Á¦·Ã Ãß°¡
	#define		__2ND_PASSWORD_SYSTEM		// 2Â÷ ºñ¹Ð¹øÈ£ ½Ã½ºÅÛ
 // end 15th

	#define		__QUIZ						// ÄûÁî ÀÌº¥Æ® ½Ã½ºÅÛ

	#define		__EVENTLUA_RAIN				// Àå¸¶ ÀÌº¥Æ® -> ·ç¾Æ·Î º¯°æ

	#define		__EVENTLUA_SNOW				// °­¼³ ÀÌº¥Æ®

	#define		__ADD_RESTATE_LOW			// »ó¿ëÈ­ ¾ÆÀÌÅÛ »ý¼º( ¸®½ºÅ×Æ® ÇÏ±Þ Èû, ¹ÎÃ¸, Ã¼·Â, Áö´É )

	#define		__YS_CHATTING_BLOCKING_SYSTEM	// Ä³¸¯ÅÍ Ã¤ÆÃ Â÷´Ü ½Ã½ºÅÛ
	#define		__BAN_CHATTING_SYSTEM			// ¿¬¼Ó Ã¤ÆÃ ±ÝÁö ½Ã½ºÅÛ


	#define __ENCRYPT_PASSWORD	//	mulcom	BEGIN100218	ÆÐ½º¿öµå ¾ÏÈ£È­

//	#define		__CERTIFIER_COLLECTING_SYSTEM	// ÀÎÁõ ¼­¹ö ¼öÁý ½Ã½ºÅÛ

	#define		__DELETE_CHAR_CHANGE_KEY_VALUE	// ¹öµð¹öµð i_PIN µµÀÔÀ¸·Î ÀÎÇÑ Ä³¸¯ÅÍ»èÁ¦ Å°°ª º¯°æ(±¹³», ÁÖ¹Î¹øÈ£ -> 2Â÷ºñ¹ø)
	#define		__BS_ADJUST_SYNC			// mover°£ µ¿±âÈ­ °³¼± 

	#define		__SHOP_COST_RATE			// »óÁ¡ °¡°Ý Á¶Á¤

//	#define		__NEW_WEB_BOX				// »õ·Î¿î À¥ Ç¥Çö Ã¢
	#define		__PROTECT_AWAKE				//°¢¼ºº¸È£
	#define		__MAIL_REQUESTING_BOX		// ¸ÞÀÏ ¿äÃ» ¹Ú½º
	#define     __BS_SAFE_WORLD_DELETE		// CWorld::Process¿¡¼­ safe delete obj( sfx ·ù·Î È®ÀÎ´ï )
//	#define		__GAME_GRADE_SYSTEM			// °ÔÀÓ¹° µî±Þ Ç¥½Ã ½Ã½ºÅÛ
	#define		__BS_FIX_ARRIVEPOS_ALGO		// ¸¶¿ì½º ÀÌµ¿½Ã µµÂø °Ë»ç·çÆ¾ °³¼± ( Á¤“‡Çâ ÃàÀ¸·Î ÇÑ°÷¸¸ µµÂøÇßÀ»¶§ ¸ØÃß´Â ¹®Á¦°¡ÀÖ¾úÀ½ )
	#define		__BS_ITEM_UNLIMITEDTIME		// ¾ÆÀÌÅÛ À¯Áö½Ã°£ ( 999999999 >= ÀÏ°æ¿ì ¹«Á¦ÇÑ Ç¥±â )
	
	#define		__ENVIRONMENT_EFFECT

// 8.5Â÷
#if	  defined(__INTERNALSERVER)	// ³»ºÎ »ç¹«½Ç Å×½ºÆ®¼­¹ö 
//	#define	__RULE_0615

	
	#undef		__TRANSFER_ERROR_TEXT

	#define		__CPU_UTILDOWN_060502		// CPU »ç¿ë·ü °¨¼ÒÀÛ¾÷ 
	#define		__SLIDE_060502				// ¶¥À¸·Î ²¨Áö´Â ¹®Á¦ ¼öÁ¤ 
	#define		__GUILDVOTE					// ±æµå ÅõÇ¥ 
	#define		__IAOBJ0622					// »ó´ë ¸ñÇ¥ ÁÂÇ¥ Àü¼Û	// ¿ùµå, ´ºÁî
	#define		__YNOTICE_UNI1026			// °øÁö»çÇ× À¯´ÏÄÚµå Áö¿ø
//	#define		__YENV
//	#define		__YENV_WITHOUT_BUMP
	#define		__SKILL0517					// ½ºÅ³ ·¹º§ ÆÄ¶ó¹ÌÅÍ
	#define		__YAIMONSTER_EX				// AI±â´É Ãß°¡ - Neuz, World
//	#define		__Y_INTERFACE_VER3			// ÀÎÅÍÆäÀÌ½º ¹öÀü 3.0 - Neuz
	#define		__VERIFY_MEMPOOL
//	#define		__S_NEW_SKILL_2				// ½ºÅ³ °³¼± ÆÐÅ¶ Àü¼Û Neuz, World, Trans
	#define		__Y_ROTXZ					// È¸Àü Ãß°¡ Neuz, World
	#define		__Y_PATROL					// Á¤Âû...Neuz. World
	#define		__Y_CHARACTER_TEXT			// Ä³¸¯ÅÍ Á¤º¸Ã¢ ÇÁ·Î±×·¥ ÅØ½ºÆ® Ãâ·Â..Neuz
	#define		__Y_RENDER_NAME_OPTION		// ÀÌ¸§ Ãâ·Â ¼±ÅÃ UI.Neuz
	#define		__V060721_TEXTDRAG
	#define		__Y_MAPVIEW_EX
	#define		__Y_BEAUTY_SHOP_CHARGE		// ºäÆ¼¼¥, °³ÀÎ»óÁ¡ À¯·á¾ÆÀÌÅÛÈ­..Neuz, World
//	#define		__EVENT_FALL				// ´ÜÇ³ ÀÌº¥Æ® - ¸ðµ¨±³Ã¼ Neuz, World
//	#define		__LANG_1013					// ÇØ¿Ü ¹öÀü Ãß°¡ ½ºÅ©¸³Æ®
//	#define		__KWCSC_UPDATE				// ½ºÅ³ ¹ßµ¿ °ü·Ã ¹®Á¦ ¼öÁ¤ Neuz
//	#define		__CSC_VER8_1				// 8Â÷ 'T'Å° »ç¿ë, »ó´ë¹æ ·¹º§ ¾Èº¸ÀÌ±â, È­¸é ¸ðµç Ã¢ On/Off Neuz
//	#define		__CSC_VER8_2				// 8Â÷ ÆÄÆ¼Ã¢ °ü·Ã Àû¿ë Neuz
//	#define		__JEFF_VER_8				// 8Â÷ ÀÛ¾÷
//	#define		__Y_FLAG_SKILL_BUFF			// ÆÖ, º¯½Å ¾ÆÀÌÅÛ Åä±Û¹öÇÁ Àû¿ë... Neuz, World
//	#define		__Y_GAMMA_CONTROL_8			// ¹à±â, °¨¸¶, ¸í¾Ï Á¶Àý Neuz
//	#define		__Y_CHAT_SYSTEM_8			// ½Ã½ºÅÛ ¸Þ¼¼Áö À©µµ¿ìÈ­... Neuz
//	#define		__Y_EYE_FLASH_8				// ´«±ô¹Ú°Å¸®±â... Neuz
//	#define		__Y_CAMERA_SLOW_8			// 8Â÷ Å°/¸¶¿ì½º XÃà È¸Àü½Ã º¸°£À¸·Î È¸ÀüÇÏ±â..Neuz
//	#define		__Y_MAX_LEVEL_8				// ¸¸·¦ 120À¸·Î Á¶Á¤... Neuz, World, Trans
//	#define		__CSC_VER8_3				// 8Â÷ ¹öÇÁÃ¢ °ü·Ã Àû¿ë, Key Down½Ã ½ºÅ³¹ßµ¿ 1.5ÃÊ°£ µô·¹ÀÌ·Î Áö¼ÓµÇ°Ô º¯°æ Neuz
//	#define		__CSC_VER8_4				// 8Â÷ Çì¾î¼¥°ü·Ã ¼öÁ¤ ¹× ¼ºÇü¼ö¼ú ±â´É Ãß°¡.
//	#define		__JHMA_VER_8_1				// 8Â÷ °ÔÀÓ³»µ·µå·Ó±ÝÁö	Neuz, World
//	#define		__JHMA_VER_8_2				// 8Â÷ °ÔÀÓ³»¾ÆÀÌÅÛÆÇ¸Å°¡°ÝÁ¦ÇÑÇ®±â	Neuz, World
	#define		__FIX_WND_1109				// ÀÚ½Ä Ã¢ ÃÊ±âÈ­ ¿À·ù ¼öÁ¤
//	#define		__JHMA_VER_8_3				// 8Â÷ ctrl ÀÚµ¿°ø°Ý±â´É »èÁ¦	Neuz
//	#define		__JHMA_VER_8_4				// 8Â÷ Å¸°ÙÅ¬¸¯ÀÚµ¿°ø°Ý ÀÌ¸ðÆ¼ÄÜ	Neuz
//	#define		__JHMA_VER_8_5				// 8Â÷ ½ºÅ³°æÇèÄ¡´Ù¿îº¯°æ	Neuz, World
//	#define		__JHMA_VER_8_7				// 8Â÷ µà¾óÁ¸¿¡ °ü°è¾øÀÌ PVP°¡´ÉÇÏ°ÔÇÔ   Neuz, World


//	#define		__CSC_VER8_5				// 8Â÷ ¿£Á© ¼ÒÈ¯ Neuz, World, Trans

	#define		__TRAFIC_1218				// ¼­¹ö¿¡¼­ º¸³½ ÆÐÅ¶ Á¤º¸
	#define		__Y_HAIR_BUG_FIX
	#define		__FOR_PROLOGUE_UPDATE		// ÅÂ±¹,´ë¸¸,¹Ì±¹,µ¶ÀÏ PrologueÃß°¡
//	#define		__NEWYEARDAY_EVENT_COUPON	// ¼³ ÀÌº¥Æ® - Çì¾î˜? ¼ºÇü ¹«·áÀÌ¿ë±Ç °ü·Ã.
	#define		__TRAFIC_1215				// Àü¼Û·® °¨¼Ò

//	#define     __Y_NEW_ENCHANT				// Á¦·Ã ¾ÆÀÌÅÛ º¯°æ, Neuz, World

//	#define		__ULTIMATE					// 9,10Â÷ Á¦·Ã
//	#define		__LEGEND					// 10Â÷ Àü½Â½Ã½ºÅÛ	Neuz, World, Trans
//	#define		__CSC_VER9_1				// 9Â÷ Àü½Â°ü·Ã Clienet - Neuz

//	#define		__PET_0410					// 9, 10Â÷ Æê
	#define		__HACK_0516					// ¹Ì±¹ ÇØÅ· 2Â÷
//	#define		__AI_0509					// ¸ó½ºÅÍ ÀÎ°øÁö´É

//	#define		__CSC_VER9_RESOLUTION		// Wide¹× °íÇØ»óµµ Ãß°¡
//	#define		__Y_ADV_ENCHANT_EFFECT		// Á¦·Ã ÀÌÆÑÆ® Çâ»ó ¹öÀü
//	#define		__S_9_ADD					// 9Â÷ Ãß°¡ºÐ
//	#define		__RECOVERY10				// 9Â÷ Ãß°¡ (Å¸°Ý, ÇÇ°Ý 10ÃÊ ÈÄ ÀÚµ¿ È¸º¹)

//	#define		__CSC_VER9_2				// 9Â÷ »óÅÂÃ¢ º¯°æ °ü·Ã Neuz, World
//	#define		__CSC_VER9_3				// 9Â÷ Ã¤ÆÃ»óÈ²¿¡¼­ Function Key »ç¿ë °¡´É
//	#define		__CSC_VER9_4				// Å¬¶óÀÌ¾ðÆ® ±¸µ¿ ½Ã °ø¹é½Ã°£¿¡ ÀÌ¹ÌÁö Ãß°¡.
//	#define		__CSC_VER9_5				// 9Â÷ Á¦·Ã°ü·Ã (Ãß°¡ °Ë±¤ ±â´É)

//	#define		__Y_DRAGON_FIRE				// ¸ÞÅ×¿À´ÏÄ¿ ÆÄÀÌ¾î ¹ß»ç!!!

//	#define		__LUASCRIPT					// ·ç¾Æ ½ºÅ©¸³Æ® »ç¿ë (World, Trans, Neuz)
//	#define		__EVENTLUA					// ÀÌº¥Æ® (·ç¾Æ ½ºÅ©¸³Æ® Àû¿ë) - World, Trans, Neuz

//	#define		__METEONYKER_0608
//	#define		__CSC_UPDATE_WORLD3D		// World3D Object CullingºÎºÐ ¾÷µ¥ÀÌÆ®
//	#define		__CSC_VER9_REMOVE_PKSETTING	// ¿É¼Ç ¼³Á¤ Ã¢¿¡¼­ PK¼³Á¤ Á¦°Å (¹«Á¶°Ç CtrlÅ° ´©¸¥ »óÅÂ¿¡¼­¸¸ °ø°Ý)

	#define		__SECURITY_0628				// ¸®¼Ò½º ¹öÀü ÀÎÁõ not contained

//	#define		__INSERT_MAP				// ½ºÅ¸Æ®¸Þ´º¿¡ ÀüÃ¼Áöµµ ¸Þ´º Ãß°¡ 

	#define		__GLOBAL_COUNT_0705			// CTime::GetTimer
	
//	#define		__SKILL_0706				// ´ëÀÎ¿ë AddSkillProp ÄÃ·³ Ãß°¡ ¹× Àû¿ë

//	#define		__AI_0711					// ¸ÞÅ×¿À´ÏÄ¿ AI ¼öÁ¤

//	#define		__REMOVE_ATTRIBUTE			// ¼Ó¼ºÁ¦·Ã Á¦°Å(10Â÷·Î º¯°æ)
//	#define		__CSC_ENCHANT_EFFECT_2		// ±âÁ¸ ÀÌÆåÆ® + Çâ»óµÈ ÀÌÆåÆ®
	
//	#define		__SYS_TICKET				// ÀÔÀå±Ç
//	#define		__SYS_PLAYER_DATA			// Ä³¸¯ÅÍ Á¤º¸ ÅëÇÕ
//	#define		__HACK_1023					// ¸®¼Ò½º º¯Á¶ // ³¯°Í ¼Óµµ, ¹«±â °ø°Ý ¼Óµµ

//	#define		__RT_1025					// ¸Þ½ÅÀú

//  #define		__LINK_PORTAL				// ¿ÜºÎ Æ÷Å» ¿¬°á ½Ã ¹«ÀÎÀÚ Ã³¸®

//	#define		__VENDOR_1106				// °³ÀÎ»óÁ¡ Çã¿ë ¹®ÀÚ
//	#define		__JEFF_11

	#define		__JEFF_11_1

//	#define		__JEFF_11_4					// ¾Æ·¹³ª
//	#define		__JEFF_11_5					// ¸Þ¸ð¸® ´©¼ö

//	#define		__DST_GIFTBOX				// Âø¿ë ¾ÆÀÌÅÛ¿¡ ±âÇÁÆ® ¹Ú½º ±â´É Ãß°¡ 
	#define		__DISABLE_GAMMA_WND			// À©µµ¿ì ¸ðµå¿¡¼­ °¨¸¶ Á¶Àý ºÒ°¡ÇÏ°Ô ¼öÁ¤

	#define		__ATTACH_MODEL				// ¸ðµ¨¿¡ ´Ù¸¥ ¸ðµ¨ ºÙÀÌ±â (³¯°³...)
	#define		__NEW_PROFILE

	#define		__VTN_TIMELIMIT				// º£Æ®³² ÇÃ·¹ÀÌ ½Ã°£ Á¦ÇÑ

//	#define		__FLYFF_INITPAGE_EXT

	#define		__BS_CHECKLEAK				// ¸Þ¸ð¸® ´©¼ö Å½Áö¹× ¶óÀÎ È®ÀÎ 2009/07/14
	#define		__BS_ADJUST_COLLISION		// Ãæµ¹ ·çÆ¾ °³¼± ( 2009. 07. 28 )
//	#define		__BS_PUTNAME_QUESTARROW		// Äù½ºÆ® Å¬¸¯½Ã º¸»ó NPC È­»ìÇ¥ Ç¥ÇöÁß ÀÌ¸§ Ãß°¡			( 09_1228 Á¦°Å )

	#define		__JAPAN_AUTH				// ÀÏº» ÀÎÁõ º¯°æ(À¥ÀÎÁõ)
	#define		__IMPROVE_MAP_SYSTEM		// Çâ»óµÈ Áöµµ ½Ã½ºÅÛ

//	#define		__BS_NO_CREATION_POST		// ÀÓ½Ã : ¿ìÃ¼Åë »ý¼º ¹«½Ã


	#undef		__VER
	#define		__VER 15

	#define		__GUILD_HOUSE_MIDDLE		// ±æµåÇÏ¿ì½º ÁßÇü
	#define		__BS_ADDOBJATTR_INVISIBLE	// CObj Invisible ¿¡ °üÇÑ ¼Ó¼ºÃß°¡   --> 16Â÷ ¿¹Á¤ 
	#define		__BS_DEATH_ACTION			// die »óÅÂ·Î ÁøÀÔ½Ã ¿¬Ãâ È¿°ú ( client only )
	#define		__BS_EFFECT_LUA				// ¿ÀºêÁ§Æ® »óÅÂº° È¿°ú¿¬Ãâ ( Lua base )
	#define		__BS_ADD_CONTINENT_WEATHER	// ´ë·ú ³¯¾¾ Ãß°¡ ( ¿Â³­È­·Î ÀÎÇÑ ÅÂ¾ç³¯¾¾, ´Ù¸¥ ¾î¶²ÀÌÀ¯·Îµç º¯ÇÏÁö ¾ÊÀ½ )
	#define		__BS_CHANGEABLE_WORLD_SEACLOUD	// º¯°æ°¡´ÉÇÑ ¿ùµå ¹Ù´Ù±¸¸§ 

	
#elif defined(__TESTSERVER)  // ¿ÜºÎ À¯Àú Å×½ºÆ®¼­¹ö 

	#define		NO_GAMEGUARD

	#define		__CPU_UTILDOWN_060502		// CPU »ç¿ë·ü °¨¼ÒÀÛ¾÷ 
	#define		__SLIDE_060502				// ¶¥À¸·Î ²¨Áö´Â ¹®Á¦ ¼öÁ¤ 
	#define     __GUILDVOTE					// ±æµå ÅõÇ¥
//	#define		__SKILL0517					// ½ºÅ³ ·¹º§ ÆÄ¶ó¹ÌÅÍ
	#define		__Y_CHARACTER_TEXT			// Ä³¸¯ÅÍ Á¤º¸Ã¢ ÇÁ·Î±×·¥ ÅØ½ºÆ® Ãâ·Â..Neuz
	#define		__V060721_TEXTDRAG			// ±ÛÀÚ¿¡ È¿°úÁÖ±â
	#define		__Y_ROTXZ					// È¸Àü Ãß°¡ Neuz, World
	#define		__Y_PATROL					// Á¤Âû...Neuz. World
	#define		__Y_BEAUTY_SHOP_CHARGE		// ºäÆ¼¼¥, °³ÀÎ»óÁ¡ À¯·á¾ÆÀÌÅÛÈ­..Neuz, World
	#define		__TRAFIC_1215				// Àü¼Û·® °¨¼Ò

//	#define		__ULTIMATE					// 9,10Â÷ Á¦·Ã
//	#define		__LEGEND					// 10Â÷ Àü½Â½Ã½ºÅÛ	Neuz, World, Trans
//	#define		__CSC_VER9_1				// 9Â÷ Àü½Â°ü·Ã Clienet - Neuz

//	#define		__CSC_VER9_RESOLUTION		// Wide¹× °íÇØ»óµµ Ãß°¡
//	#define		__Y_ADV_ENCHANT_EFFECT		// Á¦·Ã ÀÌÆÑÆ® Çâ»ó ¹öÀü
//	#define		__S_9_ADD					// 9Â÷ Ãß°¡ºÐ
//	#define		__RECOVERY10				// 9Â÷ Ãß°¡ (Å¸°Ý, ÇÇ°Ý 10ÃÊ ÈÄ ÀÚµ¿ È¸º¹)

//	#define		__CSC_VER9_2				// 9Â÷ »óÅÂÃ¢ º¯°æ °ü·Ã Neuz, World
//	#define		__CSC_VER9_3				// 9Â÷ Ã¤ÆÃ»óÈ²¿¡¼­ Function Key »ç¿ë °¡´É
//	#define		__CSC_VER9_4				// Å¬¶óÀÌ¾ðÆ® ±¸µ¿ ½Ã °ø¹é½Ã°£¿¡ ÀÌ¹ÌÁö Ãß°¡.
//	#define		__CSC_VER9_5				// 9Â÷ Á¦·Ã°ü·Ã (Ãß°¡ °Ë±¤ ±â´É)

//	#define		__Y_DRAGON_FIRE				// ¸ÞÅ×¿À´ÏÄ¿ ÆÄÀÌ¾î ¹ß»ç!!!
	#define		__HACK_0516					// ¹Ì±¹ ÇØÅ· 2Â÷

//	#define		__LUASCRIPT					// ·ç¾Æ ½ºÅ©¸³Æ® »ç¿ë (World, Trans, Neuz)
//	#define		__EVENTLUA					// ÀÌº¥Æ® (·ç¾Æ ½ºÅ©¸³Æ® Àû¿ë) - World, Trans, Neuz
//	#define		__CSC_VER9_REMOVE_PKSETTING	// ¿É¼Ç ¼³Á¤ Ã¢¿¡¼­ PK¼³Á¤ Á¦°Å (¹«Á¶°Ç CtrlÅ° ´©¸¥ »óÅÂ¿¡¼­¸¸ °ø°Ý)

//	#define		__INSERT_MAP				// ½ºÅ¸Æ®¸Þ´º¿¡ ÀüÃ¼Áöµµ ¸Þ´º Ãß°¡ 

//	#define		__PET_0410					// 9, 10Â÷ Æê
//	#define		__AI_0509					// ¸ó½ºÅÍ ÀÎ°øÁö´É
//	#define		__METEONYKER_0608
//	#define		__SKILL_0706				// ´ëÀÎ¿ë AddSkillProp ÄÃ·³ Ãß°¡ ¹× Àû¿ë
//	#define		__AI_0711					// ¸ÞÅ×¿À´ÏÄ¿ AI ¼öÁ¤
	#define		__GLOBAL_COUNT_0705			// CTime::GetTimer

//	#undef		__VER
//	#define		__VER	11					// 11Â÷

	#define		__JEFF_11_1
//	#define		__JEFF_11_4					// ¾Æ·¹³ª
//	#define		__JEFF_11_5					// ¸Þ¸ð¸® ´©¼ö

//	#define		__JAPAN_SAKURA				// ¹þ²É ÀÌº¥Æ®


//   VER 16 __TESTSERVER begin
	#define		__GUILD_HOUSE_MIDDLE		// ±æµåÇÏ¿ì½º ÁßÇü
	#define		__BS_ADDOBJATTR_INVISIBLE	// CObj Invisible ¿¡ °üÇÑ ¼Ó¼ºÃß°¡   --> 16Â÷ ¿¹Á¤ 
	#define		__BS_DEATH_ACTION			// die »óÅÂ·Î ÁøÀÔ½Ã ¿¬Ãâ È¿°ú ( client only )
//	#define		__BS_EFFECT_LUA				// ¿ÀºêÁ§Æ® »óÅÂº° È¿°ú¿¬Ãâ ( Lua base )
	#define		__BS_ADD_CONTINENT_WEATHER	// ´ë·ú ³¯¾¾ Ãß°¡ ( ¿Â³­È­·Î ÀÎÇÑ ÅÂ¾ç³¯¾¾, ´Ù¸¥ ¾î¶²ÀÌÀ¯·Îµç º¯ÇÏÁö ¾ÊÀ½ )
	#define		__BS_CHANGEABLE_WORLD_SEACLOUD	// º¯°æ°¡´ÉÇÑ ¿ùµå ¹Ù´Ù±¸¸§ 
//   VER 16 __TESTSERVER end

	
#elif defined(__MAINSERVER)  // ¿ÜºÎ º»¼·
//	#define		__TMP_POCKET				// ÈÞ´ë °¡¹æ ÀÏ½ÃÀûÀ¸·Î ¸·±â
	#define		__Y_BEAUTY_SHOP_CHARGE		// ºäÆ¼¼¥, °³ÀÎ»óÁ¡ À¯·á¾ÆÀÌÅÛÈ­..Neuz, World
	#define		__TRAFIC_1215
//	#define     __Y_NEW_ENCHANT				// Á¦·Ã ¾ÆÀÌÅÛ º¯°æ, Neuz, World
//	#define		__EVENT_FALL				// ´ÜÇ³
//	#define		__JAPAN_SAKURA				// ¹þ²É ÀÌº¥Æ®

	#define		__JEFF_11_1
//	#define		__RAIN_EVENT				// Àå¸¶ ÀÌº¥Æ®(ºñ¿À´Â µ¿¾È °æÇèÄ¡ 2¹è)

#endif	// end - ¼­¹öÁ¾·ùº° define 

#ifndef NO_GAMEGUARD 
	#define	__NPROTECT_VER	4	
#endif	

#endif // VERSION_COMMON_H
