module("modules.logic.versionactivity1_4.act131.define.Activity131Enum", package.seeall)

local var_0_0 = _M

var_0_0.TaskMOAllFinishId = -100
var_0_0.MinSlideX = 0
var_0_0.MaxSlideX = 1538
var_0_0.SceneMaxX = 21.55
var_0_0.SlideSpeed = 1
var_0_0.MaxShowEpisodeCount = 6
var_0_0.ActivityId = {
	Act131 = 11403
}
var_0_0.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
var_0_0.ElementType = {
	TaskTip = 5,
	General = 2,
	LogEnd = 11,
	LogStart = 10,
	Dialog = 4,
	ChangeScene = 9,
	SetValue = 6,
	UnlockDecrypt = 7,
	Battle = 1,
	Respawn = 3,
	CheckDecrypt = 8
}
var_0_0.EpisodeState = {
	Unfinished = 0,
	Finished = 1
}
var_0_0.GeneralType = {
	Audio = 1,
	Bgm = 0
}
var_0_0.ProgressType = {
	Interact = 1,
	BeforeStory = 0,
	Finished = 3,
	AfterStory = 2
}
var_0_0.dialogType = {
	slector = "slector",
	option = "option",
	talk = "talk",
	dialog = "dialog",
	tip = "tip"
}

return var_0_0
