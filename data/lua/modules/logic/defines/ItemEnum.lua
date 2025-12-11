module("modules.logic.defines.ItemEnum", package.seeall)

local var_0_0 = _M

var_0_0.SubType = {
	RandomGift = 49,
	CommonItem = 14,
	PlayerBg = 21,
	UtmStickers = 33,
	RoomManufactureAccelerateItem = 26,
	SpecifiedGift = 48,
	SkinTicket = 61,
	RoomBlockGift = 66,
	RoomTicket = 60,
	MainSceneSkin = 24,
	FightCard = 67,
	MultipleCoupon = 16,
	FightFloatType = 68,
	CritterAccelerateItem = 34,
	ResonanceItem = 12,
	SummonSimulationPick = 54,
	Portrait = 17,
	SelfSelectSix = 65,
	InsightItem = 11,
	AdventureItem = 15,
	OptionalGift = 53,
	BreachItem = 13,
	CritterIncubate = 30,
	OptionalHeroGift = 52,
	UnlimitedPower = 32,
	DecorateDiscountTicket = 63,
	CritterTrain = 28,
	EquipBreak = 18,
	CommonGift = 50,
	LimitPower = 31,
	RoomManufactureItem = 25,
	RoomBlockGiftNew = 69,
	CritterFood = 27,
	RoomBlockColorGift = 70,
	CritterSummon = 29,
	MainUISkin = 35,
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
