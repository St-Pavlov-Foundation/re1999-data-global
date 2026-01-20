-- chunkname: @modules/logic/turnback/define/TurnbackEnum.lua

module("modules.logic.turnback.define.TurnbackEnum", package.seeall)

local TurnbackEnum = {}

TurnbackEnum.ActivityId = {
	Turnback3SignInView = 111,
	NewSignIn = 106,
	DungeonShowView = 103,
	RewardShowView = 104,
	NewProgressView = 109,
	RecommendView = 105,
	Turnback3ProgressView = 115,
	SignIn = 101,
	Turnback3DoubleView = 113,
	NewBenfitView = 108,
	Turnback3BPView = 112,
	NewTaskView = 107,
	ReviewView = 110,
	Turnback3ReviewView = 116,
	TaskView = 102,
	Turnback3StoreView = 114
}
TurnbackEnum.TaskLoopType = {
	HalfMonth = 4,
	Day = 1,
	Long = 3,
	Week = 2,
	Custom = 5
}
TurnbackEnum.SignInState = {
	CanGet = 1,
	HasGet = 2,
	NotFinish = 0
}
TurnbackEnum.SearchState = {
	CanGet = 1,
	HasGet = 2,
	NotFinish = 0
}
TurnbackEnum.showInPopup = {
	Hide = 0,
	Show = 1
}
TurnbackEnum.type = {
	New = 1,
	Old = 0
}
TurnbackEnum.TaskEnum = {
	Online = 2,
	Old = 0,
	New = 1
}
TurnbackEnum.DropInfoEnum = {
	Explore = 8,
	WeekWalk = 4,
	Room = 7,
	Guide = 5,
	MainEpisode = 2,
	ActivityTask = 3,
	Tower = 9,
	Permanent = 6,
	MainAct = 1
}
TurnbackEnum.DropType = {
	Progress = 1,
	Jump = 2
}
TurnbackEnum.ChannelType = {
	eFun = 2,
	Global = 1,
	KO = 3
}
TurnbackEnum.BpBtn = {
	Bonus = 1,
	Task = 2
}
TurnbackEnum.TaskGetAnimTime = 0.5
TurnbackEnum.TaskGetAllAnimTime = 0.4
TurnbackEnum.TaskMaskTime = 0.65
TurnbackEnum.itemUptime = 0.15
TurnbackEnum.TaskGetBonusAnimTime = 1.367
TurnbackEnum.BonusPointIcon = 31
TurnbackEnum.RefreshCd = 10
TurnbackEnum.FirstSearchTask = 180035
TurnbackEnum.LastSearchTask = 180037
TurnbackEnum.Level2Count = 3
TurnbackEnum.Level3Count = 1
TurnbackEnum.ReadTaskId = 180013
TurnbackEnum.Version2ProgressId = {
	[2] = 180013,
	[3] = 180053
}
TurnbackEnum.SwapIndex = -1

return TurnbackEnum
