module("modules.logic.turnback.define.TurnbackEnum", package.seeall)

return {
	ActivityId = {
		SignIn = 101,
		NewSignIn = 106,
		DungeonShowView = 103,
		RewardShowView = 104,
		NewProgressView = 109,
		RecommendView = 105,
		NewRecommendView = 110,
		NewBenfitView = 108,
		NewTaskView = 107,
		TaskView = 102
	},
	TaskLoopType = {
		HalfMonth = 4,
		Day = 1,
		Long = 3,
		Week = 2,
		Custom = 5
	},
	SignInState = {
		CanGet = 1,
		HasGet = 2,
		NotFinish = 0
	},
	SearchState = {
		CanGet = 1,
		HasGet = 2,
		NotFinish = 0
	},
	showInPopup = {
		Hide = 0,
		Show = 1
	},
	type = {
		New = 1,
		Old = 0
	},
	TaskEnum = {
		Online = 2,
		Old = 0,
		New = 1
	},
	DropInfoEnum = {
		Explore = 8,
		WeekWalk = 4,
		Room = 7,
		Guide = 5,
		MainEpisode = 2,
		ActivityTask = 3,
		Tower = 9,
		Permanent = 6,
		MainAct = 1
	},
	DropType = {
		Progress = 1,
		Jump = 2
	},
	ChannelType = {
		eFun = 2,
		Global = 1,
		KO = 3
	},
	TaskGetAnimTime = 0.5,
	TaskMaskTime = 0.65,
	TaskGetBonusAnimTime = 1.367,
	BonusPointIcon = 31,
	RefreshCd = 10,
	FirstSearchTask = 180035,
	LastSearchTask = 180037,
	Level2Count = 3,
	Level3Count = 1,
	ReadTaskId = 180013
}
