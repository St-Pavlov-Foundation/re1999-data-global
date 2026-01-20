-- chunkname: @modules/logic/popup/define/PopupEnum.lua

module("modules.logic.popup.define.PopupEnum", package.seeall)

local PopupEnum = _M

PopupEnum.PriorityType = {
	GainSkinView = 400,
	RoomBlockPackageGetView = 701,
	DungeonFragmentInfoView = 200,
	CachotTips = 100001,
	RoomBuildingGetView = 700,
	SummonResultView = 500,
	ChargeStoreQuickUseTip = 2,
	SkinCouponTipView = 399,
	SigninPropView = 1001,
	GainCharacterView = 600,
	SpecialEquipOpenTip = 1,
	RoomGetCritterView = 801,
	CollectionGet = 100002,
	CommonPropView = 300,
	NuoDiKaUnitTip = 100003,
	AdventureCompleteView = 100
}
PopupEnum.CacheType = {
	Fight = 1,
	Summon = 3,
	Guide = 2
}
PopupEnum.CheckCacheHandler = {
	[PopupEnum.CacheType.Fight] = PopupHelper.checkInFight,
	[PopupEnum.CacheType.Guide] = PopupHelper.checkInGuide,
	[PopupEnum.CacheType.Summon] = PopupHelper.checkInSummonDrawing
}
PopupEnum.CheckCacheGetApproach = {
	[MaterialEnum.GetApproach.Charge] = {
		PopupEnum.CacheType.Fight,
		PopupEnum.CacheType.Guide
	},
	[MaterialEnum.GetApproach.MonthCard] = {
		PopupEnum.CacheType.Fight,
		PopupEnum.CacheType.Guide,
		PopupEnum.CacheType.Summon
	}
}

return PopupEnum
