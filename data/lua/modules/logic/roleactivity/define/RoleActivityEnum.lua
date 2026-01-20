-- chunkname: @modules/logic/roleactivity/define/RoleActivityEnum.lua

module("modules.logic.roleactivity.define.RoleActivityEnum", package.seeall)

local RoleActivityEnum = _M

RoleActivityEnum.AnimEvt = {
	OnGoStoryEnd = "goStoryEnd",
	OnStoryOpenEnd = "storyOpenEnd",
	OnFightOpenEnd = "fightOpenEnd"
}
RoleActivityEnum.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
RoleActivityEnum.LevelView = {
	[VersionActivity1_9Enum.ActivityId.Lucy] = ViewName.ActLucyLevelView,
	[VersionActivity1_9Enum.ActivityId.KaKaNia] = ViewName.ActKaKaNiaLevelView,
	[VersionActivity2_0Enum.ActivityId.Mercuria] = ViewName.ActMercuriaLevelView,
	[VersionActivity2_0Enum.ActivityId.Joe] = ViewName.ActJoeLevelView,
	[VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr] = ViewName.ZhiXinQuanErLevelView,
	[VersionActivity2_3Enum.ActivityId.DuDuGu] = ViewName.ActDuDuGuLevelView,
	[VersionActivity3_0Enum.ActivityId.KaRong] = ViewName.KaRongLevelView,
	[VersionActivity2_4Enum.ActivityId.Pinball] = ViewName.PinballCityView,
	[VersionActivity2_4Enum.ActivityId.MusicGame] = ViewName.VersionActivity2_4MusicChapterView
}

return RoleActivityEnum
