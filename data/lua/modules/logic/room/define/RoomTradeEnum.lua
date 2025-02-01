module("modules.logic.room.define.RoomTradeEnum", package.seeall)

slot0 = _M
slot0.Mode = {
	Wholesale = 2,
	DailyOrder = 1
}
slot0.RefreshType = {
	ActiveRefresh = 3,
	DailyRefresh = 1,
	FinishRefresh = 2
}
slot0.BarrageType = {
	Dialogue = 2,
	DailyOrder = 3,
	Weather = 1
}
slot0.LevelUnlock = {
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
slot0.ConstId = {
	DailyHighOrderAddRate = 7,
	DailyOrderFinishMaxCount = 6,
	DialogueBarrageOdds = 9,
	DailyOrderRefreshTime = 4
}
slot0.CameraId = 2233
slot0.TradeAnim = {
	Swicth = "swicth",
	DailyOrderOpen = "roomdailyorderview_open",
	Unlock = "unlock"
}
slot0.TradeDailyOrderAnim = {
	Delivery = "delivery",
	Update = "update",
	Idle = "idle",
	Open = "open"
}
slot0.TradeTaskAnim = {
	Swicth = "switch",
	Idle = "idle"
}
slot0.GuideUnlock = {
	Summon = 416
}

return slot0
