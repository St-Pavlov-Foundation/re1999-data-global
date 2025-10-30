module("modules.logic.commandstation.define.CommandStationEnum", package.seeall)

local var_0_0 = _M

var_0_0.EventType = {
	Dialogue = 3,
	Dispatch = 4,
	Normal = 2,
	Main = 1
}
var_0_0.EventCategory = {
	Character = 1,
	Normal = 2
}
var_0_0.DispatchTabView = {
	Process = 2,
	Normal = 1
}
var_0_0.EventState = {
	NotDispatch = -1,
	GetReward = 1
}
var_0_0.DispatchState = {
	NotStart = 1,
	Completed = 3,
	GetReward = 4,
	InProgress = 2
}
var_0_0.EventCategoryKey = {
	Character = "chaEventId",
	Normal = "eventId"
}
var_0_0.DialogueType = {
	Click = 3,
	Enter = 1,
	Idle = 2
}
var_0_0.ConstId = {
	ChapterList = 1,
	ActParam2 = 5,
	VersionEndDt = 3,
	ActParam = 2,
	VersionName = 4
}
var_0_0.PrefsKey = {
	Version = 3,
	NewMapTip = 1,
	DungeonMapLoopEffect = 4,
	DungeonMapLightEffect = 5,
	TimeId = 2
}
var_0_0.TaskType = {
	Catch = 2,
	Normal = 1
}
var_0_0.TaskShowType = {
	Parade = 1,
	Overseas = 2,
	Normal = 0
}
var_0_0.FirstEpisodeId = 11101
var_0_0.CameraFov = 21
var_0_0.CameraRotation = -35
var_0_0.CameraRotaionMax = -90
var_0_0.TimelineOpenTime = 1
var_0_0.TimelineCloseTime = 0.5
var_0_0.TimeItemDelay = 0.03
var_0_0.BuoyMoveTime = 0.5
var_0_0.AllVersion = 1
var_0_0.FirstTimeId = 100
var_0_0.DispatchCharacterNum = 4
var_0_0.TimeItemWidth = 68
var_0_0.TimeItemSpace = 48
var_0_0.ClickOffset = 30
var_0_0.ConstId_CurVersion = 300
var_0_0.ConstId_PaperItemId = 299

return var_0_0
