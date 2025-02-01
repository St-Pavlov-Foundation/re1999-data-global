module("modules.logic.popup.define.PopupEnum", package.seeall)

slot0 = _M
slot0.PriorityType = {
	GainSkinView = 400,
	RoomBlockPackageGetView = 701,
	DungeonFragmentInfoView = 200,
	CachotTips = 100001,
	CommonPropView = 300,
	SummonResultView = 500,
	SpecialEquipOpenTip = 1,
	CollectionGet = 100002,
	GainCharacterView = 600,
	RoomBuildingGetView = 700,
	AdventureCompleteView = 100
}
slot0.CacheType = {
	Fight = 1,
	Summon = 3,
	Guide = 2
}
slot0.CheckCacheHandler = {
	[slot0.CacheType.Fight] = PopupHelper.checkInFight,
	[slot0.CacheType.Guide] = PopupHelper.checkInGuide,
	[slot0.CacheType.Summon] = PopupHelper.checkInSummonDrawing
}
slot0.CheckCacheGetApproach = {
	[MaterialEnum.GetApproach.Charge] = {
		slot0.CacheType.Fight,
		slot0.CacheType.Guide,
		slot0.CacheType.Summon
	},
	[MaterialEnum.GetApproach.MonthCard] = {
		slot0.CacheType.Fight,
		slot0.CacheType.Guide,
		slot0.CacheType.Summon
	}
}

return slot0
