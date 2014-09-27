#ifndef __WNDPARTYFINDER__H
#define __WNDPARTYFINDER__H
#pragma once

#include "Party.h"


class CWndPartyFinder : public CWndNeuz 
{
private:
	// 실제 창에서 쓰일 정보들
	// 소팅 타입
	int						m_nSortType;
	BOOL					m_bIsGreater;
	int						m_nSelected;
public: 

	vector<PARTYFINDER_LIST>	m_mapItem;

	CWndPartyFinder(); 
	virtual ~CWndPartyFinder(); 
	
	virtual void SerializeRegInfo( CAr& ar, DWORD& dwVersion );
	virtual BOOL Initialize( CWndBase* pWndParent = NULL, DWORD nType = MB_OK ); 
	virtual BOOL OnChildNotify( UINT message, UINT nID, LRESULT* pLResult ); 
	virtual void OnDraw( C2DRender* p2DRender ); 
	virtual	void OnInitialUpdate(); 
	virtual BOOL OnCommand( UINT nID, DWORD dwMessage, CWndBase* pWndBase ); 
	virtual void OnSize( UINT nType, int cx, int cy ); 
	virtual void OnLButtonUp( UINT nFlags, CPoint point ); 
	virtual void OnLButtonDown( UINT nFlags, CPoint point ); 
	virtual BOOL OnMouseWheel( UINT nFlags, short zDelta, CPoint pt );
	
	void RefreshItemList( );
	void Sort();
	
	
}; 

#endif