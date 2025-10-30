module("modules.logic.roleactivity.define.RoleActivityEnum", package.seeall)

local var_0_0 = _M

var_0_0.AnimEvt = {
	OnGoStoryEnd = "goStoryEnd",
	OnStoryOpenEnd = "storyOpenEnd",
	OnFightOpenEnd = "fightOpenEnd"
}
var_0_0.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
var_0_0.LevelView = {
	[VersionActivity1_9Enum.ActivityId.Lucy] = ViewName.ActLucyLevelView,
	[VersionActivity1_9Enum.ActivityId.KaKaNia] = ViewName.ActKaKaNiaLevelView,
	[VersionActivity2_0Enum.ActivityId.Mercuria] = ViewName.ActMercuriaLevelView,
	[VersionActivity2_0Enum.ActivityId.Joe] = ViewName.ActJoeLevelView,
	[VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr] = ViewName.ZhiXinQuanErLevelView,
	[VersionActivity2_3Enum.ActivityId.DuDuGu] = ViewName.ActDuDuGuLevelView,
	[VersionActivity3_0Enum.ActivityId.KaRong] = ViewName.KaRongLevelView
}

return var_0_0
