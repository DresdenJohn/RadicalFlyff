#ifndef __VERSION_COMMON_H__
#define __VERSION_COMMON_H__
#define		__VER	15	// 15��
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

#define		__SERVER				// Ŭ���̾�Ʈ �����ڵ带 �������� �ʱ� ���� define

#define		__CRC
#define		__SO1014				// ���� ���� ó��( ĳ��, ����, �α��� )
#define		__PROTOCOL0910
#define		__PROTOCOL1021
#define		__VERIFYNETLIB
#define		__DOS1101
#define		__STL_0402		// stl

#if (_MSC_VER > 1200)
#define		__VS2003		// �����Ϸ�����.net
#endif

// 15��
//	#define		__2ND_PASSWORD_SYSTEM			// �α��� �� 2�� ��й�ȣ �Է�

#if	  defined(__INTERNALSERVER)	// ���� �繫�� �׽�Ʈ���� 


#elif defined(__TESTSERVER)		// �ܺ� ���� �׽�Ʈ����


#elif defined(__MAINSERVER)		// �ܺ� ����

#endif	// end - ���������� define 


#endif

