module("modules.logic.versionactivity1_6.quniang.define.ActQuNiangEnum", package.seeall)

slot0 = _M
slot0.ActivityId = VersionActivity1_6Enum.ActivityId.Role1
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
