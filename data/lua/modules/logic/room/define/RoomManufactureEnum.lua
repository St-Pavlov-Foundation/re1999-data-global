module("modules.logic.room.define.RoomManufactureEnum", package.seeall)

local var_0_0 = _M

var_0_0.InvalidBuildingUid = "0"
var_0_0.ConstId = {
	OrderPriceMul = 10,
	CritterMaxMood = 2,
	CultivatingIcon = 9
}
var_0_0.ItemCountY = 36
var_0_0.ItemCountBgY = 37
var_0_0.AudioDelayTime = 0.5
var_0_0.ManufactureState = {
	Stop = 2,
	Running = 1,
	Wait = 0
}
var_0_0.OneKeyType = {
	Customize = 5,
	ShortTime = 1,
	LowQuantity = 3,
	TracedOrder = 4,
	LongTime = 2
}
var_0_0.ManufactureWrongType = {
	LackPreMat = 1,
	NoCritter = 5,
	NoLinkPath = 3,
	WaitPreMat = 4,
	PreMatNotUnlock = 2
}
var_0_0.DefaultPauseIcon = "room_trade_icon_1"
var_0_0.ManufactureWrongDisplay = {
	[var_0_0.ManufactureWrongType.LackPreMat] = {
		jumpDesc = "room_manufacture_jump_add",
		icon = "room_trade_icon_2",
		desc = "room_manufacture_lack_mat"
	},
	[var_0_0.ManufactureWrongType.PreMatNotUnlock] = {
		jumpDesc = "room_manufacture_jump_level_up_unlock",
		icon = "room_trade_icon_2",
		desc = "room_manufacture_lack_mat_level_up"
	},
	[var_0_0.ManufactureWrongType.NoLinkPath] = {
		jumpDesc = "room_manufacture_jump_link_path",
		icon = "room_trade_icon_3",
		desc = "room_manufacture_lack_mat_link_path"
	},
	[var_0_0.ManufactureWrongType.WaitPreMat] = {
		desc = "room_manufacture_wait_mat",
		icon = "room_trade_icon_4"
	},
	[var_0_0.ManufactureWrongType.NoCritter] = {
		jumpDesc = "room_manufacture_jump_place_critter",
		icon = "room_trade_icon_1",
		desc = "room_manufacture_no_critter"
	}
}
var_0_0.WrongTypeHandlerFunc = {
	[var_0_0.ManufactureWrongType.LackPreMat] = ManufactureController._addPreMat,
	[var_0_0.ManufactureWrongType.PreMatNotUnlock] = ManufactureController._lvUpBuilding,
	[var_0_0.ManufactureWrongType.NoLinkPath] = ManufactureController._linPath
}
var_0_0.SlotItemSpace = 10
var_0_0.OverviewSlotItemSpace = 15
var_0_0.FirstSlotPriority = 0
var_0_0.SlotState = {
	Stop = 3,
	Running = 1,
	Wait = 2,
	Complete = 4,
	Locked = 5,
	None = 0
}
var_0_0.SlotOperation = {
	Cancel = 1,
	MoveTop = 4,
	Add = 0,
	MoveBottom = 5
}
var_0_0.RareImageMap = {
	"critter_manufacture_itemquality1",
	"critter_manufacture_itemquality2",
	"critter_manufacture_itemquality3",
	"critter_manufacture_itemquality4",
	"critter_manufacture_itemquality5"
}
var_0_0.TradeLevelUnlock = {
	Trade = 2
}
var_0_0.LuckyItemType = {
	All = 1,
	ItemId = 2
}

return var_0_0
