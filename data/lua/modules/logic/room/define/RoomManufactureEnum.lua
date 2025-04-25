module("modules.logic.room.define.RoomManufactureEnum", package.seeall)

slot0 = _M
slot0.InvalidBuildingUid = "0"
slot0.ConstId = {
	OrderPriceMul = 10,
	CritterMaxMood = 2,
	CultivatingIcon = 9
}
slot0.ItemCountY = 36
slot0.ItemCountBgY = 37
slot0.AudioDelayTime = 0.5
slot0.ManufactureState = {
	Stop = 2,
	Running = 1,
	Wait = 0
}
slot0.OneKeyType = {
	Customize = 5,
	ShortTime = 1,
	LowQuantity = 3,
	TracedOrder = 4,
	LongTime = 2
}
slot0.ManufactureWrongType = {
	LackPreMat = 1,
	NoCritter = 5,
	NoLinkPath = 3,
	WaitPreMat = 4,
	PreMatNotUnlock = 2
}
slot0.DefaultPauseIcon = "room_trade_icon_1"
slot0.ManufactureWrongDisplay = {
	[slot0.ManufactureWrongType.LackPreMat] = {
		jumpDesc = "room_manufacture_jump_add",
		icon = "room_trade_icon_2",
		desc = "room_manufacture_lack_mat"
	},
	[slot0.ManufactureWrongType.PreMatNotUnlock] = {
		jumpDesc = "room_manufacture_jump_level_up_unlock",
		icon = "room_trade_icon_2",
		desc = "room_manufacture_lack_mat_level_up"
	},
	[slot0.ManufactureWrongType.NoLinkPath] = {
		jumpDesc = "room_manufacture_jump_link_path",
		icon = "room_trade_icon_3",
		desc = "room_manufacture_lack_mat_link_path"
	},
	[slot0.ManufactureWrongType.WaitPreMat] = {
		desc = "room_manufacture_wait_mat",
		icon = "room_trade_icon_4"
	},
	[slot0.ManufactureWrongType.NoCritter] = {
		jumpDesc = "room_manufacture_jump_place_critter",
		icon = "room_trade_icon_1",
		desc = "room_manufacture_no_critter"
	}
}
slot0.WrongTypeHandlerFunc = {
	[slot0.ManufactureWrongType.LackPreMat] = ManufactureController._addPreMat,
	[slot0.ManufactureWrongType.PreMatNotUnlock] = ManufactureController._lvUpBuilding,
	[slot0.ManufactureWrongType.NoLinkPath] = ManufactureController._linPath
}
slot0.SlotItemSpace = 10
slot0.OverviewSlotItemSpace = 15
slot0.FirstSlotPriority = 0
slot0.SlotState = {
	Stop = 3,
	Running = 1,
	Wait = 2,
	Complete = 4,
	Locked = 5,
	None = 0
}
slot0.SlotOperation = {
	Cancel = 1,
	MoveTop = 4,
	Add = 0,
	MoveBottom = 5
}
slot0.RareImageMap = {
	"critter_manufacture_itemquality1",
	"critter_manufacture_itemquality2",
	"critter_manufacture_itemquality3",
	"critter_manufacture_itemquality4",
	"critter_manufacture_itemquality5"
}
slot0.TradeLevelUnlock = {
	Trade = 2
}
slot0.LuckyItemType = {
	All = 1,
	ItemId = 2
}

return slot0
