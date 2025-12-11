module("modules.logic.achievement.define.AchievementEnum", package.seeall)

local var_0_0 = _M

var_0_0.Type = {
	GamePlay = 3,
	Activity = 4,
	Story = 1,
	NamePlate = 5,
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
	[var_0_0.Type.Activity] = "achievement_category_action",
	[var_0_0.Type.NamePlate] = "achievement_category_nameplate"
}
var_0_0.TypeNameEn = {
	[var_0_0.Type.Normal] = "LOG",
	[var_0_0.Type.GamePlay] = "CHALLENGE",
	[var_0_0.Type.Story] = "REVIEW",
	[var_0_0.Type.Activity] = "BROCHURE",
	[var_0_0.Type.NamePlate] = "Plates"
}
var_0_0.GroupParamType = {
	Player = 1,
	List = 2
}
var_0_0.SpGroupType = {
	Tower = 6,
	Journey = 1,
	Room = 3,
	BossRush = 5,
	Explore = 4,
	WeekWalk = 2
}
var_0_0.SpGroupNameLangId = {
	[var_0_0.SpGroupType.Journey] = "achievementmainview_spgroup_journey",
	[var_0_0.SpGroupType.WeekWalk] = "achievementmainview_spgroup_weekwalk",
	[var_0_0.SpGroupType.Room] = "achievementmainview_spgroup_room",
	[var_0_0.SpGroupType.Explore] = "achievementmainview_spgroup_explore",
	[var_0_0.SpGroupType.BossRush] = "achievementmainview_spgroup_bossrush",
	[var_0_0.SpGroupType.Tower] = "achievementmainview_spgroup_tower"
}
var_0_0.SourceType = {
	Tower = 1
}
var_0_0.MainTileGroupItemHeight = 460
var_0_0.MainTileLineItemHeight = 300
var_0_0.SpGroupTitleBarHeight = 74
var_0_0.MainSpGroupLineCount = 5
var_0_0.MainListLineCount = 5
var_0_0.ShowMaxSingleCount = 6
var_0_0.ShowMaxGroupCount = 1
var_0_0.ShowMaxNamePlateCount = 1
var_0_0.ShowMaxToastCount = 10
var_0_0.MainIconPath = "ui/viewres/achievement/achievementmainicon.prefab"
var_0_0.AchievementToastPath = "ui/viewres/achievement/achievementtoastitem.prefab"
var_0_0.AchievementPreViewPrefabPath = "ui/viewres/achievement/grouppreview"

return var_0_0
