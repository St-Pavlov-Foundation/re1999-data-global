module("modules.logic.versionactivity1_6.quniang.define.ActQuNiangEnum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = VersionActivity1_6Enum.ActivityId.Role1
var_0_0.TaskMOAllFinishId = -100
var_0_0.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
var_0_0.AnimEvt = {
	OnGoStoryEnd = "goStoryEnd",
	OnStoryOpenEnd = "storyOpenEnd",
	OnFightOpenEnd = "fightOpenEnd"
}

return var_0_0
