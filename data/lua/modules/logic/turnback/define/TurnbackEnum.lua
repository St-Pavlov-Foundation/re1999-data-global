module("modules.logic.turnback.define.TurnbackEnum", package.seeall)

return {
	ActivityId = {
		RewardShowView = 104,
		DungeonShowView = 103,
		SignIn = 101,
		RecommendView = 105,
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
	ChannelType = {
		eFun = 2,
		Global = 1,
		KO = 3
	},
	TaskGetAnimTime = 0.5,
	TaskMaskTime = 0.65,
	TaskGetBonusAnimTime = 1.367,
	BonusPointIcon = 31
}
