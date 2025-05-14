module("modules.logic.room.define.RoomInitBuildingEnum", package.seeall)

local var_0_0 = _M

var_0_0.InitBuildingId = {
	Market = 2,
	Spring = 3,
	BellTower = 1,
	Hall = 0
}
var_0_0.InitRoomSkinId = {
	[var_0_0.InitBuildingId.Hall] = 23100102,
	[var_0_0.InitBuildingId.BellTower] = 23100101,
	[var_0_0.InitBuildingId.Market] = 23100103,
	[var_0_0.InitBuildingId.Spring] = 23100104
}
var_0_0.InitBuildingSkinReddot = {
	[var_0_0.InitBuildingId.Hall] = RedDotEnum.DotNode.RoomInitBuildingHall,
	[var_0_0.InitBuildingId.BellTower] = RedDotEnum.DotNode.RoomInitBuildingBellTower,
	[var_0_0.InitBuildingId.Market] = RedDotEnum.DotNode.RoomInitBuildingMarket,
	[var_0_0.InitBuildingId.Spring] = RedDotEnum.DotNode.RoomInitBuildingSpring
}
var_0_0.CanLevelUpErrorCode = {
	MaxLevel = -1,
	NotEnoughBlock = -3,
	NotEnoughItem = -2
}

return var_0_0
