// PatchClient.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "PatchClient.h"
#include "PatchClientDlg.h"
#include "PatchManager.h"

extern CPatchClientDlg *g_pDlg;
extern CPatchManager		g_PatchManager;
/////////////////////////////////////////////////////////////////////////////
// CPatchClientApp

BEGIN_MESSAGE_MAP(CPatchClientApp, CWinApp)
	//{{AFX_MSG_MAP(CPatchClientApp)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPatchClientApp construction

CPatchClientApp::CPatchClientApp()
{
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CPatchClientApp object

CPatchClientApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CPatchClientApp initialization





CHECK_TYPE CPatchClientApp::CheckSingleInstance()
{
	//	Neuz ���ؽ� �˻�
	HANDLE hNeuzMutex = OpenMutex( MUTEX_ALL_ACCESS, TRUE, "neuz" );
	if( hNeuzMutex != NULL )
	{
	#if __CURRENT_LANG == LANG_JAP || __CURRENT_LANG == LANG_KOR || __CURRENT_LANG == LANG_ENG || __CURRENT_LANG == LANG_THA || __CURRENT_CNTRY == CNTRY_HK
		//��Ƽ ���� ��� (5������), ��� ����� ������ �̹� ��ġ�޾Ҵٰ� �����Ѵ�.
/*
#if __CURRENT_LANG == LANG_KOR
#ifdef __LINK_PORTAL
		//������ �� ��� Ȩ�������� ����
		CString strCmdLine;
		strCmdLine.Format("%s", AfxGetApp()->m_lpCmdLine);
		if(strCmdLine.GetLength() == 0 || strCmdLine == "1")
		{
			return CHECK_TRUE;
		}
		else
			return CHECK_SKIP;

//		else
//			AfxMessageBox( strCmdLine );
#endif //__LINK_PORTAL
#else // LANG_KOR
*/
		return CHECK_SKIP;
//#endif // LANG_KOR
	#else
		AfxMessageBox( IDS_RUNNING_NEUZ );
	#endif
		return CHECK_FALSE;	
	}
	
	//	��ġ Ŭ���̾�Ʈ ���ؽ�
	HANDLE hMutex	= CreateMutex( NULL, TRUE, "masquerade" );
	DWORD dwError	= GetLastError();
	if( hMutex )
		ReleaseMutex( hMutex );
	if( dwError == ERROR_ALREADY_EXISTS )
	{
		AfxMessageBox( IDS_RUNNING_PATCH );
		return CHECK_FALSE;
	}

	return CHECK_TRUE;
}

// �������� ������Ʈ���� �н������� �̿������� 2006.04���� �̸� �̿����� �ʰ� ���� 
BOOL CPatchClientApp::InitPath()
{
	g_PatchManager.SetCurrentLocalDirectory();
	return TRUE;
}


// DirectX �˻� VerSion�� 9 �̸��̸� ������ �ȵ�
BOOL CPatchClientApp::CheckDirectXVersion()
{
	DWORD dwVersion, dwRevision;
	if (DirectXSetupGetVersion(&dwVersion, &dwRevision)) 
	{
		int HighVersion = HIWORD(dwVersion);
		int LowVersion  = LOWORD(dwVersion);
		if( LowVersion >= 9 ) 
			return TRUE;
	}

	return FALSE;
}

void CPatchClientApp::RunClient()
{
	PROCESS_INFORMATION pi;
	STARTUPINFO si;
	memset( &si, 0, sizeof( STARTUPINFO ) );
	si.cb = sizeof( STARTUPINFO );

	TCHAR szBuffer[2048];
	int nCount = _snprintf( szBuffer, 2047, "Neuz.exe %s", "sunkist" );
	if( nCount <= 0 )
		return;

	if( CreateProcess( NULL, szBuffer, NULL, NULL, FALSE, 0, NULL, NULL, &si, &pi ) )
	{
		if( AfxGetMainWnd() )
			AfxGetMainWnd()->PostMessage( WM_CLOSE );
	}
	else
	{
		char szError[256];
		wsprintf( szError, "ErrorNumber: %d Neuz.exe Run Error", GetLastError() );
		AfxMessageBox( szError );
	}				
}

BOOL CPatchClientApp::InitInstance()
{
	AfxEnableControlContainer();
#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	//Enable3dControlsStatic();	// Call this when linking to MFC statically	//rev1
#endif

	BOOL bSkipPatch = FALSE;

	CHECK_TYPE type = CheckSingleInstance();
	switch( type )
	{
	case CHECK_FALSE:
		return FALSE;
	case CHECK_SKIP:
		RunClient();
		return FALSE;
	}
	
	::DeleteFile( PATCH_LOGFILE );
	::DeleteFile( "NewFlyff.exe" );
	
	if( InitPath() == FALSE )				// ������Ʈ������ ���� Path�� ��� �����Ѵ�.
		return FALSE;

	if( CheckDirectXVersion() == FALSE )	
	{
		AfxMessageBox( IDS_DIRECTX_INSTALL );	// DirectX 9�� ��ġ�Ǿ� ���� �ʽ��ϴ�.
		return FALSE;
	}

	CPatchClientDlg dlg;
	m_pMainWnd = &dlg;
	g_pDlg = &dlg;

	dlg.DoModal();
	return FALSE;
}
