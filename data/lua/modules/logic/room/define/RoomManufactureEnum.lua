module("modules.logic.room.define.RoomManufactureEnum", package.seeall)

slot0 = _M
slot0.InvalidBuildingUid = "0"
slot0.ConstId = {
	CultivatingIcon = 9,
	CritterMaxMood = 2
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
	LowQuantity = 3,
	ShortTime = 1,
	LongTime = 2
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

return slot0
