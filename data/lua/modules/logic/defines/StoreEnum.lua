-- chunkname: @modules/logic/defines/StoreEnum.lua

module("modules.logic.defines.StoreEnum", package.seeall)

local StoreEnum = _M

StoreEnum.ChargeStoreTabId = 410
StoreEnum.LimitType = {
	Default = 1,
	Currency = 3,
	CurrencyChanged = 4,
	BuyLimit = 2
}
StoreEnum.Discount = {
	Recommend = "101",
	Activity = "103",
	Hot = "102",
	RoomTheme = "106",
	Discount = "3",
	Flash = "104",
	Super = "105"
}
StoreEnum.RefreshTime = {
	Day = 1,
	Week = 2,
	Month = 3,
	Forever = 0
}
StoreEnum.ChargeRefreshTime = {
	Day = 3,
	Week = 4,
	Month = 5,
	Forever = 1,
	MonthCard = 2,
	Level = 7,
	None = 0
}
StoreEnum.LittleMonthCardGoodsId = 811512
StoreEnum.StoreId = {
	PubbleCharge = 411,
	LimitStore = 112,
	EventPackage = 615,
	CritterStore = 173,
	RecommendPackage = 611,
	OneTimePackage = 613,
	OldRoomStore = 172,
	WeekWalk = 160,
	RoomFishingStore = 190,
	SummonExchange = 110,
	Charge = 410,
	DecorateStore = 800,
	MediciPackage = 616,
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
StoreEnum.DefaultTabId = StoreEnum.StoreId.RecommendStore
StoreEnum.RecommendPackageStoreIdList = {
	StoreEnum.StoreId.VersionPackage,
	StoreEnum.StoreId.OneTimePackage,
	StoreEnum.StoreId.NormalPackage,
	StoreEnum.StoreId.EventPackage,
	StoreEnum.StoreId.MediciPackage
}
StoreEnum.RecommendSubStoreId = {
	StoreRoleSkinView = 801,
	SummonSimulationPick = 822,
	GiftrecommendView1 = 803,
	MonthCardId = 711,
	GiftrecommendView2 = 804,
	BpEnterView = 714,
	StoreBlockPackageView = 802,
	New6StarsChoose = 816,
	StoreSkinBagView = 721,
	GiftPacksView = 713,
	ChargeView = 712
}
StoreEnum.RecommendRelationType = {
	OtherRecommendClose = 3,
	PackageStoreGoodsNoBuy = 6,
	StoreGoods = 5,
	BattlePass = 4,
	Summon = 1,
	PackageStoreGoods = 2
}
StoreEnum.AdjustOrderType = {
	MonthCard = 1,
	BattlePass = 2,
	SeasonCard = 3,
	Normal = 0
}
StoreEnum.GroupOrderType = {
	GroupC = 3,
	GroupA = 1,
	GroupD = 4,
	GroupB = 2
}
StoreEnum.MonthCardGoodsId = 610001
StoreEnum.SeasonCardGoodsId = 832004
StoreEnum.SupplementMonthCardItemId = 2929001
StoreEnum.V3a2_SummonSimulationPickItemId = 832005
StoreEnum.NewbiePackId = 811461
StoreEnum.NormalRoomTicket = 600001
StoreEnum.TopRoomTicket = 600002
StoreEnum.SummonSimulationPick = "v2a2_03"
StoreEnum.SummonSimulationPick2 = "v3a2_01"
StoreEnum.MonthCardStatus = {
	NotEnoughOneDay = 0,
	NotEnoughThreeDay = 3,
	NotPurchase = -1
}
StoreEnum.Need4RDEpisodeId = 9999
StoreEnum.StoreChargeType = {
	LinkGiftGoods = 8,
	DailyReleasePackage = 4,
	NationalGift = 9,
	MonthCard = 2,
	Optional = 5
}
StoreEnum.Prefab = {
	RoomStore = 6,
	ChargeStore = 2,
	PackageStore = 4,
	NormalStore = 1,
	SkinStore = 3
}
StoreEnum.BossRushStore = {
	NormalStore = 901,
	ManeTrust = 900,
	UpdateStore = 902
}
StoreEnum.TowerStore = {
	UpdateStore = 302,
	NormalStore = 301,
	MainStore = 300
}
StoreEnum.StoreTabId = {
	Skin = 500
}
StoreEnum.StoreId2TabId = {
	[StoreEnum.StoreId.Skin] = StoreEnum.StoreTabId.Skin
}
StoreEnum.chargeOptionalType = {
	GroupOption = 1,
	PosOption = 0
}

return StoreEnum
