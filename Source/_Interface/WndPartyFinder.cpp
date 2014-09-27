#include "stdafx.h"
#include "resData.h"
#include "defineText.h"


#ifdef __CLIENT

#include "WndPartyFinder.h"
#include "DPClient.h"
#include "Party.h"

extern	CDPClient	g_DPlay;

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/****************************************************
  WndId : APP_PARTYFINDER - 하우징
  CtrlId : WIDC_BUTTON1 - 설치하기
  CtrlId : WIDC_BUTTON2 - 해체하기
  CtrlId : WIDC_TEXT1 - 
  CtrlId : WIDC_STATIC1 - 설명
  CtrlId : WIDC_STATIC2 - 종류
  CtrlId : WIDC_STATIC3 - 아이템명
  CtrlId : WIDC_STATIC4 - 남은 시간
  CtrlId : WIDC_STATIC5 - 설치
  CtrlId : WIDC_LISTBOX1 - Listbox
***************************************************
*/
bool CompType_Greater( PARTYFINDER_LIST& first, PARTYFINDER_LIST& second )
{
	return first.m_nSizeofMember > second.m_nSizeofMember;
}
bool CompType_Smaller( PARTYFINDER_LIST& first, PARTYFINDER_LIST& second )
{
	return first.m_nSizeofMember < second.m_nSizeofMember;
}

bool CompDeploy_Greater( PARTYFINDER_LIST& first, PARTYFINDER_LIST& second )
{
	return first.m_nLevel > second.m_nLevel;
}
bool CompDeploy_Smaller( PARTYFINDER_LIST& first, PARTYFINDER_LIST& second )
{
	return first.m_nLevel < second.m_nLevel;
}

bool CompTime_Greater( PARTYFINDER_LIST& first, PARTYFINDER_LIST& second )
{
	return first.m_nPoint > second.m_nPoint;
}
bool CompTime_Smaller( PARTYFINDER_LIST& first, PARTYFINDER_LIST& second )
{
	return first.m_nPoint < second.m_nPoint;
}

bool CompName_Greater( PARTYFINDER_LIST& first, PARTYFINDER_LIST& second )
{
	if(strcmp( first.m_sParty, second.m_sParty) < 0)
		return true;
	else
		return false;
}
bool CompName_Smaller( PARTYFINDER_LIST& first, PARTYFINDER_LIST& second )
{
	if(strcmp( first.m_sParty, second.m_sParty) > 0)
		return true;
	else
		return false;
}


CWndPartyFinder::CWndPartyFinder() 
{ 
	m_mapItem.clear();
	m_nSortType = WIDC_STATIC2;
	m_bIsGreater = TRUE;
	m_nSelected = 0;
} 

CWndPartyFinder::~CWndPartyFinder() 
{ 
} 

void CWndPartyFinder::SerializeRegInfo( CAr& ar, DWORD& dwVersion )
{
	CWndNeuz::SerializeRegInfo( ar, dwVersion );
}

void CWndPartyFinder::OnDraw( C2DRender* p2DRender ) 
{ 
	if(m_mapItem.size())
	{
		vector<PARTYFINDER_LIST>::iterator iter;
		CWndListBox*	pWndListBox = (CWndListBox*)GetDlgItem( WIDC_LISTBOX1 );
		LPWNDCTRL		pCustom = NULL;
		DWORD			dwColor;
		int				nIndex = 0;

		int nListFontHeight = pWndListBox->GetFontHeight() + 1;

		pCustom = GetWndCtrl( WIDC_LISTBOX1 );
		dwColor = D3DCOLOR_ARGB( 255, 255, 255, 255 );

		int nDrawCount = 0;
		int nLine = 0;

		for(iter = m_mapItem.begin(); iter != m_mapItem.end(); ++iter)
		{
			if(m_nSelected != 0 && (m_nSelected - 1) == nLine)
				dwColor = D3DCOLOR_ARGB( 255, 255, 0, 0 );
			else
				dwColor = D3DCOLOR_ARGB( 255, 255, 255, 255 );

			if(nLine < pWndListBox->GetScrollPos()) 
			{
				nLine++;
				continue;	
			}
			else
				nLine++;

			if(nDrawCount >= 10) continue;	// 10개 까지만 드로잉한다


			PlayerData* pPlayerData	= CPlayerDataCenter::GetInstance()->GetPlayerData( iter->m_nLeaderId );

			p2DRender->TextOut( pCustom->rect.left + 5, pCustom->rect.top + 8 + (nIndex)*nListFontHeight, nLine+1, dwColor);

		if( pPlayerData )
			p2DRender->TextOut( pCustom->rect.left + 50, pCustom->rect.top + 8 + (nIndex)*nListFontHeight, pPlayerData->szPlayer, dwColor);


			p2DRender->TextOut( pCustom->rect.left + 225, pCustom->rect.top + 8 + (nIndex)*nListFontHeight, iter->m_sParty, dwColor);

			// 설치 여부
			p2DRender->TextOut( pCustom->rect.left + 370, pCustom->rect.top + 8 + (nIndex)*nListFontHeight, iter->m_nSizeofMember, dwColor);
		
			p2DRender->TextOut( pCustom->rect.left + 440, pCustom->rect.top + 8 + (nIndex)*nListFontHeight, iter->m_nPoint, dwColor);

			++nIndex;
			++nDrawCount;
		}
	}
} 

void CWndPartyFinder::RefreshItemList()
{
	int				nIndex = 1;

	// 아이템 리스트를 싹 새로 갱신한다
	

	CWndListBox* pWndListBox = (CWndListBox*)GetDlgItem( WIDC_LISTBOX1 );

	for(vector<PARTYFINDER_LIST>::iterator iter = m_mapItem.begin(); iter != m_mapItem.end(); ++iter)
			pWndListBox->AddString(" ");

	Sort();
	m_nSelected = 0;
}

void CWndPartyFinder::Sort()
{
	if(m_mapItem.size() > 1)
	{
		switch(m_nSortType)
		{
			case WIDC_STATIC2:		// 타입
				if(m_bIsGreater)
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompType_Greater);
				else
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompType_Smaller);
				break;
			case WIDC_STATIC3:		// 아이템명
				if(m_bIsGreater)
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompName_Greater);
				else
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompName_Smaller);
				break;
			case WIDC_STATIC4:		// 남은시간
				if(m_bIsGreater)
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompTime_Greater);
				else
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompTime_Smaller);
				break;
			case WIDC_STATIC5:		// 설치
				if(m_bIsGreater)
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompDeploy_Greater);
				else
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompDeploy_Smaller);
				break;
		};
	}
}

void CWndPartyFinder::OnInitialUpdate() 
{ 
	CWndNeuz::OnInitialUpdate(); 
	// 여기에 코딩하세요
	RefreshItemList();

	//CWndButton* pWndButton1 = (CWndButton*)GetDlgItem(WIDC_BUTTON1);
	//CWndButton* pWndButton2 = (CWndButton*)GetDlgItem(WIDC_BUTTON2);
	//pWndButton1->EnableWindow(FALSE);
	//pWndButton2->EnableWindow(FALSE);

	//ListBox
	CSize size = g_Neuz.m_2DRender.m_pFont->GetTextExtent( "123" );

	if(size.cy+2 > 16)
	{
		CRect rect;
		LPWNDCTRL lpWndCtrl;

		CWndListBox* pWndList = (CWndListBox*)GetDlgItem( WIDC_LISTBOX1 );
		lpWndCtrl = GetWndCtrl( WIDC_LISTBOX1 );
		rect = lpWndCtrl->rect;
		rect.bottom += ((size.cy+2)*10) - (rect.bottom-rect.top) + 4;
		//폰트 크기 차이 때문에 리스트박스 크기 늘임
		pWndList->SetWndRect(rect);

		//창 밀리는 경우 아래도 크기 조정
		CRect rectStatic, recText;
		CWndStatic* pWndStatic = (CWndStatic*)GetDlgItem( WIDC_STATIC1 );
		lpWndCtrl = GetWndCtrl( WIDC_STATIC1 );
		rectStatic = lpWndCtrl->rect;
		pWndStatic->Move(rectStatic.left, rect.bottom + 10);

		CWndText* pWndText = (CWndText*)GetDlgItem( WIDC_TEXT1 );
		lpWndCtrl = GetWndCtrl( WIDC_TEXT1 );
		recText = lpWndCtrl->rect;
		recText.top = rect.bottom + rectStatic.Height() + 18;
		pWndText->SetWndRect(recText, TRUE);
	}

	// 윈도를 중앙으로 옮기는 부분.
	CRect rectRoot = m_pWndRoot->GetLayoutRect();
	CRect rectWindow = GetWindowRect();
	CPoint point( rectRoot.right - rectWindow.Width(), 110 );
	Move( point );
	MoveParentCenter();
} 
// 처음 이 함수를 부르면 윈도가 열린다.
BOOL CWndPartyFinder::Initialize( CWndBase* pWndParent, DWORD /*dwWndId*/ ) 
{ 
	// Daisy에서 설정한 리소스로 윈도를 연다.
	return CWndNeuz::InitDialog( g_Neuz.GetSafeHwnd(), APP_PARTYFINDER, 0, CPoint( 0, 0 ), pWndParent );
} 
/*
  직접 윈도를 열때 사용 
BOOL CWndPartyFinder::Initialize( CWndBase* pWndParent, DWORD dwWndId ) 
{ 
	CRect rectWindow = m_pWndRoot->GetWindowRect(); 
	CRect rect( 50 ,50, 300, 300 ); 
	SetTitle( _T( "title" ) ); 
	return CWndNeuz::Create( WBS_THICKFRAME | WBS_MOVE | WBS_SOUND | WBS_CAPTION, rect, pWndParent, dwWndId ); 
} 
*/
BOOL CWndPartyFinder::OnCommand( UINT nID, DWORD dwMessage, CWndBase* pWndBase ) 
{ 
	return CWndNeuz::OnCommand( nID, dwMessage, pWndBase ); 
} 
void CWndPartyFinder::OnSize( UINT nType, int cx, int cy ) 
{ 
	CWndNeuz::OnSize( nType, cx, cy ); 
}

BOOL CWndPartyFinder::OnMouseWheel( UINT nFlags, short zDelta, CPoint pt )
{
	return TRUE;
}

void CWndPartyFinder::OnLButtonUp( UINT nFlags, CPoint point ) 
{ 
		
} 
void CWndPartyFinder::OnLButtonDown( UINT nFlags, CPoint point ) 
{ 
} 
BOOL CWndPartyFinder::OnChildNotify( UINT message, UINT nID, LRESULT* pLResult ) 
{ 
	int				nLoop		= 0;

	switch(nID)
	{
		case WIDC_LISTBOX1: // view ctrl
			{
				CWndListBox*	pWndListBox = (CWndListBox*)GetDlgItem( WIDC_LISTBOX1 );
				CWndButton*		pWndButton1 = (CWndButton*)GetDlgItem(WIDC_BUTTON1);
				CWndButton*		pWndButton2 = (CWndButton*)GetDlgItem(WIDC_BUTTON2);
				CWndText*		pWndText	= (CWndText*)GetDlgItem( WIDC_TEXT1 );
				
				m_nSelected					= pWndListBox->GetCurSel() + 1;

				for(vector<PARTYFINDER_LIST>::iterator iter = m_mapItem.begin(); iter != m_mapItem.end(); ++iter)
				{
					++nLoop;
					if(m_nSelected > nLoop)	continue;
					else if(m_nSelected == nLoop)
					{
						// 설명을 띄운다
						pWndText->SetString( iter->m_sPartyList );
						
						//설치되었으면 해제버튼 활성/설치버튼 비활성, 안되었으면 반대로

					}
				}
			}
			break;

		case WIDC_BUTTON1:// 설치버튼
			{
				CWndListBox*	pWndListBox = (CWndListBox*)GetDlgItem( WIDC_LISTBOX1 );
				pWndListBox->ResetContent();
				g_DPlay.JoinParty( -1 );
				//RefreshItemList();
			}
			break;

		case WIDC_BUTTON2:// 해제버튼
			{
				CWndListBox*	pWndListBox = (CWndListBox*)GetDlgItem( WIDC_LISTBOX1 );
				for(vector<PARTYFINDER_LIST>::iterator iter = m_mapItem.begin(); iter != m_mapItem.end(); ++iter)
				{
					++nLoop;
					if(m_nSelected > nLoop)	continue;
					else if(m_nSelected == nLoop)
					{
									g_DPlay.SendAddPartyMember( iter->m_nLeaderId, 0, 0, 0, 0, 0, 0, 0 );
					}
				}
				
			}
			break;
/*		case 10000:
		{

			return TRUE;

		}
		break; */
		
	}

	return CWndNeuz::OnChildNotify( message, nID, pLResult ); 
} 
#endif
