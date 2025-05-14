module("modules.logic.room.define.RoomSceneTaskEnum", package.seeall)

local var_0_0 = _M

var_0_0.ListenerType = {
	EditResTypeReach = "EditMainResBlockCount",
	EditHasResBlockCount = "EditHasResBlockCount",
	BuildingUseCount = "BuildingUseCount",
	RoomLevel = "RoomLevel",
	BuildingDegree = "BuildingDegree",
	EditResArea = "EditBlockCount"
}
var_0_0.TaskSymbolRes = {
	"resource_0",
	"resource_1",
	"resource_2",
	"resource_3",
	"resource_4"
}
var_0_0.AnimName = {
	Play = "switch",
	Hide = "close",
	Show = "open"
}
var_0_0.AnimEventName = {
	PlayFinish = "SwitchFinish",
	ShowFinish = "ShowFinish",
	HideFinish = "CloseFinish"
}
var_0_0.RoomLevelUpItem = 190010

return var_0_0
