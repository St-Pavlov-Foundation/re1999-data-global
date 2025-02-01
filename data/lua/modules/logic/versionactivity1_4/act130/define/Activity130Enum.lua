module("modules.logic.versionactivity1_4.act130.define.Activity130Enum", package.seeall)

slot0 = _M
slot0.TaskMOAllFinishId = -100
slot0.MinSlideX = 0
slot0.MaxSlideX = 1220
slot0.SceneMaxX = 16.4
slot0.SlideSpeed = 1
slot0.MaxShowEpisodeCount = 5
slot0.ActivityId = {
	Act130 = 11402
}
slot0.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
slot0.ElementType = {
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
slot0.lvSceneType = {
	Light = 1,
	Moon = 2
}

return slot0
