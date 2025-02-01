module("modules.logic.room.define.RoomSceneTaskEnum", package.seeall)

slot0 = _M
slot0.ListenerType = {
	EditResTypeReach = "EditMainResBlockCount",
	EditHasResBlockCount = "EditHasResBlockCount",
	BuildingUseCount = "BuildingUseCount",
	RoomLevel = "RoomLevel",
	BuildingDegree = "BuildingDegree",
	EditResArea = "EditBlockCount"
}
slot0.TaskSymbolRes = {
	"resource_0",
	"resource_1",
	"resource_2",
	"resource_3",
	"resource_4"
}
slot0.AnimName = {
	Play = "switch",
	Hide = "close",
	Show = "open"
}
slot0.AnimEventName = {
	PlayFinish = "SwitchFinish",
	ShowFinish = "ShowFinish",
	HideFinish = "CloseFinish"
}
slot0.RoomLevelUpItem = 190010

return slot0
