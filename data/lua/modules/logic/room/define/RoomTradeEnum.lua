module("modules.logic.room.define.RoomTradeEnum", package.seeall)

local var_0_0 = _M

var_0_0.Mode = {
	Wholesale = 2,
	DailyOrder = 1
}
var_0_0.RefreshType = {
	ActiveRefresh = 3,
	DailyRefresh = 1,
	FinishRefresh = 2
}
var_0_0.BarrageType = {
	Dialogue = 2,
	DailyOrder = 3,
	Weather = 1
}
var_0_0.LevelUnlock = {
	GetBouns = 10,
	NewBuilding = 1,
	LevelBonus = 9,
	BuildingMaxLevel = 6,
	CritterIncubate = 12,
	BuildingLevelUp = 13,
	Order = 11,
	TrainsRoundCount = 14,
	BlockMax = 7,
	TransportSystemOpen = 8,
	TrainSlotCount = 4
}
var_0_0.ConstId = {
	DailyHighOrderAddRate = 7,
	DailyOrderFinishMaxCount = 6,
	DialogueBarrageOdds = 9,
	DailyOrderRefreshTime = 4
}
var_0_0.CameraId = 2233
var_0_0.TradeAnim = {
	Swicth = "swicth",
	DailyOrderOpen = "roomdailyorderview_open",
	Unlock = "unlock"
}
var_0_0.TradeDailyOrderAnim = {
	Delivery = "delivery",
	Update = "update",
	Idle = "idle",
	Open = "open"
}
var_0_0.TradeTaskAnim = {
	Swicth = "switch",
	Idle = "idle"
}
var_0_0.GuideUnlock = {
	Summon = 416
}

return var_0_0
