module("modules.logic.achievement.define.AchievementEnum", package.seeall)

slot0 = _M
slot0.Type = {
	GamePlay = 3,
	Story = 1,
	Activity = 4,
	Normal = 2
}
slot0.AchievementType = {
	Group = 2,
	Single = 1
}
slot0.ViewType = {
	Tile = 2,
	List = 1
}
slot0.SortType = {
	RareDown = 2,
	RareUp = 1
}
slot0.SearchFilterType = {
	All = 1,
	Unlocked = 2,
	Locked = 3
}
slot0.AchievementState = {
	Online = 1,
	Offline = 2
}
slot0.ToastType = {
	GroupFinished = 4,
	TaskFinished = 1,
	GroupUnlocked = 2,
	GroupUpgrade = 3
}
slot0.FilterTypeName = {
	[slot0.SearchFilterType.All] = "achievementmainview_filterType_total",
	[slot0.SearchFilterType.Unlocked] = "achievementmainview_filterType_unlocked",
	[slot0.SearchFilterType.Locked] = "achievementmainview_filterType_locked"
}
slot0.TypeName = {
	[slot0.Type.Normal] = "achievement_category_normal",
	[slot0.Type.GamePlay] = "achievement_category_play",
	[slot0.Type.Story] = "achievement_category_story",
	[slot0.Type.Activity] = "achievement_category_action"
}
slot0.TypeNameEn = {
	[slot0.Type.Normal] = "LOG",
	[slot0.Type.GamePlay] = "CHALLENGE",
	[slot0.Type.Story] = "REVIEW",
	[slot0.Type.Activity] = "BROCHURE"
}
slot0.GroupParamType = {
	Player = 1,
	List = 2
}
slot0.MainListLineCount = 5
slot0.ShowMaxSingleCount = 6
slot0.ShowMaxGroupCount = 1
slot0.ShowMaxToastCount = 10
slot0.MainIconPath = "ui/viewres/achievement/achievementmainicon.prefab"
slot0.AchievementToastPath = "ui/viewres/achievement/achievementtoastitem.prefab"
slot0.AchievementPreViewPrefabPath = "ui/viewres/achievement/grouppreview"

return slot0
