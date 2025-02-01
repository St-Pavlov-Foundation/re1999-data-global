module("modules.logic.room.define.RoomNavigateBubbleEnum", package.seeall)

slot0 = _M
slot0.CategoryType = {
	Factory = 1
}
slot0.FactoryBubbleType = {
	FaithFull = 4,
	RoomGift = 5,
	Manufacture = 6,
	ProductProgress = 1,
	Critter = 7,
	FaithReward = 3,
	BuildingUpgrade = 2
}
slot0.Bubble2ResPath = {
	[slot0.FactoryBubbleType.ProductProgress] = "xw_bubbleicon_8",
	[slot0.FactoryBubbleType.BuildingUpgrade] = "xw_bubbleicon_up",
	[slot0.FactoryBubbleType.FaithReward] = "xw_bubbleicon_4",
	[slot0.FactoryBubbleType.FaithFull] = "xw_bubbleicon_max",
	[slot0.FactoryBubbleType.RoomGift] = "xw_bubbleicon_7",
	[slot0.FactoryBubbleType.Manufacture] = "xw_bubbleicon_9",
	[slot0.FactoryBubbleType.Critter] = "xw_bubbleicon_10"
}
slot0.BubbleHideNum = {
	[slot0.FactoryBubbleType.BuildingUpgrade] = true,
	[slot0.FactoryBubbleType.RoomGift] = true
}
slot0.HallId = -1

return slot0
