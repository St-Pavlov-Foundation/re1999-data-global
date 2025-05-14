module("modules.logic.room.define.RoomNavigateBubbleEnum", package.seeall)

local var_0_0 = _M

var_0_0.CategoryType = {
	Factory = 1
}
var_0_0.FactoryBubbleType = {
	FaithFull = 4,
	RoomGift = 5,
	Manufacture = 6,
	ProductProgress = 1,
	Critter = 7,
	FaithReward = 3,
	BuildingUpgrade = 2
}
var_0_0.Bubble2ResPath = {
	[var_0_0.FactoryBubbleType.ProductProgress] = "xw_bubbleicon_8",
	[var_0_0.FactoryBubbleType.BuildingUpgrade] = "xw_bubbleicon_up",
	[var_0_0.FactoryBubbleType.FaithReward] = "xw_bubbleicon_4",
	[var_0_0.FactoryBubbleType.FaithFull] = "xw_bubbleicon_max",
	[var_0_0.FactoryBubbleType.RoomGift] = "xw_bubbleicon_7",
	[var_0_0.FactoryBubbleType.Manufacture] = "xw_bubbleicon_9",
	[var_0_0.FactoryBubbleType.Critter] = "xw_bubbleicon_10"
}
var_0_0.BubbleHideNum = {
	[var_0_0.FactoryBubbleType.BuildingUpgrade] = true,
	[var_0_0.FactoryBubbleType.RoomGift] = true
}
var_0_0.HallId = -1

return var_0_0
