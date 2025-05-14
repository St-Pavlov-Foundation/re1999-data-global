﻿module("modules.logic.achievement.define.AchievementEnum", package.seeall)

local var_0_0 = _M

var_0_0.Type = {
	GamePlay = 3,
	Story = 1,
	Activity = 4,
	Normal = 2
}
var_0_0.AchievementType = {
	Group = 2,
	Single = 1
}
var_0_0.ViewType = {
	Tile = 2,
	List = 1
}
var_0_0.SortType = {
	RareDown = 2,
	RareUp = 1
}
var_0_0.SearchFilterType = {
	All = 1,
	Unlocked = 2,
	Locked = 3
}
var_0_0.AchievementState = {
	Online = 1,
	Offline = 2
}
var_0_0.ToastType = {
	GroupFinished = 4,
	TaskFinished = 1,
	GroupUnlocked = 2,
	GroupUpgrade = 3
}
var_0_0.FilterTypeName = {
	[var_0_0.SearchFilterType.All] = "achievementmainview_filterType_total",
	[var_0_0.SearchFilterType.Unlocked] = "achievementmainview_filterType_unlocked",
	[var_0_0.SearchFilterType.Locked] = "achievementmainview_filterType_locked"
}
var_0_0.TypeName = {
	[var_0_0.Type.Normal] = "achievement_category_normal",
	[var_0_0.Type.GamePlay] = "achievement_category_play",
	[var_0_0.Type.Story] = "achievement_category_story",
	[var_0_0.Type.Activity] = "achievement_category_action"
}
var_0_0.TypeNameEn = {
	[var_0_0.Type.Normal] = "LOG",
	[var_0_0.Type.GamePlay] = "CHALLENGE",
	[var_0_0.Type.Story] = "REVIEW",
	[var_0_0.Type.Activity] = "BROCHURE"
}
var_0_0.GroupParamType = {
	Player = 1,
	List = 2
}
var_0_0.MainListLineCount = 5
var_0_0.ShowMaxSingleCount = 6
var_0_0.ShowMaxGroupCount = 1
var_0_0.ShowMaxToastCount = 10
var_0_0.MainIconPath = "ui/viewres/achievement/achievementmainicon.prefab"
var_0_0.AchievementToastPath = "ui/viewres/achievement/achievementtoastitem.prefab"
var_0_0.AchievementPreViewPrefabPath = "ui/viewres/achievement/grouppreview"

return var_0_0
