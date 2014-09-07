#ifndef __BILLINGMGRTW_H__
#define	__BILLINGMGRTW_H__

#include "BillingMgr.h"


class CBillingMgrTW : public CBillingMgr
{
public:
	CBillingMgrTW();
	virtual ~CBillingMgrTW();

	virtual bool		Init( HWND hWnd );
	virtual void		Release();
	virtual BYTE		CheckAccount( int nType, DWORD dwKey, const char* szAccount, const char* szAddr );
	virtual BOOL		PreTranslateMessage( HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam ); 
	virtual BOOL		SetConfig( BILLING_ENUM id, DWORD data );
	virtual void		OnTimer( CAccount* pAccount );
	virtual void		OnDBQuery( CQuery& query, tagDB_OVERLAPPED_PLUS* pOV );
	virtual void		NotifyLogout( LPCTSTR lpszAccount, DWORD dwSession ) {}

private:
	int					m_iBillingFreePass;
};

#endif	// __BILLINGMGRTW_H__