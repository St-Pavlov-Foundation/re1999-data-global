module("modules.logic.versionactivity1_4.act131.define.Activity131Enum", package.seeall)

slot0 = _M
slot0.TaskMOAllFinishId = -100
slot0.MinSlideX = 0
slot0.MaxSlideX = 1538
slot0.SceneMaxX = 21.55
slot0.SlideSpeed = 1
slot0.MaxShowEpisodeCount = 6
slot0.ActivityId = {
	Act131 = 11403
}
slot0.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
slot0.ElementType = {
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
slot0.EpisodeState = {
	Unfinished = 0,
	Finished = 1
}
slot0.GeneralType = {
	Audio = 1,
	Bgm = 0
}
slot0.ProgressType = {
	Interact = 1,
	BeforeStory = 0,
	Finished = 3,
	AfterStory = 2
}
slot0.dialogType = {
	slector = "slector",
	option = "option",
	talk = "talk",
	dialog = "dialog",
	tip = "tip"
}

return slot0
