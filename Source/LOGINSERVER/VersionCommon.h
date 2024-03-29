#ifndef __VERSION_COMMON_H__
#define __VERSION_COMMON_H__
#define		__VER	15	// 15차
#define __MAINSERVER
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

#define __NEW_CS_SHOP

/**************************************************************************/
////////////////////////////////////////////////////////////////////////////
/**************************************************************************/

#define     __CASTBREAKFIX
#define		__NO_SPEEDHACK

#define		__SERVER				// 클라이언트 전용코드를 빌드하지 않기 위한 define

#define		__CRC
#define		__SO1014				// 소켓 예외 처리( 캐쉬, 인증, 로그인 )
#define		__PROTOCOL0910
#define		__PROTOCOL1021
#define		__VERIFYNETLIB
#define		__DOS1101
#define		__STL_0402		// stl

#if (_MSC_VER > 1200)
#define		__VS2003		// 컴파일러변경.net
#endif

// 15차
//	#define		__2ND_PASSWORD_SYSTEM			// 로그인 시 2차 비밀번호 입력

#if	  defined(__INTERNALSERVER)	// 내부 사무실 테스트서버 


#elif defined(__TESTSERVER)		// 외부 유저 테스트서버


#elif defined(__MAINSERVER)		// 외부 본섭

#endif	// end - 서버종류별 define 


#endif

