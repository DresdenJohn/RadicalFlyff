// PatchClient.h : main header file for the PATCHCLIENT application
//

#if !defined(AFX_PATCHCLIENT_H__CB6FDBED_0695_4D26_8042_AFE31500A8C5__INCLUDED_)
#define AFX_PATCHCLIENT_H__CB6FDBED_0695_4D26_8042_AFE31500A8C5__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CPatchClientApp:
// See PatchClient.cpp for the implementation of this class
//

enum CHECK_TYPE
{
	CHECK_TRUE,
	CHECK_FALSE,
	CHECK_SKIP,
};

class CPatchClientApp : public CWinApp
{
public:
	CPatchClientApp();

	void		RunClient();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CPatchClientApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
protected:
	void		InitLanguage();
	CHECK_TYPE	CheckSingleInstance();
	BOOL		InitPath();
	BOOL		CheckDirectXVersion();

	//{{AFX_MSG(CPatchClientApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PATCHCLIENT_H__CB6FDBED_0695_4D26_8042_AFE31500A8C5__INCLUDED_)
