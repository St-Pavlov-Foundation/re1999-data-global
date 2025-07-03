module("modules.logic.defines.ItemEnum", package.seeall)

local var_0_0 = _M

var_0_0.SubType = {
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
	SelfSelectSix = 65,
	CritterFood = 27,
	SummonSimulationPick = 54,
	CritterSummon = 29,
	RoomTicket = 60,
	AdventureItem = 15,
	SkinTicket = 61,
	InsightItem = 11,
	OptionalGift = 53,
	BreachItem = 13,
	MainSceneSkin = 24,
	CritterIncubate = 30,
	DestinyStoneUp = 64
}
var_0_0.CategoryType = {
	All = 1,
	Equip = 4,
	Antique = 5,
	Material = 2,
	UseType = 3
}
var_0_0.Color = {
	2,
	3,
	4,
	5,
	6
}
var_0_0.ItemIconEffect = {
	["2#1401"] = 1
}
var_0_0.RoomBackpackPropSubType = {
	[var_0_0.SubType.RoomManufactureItem] = true,
	[var_0_0.SubType.RoomManufactureAccelerateItem] = true,
	[var_0_0.SubType.CritterFood] = true,
	[var_0_0.SubType.CritterTrain] = true,
	[var_0_0.SubType.CritterSummon] = true,
	[var_0_0.SubType.CritterIncubate] = true,
	[var_0_0.SubType.CritterAccelerateItem] = true
}
var_0_0.NewbiePackGiftId = 520010
var_0_0.NoExpiredNum = 70128
var_0_0.Tag = {
	PackageSkin = 2,
	SummonSkin = 1
}

return var_0_0
