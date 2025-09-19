module("modules.logic.versionactivity2_8.molideer.define.MoLiDeErEnum", package.seeall)

local var_0_0 = _M

var_0_0.EventTitleColor = {
	NoComplete = "#DDD9D0",
	Dispatching = "#969696",
	Complete = "#EFE5B6"
}
var_0_0.EventBgColor = {
	Dispatching = "#808080",
	Normal = "#FFFFFF"
}
var_0_0.DispatchState = {
	Finish = 4,
	Dispatch = 2,
	Dispatching = 3,
	Main = 1
}
var_0_0.EventName = {
	3,
	4,
	5
}
var_0_0.ItemType = {
	Passive = 0,
	Initiative = 1
}
var_0_0.BuffType = {
	Passive = 2,
	Initiative = 3,
	Forever = 1
}
var_0_0.EventState = {
	Unlock = 0,
	Complete = 1
}
var_0_0.OptionCostType = {
	Round = 5,
	Execution = 1
}
var_0_0.OptionConditionType = {
	Team = 1,
	Item = 2
}
var_0_0.TeamBuffType = {
	Item = 2
}
var_0_0.LevelItemTitleColor = {
	NoComplete = "#FFFFFF",
	Complete = "#FFF8DA"
}
var_0_0.LevelItemStateNameColor = {
	NoComplete = "#C9EDF6",
	Complete = "#F9F1CC"
}
var_0_0.CostDestColor = {
	NoComplete = "#C9EDF6",
	Complete = "#F9F1CC"
}
var_0_0.ExecutionBuffType = {
	Percent = 2,
	Fixed = 6,
	FixedOther = 4
}
var_0_0.RoundBuffType = {
	Percent = 1,
	Fixed = 5,
	FixedOther = 3
}
var_0_0.AnimationTime = {
	InterludeDuration = 1,
	InterludeCloseDuration = 1.33
}
var_0_0.DelayTime = {
	BlackScreenTime2 = 3,
	NewEventShow = 1.5,
	Close = 0.2,
	BlackEnd = 1.167,
	BlackScreenTime = 4,
	TipHide = 2,
	BlackScreenTime3 = 4,
	TargetFxProgressAdd = 1.5,
	DescTextShowDelay = 0.05,
	DescBtnShowDelay = 0.2,
	TargetFxMove = 0.5,
	FinishEventShow = 1.15,
	ItemHideOrAppear = 0.8
}
var_0_0.OptionRestrictionType = {
	Team = 1,
	Item = 2
}
var_0_0.OptionEffectType = {
	Team = 3,
	Round = 5,
	Item = 2,
	Execution = 1
}
var_0_0.ItemBuffType = {
	ExtraRoundAdd = 12,
	MainRoundAdd = 11
}
var_0_0.TargetType = {
	RoundFinishAny = 4,
	RoundFinishAll = 2
}
var_0_0.AnimName = {
	GameViewEventItemFinish = "finish",
	GameViewEventRoleIn = "in",
	GameViewEventRoleOut = "out",
	EventViewSwitchOpen = "switch",
	InterludeViewClose = "close",
	GameViewEventItemClose = "close",
	GameViewEventTitleIdle = "idle",
	LevelViewOpen = "open",
	LevelPathItemFinished = "finished",
	InterludeViewOpen = "open",
	RoleItemOut = "out",
	GameViewEventItemOpen = "open",
	GameViewEventTitleCount = "count",
	LevelItemFinish = "finish",
	RoleItemIn = "in",
	LevelItemUnlock = "unlock",
	EventViewFinishOpen = "open",
	LevelPathItemFinish = "finish"
}
var_0_0.LevelAnimTime = {
	LevelItemUnlock = 1,
	LevelViewOpen = 0.667,
	LevelItemFinish = 1,
	LevelForceEndBlock = 5
}
var_0_0.LevelState = {
	Unlock = 0,
	Complete = 1
}
var_0_0.EventCenterOffset = {
	X = 0,
	Y = -165
}
var_0_0.EventLinePivot = {
	Appear = 0,
	Fade = 1
}
var_0_0.ProgressChangeType = {
	Percentage = 1,
	Failed = 3,
	Success = 2
}
var_0_0.TargetId = {
	Extra = 2,
	Main = 1
}
var_0_0.ProgressRange = {
	Failed = -1,
	Success = 100
}
var_0_0.TargetConditionState = {
	Shortage = 1,
	Enough = 3,
	Failed = 3,
	Normal = 2
}
var_0_0.TargetTitleColor = {
	[var_0_0.TargetConditionState.Enough] = "#74CE95",
	[var_0_0.TargetConditionState.Normal] = "#EEBF77",
	[var_0_0.TargetConditionState.Shortage] = "#F68D92"
}
var_0_0.TargetDescColor = {
	[var_0_0.ProgressChangeType.Percentage] = "#FFFFFF",
	[var_0_0.ProgressChangeType.Success] = "#EEBF77",
	[var_0_0.ProgressChangeType.Failed] = "#A6ADB0"
}
var_0_0.ResultTargetColor = {
	Fail = "#9B9A98",
	Success = "#CBB980"
}
var_0_0.TeamDispatchState = {
	WithDraw = -1,
	Dispatch = 1,
	Dispatching = 0
}
var_0_0.TargetConditionType = {
	RoundLimitedFinishAll = 2,
	RoundLimitedFinishAny = 4
}
var_0_0.EventLineUnitLength = 27

return var_0_0
