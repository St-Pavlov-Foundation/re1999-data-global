module("modules.logic.sp01.act204.define.Activity204Enum", package.seeall)

local var_0_0 = _M

var_0_0.VoiceType = {
	EnterView = 1,
	UpdateMainTask = 3,
	ClickSkin = 2
}
var_0_0.LocalPrefsKey = {
	MainActivityStageAnim = "MainActivityStageAnim",
	Question = "Question",
	GameMark = "GameMark",
	FirstEnterView = "Activity205FirstEnterView",
	SignMark = "SignMark",
	AvgMark = "Activity205AvgMark"
}
var_0_0.ConstId = {
	DailyStoneCount = 3,
	CurrencyId = 1,
	BubbleActIds = 4
}
var_0_0.RewardStatus = {
	Canget = 2,
	Hasget = 3,
	None = 1
}
var_0_0.TaskStatus = {
	None = 2,
	Hasget = 3,
	Canget = 1
}
var_0_0.EntranceIdList = {
	ActivityEnum.Activity.V2a9_LoginSign,
	ActivityEnum.Activity.V2a9_Act205,
	ActivityEnum.Activity.V2a9_AssassinChase,
	ActivityEnum.Activity.V2a9_Act204
}
var_0_0.ActId2EntranceCls = {
	[ActivityEnum.Activity.V2a9_Act204] = Activity204TaskEntranceItem,
	[ActivityEnum.Activity.V2a9_Act205] = Activity204OceanEntranceItem,
	[ActivityEnum.Activity.V2a9_LoginSign] = Activity204EntranceItemBase,
	[ActivityEnum.Activity.V2a9_AssassinChase] = Activity204ChaseEntranceItem
}
var_0_0.ActId2ViewList = {
	[ActivityEnum.Activity.V2a9_Act204] = {
		ViewName.Activity204TaskView
	},
	[ActivityEnum.Activity.V2a9_Act205] = {
		ViewName.Act205OceanSelectView,
		ViewName.Act205OceanShowView,
		ViewName.Act205OceanResultView,
		ViewName.Act205GameStartView,
		ViewName.Act205CardSelectView,
		ViewName.Act205CardShowView,
		ViewName.Act205CardResultView
	},
	[ActivityEnum.Activity.V2a9_LoginSign] = {},
	[ActivityEnum.Activity.V2a9_AssassinChase] = {}
}
var_0_0.Act205StageView = {
	{
		ViewName.Act205CardSelectView,
		ViewName.Act205CardShowView,
		ViewName.Act205CardResultView
	},
	{
		ViewName.Act205OceanSelectView,
		ViewName.Act205OceanShowView,
		ViewName.Act205OceanResultView
	}
}
var_0_0.LoginSignSpDayIndex = {
	nil,
	true,
	nil,
	nil,
	true,
	nil,
	true
}
var_0_0.RolePath = "rolesstory/rolesprefab/s01_302804_apple_p/302804_apple_p.prefab"

return var_0_0
