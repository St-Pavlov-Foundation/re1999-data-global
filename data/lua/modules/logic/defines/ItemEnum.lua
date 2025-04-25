module("modules.logic.defines.ItemEnum", package.seeall)

slot0 = _M
slot0.SubType = {
	RandomGift = 49,
	OptionalHeroGift = 52,
	PlayerBg = 21,
	UnlimitedPower = 32,
	RoomManufactureAccelerateItem = 26,
	UtmStickers = 33,
	SpecifiedGift = 48,
	DecorateDiscountTicket = 63,
	CritterTrain = 28,
	EquipBreak = 18,
	CommonItem = 14,
	MultipleCoupon = 16,
	LimitPower = 31,
	CritterAccelerateItem = 34,
	ResonanceItem = 12,
	RoomManufactureItem = 25,
	Portrait = 17,
	CommonGift = 50,
	InsightItem = 11,
	CritterFood = 27,
	SummonSimulationPick = 54,
	CritterSummon = 29,
	RoomTicket = 60,
	AdventureItem = 15,
	SkinTicket = 61,
	MainSceneSkin = 24,
	OptionalGift = 53,
	BreachItem = 13,
	CritterIncubate = 30
}
slot0.CategoryType = {
	All = 1,
	Equip = 4,
	Antique = 5,
	Material = 2,
	UseType = 3
}
slot0.Color = {
	2,
	3,
	4,
	5,
	6
}
slot0.ItemIconEffect = {
	["2#1401"] = 1
}
slot0.RoomBackpackPropSubType = {
	[slot0.SubType.RoomManufactureItem] = true,
	[slot0.SubType.RoomManufactureAccelerateItem] = true,
	[slot0.SubType.CritterFood] = true,
	[slot0.SubType.CritterTrain] = true,
	[slot0.SubType.CritterSummon] = true,
	[slot0.SubType.CritterIncubate] = true,
	[slot0.SubType.CritterAccelerateItem] = true
}
slot0.NewbiePackGiftId = 520010
slot0.NoExpiredNum = 70128
slot0.Tag = {
	PackageSkin = 2,
	SummonSkin = 1
}

return slot0
