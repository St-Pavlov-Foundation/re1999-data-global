module("modules.logic.versionactivity1_8.weila.define.ActWeilaEnum", package.seeall)

slot0 = _M
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
