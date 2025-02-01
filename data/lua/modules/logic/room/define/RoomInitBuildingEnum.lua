module("modules.logic.room.define.RoomInitBuildingEnum", package.seeall)

slot0 = _M
slot0.InitBuildingId = {
	Market = 2,
	Spring = 3,
	BellTower = 1,
	Hall = 0
}
slot0.InitRoomSkinId = {
	[slot0.InitBuildingId.Hall] = 23100102,
	[slot0.InitBuildingId.BellTower] = 23100101,
	[slot0.InitBuildingId.Market] = 23100103,
	[slot0.InitBuildingId.Spring] = 23100104
}
slot0.InitBuildingSkinReddot = {
	[slot0.InitBuildingId.Hall] = RedDotEnum.DotNode.RoomInitBuildingHall,
	[slot0.InitBuildingId.BellTower] = RedDotEnum.DotNode.RoomInitBuildingBellTower,
	[slot0.InitBuildingId.Market] = RedDotEnum.DotNode.RoomInitBuildingMarket,
	[slot0.InitBuildingId.Spring] = RedDotEnum.DotNode.RoomInitBuildingSpring
}
slot0.CanLevelUpErrorCode = {
	MaxLevel = -1,
	NotEnoughBlock = -3,
	NotEnoughItem = -2
}

return slot0
