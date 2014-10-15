#include "stdafx.h"

#include "AppDefine.h"
#include "Material.h" 
#include "DialogMsg.h"
#include "party.h"
#include "../_Common/ModelObject.h" 
#include "../_Common/HwOption.h"
#include "../_UnhandledException/ExceptionHandler.h"
#include "../_Common/ParticleMng.h"
#include "TailEffectMng.h"
#include "Sfx.h"
#include "definetext.h"
#include "DPClient.h"
#include "DPLoginClient.h"
#include "dpcertified.h"
#include "guild.h"
#include "guildwar.h"
#include "resource.h"
#include "Chatting.h"
#include "webbox.h"
#include "network.h"
#include "NPGameLib4.h"
#include "defineSound.h"
#include "ClientMsg.h"

#ifdef __LOADER_SPLASH
#include "loadersplash.h"
SPLASHLOAD NeuzLoad;
#endif

#if __VER >= 12 // __MOD_TUTORIAL
#include "WndBase.h"
#include "WndGuideSystem.h"
#endif

#include "WorldMap.h"

#include "tools.h"

#if __VER >= 15 // __GUILD_HOUSE
#include "GuildHouse.h"
#endif

#ifdef __CERTIFIER_COLLECTING_SYSTEM
#include "DPCollectClient.h"
#endif // __CERTIFIER_COLLECTING_SYSTEM

//////////////////////////////////////////////////////////////////////////////
// functions declare
//////////////////////////////////////////////////////////////////////////////
extern void PreInitNProtect();
extern CNPGameLib* GetNProtect();
void __cdecl LoadProperty( void*  );
//////////////////////////////////////////////////////////////////////////////
// global variable
//////////////////////////////////////////////////////////////////////////////

extern	CGuildWarMng	g_GuildWarMng;
extern	CGuildMng		g_GuildMng;
extern	CDPClient		g_DPlay;	 
extern	CDPLoginClient	g_dpLoginClient;
extern	CDPCertified	g_dpCertified;
extern CSfxTexture      g_SfxTex;
extern CSfxMng          g_SfxMng;
extern CSfxObjMng       g_SfxObjMng;
extern CSfxMeshMng      g_SfxMeshMng;
extern HANDLE			g_hMutex;

CDamageNumMng			g_DamageNumMng;
CModelObject			g_Shadow;

//////////////////////////////////////////////////////////////////////////////
// global enum
//////////////////////////////////////////////////////////////////////////////

enum 
{
	NOTIFY_STATUS_NONE,
	NOTIFY_STATUS_45MIN,
	NOTIFY_STATUS_50MIN,
	NOTIFY_STATUS_55MIN,
	NOTIFY_STATUS_56MIN,
	NOTIFY_STATUS_57MIN,
	NOTIFY_STATUS_58MIN,
	NOTIFY_STATUS_59MIN,
};

#ifdef __GAME_GRADE_SYSTEM
#ifdef __CLIENT
const FLOAT CNeuzApp::GAME_GRADE_MARK_FADING_SPEED( 800.0F );
#endif // __CLIENT
#endif // __GAME_GRADE_SYSTEM

//////////////////////////////////////////////////////////////////////////////
// global function
//////////////////////////////////////////////////////////////////////////////
void SetMouseCursor( DWORD dwCursor )
{
	g_Neuz.SetDeviceCursor( g_Neuz.m_ahCursor[ dwCursor ] );
}

//////////////////////////////////////////////////////////////////////////////
// CNeuzApp 
//////////////////////////////////////////////////////////////////////////////
CNeuzApp::CNeuzApp()
{

#ifdef __FIX_CHEAT
//Resources
DeleteFile( "propItem.txt");
DeleteFile( "propMover.txt");
DeleteFile( "propSkill.txt");
DeleteFile( "Spec_Item.txt");
DeleteFile( "character.inc");
DeleteFile( "propItemEtc.txt.txt");
DeleteFile( "propItem.txt.txt");
DeleteFile( "propItemEtc.inc");
DeleteFile( "propMoverEx.inc");
DeleteFile( "propSkillAdd.csv");
DeleteFile( "accessory.inc");
DeleteFile( "randomoption.inc");
DeleteFile( "randomeventmonster.inc");
//Fichier.dll
DeleteFile( "IntraVneuz.dll");
DeleteFile( "Infiltration.dll");
DeleteFile( "AntTweakBar.dll");
DeleteFile( "speedhack-i386.dll");
DeleteFile( "speedhack-x86_64.dll");
DeleteFile( "FlyffBot.dll");
DeleteFile( "akya.dll");
DeleteFile( "IntraVneuz.dll");
DeleteFile( "ggByPass.dll");
DeleteFile( "FlyffPixelBot.resources.dll");
//Fichier.exe
DeleteFile( "ftool09asource.exe");
DeleteFile( "FlyffBot.exe");
DeleteFile( "Bot.exe");
DeleteFile( "Itak-Guard-Bypass.exe");
DeleteFile( "speedy Awakes (32Bits).exe");
DeleteFile( "speedy Awakes (64Bits).exe");
DeleteFile( "BuffPangH.exe");
DeleteFile( "PerX.exe");
DeleteFile( "FlyffPixelBot.exe");
DeleteFile( "FlyFF Transformation v1.2.0.0.exe");
DeleteFile( "FlyFF Transformation.exe");
DeleteFile( "Flyff Packet Editor 4.1.5 Cracked.exe");
DeleteFile( "TSearch.exe");
#endif //__FIX_CHEAT

	m_dwTimeOutDis = 0xffffffff;
	m_dwTimeReSkillPoint = 0xffffffff;

#ifdef _DEBUG
	m_bStartFullscreen = FALSE;
#else
 	m_bStartFullscreen = TRUE;
#endif
	
    m_d3dEnumeration.AppUsesDepthBuffer = TRUE;
    m_d3dEnumeration.AppMinDepthBits = 16;
    m_d3dEnumeration.AppUsesMixedVP = TRUE;

#ifdef __XUZHU
	g_GameTimer.m_bFixed = TRUE;
	g_GameTimer.m_nHour = 12;		// ������ ���� �ǵ���
#endif
#ifdef __TWN_LOGIN0816
	m_szSessionPwd[0]	= '\0';
#endif	// __TWN_LOGIN0816

	m_dwCreationWidth  = FULLSCREEN_WIDTH;
	m_dwCreationHeight = FULLSCREEN_HEIGHT - GetSystemMetrics( SM_CYMENU );
#ifdef __RANDOM_TITLE
srand( time(NULL) );
int Random = rand() % 10;

switch( Random )
{
case 0: m_strWindowTitle = _T( "Radical Flyff - Goes best with milk!" ) ; break;
case 1: m_strWindowTitle = _T( "Radical Flyff - Check the forums daily!" ); break;
case 2: m_strWindowTitle = _T( "Radical Flyff - I'm just a window title!" ); break;
case 3: m_strWindowTitle = _T( "Radical Flyff - Nyan!" ); break;
case 4: m_strWindowTitle = _T( "Radical Flyff - Enjoy your stay!" ); break;
case 5: m_strWindowTitle = _T( "Radical Flyff - Remember never give your password out!" ); break;
case 6: m_strWindowTitle = _T( "Radical Flyff - Is this title annoying yet?" ); break;
case 7: m_strWindowTitle = _T( "Radical Flyff - Help! I'm stuck inside this window!" ); break;
case 8: m_strWindowTitle = _T( "Radical Flyff - Have a cookie!" ); break;
case 9: m_strWindowTitle = _T( "Maintained by Radical Flyff" ); break;
case 10: m_strWindowTitle = _T( "Radical Flyff - Btw, The Game." ); break;
default: Error( "CNeuzApp::CNeuzApp (%d): Create Title Error.", __LINE__ ); break;
}
#else
	m_strWindowTitle  = _T( "Radical Flyff" );
#endif
	g_pD3dApp = this;

	m_bLButtonDown = FALSE;
	m_bRButtonDown = FALSE;
	m_bFrameSkip = TRUE;
	m_dwTempMessage = 0;

	m_lpCertifierAddr[0] = '\0';
	memset( m_lpCacheAddr, 0, sizeof(TCHAR) * 16 );
	m_uCachePort = PN_CACHESRVR;
	memset( &m_loginSI, 0x00, sizeof(m_loginSI) );

	m_dwShoutLimitSecond = 0;
	m_nShoutLimitCount = 0;

	m_szAccount   [ 0 ] = 0; // ��ī��Ʈ
	m_szPassword  [ 0 ] = 0; // password
#ifdef __GPAUTH_01
	m_bGPotatoAuth	= FALSE;
	*m_szGPotatoNo	= '\0';
	#ifdef __GPAUTH_02
	*m_szCheck	= '\0';
	#endif	// __GPAUTH_02
#endif	// __GPAUTH_01
	m_szCaptureFileName[ 0 ] = 0;
	m_bCapture = FALSE;
	m_nCaptureCnt = 0;
	g_pBipedMesh = NULL;
	m_dwSys	= 0;
	m_bQuit = FALSE;

	m_uIdofMulti	= NULL_ID;
	m_b18Server     = FALSE;
	m_dwAuthKey		= 0;
	m_cbAccountFlag	= 0X00;

	m_dwTimeLeft = 0;
	m_dwCurTick	 = 0;		
	m_nLeftTimeNotifyStatus = NOTIFY_STATUS_NONE;
	
	m_bActiveNeuz = TRUE;
	
	m_dwSummonPartyData = 0;
	m_dwSummonPartyObjid = 0;
	ZeroMemory( m_szSummonPartyWorldName, sizeof( m_szSummonPartyWorldName ) );
	
#if __VER >= 12 // __ITEMCREATEMON_S0602
	m_vCursorPos = D3DXVECTOR3( 0.0f, 0.0f, 0.0f );
	m_pCreateMonItem = NULL;
#endif // __ITEMCREATEMON_S0602

	m_szWhisperName[0] = '\0';

#ifdef __THROUGHPORTAL0810
	m_bThroughPortal	= FALSE;
#else	// __THROUGHPORTAL0810
	m_bHanGame = FALSE;
#endif	// __THROUGHPORTAL0810
	m_bEncryptPWD = TRUE;
	m_idPlayer	= 0;
	m_hThread = INVALID_HANDLE_VALUE;
	memset( m_apPlayer, 0, sizeof(m_apPlayer) );
#if __VER >= 11 // __MOD_VENDOR
	memset( m_aSavedInven, 0, sizeof(m_aSavedInven) );
#endif
	for(int i = 0; i < 6; i++) m_pMasterIcon[i] = NULL;
	m_pHeroIcon = NULL;
#if __VER >= 15 // __2ND_PASSWORD_SYSTEM
	m_n2ndPasswordNumber = -1;
#endif // __2ND_PASSWORD_SYSTEM

#ifdef __GAME_GRADE_SYSTEM
#ifdef __CLIENT
	m_dwTimeGameGradeMarkRendering = 0xffffffff;
	m_bGameGradeMarkRenderingSwitch = FALSE;
	m_nGameGradeMarkAlpha = GAME_GRADE_MARK_MINIMUM_ALPHA;
	m_eGameGradeMarkState = FADE_IN;
	m_dwTimeOld = g_tmCurrent;
	m_dwTimeGameGradeMarkShowing = 0xffffffff;
#endif // __CLIENT
#endif // __GAME_GRADE_SYSTEM

	pOldModalWindow = NULL;
}

BOOL CNeuzApp::LoadOption()
{
	g_Option.Load( "neuz.ini" );
	
#ifdef _DEBUG
	g_Option.LoadToolTip( "ToolTip.ini" );
#endif // _DEBUG

	// ȭ�� ������ ���� 
	FULLSCREEN_WIDTH	= g_Option.m_nResWidth;
	FULLSCREEN_HEIGHT	= g_Option.m_nResHeight;

	SetLODDetail( g_Option.m_nViewArea );
	
	m_dwCreationWidth  = FULLSCREEN_WIDTH;
	m_dwCreationHeight = FULLSCREEN_HEIGHT - GetSystemMetrics( SM_CYMENU );

	return TRUE;
}


HRESULT CNeuzApp::ConfirmDevice( D3DCAPS9* pCaps, DWORD dwBehavior,
                                          D3DFORMAT adapterFormat, D3DFORMAT backBufferFormat )
{
	// ��Ű�� �ڵ� 
    if( dwBehavior & D3DCREATE_PUREDEVICE )
        return E_FAIL; // GetTransform doesn't work on PUREDEVICE

	if( pCaps->VertexShaderVersion < D3DVS_VERSION(1,1) )	// ���ؽ����̴� 1.1�� ���� ���ϴ°�.
	{
		g_bUsableVS = FALSE;		// ���ؽ����̴� ���ȵ�.
		if( dwBehavior & D3DCREATE_HARDWARE_VERTEXPROCESSING )	// hw vp�� ������
			return E_FAIL;
	}
    // Check that the device can blend vertices with at least two matrices
    // (Software can always do up to 4 blend matrices)
	if( (dwBehavior & D3DCREATE_HARDWARE_VERTEXPROCESSING ) ||
		(dwBehavior & D3DCREATE_MIXED_VERTEXPROCESSING ) )
	{
        if( pCaps->MaxPointSize <= 1.0f )
            return E_FAIL;
		if( pCaps->MaxVertexBlendMatrices < 2 )
			return E_FAIL;
	}

    // If this is a TnL device, make sure it supports directional lights
    if( (dwBehavior & D3DCREATE_HARDWARE_VERTEXPROCESSING ) ||
        (dwBehavior & D3DCREATE_MIXED_VERTEXPROCESSING ) )
    {
        if( !(pCaps->VertexProcessingCaps & D3DVTXPCAPS_DIRECTIONALLIGHTS ) )
            return E_FAIL;
    }

	if( pCaps->RasterCaps & D3DPRASTERCAPS_FOGVERTEX )
		return S_OK;

	return S_OK;
}


//
// ����̽� ������ �� �ѹ� �����Ѵ�.
//
HRESULT CNeuzApp::OneTimeSceneInit()
{
	CNetwork::GetInstance().StartLog();

	// ���� �ʱ�ȭ
	HRESULT hr = g_SoundMng.Initialize( GetSafeHwnd(), DSSCL_PRIORITY, 2, 22050, 16 );
	InitCustomSound( FAILED(hr) ? FALSE : TRUE );

	g_SoundMng.m_nSoundVolume = (int)( (-1) * (1.0f - g_Option.m_fEffectVolume) * 5000 );

	::SetVolume( g_Option.m_fBGMVolume );

	m_ahCursor[ CUR_ATTACK  ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_ATTACK  ) );
	m_ahCursor[ CUR_BASE    ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_BASE    ) ); // IDC_BASE
	m_ahCursor[ CUR_CAMERA  ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_CAMERA  ) );
	m_ahCursor[ CUR_CONTROL ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_CONTROL ) );
	m_ahCursor[ CUR_DELAY   ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_DELAY   ) );
	m_ahCursor[ CUR_EDIT    ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_EDIT    ) );
	m_ahCursor[ CUR_GETITEM ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_GETITEM ) );
	m_ahCursor[ CUR_HELP    ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_CURSOR2 ) );
	m_ahCursor[ CUR_NO      ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_CURSOR3 ) );
	m_ahCursor[ CUR_NPC     ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_NPC     ) );
	m_ahCursor[ CUR_SELECT  ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_SELECT  ) );
	m_ahCursor[ CUR_RESIZE_HORI ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_RESIZE_HORI ) );
	m_ahCursor[ CUR_RESIZE_VERT ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_RESIZE_VERT ) );
	m_ahCursor[ CUR_RESIZE_HV1   ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_RESIZE_HV1   ) );
	m_ahCursor[ CUR_RESIZE_HV2   ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_RESIZE_HV2   ) );
	m_ahCursor[ CUR_DOOR ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_DOOR ) );
	m_ahCursor[ CUR_GATE ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_GATE ) );
	m_ahCursor[ CUR_LEVER   ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_LEVER   ) );
	m_ahCursor[ CUR_HAMMER   ] = LoadCursor( m_hInstance, MAKEINTRESOURCE( IDC_HAMMER   ) );

	CWndBase::m_hDefaultCursor = m_ahCursor[ CUR_BASE ];
	CWndEdit::m_hEditCursor = m_ahCursor[ CUR_EDIT ];

	return S_OK;
}  

void CNeuzApp::InitNProtect()
{
	CScript s1;
	if( s1.Load(MakePath( DIR_CLIENT, "GameGuard.txt.txt" ) ) )
		s1.LoadString();
	
	CScript s2;
	if( s2.Load(MakePath( DIR_CLIENT, "GameGuard.inc" ) ) )
	{
		s2.GetToken();
		while( s2.tok != FINISHED )
		{
			m_strArray.Add( s2.Token );
			s2.GetToken();
		}
	}

	PreInitNProtect();
	DWORD dwResult = GetNProtect()->Init();
	if( dwResult != NPGAMEMON_SUCCESS )
    {
		TCHAR msg[256];
		LPCSTR lpszMsg;
		
		switch (dwResult)
		{
		case NPGAMEMON_ERROR_EXIST:
			lpszMsg	= m_strArray.GetAt(0);//"���Ӱ��尡 �̹� ���� �� �Դϴ�. ����� �� �ٽ� �����غ��ñ� �ٶ��ϴ�.";
			break;
		case NPGAMEMON_ERROR_GAME_EXIST:
			lpszMsg	= m_strArray.GetAt(1);//"������ �ߺ� ����Ǿ��ų� ���Ӱ��尡 �̹� ���� �� �Դϴ�. ���� ���� �� �ٽ� �����غ��ñ� �ٶ��ϴ�.";
			break;
		case NPGAMEMON_ERROR_INIT:
			lpszMsg	= m_strArray.GetAt(2);//"���Ӱ��� �ʱ�ȭ �����Դϴ�. ����� �� �ٽ� �����غ��ų� �浹�� �� �ִ� �ٸ� ���α׷����� ������ �� ������ ���ñ� �ٶ��ϴ�.";
			break;
		case NPGAMEMON_ERROR_AUTH_GAMEGUARD:
		case NPGAMEMON_ERROR_NFOUND_GG:
		case NPGAMEMON_ERROR_AUTH_INI:
		case NPGAMEMON_ERROR_NFOUND_INI:
			lpszMsg	= m_strArray.GetAt(3);//"���Ӱ��� ������ ���ų� �����Ǿ����ϴ�. ���Ӱ��� �¾� ������ ��ġ�غ��ñ� �ٶ��ϴ�.";
			break;
		case NPGAMEMON_ERROR_CRYPTOAPI:
			lpszMsg	= m_strArray.GetAt(4);//"�������� �Ϻ� �ý��� ������ �ջ�Ǿ����ϴ�. ���ͳ� �ͽ��÷η�(IE)�� �ٽ� ��ġ�غ��ñ� �ٶ��ϴ�.";
			break;
		case NPGAMEMON_ERROR_EXECUTE:
			lpszMsg	= m_strArray.GetAt(5);//"���Ӱ��� ���࿡ �����߽��ϴ�. ���Ӱ��� �¾� ������ �ٽ� ��ġ�غ��ñ� �ٶ��ϴ�.";
			break;
		case NPGAMEMON_ERROR_ILLEGAL_PRG:
			lpszMsg	= m_strArray.GetAt(6);//"�ҹ� ���α׷��� �߰ߵǾ����ϴ�. ���ʿ��� ���α׷��� ������ �� �ٽ� �����غ��ñ� �ٶ��ϴ�.";
			break;
		case NPGMUP_ERROR_ABORT:
			lpszMsg	= m_strArray.GetAt(7);//"���Ӱ��� ������Ʈ�� ����ϼ̽��ϴ�. ������ ��� ���� ���� ��� ���ͳ� �� ��ȭ�� ���¸� �����غ��ñ� �ٶ��ϴ�.";
			break;
		case NPGMUP_ERROR_CONNECT:
		case NPGMUP_ERROR_DOWNCFG:
			lpszMsg	= m_strArray.GetAt(8);//"���Ӱ��� ������Ʈ ���� ���ӿ� �����Ͽ����ϴ�. ��� �� ��õ� �غ��ų�, ���ͳ� �� ��ȭ�� ���¸� ������ ���ñ� �ٶ��ϴ�.";
			break;
		case NPGMUP_ERROR_AUTH:
			lpszMsg	= m_strArray.GetAt(9);//"���Ӱ��� ������Ʈ�� �Ϸ����� �� �߽��ϴ�. ���̷��� �˻縦 �غ��ðų�, PC ���� ���α׷��� ����Ͻø� ������ ������ �� ������ ������ ���ñ� �ٶ��ϴ�.";
			break;
		case NPGAMEMON_ERROR_NPSCAN:
		default:
			// ������ ���� �޽��� ���, UI �ʱ�ȭ �Ķ�� MessageBox ��� ���� UI�� ����ص� ��
			//wsprintf( msg, "���Ӱ��� ���� ���� : %lu", dwResult );
			wsprintf( msg, m_strArray.GetAt(10), dwResult );
			lpszMsg = msg;
			break;
		}
		if( lpszMsg )
			::Error( "nProtect GameGuard : %s", lpszMsg );
//			MessageBox( GetSafeHwnd(), lpszMsg, "nProtect GameGuard", MB_OK );

		ExitProcess( -1 );
	}

	GetNProtect()->SetHwnd( GetSafeHwnd() );
}


///////////////////////////////////////////////////////
HRESULT CNeuzApp::RestoreDeviceObjects()
{
#ifdef __YENV
	if( m_pEffect != NULL )
		m_pEffect->OnResetDevice();

	
	if( FAILED( LoadTextureFromRes( m_pd3dDevice, MakePath( DIR_MODELTEX, "Env.dds" ), &m_pEnvTex ) ) )
	{
		Error( "Env.dds �ؽ��� ������" );
	}
#endif //__YENV
	
    if( ( m_dwCreateFlags & D3DCREATE_SOFTWARE_VERTEXPROCESSING ) || ( m_dwCreateFlags & D3DCREATE_MIXED_VERTEXPROCESSING ) ||
        m_d3dCaps.VertexShaderVersion >= D3DVS_VERSION(1,1) )
    {
		CreateSkinningVS( m_pd3dDevice, _T("skining2.vsh") );
    }
	
	if( m_d3dCaps.RasterCaps & D3DPRASTERCAPS_DEPTHBIAS )	// d3d9.0�� ���� �߰��� ����ε� �̰� �������ϴ� ī�尡 �ִ�. �׷��� �̷��� �˻��Ѵ�.
		g_ModelGlobal.m_bDepthBias = TRUE;
	if( g_Option.m_nShadow < 2 && m_d3dCaps.MaxSimultaneousTextures <= 2 )		// �ǽð��׸��ڸ� �����ϰ� �ϵ��� ������
	{
		g_Option.m_nShadow = 2;		// �ǽð� �׸��� ����� ����.
		MessageBox( GetSafeHwnd(), m_strArray.GetAt(13), m_strArray.GetAt(11), MB_OK );
		//MessageBox( GetSafeHwnd(), "�� �׷���ī�忡�� �׸��� ����� ����� �� �����ϴ�. �׸��� ����� �������� �ٲߴϴ�.", "�ȳ�", MB_OK );
	}
	int nMem = m_pd3dDevice->GetAvailableTextureMem();
	if( g_Option.m_nTextureQuality == 0 && nMem <= (1024 * 1024 * 64) )
	{
		g_Option.m_nTextureQuality = 1;		// 64�ް� ������ �ؽ��ĸ޸𸮿��� �ؽ���ǰ���� �����.
		MessageBox( GetSafeHwnd(), m_strArray.GetAt(15), m_strArray.GetAt(14), MB_OK );
		//MessageBox( GetSafeHwnd(), "��밡���� �ؽ��� �޸𸮰� �����ؼ� �ؽ��� ǰ���� ����ϴ�.", "���", MB_OK );
	}
	if( g_Option.m_nShadow < 2 )
	{
		if( nMem <= (1024 * 1024 * 64) )
		{
			g_Option.m_nShadow = 2;		// 64�ް� ������ �ؽ��ĸ޸𸮿��� �׸��ڱ���� ������� ���Ѵ�.
			MessageBox( GetSafeHwnd(), m_strArray.GetAt(16), m_strArray.GetAt(14), MB_OK );
			//MessageBox( GetSafeHwnd(), "��밡���� �ؽ��� �޸𸮰� �����ؼ� �׸��� ����� �����մϴ�.", "���", MB_OK  );
		} else
		{
//			CreateShadowMap( m_pd3dDevice, m_d3dpp.BackBufferFormat );
			BOOL bSuccess = CreateShadowMap( m_pd3dDevice, D3DFMT_R5G6B5 );
			if( bSuccess == FALSE )
			{	
				// �����ϸ� ��͸޸� �����̶� �Ǵ��ϰ� �ɼ� ������ ����.
				if( g_Option.m_nShadow < 2 )
					g_Option.m_nShadow ++;
				if( g_Option.m_nTextureQuality < 2 )
					g_Option.m_nTextureQuality ++;
			}
		}
	}

	if( g_Option.m_nBloom == 1 )
	{
		if( m_d3dCaps.PixelShaderVersion >= D3DPS_VERSION(1,1) )
			g_Glare.Create( m_pd3dDevice, D3DFMT_R5G6B5, g_Option.m_nResWidth, g_Option.m_nResHeight - 48 );
		else
			g_Option.m_nBloom = 0;
	}

	g_ParticleMng.RestoreDeviceObjects( m_pd3dDevice );
	g_TailEffectMng.RestoreDeviceObjects( m_pd3dDevice );

    // Initialize the particle system
//	HRESULT hr;

	extern LPDIRECT3DTEXTURE9 g_pReflectMap;
	if( FAILED( LoadTextureFromRes( m_pd3dDevice, MakePath( DIR_MODELTEX, "etc_reflect.tga" ), &g_pReflectMap ) ) )
	{
		Error( "etc_Reflect.tga �ؽ��� ������" );
	}

	g_ModelGlobal.RestoreDeviceObjects( m_pd3dDevice );

	m_pd3dDevice->SetRenderState( D3DRS_SHADEMODE,   D3DSHADE_GOURAUD ); 
	CWndBase::m_Theme.RestoreDeviceObjects();

	g_WndMng.RestoreDeviceObjects();
	if( m_pd3dDevice )
	{
		m_2DRender.RestoreDeviceObjects(&m_d3dsdBackBuffer);
		if( g_WorldMng.Get() )
			g_WorldMng.Get()->RestoreDeviceObjects( m_pd3dDevice );
		CWorld::StaticRestoreDeviceObjects( m_pd3dDevice );
		prj.m_modelMng.RestoreDeviceObjects(m_pd3dDevice);
		prj.m_terrainMng.RestoreDeviceObjects();
	}
	if( g_pBipedMesh )
		g_pBipedMesh->RestoreDeviceObjects();	

	g_SfxMng.RestoreDeviceObjects();
	g_SfxMeshMng.RestoreDeviceObjects();
	
	g_DamageNumMng.RestoreDeviceObjects();
	g_DialogMsg.RestoreDeviceObjects();
	
	CWorldMap* pWorldMap = CWorldMap::GetInstance();
	pWorldMap->RestoreDeviceObjects(); 

	return S_OK;
}

///////////////////////////////////////////////////
HRESULT CNeuzApp::InvalidateDeviceObjects()
{
#ifdef __YENV
	if( m_pEffect != NULL )
		m_pEffect->OnLostDevice();

	SAFE_RELEASE(m_pEnvTex);	

#endif //__YENV	

	CWorldMap* pWorldMap = CWorldMap::GetInstance();
	pWorldMap->InvalidateDeviceObjects(); 

	g_Glare.DeleteDeviceObjects();
	DeleteShadowMap( m_pd3dDevice );
	DeleteVertexShader( m_pd3dDevice );
	CWndBase::m_Theme.InvalidateDeviceObjects();
	if( g_WorldMng.Get() )
		g_WorldMng.Get()->InvalidateDeviceObjects();
	CWorld::StaticInvalidateDeviceObjects();
	g_WndMng.InvalidateDeviceObjects();
	prj.m_modelMng.InvalidateDeviceObjects();
	prj.m_terrainMng.InvalidateDeviceObjects();
	m_2DRender.InvalidateDeviceObjects();
	if( g_pBipedMesh )
		g_pBipedMesh->InvalidateDeviceObjects();

	g_SfxMng.InvalidateDeviceObjects();
	g_SfxMeshMng.InvalidateDeviceObjects();
	
	extern LPDIRECT3DTEXTURE9 g_pReflectMap;
	SAFE_RELEASE( g_pReflectMap	);

	g_ParticleMng.InvalidateDeviceObjects();
	g_TailEffectMng.InvalidateDeviceObjects();

	g_ModelGlobal.InvalidateDeviceObjects( m_pd3dDevice );

	g_DamageNumMng.InvalidateDeviceObjects();
	g_DialogMsg.InvalidateDeviceObjects();
	
	return S_OK;
}


///////////////////////////////////////////////////////
HRESULT CNeuzApp::DeleteDeviceObjects()
{
	RestoreFakeDisplayMode();
	
#ifdef __YENV
	SAFE_RELEASE(m_pEffect);
#endif //__YENV

	CWorldMap* pWorldMap = CWorldMap::GetInstance();
	pWorldMap->DeleteDeviceObjects(); 
	g_toolTip.Delete();
#if __VER >= 15 // __IMPROVE_SYSTEM_VER15
	g_toolTipSub1.Delete();
	g_toolTipSub2.Delete();
#endif // __IMPROVE_SYSTEM_VER15
	g_Glare.DeleteDeviceObjects();
	CWndBase::m_Theme.DeleteDeviceObjects();
	g_WndMng.DestroyApplet();
	g_WndMng.Free();

	if( g_WorldMng.Get() )
		g_WorldMng.Get()->DeleteDeviceObjects();

	g_WorldMng.Free();
	CWorld::StaticDeleteDeviceObjects();
	g_WndMng.DeleteDeviceObjects();
	prj.m_modelMng.DeleteDeviceObjects();
	prj.m_terrainMng.DeleteDeviceObjects();
	m_2DRender.DeleteDeviceObjects();
	g_DamageNumMng.DeleteDeviceObjects();
	g_DialogMsg.DeleteDeviceObjects();
	if( g_pBipedMesh )
		g_pBipedMesh->DeleteDeviceObjects();

	g_TextureMng.DeleteDeviceObjects();
 
	SAFE_DELETE( g_pBipedMesh );		// g_Object3DMng�� �ı��Ǳ����� �θ���
	g_Shadow.DeleteDeviceObjects();
 
	// ���⼭ �̰��� ���� �ҷ��� ������ ��������ÿ� Release���� ���� ���� �����Ҷ� 
	// g_Object3DMng�� �ı��ڰ� �ʰ� �ߵ��Ǿ� �����Ǳ� �����̴�.  �׷��� ���⼭ ���� �ı������ش�.  ����� ����.
	// Destroy�� �ٸ����� ȣ������ ����!
	 g_Object3DMng.DeleteDeviceObjects();
#ifdef __PROF
	g_Prof.Show( m_fFPS );
#endif

	g_SfxMng.DeleteDeviceObjects();
	g_SfxTex.DeleteAll();
	g_SfxObjMng.RemoveAll();
	g_SfxMeshMng.DeleteAll();

	g_Object3DMng.Destroy();	
	CWndNeuz::FreeTileTexture();

	#if __VER >= 11 //	__SYS_COLLECTING
	m_TexCltGauge[0].DeleteDeviceObjects();
	m_TexCltGauge[1].DeleteDeviceObjects();
	#endif
	m_TextureGauge[0].DeleteDeviceObjects();
	m_TextureGauge[1].DeleteDeviceObjects();
	m_TextureGauge[2].DeleteDeviceObjects();
	m_TextureGauge[3].DeleteDeviceObjects();
	m_TextureGauge[4].DeleteDeviceObjects();

	m_TextureHPGauge[0].DeleteDeviceObjects();
	m_TextureHPGauge[1].DeleteDeviceObjects();
	m_TextureHPGauge[2].DeleteDeviceObjects();

	m_TextureTurboGauge[0].DeleteDeviceObjects();
	m_TextureTurboGauge[1].DeleteDeviceObjects();
	m_TextureCastingGauge[0].DeleteDeviceObjects();
	m_TextureCastingGauge[1].DeleteDeviceObjects();	

#if __VER >= 8 // __CSC_VER8_5
	m_TextureAngelGauge[0].DeleteDeviceObjects();
	m_TextureAngelGauge[1].DeleteDeviceObjects();
#endif //__CSC_VER8_5
	m_TexturePackPVP.DeleteDeviceObjects();
	m_TexLoading.DeleteDeviceObjects();
	m_texQuestEmoticon.DeleteDeviceObjects();
	return S_OK;
}
// 
// �����ϱ� �� ��ü�� �ı��ϴ� ��
//
HRESULT CNeuzApp::FinalCleanup()
{
#ifdef _DEBUG
	WaitLoading();
#endif

	if( g_hMutex )
		::CloseHandle( g_hMutex );
	
	// �ٽ� ��Ʈ�� �ǰ�
	::SystemParametersInfo (SPI_SCREENSAVERRUNNING, FALSE, NULL, 0);		// 95, 98, Me�� API�� ����.

#if __VER >= 8 //__Y_GAMMA_CONTROL_8
	Drv_SetGamma(GetSafeHwnd(), 1.0f, 10, 1.0f);
#endif //__Y_GAMMA_CONTROL_8
	
	for( int i = 0; i < MAX_CHARACTER_LIST; i++ )
	{
		if( m_apPlayer[i] )
			m_apPlayer[i]->m_pModel = NULL; 
		SAFE_DELETE( m_apPlayer[i] );
	}
	g_dpCertified.DeleteDPObject();
#ifdef __CERTIFIER_COLLECTING_SYSTEM
	DPCollectClient->DeleteDPObject();
#endif // __CERTIFIER_COLLECTING_SYSTEM
	g_dpLoginClient.DeleteDPObject();
	g_DPlay.DeleteDPObject();
	g_GuildWarMng.Clear();
	g_GuildMng.Clear();

	SAFE_DELETE( CParty::m_pPool );
	SAFE_DELETE( CChatting::m_pPool );
	SAFE_DELETE( CGuildMember::sm_pPool );
	SAFE_DELETE( CGuild::sm_pPool );
	SAFE_DELETE( CMover::m_pPool );
	SAFE_DELETE( CActionMover::m_pPool );
	SAFE_DELETE( CItem::m_pPool );
	SAFE_DELETE( CDamageNum::m_pPool );
	SAFE_DELETE( CSfxGenMoveMark::m_pPool );
	SAFE_DELETE( CSfxGenWaterCircle::m_pPool );
	SAFE_DELETE( CSfxGenNormalDmg01::m_pPool );
	SAFE_DELETE( CSfxModel::m_pPool );
	SAFE_DELETE( CSfxGenRainCircle::m_pPool );

#if __VER >= 12 // __LORD
	// ���� ���� ��ü�� ����
	CCLord::Instance()->DestroyColleagues();
#endif	// __LORD

	UninitializeNetLib();

	CWndNeuz::FreeTileTexture();
	CResFile::FreeResource();
	UnInitCustomSound();

	g_Option.Save( "neuz.ini" );
 	return S_OK;
}

#ifdef __WRITEAVI

#include "..\_multimedia\writeAvi.h"
#pragma comment( lib, "vfw32.lib" ) 
CAVIFile avi( _T( "Capture\\test.avi" ) );

HRESULT CNeuzApp::CaptureBitmap()
{
	IDirect3DSurface8* pDestSurface;
	m_pd3dDevice->GetBackBuffer( 0, D3DBACKBUFFER_TYPE_MONO, &pDestSurface );
	RECT  rcSource[] = {  0,  0,  1024,  768 };
	POINT ptDest[]   = {  0,  0 };

	D3DLOCKED_RECT lockedRect;
	CRect rectIn ( 0, 0, m_d3dsdBackBuffer.Width, m_d3dsdBackBuffer.Height );//cb.bih.biWidth, abs(cb.bih.biHeight) );
	D3DVIEWPORT9 viewport;
	m_pd3dDevice->GetViewport( &viewport );
	//LPBYTE lpData = new BYTE[ viewport.Width * viewport.Height * 3 ];D3DLOCK_DISCARD 

	if( pDestSurface->LockRect( &lockedRect, rectIn, D3DLOCK_READONLY  ) == D3D_OK )// Lock
	{
	//	LPDWORD pWord = (LPDWORD)lockedRect.pBits;
	//	memcpy( bmp.GetData(), pWord, viewport.Width * viewport.Height * 4 );

		//
		//LPWORD pWord = (LPWORD)lockedRect.pBits;

		//for(int y = 0; y < viewport.Height; y++ )
		//{
		//	for(int x = 0; x < viewport.Width; x++)
		//	{
		///		WORD wData = pWord[ y * viewport.Width + x ]; 
		//		// 16 bit color
		//		BYTE byData1 = ( wData & 0xf800 ) >> 8;
		//		BYTE byData2 = ( wData & 0x07e0 ) >> 3;
		//		BYTE byData3 = ( wData & 0x001f ) << 3 ;
		//		DWORD dwOffset = ( y * viewport.Width + x ) * 3;
		//		lpData[ dwOffset + 0 ] = byData3;
		//		lpData[ dwOffset + 1 ] = byData2;
		//		lpData[ dwOffset + 2 ] = byData1;
		//	}
		//}
		//
		


			LPDWORD pWord = (LPDWORD)lockedRect.pBits;
			memcpy( g_bmp.GetData(), pWord, viewport.Width * viewport.Height * 4 );

		pDestSurface->UnlockRect();

	}
	pDestSurface->Release();
	avi.AddFrame( g_bmp );
	//SAFE_DELETE( lpData );
	return S_OK;
}
#endif
/*
	IDirect3DSurface8* pDestSurface;
	m_pd3dDevice->GetBackBuffer( 0, D3DBACKBUFFER_TYPE_MONO, &pDestSurface );
	D3DLOCKED_RECT lockedRect;
	CRect rectIn ( 0, 0, m_d3dsdBackBuffer.Width, m_d3dsdBackBuffer.Height );//cb.bih.biWidth, abs(cb.bih.biHeight) );

	D3DVIEWPORT9 viewport;
	m_pd3dDevice->GetViewport( &viewport );
	LPBYTE lpData = new BYTE[ viewport.Width * viewport.Height * 3 ];
	ZeroMemory( lpData, viewport.Width * viewport.Height * 3 );
	if( pDestSurface->LockRect( &lockedRect, rectIn, 0 ) == D3D_OK )// Lock
	{
		
		LPWORD pWord = (LPWORD)lockedRect.pBits;
		for(int y = 0; y < viewport.Height; y++ )
		{
			for(int x = 0; x < viewport.Width; x++)
			{
				WORD wData = pWord[ y * viewport.Width + x ]; 
				// 16 bit color
				BYTE byData1 = ( wData & 0xf800 ) >> 8;
				BYTE byData2 = ( wData & 0x07e0 ) >> 3;
				BYTE byData3 = ( wData & 0x001f ) << 3 ;
				DWORD dwOffset = ( y * viewport.Width + x ) * 3;
				lpData[ dwOffset + 0 ] = byData3;
				lpData[ dwOffset + 1 ] = byData2;
				lpData[ dwOffset + 2 ] = byData1;
			}
		}
		pDestSurface->UnlockRect();

		TCHAR szFileName[ 128 ];
		_stprintf( szFileName, _T( "Capture\\%s%06d.bmp" ), m_szCaptureFileName, m_nCaptureCnt );
//	SaveBMP( szFileName, (LPBYTE)lockedRect.pBits, CSize( viewport.Width, viewport.Height ) );
		delete lpData;
		m_nCaptureCnt++;

	}
	pDestSurface->Release();

	return S_OK;
}
*/

// 
// ȭ���� ������ �Ѵ�. (���)
//

#ifdef __FIX_CHEAT
void CheatEngine()
{
	HWND WCE7 = FindWindow(0, TEXT(CE7));
	HWND WCE69 = FindWindow(0, TEXT(CE69));
	HWND WCE68 = FindWindow(0, TEXT(CE68));
	HWND WCE67 = FindWindow(0, TEXT(CE67));
	HWND WCE66 = FindWindow(0, TEXT(CE66));
	HWND WCE65 = FindWindow(0, TEXT(CE65));
	HWND WCE64 = FindWindow(0, TEXT(CE64));
	HWND WCE63 = FindWindow(0, TEXT(CE63));
	HWND WCE62 = FindWindow(0, TEXT(CE62));
	HWND WCE61 = FindWindow(0, TEXT(CE61));
	HWND WCE6 = FindWindow(0, TEXT(CE6));
	HWND WCE561 = FindWindow(0, TEXT(CE561));
	HWND WCE56 = FindWindow(0, TEXT(CE56));
	HWND WCE55 = FindWindow(0, TEXT(CE55));
	HWND WCE54 = FindWindow(0, TEXT(CE54));
	HWND WCE53 = FindWindow(0, TEXT(CE53));
	HWND WCE52 = FindWindow(0, TEXT(CE52));
	HWND WCE51 = FindWindow(0, TEXT(CE51));
	HWND WCE4 = FindWindow(0, TEXT(CE4));

    HWND WTSearch = FindWindow(0, TEXT(TSearch1));
	HWND WSpeedG = FindWindow(0, TEXT(SpeedG));
	HWND WMSH = FindWindow(0, TEXT(MSH));
	HWND WHACK = FindWindow(0, TEXT(HACK));

if (WCE7 != NULL && IsWindow(WCE7) == TRUE)
	{
		Error(" Cheat Engine entdeckt !");
		exit( 0 );
	} 
    else if (WCE69 != NULL && IsWindow(WCE69) == TRUE)
	{
		Error(" Cheat Engine entdeckt !");
		exit( 0 );
	} 
    else if (WCE68 != NULL && IsWindow(WCE68) == TRUE)
	{
		Error(" Cheat Engine entdeckt !");
		exit( 0 );
	} 
    else if (WCE67 != NULL && IsWindow(WCE67) == TRUE)
	{
		Error(" Cheat Engine entdeckt !");
		exit( 0 );
	} 
    else if (WCE66 != NULL && IsWindow(WCE66) == TRUE)
	{
		Error(" Cheat Engine entdeckt !");
		exit( 0 );
	} 
    else if (WCE65 != NULL && IsWindow(WCE65) == TRUE)
	{
		Error(" Cheat Engine entdeckt !");
		exit( 0 );
	} 
    else if (WCE64 != NULL && IsWindow(WCE64) == TRUE)
	{
		Error(" Cheat Engine entdeckt !");
		exit( 0 );
	} 
    else if (WCE63 != NULL && IsWindow(WCE63) == TRUE)
	{
		Error(" Cheat Engine entdeckt !");
		exit( 0 );
	} 
    else if (WCE62 != NULL && IsWindow(WCE62) == TRUE)
	{
		Error(" Cheat Engine entdeckt !");
		exit( 0 );
	} 
	else if (WCE61 != NULL && IsWindow(WCE61) == TRUE)
	{
		Error(" Cheat Engine entdeckt !");
		exit( 0 );
	} 
	else if (WCE6 != NULL && IsWindow(WCE6) == TRUE)
	{
		Error(" Cheat Engine entdeckt ! ");
		exit( 0 );
	}
	else if (WCE561 != NULL && IsWindow(WCE561) == TRUE)
	{
		Error(" Cheat Engine entdeckt ! ");
		exit( 0 );
	}
	else if (WCE56 != NULL && IsWindow(WCE56) == TRUE)
	{
		Error(" Cheat Engine entdeckt ! ");
		exit( 0 );
	}
	else if (WCE55 != NULL && IsWindow(WCE55) == TRUE)
	{
		Error(" Cheat Engine entdeckt ! ");
		exit( 0 );
	}
	else if (WCE54 != NULL && IsWindow(WCE54) == TRUE)
	{
		Error(" Cheat Engine entdeckt ! ");
		exit( 0 );
	}
	else if (WCE53 != NULL && IsWindow(WCE53) == TRUE)
	{
		Error(" Cheat Engine entdeckt ! ");
		exit( 0 );
	}
	else if (WCE52 != NULL && IsWindow(WCE52) == TRUE)
	{
		Error(" Cheat Engine entdeckt ! ");
		exit( 0 );
	}
	else if (WCE51 != NULL && IsWindow(WCE51) == TRUE)
	{
		Error("Hack entdeckt");
		exit(0);
	}
	else if (WCE4 != NULL && IsWindow(WCE4) == TRUE)
	{
		Error("Hack entdeckt");
		exit(0);
	}
	else if(WSpeedG != NULL && IsWindow(WSpeedG) == TRUE)
	{
		Error("Hack entdeckt");
		AfxMessageBox("Hack entdeckt");
		exit(0);
	}
	else if(WMSH != NULL && IsWindow(WMSH) == TRUE)
	{
		Error("Hack entdeckt");
		AfxMessageBox("Hack entdeckt");
		exit(0);
	}
	else if(WHACK != NULL && IsWindow(WHACK) == TRUE)
	{
		Error("Hack entdeckt");
		AfxMessageBox("Hack entdeckt");
		exit(0);
	}
	else if(WTSearch != NULL && IsWindow(WTSearch) == TRUE)
	{
		Error("Hack entdeckt");
		AfxMessageBox("Hack entdeckt");
		exit(0);
	}
}


BOOL KillProcess(char *szProcessToKill)
{
	HANDLE hProcessSnap;
	HANDLE hProcess;
	PROCESSENTRY32 pe32;

	hProcessSnap = CreateToolhelp32Snapshot( TH32CS_SNAPPROCESS, 0 );

	if( hProcessSnap == INVALID_HANDLE_VALUE )
	{
		return( FALSE );
	}

	pe32.dwSize = sizeof( PROCESSENTRY32 );

	if( !Process32First( hProcessSnap, &pe32 ) )
	{
		CloseHandle( hProcessSnap );
		return( FALSE );
	}

	do{
		if(!strcmp(pe32.szExeFile,szProcessToKill))
		{
			exit(0);
			hProcess = OpenProcess(PROCESS_TERMINATE,0, pe32.th32ProcessID);
			TerminateProcess(hProcess,0);
			CloseHandle(hProcess);
			Error(" Cheat Engine entdeckt ");
		}
	}		while( Process32Next(hProcessSnap,&pe32) );


	CloseHandle( hProcessSnap );
	return( TRUE );
}
#endif //__FIX_CHEAT

#ifdef __VCINEMASCOPE
int m_nCinemaScopeCnt = -100;
#endif
HRESULT CNeuzApp::Render()
{
	_PROFILE("CNeuzApp::Render()");

	if(	m_bActive == FALSE )
		return S_FALSE;
	// Clear the viewport
	m_pd3dDevice->Clear(0, NULL, D3DCLEAR_ZBUFFER | D3DCLEAR_TARGET, CWndBase::m_Theme.m_d3dcBackground, 1.0f, 0 ) ;
	
	CWndWorld* pWndWorld = (CWndWorld*)g_WndMng.GetWndBase( APP_WORLD );
	
	if( pWndWorld )
		pWndWorld ->ClearFlyTarget();		// ���ට ���ݰ����� Ÿ�ٵ� ����Ʈ ������.	

	//pd3dDevice->Clear(0, NULL, D3DCLEAR_ZBUFFER | D3DCLEAR_TARGET, D3DCOLOR_ARGB( 255, 90, 146, 222 ), 1.0f, 0 ) ;
	//m_pd3dDevice->Clear(0, NULL, D3DCLEAR_ZBUFFER | D3DCLEAR_TARGET, D3DCOLOR_ARGB( 255, 255, 255, 255 ), 1.0f, 0 ) ;
	//m_pd3dDevice->Clear(0, NULL, D3DCLEAR_ZBUFFER | D3DCLEAR_TARGET, D3DCOLOR_ARGB( 255, 0, 0, 0 ), 1.0f, 0 ) ;
	// Begin the scene
	
	if( g_Option.m_nShadow < 2 )		// ����/�߰� �� ������ ���� �����.
	{
		_PROFILE("Make Shadow Map");
		CHECK1();
		void RenderShadowMap( LPDIRECT3DDEVICE9 pd3dDevice, CObj **pList, int nMax );
		if( g_pPlayer )
		{
			CWorld *pWorld = g_pPlayer->GetWorld();
			if( pWorld )
			{
#if __VER >= 13 // __HOUSING

#if __VER >= 14 // __BS_FIX_SHADOW_ONOBJECT
		if( pWorld->GetID() != WI_WORLD_MINIROOM ) // 7.28��ȹ��û : �Ͽ�¡ �׸��� ����
			RenderShadowMap( m_pd3dDevice, pWorld->m_aobjCull, pWorld->m_nObjCullSize );
#else 
		if(pWorld->GetID() != WI_WORLD_MINIROOM && pWorld->GetID() != WI_INSTANCE_OMINOUS && pWorld->GetID() != WI_INSTANCE_OMINOUS_1)
			RenderShadowMap( m_pd3dDevice, pWorld->m_aobjCull, pWorld->m_nObjCullSize );

#endif	//__VER >= 14

#endif	//__VER >= 13
			}

		}
		CHECK2( " Render ShadowMap" );
	}

	// �ǻ��� �ɼ��� ���������� ����Ÿ�ٿ� ����ȭ���� ������.
	if( g_Option.m_nBloom )
	{
		_PROFILE("Make Bloom");
		CWorld* pWorld = g_WorldMng.Get();
		if( pWorld && g_pPlayer && g_Glare.m_bActive )
		{
			pWorld->Projection( m_pd3dDevice, g_Glare.m_Src.m_nWidth, g_Glare.m_Src.m_nHeight );
			pWorld->SetCamera( &m_camera );
			g_Glare.m_Src.BeginScene();
			DWORD dwColor = CWorld::GetDiffuseColor();
			m_2DRender.m_pd3dDevice->Clear(0, NULL, D3DCLEAR_ZBUFFER | D3DCLEAR_TARGET, dwColor /*D3DCOLOR_ARGB( 255, 255, 255, 255 )*/, 1.0f, 0 ) ;
			pWorld->RenderBase( m_pd3dDevice, g_WndMng.m_Theme.m_pFontWorld );		// ������ ������Ʈ�� �̸� ������ �ص�.
			g_Glare.m_Src.EndScene();

			g_Glare.Blur( m_pd3dDevice );		// m_Src�� m_Surface[0]�� ����.		
		}
	}

	CHECK1();
	if(SUCCEEDED(m_pd3dDevice->BeginScene()))
	{
		_PROFILE("BeginScene");

		CHECK2( "Begin" );
		g_nRenderCnt ++;

		CHECK1();

		CWorldMap* pWorldMap = CWorldMap::GetInstance();
		g_WndMng.PaintRoot(&m_2DRender);		
		
#ifdef __VCINEMASCOPE
		CRect rect = g_WndMng.GetWndRect();

#if __VER >= 15 // __IMPROVE_QUEST_INTERFACE
		CWndDialog* pWndDialog = (CWndDialog*)g_WndMng.GetWndBase( APP_DIALOG_EX );
#else // __IMPROVE_QUEST_INTERFACE
		CWndDialog* pWndDialog = (CWndDialog*)g_WndMng.GetWndBase( APP_DIALOG );
#endif // __IMPROVE_QUEST_INTERFACE
//		m_nCinemaScopeCnt = 0;
		if( pWndDialog )
		{
			m_2DRender.RenderFillRect( CRect( 0, 0   + m_nCinemaScopeCnt, rect.Width(), 100  + m_nCinemaScopeCnt ), 0xff000000 );
			m_2DRender.RenderFillRect( CRect( 0, 100 + m_nCinemaScopeCnt, rect.Width(), 150 + m_nCinemaScopeCnt ), 0xff000000, 0xff000000, 0x00000000, 0x00000000 );

			m_2DRender.RenderFillRect( CRect( 0, rect.Height() - 100 - m_nCinemaScopeCnt, rect.Width(), rect.Height()      - m_nCinemaScopeCnt ), 0xff000000 );
			m_2DRender.RenderFillRect( CRect( 0, rect.Height() - 150 - m_nCinemaScopeCnt, rect.Width(), rect.Height() - 100 - m_nCinemaScopeCnt ), 0x00000000, 0x00000000, 0xff000000, 0xff000000 );

		}
#endif
		CHECK2( "Render WndMng" );
		
		if( g_WndMng.m_pWndWorld )
			g_WndMng.m_pWndWorld->RenderFocusArrow( CPoint(0,0) );

		// �巡�� ������ 
		if(	CWndBase::m_GlobalShortcut.IsEmpty() == FALSE )
		{
			GET_CLIENT_POINT( GetSafeHwnd(), point );
			if( CWndBase::m_GlobalShortcut.m_pTexture )
				CWndBase::m_GlobalShortcut.m_pTexture->Render( &m_2DRender, CPoint( point.x - 16, point.y - 16 ) );
			else
			{
				int nHeight = m_2DRender.m_pFont->GetMaxHeight() / 2;
				m_2DRender.TextOut( point.x - nHeight , point.y - nHeight, CWndBase::m_GlobalShortcut.m_szString );
			}
		}

		// ���� ����
		g_toolTip.Paint(&m_2DRender);
#if __VER >= 15 // __IMPROVE_SYSTEM_VER15
		g_toolTipSub1.Paint( &m_2DRender );
		g_toolTipSub2.Paint( &m_2DRender );
#endif // __IMPROVE_SYSTEM_VER15
		m_pd3dDevice->SetRenderState( D3DRS_ZWRITEENABLE, TRUE );
		m_2DRender.SetFont( 	CWndBase::m_Theme.m_pFontWorld );
		g_ClientMsg.Render( CPoint( m_2DRender.m_clipRect.Width() / 2 , 520 * m_2DRender.m_clipRect.Height() / 768 ), &m_2DRender );
		m_2DRender.SetFont( 	CWndBase::m_Theme.m_pFontText );
#ifdef __PROF
//		CHECK1();
//		m_2DRender.TextOut( 600, 120, g_Prof.m_szResult, D3DCOLOR_ARGB( 255, 255, 255, 255 ) );
//		CHECK2( "Prof Text" );
#endif		

		// ���̵����� �̹��� �ε����
		if( m_bTexLoad && m_bTexLoadAlpha )
		{
			m_nTexAlpha	= (int)( m_nTexAlpha - 6.0f );

			if( m_nTexAlpha < 0 )
			{
				m_nTexAlpha	   = 0;
				m_bTexLoad     = FALSE;
				m_bTexLoadAlpha  = FALSE;
				
				m_TexLoading.DeleteDeviceObjects();	
				
			}
			else
			{
#if __VER >= 9 // __CSC_VER9_RESOLUTION
				int wideOffsetX = 0;
				
				if(g_Option.m_nResWidth == 1280 && (g_Option.m_nResHeight == 720 || g_Option.m_nResHeight == 768 || g_Option.m_nResHeight == 800)) //Wide Offset
				{
					m_TexLoading.m_size = CSize(960, FULLSCREEN_HEIGHT);
					wideOffsetX = (g_Option.m_nResWidth - 960) / 2;
					m_2DRender.RenderFillRect( CRect( 0, 0, g_Option.m_nResWidth, g_Option.m_nResHeight ), 0xff000000 );
				}
				else if(g_Option.m_nResWidth == 1360 && g_Option.m_nResHeight == 768)
				{
					m_TexLoading.m_size = CSize(1024, FULLSCREEN_HEIGHT);
					wideOffsetX = (g_Option.m_nResWidth - 1024) / 2;
					m_2DRender.RenderFillRect( CRect( 0, 0, g_Option.m_nResWidth, g_Option.m_nResHeight ), 0xff000000 );
				}
				else if(g_Option.m_nResWidth == 1440 && g_Option.m_nResHeight == 900)
				{
					m_TexLoading.m_size = CSize(1200, FULLSCREEN_HEIGHT);
					wideOffsetX = (g_Option.m_nResWidth - 1200) / 2;
					m_2DRender.RenderFillRect( CRect( 0, 0, g_Option.m_nResWidth, g_Option.m_nResHeight ), 0xff000000 );
				}
				else if(g_Option.m_nResWidth == 1680 && g_Option.m_nResHeight == 1050)
				{
					m_TexLoading.m_size = CSize(1400, FULLSCREEN_HEIGHT);
					wideOffsetX = (g_Option.m_nResWidth - 1400) / 2;
					m_2DRender.RenderFillRect( CRect( 0, 0, g_Option.m_nResWidth, g_Option.m_nResHeight ), 0xff000000 );
				}
			
				else if(g_Option.m_nResWidth == 1920 && g_Option.m_nResHeight == 1080)
				{
					m_TexLoading.m_size = CSize(1600, FULLSCREEN_HEIGHT);
					wideOffsetX = (g_Option.m_nResWidth - 1600) / 2;
					m_2DRender.RenderFillRect( CRect( 0, 0, g_Option.m_nResWidth, g_Option.m_nResHeight ), 0xff000000 );
				}
			
				else
					m_TexLoading.m_size = CSize(FULLSCREEN_WIDTH, FULLSCREEN_HEIGHT);
				
				m_2DRender.RenderTexture( CPoint(0 + wideOffsetX, 0), &m_TexLoading, m_nTexAlpha );		
#else //__CSC_VER9_RESOLUTION				
				m_TexLoading.m_size = CSize(FULLSCREEN_WIDTH, FULLSCREEN_HEIGHT);
				m_2DRender.RenderTexture( CPoint(0,0), &m_TexLoading, m_nTexAlpha );
#endif //__CSC_VER9_RESOLUTION
			}			
		}

		pWorldMap->RenderWorldMap( &m_2DRender );

#ifdef __GAME_GRADE_SYSTEM
#ifdef __CLIENT
		if( ::GetLanguage() == LANG_KOR )
		{
			g_WndMng.m_pTheme->RenderGameGradeMark( &m_2DRender, static_cast< DWORD >( m_nGameGradeMarkAlpha ) );
		}
#endif // __CLIENT
#endif // __GAME_GRADE_SYSTEM
		
		CHECK1();
		m_pd3dDevice->EndScene();
		CHECK2( "End" );
	}
	
	return S_OK;
}

// �÷��� ���� �ð� ���� 
void CNeuzApp::SetLeftTime( long lTimeLeft )
{
	m_dwTimeLeft = lTimeLeft * 1000;
	m_dwCurTick = timeGetTime();
}

void CNeuzApp::NotifyLeftMinute( UINT type, int nMin )
{
	if( ::GetLanguage() == LANG_THA )
	{
		if( type == m_nLeftTimeNotifyStatus )
			return;

		m_nLeftTimeNotifyStatus = type;

		char szBuffer[256];
		sprintf( szBuffer, prj.GetText(TID_GAME_REMAINPLAYTIMEMIN), nMin );
		g_WndMng.OpenMessageBox( szBuffer );
	}
}

// �±��� ��� �÷��� ���� �ð��� ǥ���� �ش�.
void CNeuzApp::NotifyLeftTime()
{
	if( ::GetLanguage() != LANG_THA )
		return; 

	if( m_dwTimeLeft == 0 )
		return;

	DWORD dw = timeGetTime() - m_dwCurTick;
	if( dw > 1000 ) 
	{
		m_dwCurTick = timeGetTime();

		if( m_dwTimeLeft >= dw )
			m_dwTimeLeft -= dw;
		else
		{
			m_dwTimeLeft = 0;								// 0�ʴ� ǥ������ �ʴ´�.
			return;
		}

		long lLeftTime = ( m_dwTimeLeft + 500 ) / 1000;		// + 500�ݿø� 
		if( lLeftTime <= 10 )			// 10�� ���� 
		{
			char szBuffer[256];
			sprintf( szBuffer, prj.GetText(TID_GAME_REMAINPLAYTIMESEC), lLeftTime );			
			g_WndMng.PutString( szBuffer );
		}
		else if( lLeftTime <= 60 * 15 )	// 15�� ���� 
		{
			switch( lLeftTime )
			{
			case 60 * 1:
				NotifyLeftMinute( NOTIFY_STATUS_59MIN, 1 );
				break;
			case 60 * 2:
				NotifyLeftMinute( NOTIFY_STATUS_58MIN, 2 );
				break;
			case 60 * 3:
				NotifyLeftMinute( NOTIFY_STATUS_57MIN, 3 );
				break;
			case 60 * 4:
				NotifyLeftMinute( NOTIFY_STATUS_56MIN, 4 );
				break;
			case 60 * 5:
				NotifyLeftMinute( NOTIFY_STATUS_55MIN, 5 );
				break;
			case 60 * 10:
				NotifyLeftMinute( NOTIFY_STATUS_50MIN, 10 );
				break;
			case 60 * 15:
				NotifyLeftMinute( NOTIFY_STATUS_45MIN, 15 );
				break;
			}
		}
	}
}

extern int g_nOldVirtKey;

//
// Frame�� �����δ�. ������ Process�� ���� ���� 
//
HRESULT CNeuzApp::FrameMove()
{

#ifdef __VCINEMASCOPE
#if __VER >= 15 // __IMPROVE_QUEST_INTERFACE
	CWndDialog* pWndDialog = (CWndDialog*)g_WndMng.GetWndBase( APP_DIALOG_EX );
#else // __IMPROVE_QUEST_INTERFACE
	CWndDialog* pWndDialog = (CWndDialog*)g_WndMng.GetWndBase( APP_DIALOG );
#endif // __IMPROVE_QUEST_INTERFACE
	if( pWndDialog )
	{
		if( m_nCinemaScopeCnt < 0 )
			m_nCinemaScopeCnt += 2;
	}
	else
		m_nCinemaScopeCnt = -150;
#endif

	_PROFILE("CNeuzApp::FrameMove()");

	g_tmCurrent = timeGetTime();		// �������� ����� ���� �ð�.
	g_tCurrent	= time( NULL );
	g_nProcessCnt ++;
	if( g_GameTimer.m_nHour >= 21 || g_GameTimer.m_nHour <= 6 )
		::SetNight( TRUE );
	else
		::SetNight( FALSE );

	NotifyLeftTime();

	CHECK1();
	g_DPlay.ReceiveMessage();
	g_DPlay.SendSnapshot();

	g_DPlay.FlushPlayerAngle();

	g_dpLoginClient.ReceiveMessage();
	g_dpCertified.ReceiveMessage();
#ifdef __CERTIFIER_COLLECTING_SYSTEM
	DPCollectClient->ReceiveMessage();
#endif // __CERTIFIER_COLLECTING_SYSTEM
	CHECK2( "Receive" );

	if( m_dwTempMessage )
	{
		CWndBase* pWndBase;
		if( m_timerConnect.TimeOut() )
		{
			m_dwTempMessage = 0;
			pWndBase = g_WndMng.GetWndBase( APP_SELECT_CHAR );
			if( pWndBase )
			{
				((CWndSelectChar*)pWndBase)->Connected();
				goto NEXT;
			}
		}
	}

	if( g_pBipedMesh )
		g_pBipedMesh->FrameMove();

	g_WndMng.Process(); // �������� ����� ĳ���� ��Ʈ�� �������̽��� CWndWorld::Process�� ó���� 
	
	// ��ġ �ٲ��� ���ÿ�!! ata3k
	// Ű���� �������� �����ϱ� ���� Ŭ���� �����ش�....
	if( g_nOldVirtKey != 0 )
		g_bKeyTable[ g_nOldVirtKey ] = FALSE;	

NEXT:
	if( g_WndMng.IsTitle() == TRUE )
		CWndBase::m_Theme.FrameMove();
	GET_CLIENT_POINT( GetSafeHwnd(), point );
	g_toolTip.Process( point, &m_2DRender );
#if __VER >= 15 // __IMPROVE_SYSTEM_VER15
	g_toolTipSub1.Process( point, &m_2DRender );
	g_toolTipSub2.Process( point, &m_2DRender );
#endif // __IMPROVE_SYSTEM_VER15
	g_DamageNumMng.Process();
#ifdef __FLYFF_INITPAGE_EXT
	if(CWndBase::m_Theme.m_bRenderTitleWorld)
	{
		g_GameTimer.m_bFixed = TRUE;
		g_GameTimer.m_nHour = 10;
	}
	else
		g_GameTimer.Compute();
#else //__FLYFF_INITPAGE_EXT
	g_GameTimer.Compute();
#endif //__FLYFF_INITPAGE_EXT
	ProcessFadeMusic();
	CalcUPS();
	g_Object3DMng.Process();

	g_ParticleMng.Process();
	g_TailEffectMng.Process();

#ifdef __NEW_WEB_BOX
	if( g_WndMng.GetWndBase( APP_WEBBOX ) )
#else // __NEW_WEB_BOX
	if( g_WndMng.GetWndBase(APP_WEBBOX) || g_WndMng.GetWndBase(APP_WEBBOX2)  )
#endif // __NEW_WEB_BOX
	{
		if( CWebBox::GetInstance()->Get_Start() == false )
			CWebBox::GetInstance()->Set_Start();

		CWebBox::GetInstance()->Process( GetSafeHwnd(), m_hInstance
#ifdef __GPAUTH_01
			, m_bGPotatoAuth? m_szGPotatoNo: m_szAccount
#else	// __GPAUTH_01
			, m_szAccount
#endif	// __GPAUTH_01
			, CMover::GetActiveMover()? CMover::GetActiveMover()->m_idPlayer: 0
			, m_dwSys
			, CMover::GetActiveMover()? (int)CMover::GetActiveMover()->GetLevel(): 0
			, CMover::GetActiveMover()? (int)CMover::GetActiveMover()->GetJob(): 0
			, CMover::GetActiveMover()? (int)CMover::GetActiveMover()->GetSex(): 0
			, CMover::GetActiveMover()? CMover::GetActiveMover()->GetName(): ""
			);
	}
	
	CWorldMap* pWorldMap = CWorldMap::GetInstance();
	pWorldMap->Process();

#ifdef __GAME_GRADE_SYSTEM
#ifdef __CLIENT
	if( ::GetLanguage() == LANG_KOR )
	{
		CalculateGameGradeMarkAlpha();
	}
#endif // __CLIENT
#endif // __GAME_GRADE_SYSTEM
	
	if( m_bQuit )
	{
		if( g_pPlayer == NULL || m_timerQuit.IsTimeOut() )
			::PostMessage( g_Neuz.GetSafeHwnd(), WM_CLOSE, TRUE, 0 );
	}
	return S_OK;
}

BOOL CALLBACK NPGameMonCallback( DWORD dwMsg, DWORD dwArg )
{
	if( g_Neuz.m_strArray.GetSize() == 0 )
		return false;

	bool bAppExit	= false;

	TCHAR msg[128];
	LPCTSTR lpszMsg	= NULL;

	switch (dwMsg) 
	{
		case NPGAMEMON_CHECK_CSAUTH2:	// ������ ���� ��Ŷ�� ����
			{
				GG_AUTH_DATA AuthData;
				memcpy( &AuthData, (PVOID)dwArg, sizeof(GG_AUTH_DATA) );
				
				BEFORESENDSOLE( ar, PACKETTYPE_AUTHQUERY, DPID_UNKNOWN );
				ar.Write( (void*)&AuthData, sizeof(GG_AUTH_DATA) );
				SEND( ar, &g_dpLoginClient, DPID_SERVERPLAYER );

				if( g_Neuz.m_loginSI.nCount == 1 )
				{
					++g_Neuz.m_loginSI.nCount;
					g_dpLoginClient.SendGetPlayerList( g_Neuz.m_loginSI.dwID, g_Neuz.m_loginSI.pszAccount, g_Neuz.m_loginSI.pszPassword );
				}
				return true;
			}
		case NPGAMEMON_COMM_ERROR:
		case NPGAMEMON_COMM_CLOSE:
			bAppExit = true;
			return false;
		case NPGAMEMON_INIT_ERROR:		// "���Ӱ��� �ʱ�ȭ ����
			bAppExit = true;
			wsprintf( msg, g_Neuz.m_strArray.GetAt(17), dwArg );
			lpszMsg	= msg;
			break;
		case NPGAMEMON_SPEEDHACK:		// "���ǵ����� �����Ǿ����ϴ�."
			bAppExit = true;
			lpszMsg	= g_Neuz.m_strArray.GetAt(18);
			break;
		case NPGAMEMON_GAMEHACK_KILLED:	// "�������� �߰ߵǾ����ϴ�."
		case NPGAMEMON_GAMEHACK_DETECT:	// "�������� �߰ߵǾ����ϴ�."
			bAppExit = true;
			lpszMsg	= g_Neuz.m_strArray.GetAt(19);
			break;
		case NPGAMEMON_GAMEHACK_DOUBT:	//"�����̳� ���Ӱ��尡 �����Ǿ����ϴ�.";	
			bAppExit = true;
			lpszMsg = g_Neuz.m_strArray.GetAt(20);
			break;
	}

	if( lpszMsg )
		MessageBox( g_Neuz.GetSafeHwnd(), lpszMsg, "nProtect GameGuard", MB_OK );

	if( bAppExit )
	{
		ExitProcess( -1 );
		return false;
	}

    return true;
}


void CNeuzApp::HashMD5( char* szResult, LPCTSTR szPWD )
{
	char szBuffer[256];
	char* szKey = "";

#ifdef __INTERNALSERVER
	switch( LANG_KOR )
#else // __INTERNALSERVER
	switch( ::GetLanguage() )
#endif // __INTERNALSERVER
	{
	case LANG_JAP:	
		szKey = "chanho_park";
		break;
	case LANG_TWN:	
		szKey = "omg";
		break;
	case LANG_HK:
		szKey	= "tpgk";
		break;
	case LANG_ENG:
		{
			if( ::GetSubLanguage() == LANG_SUB_IND )
			{
				szKey = "dldhsdlseh";
			}
			else
			{
				szKey = "flight";	//rev1
			}
		}
		break;
	case LANG_KOR:	
		szKey = "@FLYFF";
		break;
	case LANG_GER:
		szKey	= "gjgusdbfjq";
		break;
	case LANG_SPA:
		szKey	= "rlawnsgud";
		break;
	case LANG_POR:
		//szKey	= "rlawnsgud";
		szKey	= "kikugalanet";	//chipi_090520 05/22���� ��ȣȭŰ ����
		break;
	case LANG_FRE:
		szKey	= "gjgusdbfjq";
		break;
	case LANG_VTN:
		szKey	= "dlrjsdn";
		break;
	case LANG_RUS:
		szKey	= "rlaansrms";
		break;
	}

	sprintf( szBuffer, "%s%s", szKey, szPWD );
	md5( szResult, szBuffer );
}

// ĳ���� ���� Ű�� ��´�. ( szNo�� ���� �Է� �� )
//     �Ϻ� - �н�����
//     �̱� - �н����� 
//     �׿� - �Է°� 
LPCTSTR CNeuzApp::GetDeleteKey( LPCTSTR szNo )
{
	static char szKey[512];

	if( m_bEncryptPWD )
	{
		switch( ::GetLanguage() )
		{
		case LANG_JAP:
#ifdef __THROUGHPORTAL0810
			if( m_bThroughPortal )
#else	// __THROUGHPORTAL0810
			if( m_bHanGame )
#endif	// __THROUGHPORTAL0810
				strcpy( szKey, szNo );	// �Ѱ����� �̹� ��ȣȭ �Ǿ� ���� 
			else
				HashMD5( szKey, szNo );
			break;
		case LANG_ENG:
		case LANG_GER:
		case LANG_SPA:
		case LANG_POR:
		case LANG_FRE:
		//case LANG_VTN: //��Ʈ����� �̹� ��ȣȭ �Ǿ� �ִ�.
		case LANG_RUS:
			HashMD5( szKey, szNo );
			break;
		case LANG_TWN:
		case LANG_HK:
		default:
			strcpy( szKey, szNo );
			break;
		}
	}
	else
	{
		strcpy( szKey, szNo );
	}
	return szKey;
}

#ifdef __TWN_LOGIN0816
void CNeuzApp::SetAccountInfo( LPCTSTR lpszAccount, LPCTSTR lpszpw, LPCTSTR lpszSessionPwd )
#else	// __TWN_LOGIN0816
void CNeuzApp::SetAccountInfo( LPCTSTR lpszAccount, LPCTSTR lpszpw )
#endif	// __TWN_LOGIN0816
{
	CString strAccount	= lpszAccount;
	strAccount.TrimLeft();	
	strAccount.TrimRight();		// TRIM
	_tcscpy( g_Neuz.m_szAccount, (LPCTSTR)strAccount );
	_tcslwr( g_Neuz.m_szAccount );

#ifdef __TWN_LOGIN0816
	CString strSessionPwd	= lpszSessionPwd;
	strSessionPwd.TrimLeft();	
	strSessionPwd.TrimRight();
	_tcscpy( g_Neuz.m_szSessionPwd, (LPCTSTR)strSessionPwd );
#endif	// __TWN_LOGIN0816

	if( m_bEncryptPWD )
		HashMD5( g_Neuz.m_szPassword, lpszpw );
	else
		_tcscpy( g_Neuz.m_szPassword, lpszpw );
}


int g_nOldVirtKey = 0;

// Ư��Ű���� �������� �����ϵ��� �Ѵ�...
// ������ Ű���� �������� ����
static BOOL IsPushedKey( int nVirtKey )
{
	if( nVirtKey == g_Neuz.Key.chUp || nVirtKey == g_Neuz.Key.chLeft || nVirtKey == 'S' || nVirtKey == 'D' || nVirtKey == VK_SPACE ||
//		nVirtKey == 'Q' || nVirtKey == 'E' ||
		nVirtKey == VK_LEFT || nVirtKey == VK_RIGHT || nVirtKey == VK_UP || nVirtKey == VK_DOWN || 
		nVirtKey == VK_PRIOR || nVirtKey == VK_NEXT )
		return TRUE;

	return FALSE;
}

LRESULT CNeuzApp::MsgProc( HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam )
{
#if __VER >= 15 // __GUILD_HOUSE
	BOOL bHook = GuildDeploy()->MsgProc( hWnd, msg, wParam, lParam );
	if( bHook )
		return 0;
#endif

	CWndEdit* pWndEdit = CWndEdit::GetWndEditCtrl();
	if( pWndEdit )
	{
#if __VER >= 9 // __CSC_VER9_3
		if( !( ( msg == WM_KEYDOWN || msg == WM_KEYUP ) && (wParam == VK_ESCAPE || wParam == VK_F1 || wParam == VK_F2 || wParam == VK_F3 ||
			wParam == VK_F4 || wParam == VK_F5 || wParam == VK_F6 || wParam == VK_F7 || wParam == VK_F8 || wParam == VK_F9) ) )
#else //__CSC_VER9_3
		if( !( ( msg == WM_KEYDOWN || msg == WM_KEYUP ) && wParam == VK_ESCAPE ) )
#endif //__CSC_VER9_3
		{
			if( pWndEdit->IsYouMessage( msg, wParam, lParam ) )	
				return 0;
			if( ( msg == WM_KEYDOWN || msg == WM_KEYUP ) && wParam != VK_RETURN )
				return 0;
		}
	}
	else
	{
		if( msg >= WM_IME_SETCONTEXT && msg <= WM_IME_KEYUP ) // ��� IME �Ž����� ��ŵ 
			return 0;

		if( CWndEdit::m_hIMCBackup == NULL )
		{
			CWndEdit::m_hIMCBackup = ::ImmAssociateContext( CWndEdit::m_hWnd, NULL );
		}
		CWndEdit::SetAlphaNumeric();
	}

	CWorldMap* pWorldMap = CWorldMap::GetInstance();
	if( WM_LBUTTONDOWN == msg && pWorldMap && pWorldMap->IsRender( ) )	
		pWorldMap->OnLButtonDown( );
	else
		g_WndMng.WindowRootProc( msg, wParam, lParam );

	//gmpbigsun(100308): here is stop if activated modal window
	if( g_WndMng.IsOpenModalWnd() == TRUE && msg != WM_LOGOUT )
	{
		switch( msg )
		{
		case WM_KEYDOWN:
			{
				if( g_WndMng.m_pLogOutWaitting )
					break;

				if( KillWindow( wParam ) )
					break;

				CWndChat* pWndChat = ( CWndChat* )g_WndMng.GetApplet( APP_COMMUNICATION_CHAT );
				int nVirtKey = ( int )wParam;
				if( pWndChat )
				{
					switch( nVirtKey )
					{
					case VK_RETURN:
						if( pWndEdit == NULL )
						{
							pWndChat->AddWndStyle( WBS_MODAL );
							pOldModalWindow = g_WndMng.m_pWndFocus;

							pWndChat->SetFocus();
							CWndEditChat* pWndEdit = &pWndChat->m_wndEdit;
							pWndEdit->SetFocus();

							break;
						}
					}
				}

				break;
			}
#ifdef __IMPROVE_MAP_SYSTEM
#ifdef __CLIENT
		case WM_CLOSE:
			{
				prj.m_MapInformationManager.DeleteAllMapInformation();
				g_Neuz.m_bQuit = TRUE;
				if( wParam == FALSE )
				{
					if( g_pPlayer )
					{
						g_WndMng.m_bConnect = FALSE;
						StopMusic();
						return 1;
					}
				}
				break;
			}
#endif // __CLIENT
#endif // __IMPROVE_MAP_SYSTEM
		}
		return CD3DApplication::MsgProc( hWnd, msg, wParam, lParam );
	}

	switch( msg )
	{
	case WM_KEYDOWN:
		{
		#if __VER >= 12 // __MOD_TUTORIAL
			CWndGuideSystem* pWndGuide = NULL;
			pWndGuide = (CWndGuideSystem*)g_WndMng.GetWndBase( APP_GUIDE );
			if(pWndGuide && pWndGuide->IsVisible()) pWndGuide->m_Condition.nInputKey = (UINT)wParam;
		#endif
			if( g_WndMng.m_pLogOutWaitting ) // �������̸� Ű���� �Է� �Ұ�
				break;
			
			if( KillWindow( wParam ) )
				break;

			CWndChat* pWndChat = (CWndChat*) g_WndMng.GetApplet( APP_COMMUNICATION_CHAT );
			int nVirtKey = (int) wParam;    // virtual-key code
			int lKeyData = lParam;
			if( pWndChat ) 
			{
				switch(nVirtKey)
				{
				case VK_RETURN:
					if( pWndChat && pWndEdit == NULL )
					{
						pWndChat->SetFocus();
						CWndEditChat* pWndEdit = &pWndChat->m_wndEdit;
						pWndEdit->SetFocus();
					}
					break;
				}
			}
#if __VER >= 13 // __HOUSING
			if(nVirtKey == VK_ESCAPE)
			{
				if(CDeployManager::GetInstance()->IsReady())
				{
					CDeployManager::GetInstance()->EndDeploy();
					return FALSE;
				}

#if __VER >= 15 // __GUILD_HOUSE
				GuildHouse->m_dwSelectedObjID = NULL_ID;		//�ֿ켱�����̹Ƿ� �� NULL_ID�� ..
#endif
			}
#endif // __HOUSING
			CWndWorld* pWndWorld = (CWndWorld*)g_WndMng.GetApplet( APP_WORLD );
			if( pWndWorld && pWndWorld->IsFocusWnd() == FALSE )
				pWndWorld->OnKeyDown( nVirtKey, 0, 0 );
			
			g_bKeyTable[ nVirtKey ] = TRUE;
			g_WndMng.SetMessengerAutoState();

#ifdef __BS_CONSOLE
			if( nVirtKey == VK_OEM_3 )
			{
				gConsole()->Show( );			
			}
#endif 

		}
		break;
	case WM_KEYUP:
		{
			int nVirtKey = (int) wParam;    // virtual-key code
			int lKeyData = lParam;
			for( int i = 0; i < MAX_SLOT_ITEM; ++i )
			{
				if( g_bSlotSwitchAboutEquipItem[ i ] == TRUE )
					g_bSlotSwitchAboutEquipItem[ i ] = FALSE;
			}
			CWndWorld* pWndWorld = (CWndWorld*)g_WndMng.GetApplet( APP_WORLD );
			if( pWndWorld && pWndWorld->IsFocusWnd() == FALSE )
				pWndWorld->OnKeyUp( nVirtKey, 0, 0 );
#if __VER >= 13 // __HOUSING
			if(g_bKeyTable[VK_NEXT])
			{
				if(CDeployManager::GetInstance()->IsReady())
				{
					CDeployManager::GetInstance()->m_fAngle += 45.0f;
					if(CDeployManager::GetInstance()->m_fAngle > 359.0f) CDeployManager::GetInstance()->m_fAngle = 0.0f;
					CDeployManager::GetInstance()->m_pTargetObj->SetAngle(CDeployManager::GetInstance()->m_fAngle);
					CDeployManager::GetInstance()->m_pTargetObj->UpdateLocalMatrix();
				}
			}
			else if(g_bKeyTable[VK_PRIOR])
			{
				if(CDeployManager::GetInstance()->IsReady())
				{
					CDeployManager::GetInstance()->m_fAngle -= 45.0f;
					if(CDeployManager::GetInstance()->m_fAngle < -359.0f) CDeployManager::GetInstance()->m_fAngle = 0.0f;
					CDeployManager::GetInstance()->m_pTargetObj->SetAngle(CDeployManager::GetInstance()->m_fAngle);
					CDeployManager::GetInstance()->m_pTargetObj->UpdateLocalMatrix();
				}
			}
#endif // __HOUSING
#if __VER >= 8 //__CSC_VER8_1
			if( g_bKeyTable[ VK_MULTIPLY ] ) //VK_MULTIPLY �ӽ÷�....
			{
				if(!g_WndMng.m_clearFlag)
					g_WndMng.ClearAllWnd();
				else
					g_WndMng.RestoreWnd();
			}
#endif //__CSC_VER8_1
			
			g_bKeyTable[ nVirtKey ] = FALSE;
			g_WndMng.SetMessengerAutoState();
		}
		break;
	case WM_LBUTTONDOWN:
	case WM_RBUTTONDOWN:
	case WM_LBUTTONUP:
	case WM_LBUTTONDBLCLK:
	case WM_RBUTTONUP:
	case WM_MOUSEMOVE:
	case WM_MOUSEWHEEL:
#if __VER >= 13 // __HOUSING
		if(CDeployManager::GetInstance()->IsReady() && msg == WM_MOUSEWHEEL)
		{
			int nDelta = (short)HIWORD(wParam);
			if(nDelta < 0)
			{
				CDeployManager::GetInstance()->m_pTargetObj->AddAngle(2.5f);
				CDeployManager::GetInstance()->m_pTargetObj->UpdateLocalMatrix();
			}
			else
			{
				CDeployManager::GetInstance()->m_pTargetObj->AddAngle(-2.5f);
				CDeployManager::GetInstance()->m_pTargetObj->UpdateLocalMatrix();
			}
		}
#endif // __HOUSING
			g_WndMng.SetMessengerAutoState();		
		break;
	case WM_CLOSE:
		{
#ifdef __IMPROVE_MAP_SYSTEM
#ifdef __CLIENT
			prj.m_MapInformationManager.DeleteAllMapInformation();
#endif // __CLIENT
#endif // __IMPROVE_MAP_SYSTEM
			g_Neuz.m_bQuit = TRUE;
			if( wParam == FALSE )
			{
				if( g_pPlayer )
				{
					g_WndMng.m_bConnect = FALSE;
					StopMusic();
					return 1;
				}
			}
		}
		break;
	case WM_LOGOUT:
		{
			g_WndMng.OpenTitle();
			PlayMusic( BGM_TITLE, 0 );
			g_WndMng.m_bConnect = FALSE;
			return 1;
		}
		break;
		
	case WM_MOVE:
		{
			CWebBox* pWebBox	= CWebBox::GetInstance();
			if( pWebBox && pWebBox->m_hDlg )
				::SendMessage( pWebBox->m_hDlg, WM_INITDIALOG, 0, 0 );
		}
		break;

	case WM_COMMAND:
		break;
	case WM_ACTIVATE:
		m_bActiveNeuz = TRUE;
		if( LOWORD(wParam) == WA_INACTIVE )
		{
			m_bActiveNeuz = FALSE;
		}
		break;
	}
	return CD3DApplication::MsgProc( hWnd, msg, wParam, lParam );
}

BOOL CNeuzApp::KillWindow( int wParam )
{
	CWndStateConfirm* pWndStateConfirm = (CWndStateConfirm*)g_WndMng.GetWndBase( APP_STATE_CONFIRM );
	if( pWndStateConfirm )
	{
		if( wParam == VK_RETURN )
		{
			pWndStateConfirm->SendYes();
		}
		else if( wParam == VK_ESCAPE )
		{
#if __VER >= 13 // __RENEW_CHARINFO
	CWndBase* pWndBase	= g_WndMng.GetWndBase( APP_CHARACTER3 );
#elif __VER >= 9 // __CSC_VER9_2
			CWndBase* pWndBase	= g_WndMng.GetWndBase( APP_CHARACTER2 );
#else //__CSC_VER9_2
			CWndBase* pWndBase	= g_WndMng.GetWndBase( APP_CHARACTER );
#endif //__CSC_VER9_2
			if( pWndBase ) {
#if __VER < 9 // __CSC_VER9_2
				( (CWndCharacter*)pWndBase )->m_wndStateDetail.m_fWaitingConfirm	= FALSE;
#endif //__CSC_VER9_2
			}
			pWndStateConfirm->Destroy();
		}
		return TRUE;
	}

	return FALSE;
}

void __cdecl LoadProperty( void* p )
{ 
	prj.OpenProject( "Masquerade.prj" );
	CNeuzApp* pApp = (CNeuzApp*) p;
	pApp->m_hThread = INVALID_HANDLE_VALUE;
}

void CNeuzApp::WaitLoading()
{
	OutputDebugString("Wait Loading start\n");
	#ifdef __LOADER_SPLASH

		NeuzLoad.Load(m_hInstance,ID_PRELOADER);

		NeuzLoad.Active(); // like splash :p

	#endif
	if( m_hThread != INVALID_HANDLE_VALUE )
	{
		WaitForSingleObject( m_hThread, INFINITE );
		m_hThread = INVALID_HANDLE_VALUE;
	}
	OutputDebugString("WaitLoading end\n");
}

void CNeuzApp::BeginLoadThread()
{

	#ifdef __LOADER_SPLASH

	//ShowWindow( m_hWnd, SW_HIDE );
	AnimateWindow(m_hWnd, 400, AW_BLEND);
	#endif
	
	CResFile::ScanResource( "" );

	prj.LoadPreFiles();

	m_hThread = (HANDLE) _beginthread( LoadProperty, 0, (LPVOID)this );
#if !defined(_DEBUG)
	WaitLoading();
#endif
}

//
// ����̽��� �񵶸����� �Ž�, ������ ���� ó�� �ʱ�ȭ �ϴ� �� 
//
HRESULT CNeuzApp::InitDeviceObjects()
{
	InitNProtect();
	BeginLoadThread();

	SetMouseCursor( CUR_DELAY ); 

	g_MusicMng.LoadScript( MakePath( DIR_MUSIC, _T( "default.bgm" ) ) );
	g_SoundMng.LoadScript( MakePath( DIR_CLIENT, _T( "sound.inc" ) ) );

#ifndef _DEBUG
	{
		CString strError;
		int nMem = m_pd3dDevice->GetAvailableTextureMem();
		int nVersion = LOWORD(m_d3dSettings.pWindowed_AdapterInfo->AdapterIdentifier.DriverVersion.u.LowPart);
		strError.Format( "%s, %d(%d)", m_d3dSettings.pWindowed_AdapterInfo->AdapterIdentifier.Description, nMem, nVersion );
		ADDERRORMSG_NOHEAD( strError );
	}
#endif 

#ifdef __YENV
	if( m_d3dCaps.PixelShaderVersion < D3DPS_VERSION(1,1) )
		g_dwUsablePS_Level = 0;
	else if( m_d3dCaps.PixelShaderVersion < D3DPS_VERSION(2,0) )
		g_dwUsablePS_Level = 1;
	else 
		g_dwUsablePS_Level = 2;
#endif //__YENV

	if( m_d3dCaps.TextureCaps & D3DPTEXTURECAPS_SQUAREONLY )	// ���簢���� �ؽ��ĸ� �����ϴ� ī�峪 ����̹���� ���ظ��Ѵ�.
	{
		MessageBox( GetSafeHwnd(), m_strArray.GetAt(12), m_strArray.GetAt(11), MB_OK );
		ADDERRORMSG( m_strArray.GetAt(12) );
		int *p = NULL;
		*p = 1;
	}

	m_pd3dDevice->SetRenderState( D3DRS_ZFUNC, D3DCMP_LESSEQUAL);

	prj.m_modelMng.InitDeviceObjects( m_pd3dDevice );
	prj.m_terrainMng.InitDeviceObjects( m_pd3dDevice );

	CWorld::StaticInitDeviceObjects( m_pd3dDevice );
	
	g_DamageNumMng.LoadTexture( m_pd3dDevice );		// ������ ����Ʈ 

	g_SfxMng.InitDeviceObjects(m_pd3dDevice);
	g_SfxMeshMng.InitDeviceObjects(m_pd3dDevice);

	g_Shadow.InitDeviceObjects( m_pd3dDevice );
	g_Shadow.LoadElement( "Shadow.o3d" );

	g_ParticleMng.InitDeviceObjects( m_pd3dDevice );
	if( g_Option.m_nTextureQuality == 2 )		// �ؽ��� ����Ƽ �����̸� ��ƼŬ ����ȵ�.
		g_ParticleMng.m_bActive = FALSE;

	m_TextureGauge[0].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauMagChargeBG.TGA" ), 0xffff00ff, TRUE );
	m_TextureGauge[1].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauMagChargeHead.TGA" ), 0xffff00ff, TRUE );
	m_TextureGauge[2].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauMagChargeBody.TGA" ), 0xffff00ff, TRUE );
	m_TextureGauge[3].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauMagChargeBody2.tga" ), 0xffff00ff, TRUE );
	m_TextureGauge[4].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauMagChargeTail.TGA" ), 0xffff00ff, TRUE );
	
	m_TextureHPGauge[0].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauPartyHpBG.TGA" ), 0xffff00ff, TRUE );
	m_TextureHPGauge[1].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauPartyHp.TGA" ), 0xffff00ff, TRUE );
	m_TextureHPGauge[2].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauPartyHp_Dbf.TGA" ), 0xffff00ff, TRUE );
	m_TextureTurboGauge[0].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauAccelBG.TGA" ), 0xffff00ff, TRUE );
	m_TextureTurboGauge[1].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauAccelInner.TGA" ), 0xffff00ff, TRUE );
	m_TextureCastingGauge[0].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauAccelBG.TGA" ), 0xffff00ff, TRUE );
	m_TextureCastingGauge[1].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauAccelInner.TGA" ), 0xffff00ff, TRUE );

	m_pMasterIcon[0] = CWndBase::m_textureMng.AddTexture( g_Neuz.m_pd3dDevice, MakePath( DIR_ICON, "icon_Expert1.dds"), 0xffff00ff );
	m_pMasterIcon[1] = CWndBase::m_textureMng.AddTexture( g_Neuz.m_pd3dDevice, MakePath( DIR_ICON, "icon_Expert2.dds"), 0xffff00ff );
	m_pMasterIcon[2] = CWndBase::m_textureMng.AddTexture( g_Neuz.m_pd3dDevice, MakePath( DIR_ICON, "icon_Expert3.dds"), 0xffff00ff );
	m_pMasterIcon[3] = CWndBase::m_textureMng.AddTexture( g_Neuz.m_pd3dDevice, MakePath( DIR_ICON, "icon_Expert4.dds"), 0xffff00ff );
	m_pMasterIcon[4] = CWndBase::m_textureMng.AddTexture( g_Neuz.m_pd3dDevice, MakePath( DIR_ICON, "icon_Expert5.dds"), 0xffff00ff );
	m_pMasterIcon[5] = CWndBase::m_textureMng.AddTexture( g_Neuz.m_pd3dDevice, MakePath( DIR_ICON, "icon_Expert6.dds"), 0xffff00ff );
	m_pHeroIcon		 = CWndBase::m_textureMng.AddTexture( g_Neuz.m_pd3dDevice, MakePath( DIR_ICON, "icon_Hero.dds"), 0xffff00ff );

#if __VER >= 11 //	__SYS_COLLECTING
	m_TexCltGauge[0].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauAccelBG.TGA" ), 0xffff00ff, TRUE );
	m_TexCltGauge[1].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauAccelInner.TGA" ), 0xffff00ff, TRUE );
	//m_TexCltGauge[2].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauPartyHp_Dbf.TGA" ), 0xffff00ff, TRUE );
#endif
	
#if __VER >= 8 //__CSC_VER8_5
	m_TextureAngelGauge[0].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauAngelExpBG.TGA" ), 0xffff00ff, TRUE );
	m_TextureAngelGauge[1].LoadTexture( m_pd3dDevice, MakePath( DIR_THEME, "GauAngelExp.TGA" ), 0xffff00ff, TRUE );
#endif //__CSC_VER8_5

	m_dwPVPTime = GetTickCount();
	m_nTexAlpha		= 255;
	m_bTexLoad      = FALSE;
	m_bTexLoadAlpha = FALSE;

	g_toolTip.InitTexture();
#if __VER >= 15 // __IMPROVE_SYSTEM_VER15
	g_toolTipSub1.InitTexture();
	g_toolTipSub2.InitTexture();
#endif // __IMPROVE_SYSTEM_VER15
	
#ifdef __YENV
	HRESULT	hr;
	LPD3DXBUFFER	pErr = NULL;

#ifdef _DEBUG
	if( FAILED(hr = D3DXCreateEffectFromFile( m_pd3dDevice, "hlsl.fx", NULL, NULL, 0, NULL, &m_pEffect, &pErr )))
#else //_DEBUG
	if( FAILED(hr = D3DXCreateEffectFromResource( D3DDEVICE, NULL, MAKEINTRESOURCE(IDR_DATA3), NULL, NULL, 0, NULL, &m_pEffect, &pErr )))
#endif //_DEBUG
	{
		MessageBox( NULL, (LPCTSTR)pErr->GetBufferPointer(), "ERROR", MB_OK );
	}
	else
	{
		m_hTechnique	= m_pEffect->GetTechniqueByName( "TShader" );
		m_hmWVP			= m_pEffect->GetParameterByName( NULL, "mWVP" );
		m_hTexDiffuse   = m_pEffect->GetParameterByName( NULL, "Tex_Diffuse" );
		m_hTexBump      = m_pEffect->GetParameterByName( NULL, "Tex_Bump" );
		m_hTexSpecular  = m_pEffect->GetParameterByName( NULL, "Tex_Specular" );
		m_hvLightDir	= m_pEffect->GetParameterByName( NULL, "vLightDir" );
		m_hvEyePos		= m_pEffect->GetParameterByName( NULL, "vEyePos" );	
		m_hvFog			= m_pEffect->GetParameterByName( NULL, "vFog" );	
		m_hvDiffuse		= m_pEffect->GetParameterByName( NULL, "I_d" );	
		m_hvAmbient		= m_pEffect->GetParameterByName( NULL, "I_a" );			
		m_hvSpecual		= m_pEffect->GetParameterByName( NULL, "I_s" );			
	}
	SAFE_RELEASE( pErr );

	if( g_dwUsablePS_Level < 2 )
		g_Option.m_bSpecBump = FALSE;

	m_pEnvTex = NULL;
#endif //__YENV	
/*

	{
		CScript s;
		if( s.Load(MakePath( DIR_CLIENT, "GameGuard.inc" )) )
		{
			s.GetToken();
			while( s.tok != FINISHED )
			{
				m_strArray.Add( s.Token );
				s.GetToken();
			}
		}
	}

	InitNProtect();

*/

	// �׸� ���� 
	CWndBase::m_Theme.LoadTheme( m_pd3dDevice, "Default.thm" );
	CWndBase::m_Theme.InitDeviceObjects( m_pd3dDevice );

	// CWndBase ���� 
	g_WndMng.m_pApp = this;
	g_WndMng.m_pTheme = &CWndBase::m_Theme;
	g_WndMng.m_pFont = CWndBase::m_Theme.m_pFontText;
	g_WndMng.Initialize();
	g_WndMng.InitDeviceObjects();
	CWndBase::m_hWnd = GetSafeHwnd();
	CWndBase::SetForbidTexture( m_pd3dDevice, MakePath( DIR_ICON, "icon_forbid.dds" ) );

	// ���̾�α� �޽��� ���� 
	g_DialogMsg.InitDeviceObjects( m_pd3dDevice );

	// 2DRender ���� 
	m_2DRender.InitDeviceObjects( m_pd3dDevice );
	m_2DRender.m_pFont = CWndBase::m_Theme.m_pFontText;
	g_WndMng.OpenTitle( TRUE );

	InitFST();		// init frame skipping time
#ifdef	__PROF
	SetFrameSkip( FALSE );
#endif

	m_texQuestEmoticon.LoadScript( m_pd3dDevice, MakePath( DIR_ICON, "icon_QuestEmoticon.inc" ) );
	m_TexturePackPVP.LoadScript( m_pd3dDevice, MakePath( DIR_SFX, "CountFight.inc" ) );

#if __VER >= 15 // __BS_CHANGING_ENVIR
	TexturePool::Get()->Init( m_pd3dDevice );
#endif	//__BS_CHANGING_ENVIR

#ifdef __LOADER_SPLASH

    //ShowWindow( m_hWnd, SW_SHOW ); // reviens mon pti coeur <3
	AnimateWindow(m_hWnd, 400, AW_BLEND);
    if(NeuzLoad.SHOW)
	{
        NeuzLoad.exit(); // now c'est bon tu peu aller dormir :3
	}
#endif
	PlayMusic( BGM_TITLE, 0 );

	return S_OK;
}

#if __VER >= 15
void CNeuzApp::ResetStaticValues( )
{
	GuildHouse->ResetValues( );
}
#endif

#if __VER >= 8 //__Y_GAMMA_CONTROL_8
void CNeuzApp::Drv_SetGamma(HWND hWnd, float gamma, int overbright, float fContrast)
{
    unsigned short ramp[3*256];
    float f;
	   
    GetDeviceGammaRamp( GetDC(hWnd), ramp );
	   
    for ( int i = 0; i < 256; i++ )
	   {
        f = (float)(255 * pow((float)i/256, 1/gamma));
        f = f * fContrast + overbright;
        if (f < 0)
            f = 0;
        if (f > 255)
            f = 255;
        ramp[i+0] = ramp[i+256] = ramp[i+512] = ((unsigned short)f<<8) ;
    }
	   
    SetDeviceGammaRamp( GetDC(hWnd), ramp );
}
/*
void CNeuzApp::Loop()
{
	   if (GetAsyncKeyState(VK_F5)) 
		   g_fGamma -= 0.1f;
	   if (GetAsyncKeyState(VK_F6)) 
		   g_fGamma += 0.1f;
	   if (GetAsyncKeyState(VK_F7)) 
		   g_nOverBright -= 1;
	   if (GetAsyncKeyState(VK_F8)) 
		   g_nOverBright += 1;
	   if (GetAsyncKeyState(VK_F9)) 
		   g_fContrast -= 0.1f;
	   if (GetAsyncKeyState(VK_F10)) 
		   g_fContrast += 0.1f;
	   
	   Drv_SetGamma(GetSafeHwnd(), g_fGamma, g_nOverBright, g_fContrast);
}
*/

#endif //__Y_GAMMA_CONTROL_8

#ifdef __GAME_GRADE_SYSTEM
#ifdef __CLIENT
void CNeuzApp::CalculateGameGradeMarkAlpha( void )
{
	CWndWorld* pWndWorld = (CWndWorld*)g_WndMng.GetWndBase( APP_WORLD );
	if( pWndWorld == NULL )
	{
		return;
	}

	if( g_Option.m_bGameGradeRendering == TRUE )
	{
		if( g_tmCurrent > m_dwTimeGameGradeMarkRendering )
		{
			m_bGameGradeMarkRenderingSwitch = TRUE;
			m_nGameGradeMarkAlpha = GAME_GRADE_MARK_MINIMUM_ALPHA;
			m_eGameGradeMarkState = FADE_IN;
			m_dwTimeOld = g_tmCurrent;
			m_dwTimeGameGradeMarkRendering = g_tmCurrent + SEC( GAME_GRADE_MARK_RENDERING_INTERVAL_SECOND );
		}
	}

	if( m_bGameGradeMarkRenderingSwitch == TRUE )
	{
		float fDelta = ( static_cast< float >( g_tmCurrent - m_dwTimeOld ) / 1000.0f );
		m_dwTimeOld = g_tmCurrent;

		switch( m_eGameGradeMarkState )
		{
		case FADE_IN:
			{
				m_nGameGradeMarkAlpha += static_cast< int >( GAME_GRADE_MARK_FADING_SPEED * fDelta );
				if( m_nGameGradeMarkAlpha > GAME_GRADE_MARK_MAXIMUM_ALPHA )
				{
					m_nGameGradeMarkAlpha = GAME_GRADE_MARK_MAXIMUM_ALPHA;
					m_dwTimeGameGradeMarkShowing = g_tmCurrent + SEC( GAME_GRADE_MARK_SHOWING_SECOND );
					m_eGameGradeMarkState = SHOW;
				}
				break;
			}
		case SHOW:
			{
				if( g_tmCurrent > m_dwTimeGameGradeMarkShowing )
				{
					m_eGameGradeMarkState = FADE_OUT;
				}
				break;
			}
		case FADE_OUT:
			{
				m_nGameGradeMarkAlpha -= static_cast< int >( GAME_GRADE_MARK_FADING_SPEED * fDelta );
				if( m_nGameGradeMarkAlpha < GAME_GRADE_MARK_MINIMUM_ALPHA )
				{
					m_nGameGradeMarkAlpha = GAME_GRADE_MARK_MINIMUM_ALPHA;
					m_bGameGradeMarkRenderingSwitch = FALSE;
					m_eGameGradeMarkState = FADE_IN;
				}
				break;
			}
		}
	}
}
#endif // __CLIENT
#endif // __GAME_GRADE_SYSTEM