AvailDestParam	// 펫 종류 별 능력치 상승 파라미터
{
//	영향		레벨1	레벨2	레벨3	레벨4	레벨5	레벨6	레벨7	레벨8	레벨9	아이템			무버1			무버2			무버3			부화확률
	DST_STR		1	2	4	7	11	16	22	29	37	II_PET_WHITETIGER01	MI_PET_WHITETIGER01	MI_PET_WHITETIGER01_1	MI_PET_WHITETIGER01_2	900
	DST_STA		1	2	4	7	11	16	22	29	37	II_PET_BARBARYLION01	MI_PET_BARBARYLION01	MI_PET_BARBARYLION01_1	MI_PET_BARBARYLION01_2	1100
	DST_DEX		1	2	4	7	11	16	22	29	37	II_PET_RABBIT02		MI_PET_RABBIT02		MI_PET_RABBIT02_1	MI_PET_RABBIT02_2	1300
	DST_INT		1	2	4	7	11	16	22	29	37	II_PET_NINEFOX01	MI_PET_NINEFOX01	MI_PET_NINEFOX01_1	MI_PET_NINEFOX01_2	1675
	DST_ATKPOWER	5	10	20	35	55	80	110	145	185	II_PET_DRAGON01		MI_PET_DRAGON01		MI_PET_DRAGON01_1	MI_PET_DRAGON01_2	1675
	DST_SPEED	1	2	4	7	11	16	22	29	37	II_PET_EAGLE01		MI_PET_EAGLE01		MI_PET_EAGLE01_1	MI_PET_EAGLE01_2	1675
	DST_HP_MAX	91	182	364	637	1001	1456	2002	2639	3367	II_PET_UNICORN01	MI_PET_UNICORN01	MI_PET_UNICORN01_1	MI_PET_UNICORN01_2	1675
}

FeedEnergy	0	// npc를 통한 먹이 생성
{				
//	최소 가격	최대 가격	최소 회복량	최대 회복량
	1	575	          7	 14
	576	823              18	 35
	824	1175		 25	 50
	1176	1680		 36	 71
	1681	2400		 51	102
	2401	3429	  	 73	146
	3430	4899		104	208
	4900	6999		149	297
	7000	9999		213	425
	10000	2147483647	250	500
}				

FeedEnergy	1	// 아이템을 통한 먹이 생성
{				
//	최소 가격	최대 가격	최소 회복량	최대 회복량
	1	575		28    28
	576	823		70    70
	824	1175	       100   100	
	1176	1680	       142   142
	1681	2400	       204   204
	2401	3429	       292   292
	3430	4899	       416   416
	4900	6999	       594   594
	7000	9999           850   850 
	10000	2147483647    1000  1000
}

IncrementExp	// 100,000분의 1 기준			
{	
//	1분당 습득 경험치
	5000	// 5.00%	// D
	2500	// 2.50%	// C
	1250	// 1.25%	// B
	1000	// 1.00%	// A
}

MaxEnergy	// 최대 HP
{
//	HP
	18000	// D
	30000	// C
	42000	// B
	60000	// A
	150000	// S
}

Penalty	// 소환해제 시 패널티
{
	// 경험치(100분율)	// 기력
	0.16			0	// D
	0.08			0	// C
	0.04			0	// B
	0.02			0	// A
	0			0	// S
}