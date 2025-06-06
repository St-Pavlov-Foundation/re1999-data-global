﻿module("modules.logic.versionactivity1_4.act130.define.Activity130Enum", package.seeall)

local var_0_0 = _M

var_0_0.TaskMOAllFinishId = -100
var_0_0.MinSlideX = 0
var_0_0.MaxSlideX = 1220
var_0_0.SceneMaxX = 16.4
var_0_0.SlideSpeed = 1
var_0_0.MaxShowEpisodeCount = 5
var_0_0.ActivityId = {
	Act130 = 11402
}
var_0_0.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
var_0_0.ElementType = {
	TaskTip = 5,
	General = 2,
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
var_0_0.lvSceneType = {
	Light = 1,
	Moon = 2
}

return var_0_0
