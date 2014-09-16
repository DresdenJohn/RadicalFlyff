// AIPet.cpp : 
//

#include "stdafx.h"
#include "AIPet.h"
#include "lang.h"
#include "User.h"
#include "dpcoreclient.h"

#ifdef __PETFILTER
#include "defineFilter.h"
#endif //__PETFILTER

extern	CUserMng		g_UserMng;
extern	CDPCoreClient	g_DPCoreClient;

enum
{
	STATE_INIT = 1,
	STATE_IDLE,
	STATE_RAGE
};
BEGIN_AISTATE_MAP( CAIPet, CAIInterface )

	ON_STATE( STATE_INIT   , StateInit   )
	ON_STATE( STATE_IDLE   , StateIdle   )
	ON_STATE( STATE_RAGE   , StateRage   )

END_AISTATE_MAP()

#define		PETSTATE_IDLE		0
#define		PETSTATE_TRACE		1

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __VM_0820
#ifndef __MEM_TRACE
	#ifdef __VM_0819
	MemPooler<CAIPet>*	CAIPet::m_pPool		= new MemPooler<CAIPet>( 128, "CAIPet" );
	#else	// __VM_0819
	MemPooler<CAIPet>*	CAIPet::m_pPool		= new MemPooler<CAIPet>( 128 );
	#endif	// __VM_0819
#endif	// __MEM_TRACE
#endif	// __VM_0820

CAIPet::CAIPet()
{
	Init();
}
CAIPet::CAIPet( CObj* pObj ) : CAIInterface( pObj )
{
	Init();
}

CAIPet::~CAIPet()
{
	Destroy();
}

void CAIPet::Init( void )
{
	m_idOwner	= NULL_ID;
	m_bLootMove		= FALSE;				
	m_idLootItem	= NULL_ID;				
	m_nState	= PETSTATE_IDLE;
#if __VER >= 12 // __PET_0519
	m_dwSkillId		= NULL_ID;	// 
	m_idPetItem		= NULL_ID;	// ���� ������
#endif	// __PET_0519
}

void CAIPet::Destroy( void )
{
	// ����� �ı��ڵ带 ������.


	Init();
}

void CAIPet::InitAI()
{
	PostAIMsg( AIMSG_SETSTATE, STATE_IDLE ); 
}

// vDst������ �̵�.
void CAIPet::MoveToDst(	D3DXVECTOR3 vDst )
{
	CMover* pMover = GetMover();
	CWorld* pWorld = GetWorld();
	pMover->SetDestPos( vDst );
	pMover->m_nCorr		= -1;
	g_UserMng.AddSetDestPos( pMover, vDst, 1 );
	
}

// idTarget������ �̵�.
void CAIPet::MoveToDst(	OBJID idTarget )
{
	CMover* pMover = GetMover();
	if( pMover->GetDestId() == idTarget )
		return;
	pMover->SetDestObj( idTarget ); // ��ǥ�� �缳�����ش�.
	g_UserMng.AddMoverSetDestObj( (CMover*)pMover, idTarget );
}


// ��ó�� �������� ������ ����.
BOOL CAIPet::SubItemLoot( void )
{
	CMover* pMover = GetMover();
	CMover* pOwner = prj.GetMover( m_idOwner );
	CWorld* pWorld = GetWorld();
	MoverProp *pProp = pMover->GetProp();
	D3DXVECTOR3 vPos = pMover->GetPos();
	CObj *pObj = NULL;
	int nRange = 0;
	D3DXVECTOR3 vDist;
	FLOAT fDistSq, fMinDist = 9999999.0f;
	CObj *pMinObj = NULL;

	vDist = pOwner->GetPos() - pMover->GetPos();
	fDistSq = D3DXVec3LengthSq( &vDist );
	if( fDistSq > 32.0f * 32.0f )	// ���δ԰��� �Ÿ��� 32���Ͱ� ������ ������ �����´�.
		return FALSE;

	if( pOwner && pOwner->IsFly() )
		return FALSE;
		
	// ��ó�� �������� �˻���. - ���δԲ��� �˻��ؾ��ҵ�...
	FOR_LINKMAP( pWorld, vPos, pObj, nRange, CObj::linkDynamic, pMover->GetLayer() )
	{
		if( pObj->GetType() == OT_ITEM )	// ���۸� �˻�
		{
			CItem *pItem = (CItem *)pObj;
			ItemProp* pItemProp	= pItem->GetProp();
			// �̰� ���� ���������� StateIdle ARRIVAL���� DoLoot()�ϰ� �����Ŀ� �ٽ� SubItemLoot()�� ȣ��������
			// Loot�� �������� ���� ���������� ���⼭ �� �˻��� �Ǵ����.. �׷��� �ߺ��Ǵ� �������� �˻� �ȵǰ� ���ĺô�.
//			if( pItem->GetId() != m_idLootItem )		
			if( pItem->IsDelete() == FALSE )
			{
				if( pItemProp )
				{
//			#ifdef __WORLDSERVER
				#ifdef __PETFILTER
					BOOL b1 = TRUE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_HPFOOD) && pItem->GetProp()->dwItemKind2 == IK2_FOOD )
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_MPFOOD) && pItem->GetProp()->dwItemKind3 == IK3_REFRESHER )
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_FPFOOD) && pItem->GetProp()->dwItemKind2 == IK2_POTION)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_FPFOOD) && pItem->GetProp()->dwItemKind1 == IK3_DRINK)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_BWEAPON) && pItem->GetProp()->dwReferStat1 == WEAPON_GENERAL )
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_GWEAPON) && pItem->GetProp()->dwReferStat1 == WEAPON_UNIQUE )
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_GOLD) && pItem->GetProp()->dwReferStat1 == ARMOR_GEN	)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_GSET) && pItem->GetProp()->dwReferStat1 == ARMOR_SET )
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_NECKLACE) && pItem->GetProp()->dwItemKind3 == IK3_NECKLACE )
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_EARRING) && pItem->GetProp()->dwItemKind3 == IK3_EARRING )
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_RING) && pItem->GetProp()->dwItemKind3 == IK3_RING )
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_EGG) && pItem->GetProp()->dwID == II_PET_EGG )
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_SUNSTONE) && pItem->GetProp()->dwID == II_GEN_MAT_ORICHALCUM01)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_SUNSTONE) && pItem->GetProp()->dwID == II_GEN_MAT_ORICHALCUM02)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_SUNSTONE) && pItem->GetProp()->dwID == II_GEN_MAT_ORICHALCUM01_1)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_SUNSTONE) && pItem->GetProp()->dwID == II_SYS_SYS_SCR_SCRAPORICHALCUM)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_MOONSTONE) && pItem->GetProp()->dwID == II_GEN_MAT_MOONSTONE)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_MOONSTONE) && pItem->GetProp()->dwID == II_GEN_MAT_MOONSTONE_1)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_MOONSTONE) && pItem->GetProp()->dwID == II_SYS_SYS_SCR_SCRAPMOONSTONE)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_QUESTITEM) && pItem->GetProp()->dwItemKind2 == IK2_GEM)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_QUESTITEM) && pItem->GetProp()->dwItemKind2 == IK3_GEM)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_ELECARDS) && pItem->GetProp()->dwItemKind3 == IK3_ELECARD )
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_4PCARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_MAGMA)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_4PCARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_FLOOD)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_4PCARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_STORM)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_4PCARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_THUNDER)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_4PCARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_MOUNTAIN)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_7PCARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_EARTHQUAKE)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_7PCARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_LIGHTING)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_7PCARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_VACCUM)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_7PCARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_OCEAN)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_7PCARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_VOLCANO)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_BPIECARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_CANDLEB)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_BPIECARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_RAINATKB)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_BPIECARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_BREEZEATKB)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_BPIECARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_SPARKATKB)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_BPIECARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_SANDATKB)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_APIECARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_SANDATKA)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_APIECARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_SPARKATKA)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_APIECARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_BREEZEATKA)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_APIECARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_RAINATKA)
							b1 = FALSE;
						if( (((CUser*)pOwner)->m_dwPetfilter & FILTER_APIECARD) && pItem->GetProp()->dwID == II_GEN_MAT_ELE_CANDLEA)
							b1 = FALSE;
					

					if( pOwner->IsLoot( pItem, TRUE ) && b1 )// ���õǴ¾��������� �˻���.
#else //__PETFILTER
					if( pOwner->IsLoot( pItem, TRUE) )
#endif //__PETFILTER
	//		#endif
					if( pOwner->IsLoot( pItem, TRUE ) && b1 )	// ���õǴ¾��������� �˻���.
					{
						vDist = pObj->GetPos() - pMover->GetPos();
						fDistSq = D3DXVec3LengthSq( &vDist );		// �Ÿ� ����.
						if( fDistSq < 15 * 15 && fDistSq < fMinDist )	// 10���� �̳���... ���� �Ÿ��� ����� ������ ã��.
							pMinObj = pObj;
					}
				}
			}
		}
	}
	END_LINKMAP

	if( pMinObj )
	{
		// Get object ID of the loot item
		DWORD dwIdLootItem = ((CItem *)pMinObj)->GetId();

		// Get the item obj
		CCtrl *pCtrl = prj.GetCtrl( dwIdLootItem );	

		// if exists...
		if( IsValidObj(pCtrl) )
		{
				MoveToDst( pMinObj->GetPos() );		// ��ǥ������ �̵�.
				m_idLootItem = dwIdLootItem;
				m_bLootMove = TRUE;
		}
	}
		
	return m_bLootMove;
}

BOOL CAIPet::StateInit( const AIMSG & msg )
{
	return TRUE;
}

BOOL CAIPet::MoveProcessIdle( const AIMSG & msg )
{
	CMover *pMover = GetMover();
	CMover *pOwner = prj.GetMover( m_idOwner ); 
	CWorld *pWorld = GetWorld();
	MoverProp *pProp = pMover->GetProp();


	// ������ ���°ų� �׾��� ��� �̵� ó�� ���� ���� 
	if( pMover->IsDie() || (pMover->m_pActMover->GetState() & OBJSTA_DMG_FLY_ALL) )
		return FALSE;

	if( NotOwnedPetInactivated() )
		return FALSE;
	
	if( m_bLootMove == FALSE )	// �����Ϸ� ���� �Ʒ� ó���� �ϸ� �ȵǱ���...
	{
		// ���δ԰��� �Ÿ��� �־����� ���δ������� �޷�����.
		if( m_nState == PETSTATE_IDLE )
		{
			D3DXVECTOR3 vDist = pOwner->GetPos() - pMover->GetPos();
			FLOAT fDistSq = D3DXVec3LengthSq( &vDist );
			if( fDistSq > 1.0f * 1.0f )
			{
				MoveToDst( m_idOwner );
				m_nState = PETSTATE_TRACE;
			}
		} else
		if( m_nState == PETSTATE_TRACE )
		{
			if( pOwner->IsRangeObj( pMover, 0 ) == TRUE )		// ���δ� ������ �ٰ�����.
			{
				m_nState = PETSTATE_IDLE;			// �����·� ��ȯ
				pMover->SendActMsg( OBJMSG_STOP );	// ��� ����
				pMover->ClearDest();				// �̵���ǥ Ŭ����.
			}
			if( pMover->IsEmptyDest() )			// �˼����� ������ ���� �̵����� �ʰ� ���ڸ� ������ .
			{
				m_bLootMove = FALSE;			// ������ ������ ���.
				m_idLootItem = NULL_ID;
				m_nState = PETSTATE_IDLE;
			}
			
		}
	}

	// ������ ��ĵ/����
	{
		{
			if( (pMover->GetCount() & 15) == 0 )		// ������ �ֺ��� ��ĵ�ؼ�... �����ϱ� 15�� 1��
			{	
				if( m_bLootMove == FALSE )		// �����Ϸ� ���� ������ �� üũ�ϸ� �Ȋ�
					if( SubItemLoot() )		// �������� ������.
						m_nState = PETSTATE_IDLE;	// ���ý��������� �����·� �ٲ����.
			}
		}

		if( m_bLootMove == TRUE )
		{
			CCtrl *pCtrl = prj.GetCtrl( m_idLootItem );		// �׾������� ��������� �����ϱ� �˻���.
			if( IsInvalidObj(pCtrl) )		// ������ ������ �̵��߿� ������ ��������
			{
				MoveToDst( pMover->GetPos() );	// ���ڸ��� ��.
				m_bLootMove = FALSE;
				m_idLootItem = NULL_ID;
				m_nState = PETSTATE_IDLE;
			} else
			{
				if( pMover->IsEmptyDest() )			// �˼����� ������ ���� �̵����� �ʰ� ���ڸ� ������ .
				{
					m_bLootMove = FALSE;			// ������ ������ ���.
					m_idLootItem = NULL_ID;
					m_nState = PETSTATE_IDLE;
				}
			}
		}
	}

	return TRUE;
}

BOOL CAIPet::StateIdle( const AIMSG & msg )
{
	CMover* pMover = GetMover();
	CWorld* pWorld = GetWorld();

	BeginAIHandler( )

	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_INIT ) 
//		SetStop( SEC( 0 ) );
	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_INIT_TARGETCLEAR )
//		m_dwIdTarget = NULL_ID;
			
	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_PROCESS ) 
		MoveProcessIdle( msg );

	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_DAMAGE ) 

	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_DIE ) 
		SendAIMsg( AIMSG_EXIT );

	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_COLLISION )

	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_ARRIVAL )
		{
			if( m_bLootMove )	// ������ ���ø�忴��.
			{
				CMover *pOwner = prj.GetMover( m_idOwner );
				if( IsValidObj(pOwner) )
				{
					BOOL bSuccess = FALSE;
					CCtrl *pCtrl = prj.GetCtrl( m_idLootItem );		// �׾������� ��������� �����ϱ� �˻���.
					if( IsValidObj(pCtrl) )
					{
						CItem *pItem = (CItem *)pCtrl;
						D3DXVECTOR3 vDist = pCtrl->GetPos() - pMover->GetPos();
						FLOAT fDistSq = D3DXVec3LengthSq( &vDist );
						if( fDistSq < 5.0f * 5.0f )		// �����ؼ� �Ÿ� �˻� �ѹ��� �ؼ� 
						{
							if( pItem->IsDelete() )
								return TRUE;
							CItemElem* pItemElem = (CItemElem *)pItem->m_pItemBase;
							ItemProp *pItemProp = pItem->GetProp();
							// ������ �������� �ݴ°Ͱ� ���� ȿ���� ��.
							bSuccess = pOwner->DoLoot( pItem );
						}
					}
					if( bSuccess )
					{
						if( SubItemLoot() == FALSE )		// ���������� ������ �ѹ��� ��ĵ�ؼ� ������ ������ �ٽð��� ������ ���ο��� ���ư���.
						{
							m_bLootMove = FALSE;		// this�� ������ �������̶�°� ����.
							m_idLootItem = NULL_ID;
						}
					} else
					{
						m_bLootMove = FALSE;		// this�� ������ �������̶�°� ����.
						m_idLootItem = NULL_ID;
					}
				}
			}
		}
		
	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_EXIT )	

	EndAIHandler( )

	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////



BOOL CAIPet::MoveProcessRage( const AIMSG & msg )
{
	CMover* pMover = GetMover();
	CWorld* pWorld = GetWorld();
	MoverProp *pProp = pMover->GetProp();
	
	// ������ ���°ų� �׾��� ��� �̵� ó�� ���� ���� 
	if( pMover->IsDie() || (pMover->m_pActMover->GetState() & OBJSTA_DMG_FLY_ALL) )
		return FALSE;

	return TRUE;
}

BOOL CAIPet::StateRage( const AIMSG & msg )
{
	CMover* pMover = GetMover();
	CWorld* pWorld = GetWorld();
	if( IsInvalidObj(pMover) )	return FALSE;

	BeginAIHandler( )

	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_INIT ) 

	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_INIT_TARGETCLEAR )		// Ÿ���� Ŭ�����ϰ� ������ ���ư�.
		
	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_PROCESS ) 
		MoveProcessRage( msg );
		
	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_DAMAGE ) 

	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_COLLISION )
	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_DIE ) 
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_DSTDIE ) 
		SendAIMsg( AIMSG_SETSTATE, STATE_IDLE );

	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_BEGINMOVE )

	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_ARRIVAL )

	///////////////////////////////////////////////////////////////////////////////////////////////////
	OnMessage( AIMSG_EXIT )	
//		SendAIMsg( AIMSG_SETPROCESS, FALSE );

	EndAIHandler( )
	
	return TRUE;
}

BOOL CAIPet::NotOwnedPetInactivated( void )
{
	CMover *pEatPet		= GetMover();
	CMover *pOwner	= prj.GetMover( m_idOwner ); 

	if( IsInvalidObj( pOwner ) )
	{
		pEatPet->Delete();
		return TRUE;
	}
	if( pOwner->IsDie() 
		|| !pOwner->IsValidArea( pEatPet, 32 )
	)
	{
		pOwner->InactivateEatPet();
		return TRUE;
	}
	return FALSE;
}

#if __VER >= 12 // __PET_0519
void CAIPet::SetItem( CMover* pPlayer, CItemElem* pItem )
{	// ����ڿ��� ���� ���� ȿ�� ����
	m_idPetItem		= pItem->m_dwObjId;
	pPlayer->SetDestParamRandomOptExtension( pItem );
	SetSkill( pPlayer, pItem->GetProp() );		// ���� ��� �� ����
																		// ������ ���� �۾� �κ��� �����丵�ϸ鼭 �̰����� �̵� ��Ŵ
}

void CAIPet::SetSkill( CMover* pPlayer, ItemProp* Prop )
{	// ���� ��� �� ����
	if( Prop->dwActiveSkill != NULL_ID )
	{
		SetSkillId( Prop->dwActiveSkill );
		pPlayer->DoActiveSkill( Prop->dwActiveSkill, 1, pPlayer );
	}
}

void CAIPet::ResetItem( void )
{	// �������κ��� ���� ���� ȿ�� ����
	CMover* pPlayer		= prj.GetMover( m_idOwner );
	if( IsValidObj( pPlayer ) )
	{
		CItemElem* pItem	= static_cast<CItemElem*>( pPlayer->GetItemId( m_idPetItem ) );
		if( pItem && pItem->IsEatPet() )
		{
			pPlayer->ResetDestParamRandomOptExtension( pItem );
			ResetSkill( pPlayer );	// ��� �� ����
		}
	}
	m_idPetItem		= NULL_ID;
}

void CAIPet::ResetSkill( CMover* pPlayer )
{	// ��� �� ����
	if( GetSkillId() != NULL_ID && pPlayer->HasBuff( BUFF_SKILL, (WORD)( GetSkillId() ) ) )
		pPlayer->RemoveBuff( BUFF_SKILL, (WORD)( GetSkillId() ) );
}
#endif	// __PET_0519