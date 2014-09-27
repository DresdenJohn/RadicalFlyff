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
  WndId : APP_PARTYFINDER - �Ͽ�¡
  CtrlId : WIDC_BUTTON1 - ��ġ�ϱ�
  CtrlId : WIDC_BUTTON2 - ��ü�ϱ�
  CtrlId : WIDC_TEXT1 - 
  CtrlId : WIDC_STATIC1 - ����
  CtrlId : WIDC_STATIC2 - ����
  CtrlId : WIDC_STATIC3 - �����۸�
  CtrlId : WIDC_STATIC4 - ���� �ð�
  CtrlId : WIDC_STATIC5 - ��ġ
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

			if(nDrawCount >= 10) continue;	// 10�� ������ ������Ѵ�


			PlayerData* pPlayerData	= CPlayerDataCenter::GetInstance()->GetPlayerData( iter->m_nLeaderId );

			p2DRender->TextOut( pCustom->rect.left + 5, pCustom->rect.top + 8 + (nIndex)*nListFontHeight, nLine+1, dwColor);

		if( pPlayerData )
			p2DRender->TextOut( pCustom->rect.left + 50, pCustom->rect.top + 8 + (nIndex)*nListFontHeight, pPlayerData->szPlayer, dwColor);


			p2DRender->TextOut( pCustom->rect.left + 225, pCustom->rect.top + 8 + (nIndex)*nListFontHeight, iter->m_sParty, dwColor);

			// ��ġ ����
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

	// ������ ����Ʈ�� �� ���� �����Ѵ�
	

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
			case WIDC_STATIC2:		// Ÿ��
				if(m_bIsGreater)
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompType_Greater);
				else
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompType_Smaller);
				break;
			case WIDC_STATIC3:		// �����۸�
				if(m_bIsGreater)
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompName_Greater);
				else
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompName_Smaller);
				break;
			case WIDC_STATIC4:		// �����ð�
				if(m_bIsGreater)
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompTime_Greater);
				else
					std::sort( m_mapItem.begin(), m_mapItem.end(), CompTime_Smaller);
				break;
			case WIDC_STATIC5:		// ��ġ
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
	// ���⿡ �ڵ��ϼ���
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
		//��Ʈ ũ�� ���� ������ ����Ʈ�ڽ� ũ�� ����
		pWndList->SetWndRect(rect);

		//â �и��� ��� �Ʒ��� ũ�� ����
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

	// ������ �߾����� �ű�� �κ�.
	CRect rectRoot = m_pWndRoot->GetLayoutRect();
	CRect rectWindow = GetWindowRect();
	CPoint point( rectRoot.right - rectWindow.Width(), 110 );
	Move( point );
	MoveParentCenter();
} 
// ó�� �� �Լ��� �θ��� ������ ������.
BOOL CWndPartyFinder::Initialize( CWndBase* pWndParent, DWORD /*dwWndId*/ ) 
{ 
	// Daisy���� ������ ���ҽ��� ������ ����.
	return CWndNeuz::InitDialog( g_Neuz.GetSafeHwnd(), APP_PARTYFINDER, 0, CPoint( 0, 0 ), pWndParent );
} 
/*
  ���� ������ ���� ��� 
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
						// ������ ����
						pWndText->SetString( iter->m_sPartyList );
						
						//��ġ�Ǿ����� ������ư Ȱ��/��ġ��ư ��Ȱ��, �ȵǾ����� �ݴ��

					}
				}
			}
			break;

		case WIDC_BUTTON1:// ��ġ��ư
			{
				CWndListBox*	pWndListBox = (CWndListBox*)GetDlgItem( WIDC_LISTBOX1 );
				pWndListBox->ResetContent();
				g_DPlay.JoinParty( -1 );
				//RefreshItemList();
			}
			break;

		case WIDC_BUTTON2:// ������ư
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
