module("modules.logic.versionactivity1_6.getian.define.ActGeTianEnum", package.seeall)

slot0 = _M
slot0.ActivityId = VersionActivity1_6Enum.ActivityId.Role2
slot0.TaskMOAllFinishId = -100
slot0.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
slot0.AnimEvt = {
	OnGoStoryEnd = "goStoryEnd",
	OnStoryOpenEnd = "storyOpenEnd",
	OnFightOpenEnd = "fightOpenEnd"
}

return slot0
