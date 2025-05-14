module("modules.logic.popup.define.PopupEnum", package.seeall)

local var_0_0 = _M

var_0_0.PriorityType = {
	GainSkinView = 400,
	RoomBlockPackageGetView = 701,
	DungeonFragmentInfoView = 200,
	CachotTips = 100001,
	RoomBuildingGetView = 700,
	SummonResultView = 500,
	ChargeStoreQuickUseTip = 2,
	SpecialEquipOpenTip = 1,
	CollectionGet = 100002,
	GainCharacterView = 600,
	RoomGetCritterView = 801,
	CommonPropView = 300,
	AdventureCompleteView = 100
}
var_0_0.CacheType = {
	Fight = 1,
	Summon = 3,
	Guide = 2
}
var_0_0.CheckCacheHandler = {
	[var_0_0.CacheType.Fight] = PopupHelper.checkInFight,
	[var_0_0.CacheType.Guide] = PopupHelper.checkInGuide,
	[var_0_0.CacheType.Summon] = PopupHelper.checkInSummonDrawing
}
var_0_0.CheckCacheGetApproach = {
	[MaterialEnum.GetApproach.Charge] = {
		var_0_0.CacheType.Fight,
		var_0_0.CacheType.Guide,
		var_0_0.CacheType.Summon
	},
	[MaterialEnum.GetApproach.MonthCard] = {
		var_0_0.CacheType.Fight,
		var_0_0.CacheType.Guide,
		var_0_0.CacheType.Summon
	}
}

return var_0_0
