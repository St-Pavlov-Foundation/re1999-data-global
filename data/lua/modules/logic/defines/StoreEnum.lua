﻿module("modules.logic.defines.StoreEnum", package.seeall)

local var_0_0 = _M

var_0_0.ChargeStoreTabId = 410
var_0_0.LimitType = {
	Default = 1,
	Currency = 3,
	CurrencyChanged = 4,
	BuyLimit = 2
}
var_0_0.Discount = {
	Recommend = "101",
	Activity = "103",
	Hot = "102",
	RoomTheme = "106",
	Discount = "3",
	Flash = "104",
	Super = "105"
}
var_0_0.RefreshTime = {
	Day = 1,
	Week = 2,
	Month = 3,
	Forever = 0
}
var_0_0.ChargeRefreshTime = {
	Day = 3,
	Week = 4,
	Month = 5,
	Forever = 1,
	MonthCard = 2,
	Level = 7,
	None = 0
}
var_0_0.LittleMonthCardGoodsId = 811512
var_0_0.StoreId = {
	Charge = 410,
	PubbleCharge = 411,
	EventPackage = 615,
	CritterStore = 173,
	SummonExchange = 110,
	OneTimePackage = 613,
	OldRoomStore = 172,
	WeekWalk = 160,
	LimitStore = 112,
	DecorateStore = 800,
	RecommendPackage = 611,
	Summon = 130,
	RoomStore = 170,
	VersionPackage = 612,
	SummonCost = 118,
	SummonEquipExchange = 150,
	Package = 610,
	RecommendStore = 700,
	NormalPackage = 614,
	NewDecorateStore = 801,
	NewRoomStore = 171,
	OldDecorateStore = 802,
	Skin = 510,
	GlowCharge = 412
}
var_0_0.DefaultTabId = var_0_0.StoreId.RecommendStore
var_0_0.RecommendSubStoreId = {
	StoreRoleSkinView = 801,
	GiftrecommendView1 = 803,
	MonthCardId = 711,
	GiftrecommendView2 = 804,
	BpEnterView = 714,
	StoreBlockPackageView = 802,
	StoreSkinBagView = 721,
	GiftPacksView = 713,
	ChargeView = 712
}
var_0_0.RecommendRelationType = {
	OtherRecommendClose = 3,
	PackageStoreGoodsNoBuy = 6,
	StoreGoods = 5,
	BattlePass = 4,
	Summon = 1,
	PackageStoreGoods = 2
}
var_0_0.AdjustOrderType = {
	MonthCard = 1,
	BattlePass = 2,
	Normal = 0
}
var_0_0.GroupOrderType = {
	GroupC = 3,
	GroupA = 1,
	GroupD = 4,
	GroupB = 2
}
var_0_0.MonthCardGoodsId = 610001
var_0_0.SeasonCardGoodsId = 811532
var_0_0.NewbiePackId = 811461
var_0_0.NormalRoomTicket = 600001
var_0_0.TopRoomTicket = 600002
var_0_0.SummonSimulationPick = "v2a2_03"
var_0_0.MonthCardStatus = {
	NotEnoughOneDay = 0,
	NotEnoughThreeDay = 3,
	NotPurchase = -1
}
var_0_0.Need4RDEpisodeId = 9999
var_0_0.StoreChargeType = {
	DailyReleasePackage = 4,
	Optional = 5,
	MonthCard = 2
}
var_0_0.Prefab = {
	RoomStore = 6,
	ChargeStore = 2,
	PackageStore = 4,
	NormalStore = 1,
	SkinStore = 3
}
var_0_0.BossRushStore = {
	NormalStore = 901,
	ManeTrust = 900,
	UpdateStore = 902
}
var_0_0.TowerStore = {
	UpdateStore = 302,
	NormalStore = 301,
	MainStore = 300
}

return var_0_0
