module("modules.logic.versionactivity1_9.enter.define.VersionActivity1_9Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	Warmup = 11720,
	BossRush = 11910,
	RoleStory1 = 11911,
	ToughBattle = 11905,
	Season = 11906,
	DoubleDrop = 11714,
	KaKaNia = 11909,
	Explore3 = 11922,
	RoleStory2 = 11912,
	DungeonStore = 11903,
	Lucy = 11908,
	Dungeon = 11902,
	SeasonStore = 11907,
	EnterView = 11901,
	Rouge = 11920
}
var_0_0.ActLevel = {
	Second = 2,
	First = 1
}
var_0_0.ActType = {
	Multi = 2,
	Single = 1
}
var_0_0.EnterViewActIdList = {
	{
		actId = var_0_0.ActivityId.Dungeon,
		actLevel = var_0_0.ActLevel.First,
		actType = var_0_0.ActType.Single,
		storeId = var_0_0.ActivityId.DungeonStore
	},
	{
		actId = var_0_0.ActivityId.BossRush,
		actLevel = var_0_0.ActLevel.Second,
		actType = var_0_0.ActType.Single
	},
	{
		actId = {
			var_0_0.ActivityId.RoleStory1,
			var_0_0.ActivityId.RoleStory2
		},
		actLevel = var_0_0.ActLevel.Second,
		actType = var_0_0.ActType.Multi
	},
	{
		actId = var_0_0.ActivityId.Season,
		actLevel = var_0_0.ActLevel.Second,
		actType = var_0_0.ActType.Single,
		storeId = var_0_0.ActivityId.SeasonStore
	},
	{
		actId = var_0_0.ActivityId.Lucy,
		actLevel = var_0_0.ActLevel.Second,
		actType = var_0_0.ActType.Single,
		redDotUid = var_0_0.ActivityId.Lucy
	},
	{
		actId = var_0_0.ActivityId.KaKaNia,
		actLevel = var_0_0.ActLevel.Second,
		actType = var_0_0.ActType.Single,
		redDotUid = var_0_0.ActivityId.KaKaNia
	},
	{
		actId = var_0_0.ActivityId.Rouge,
		actLevel = var_0_0.ActLevel.First,
		actType = var_0_0.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.Explore3,
		actLevel = var_0_0.ActLevel.Second,
		actType = var_0_0.ActType.Single
	}
}
var_0_0.EnterViewActIdListWithRedDot = {
	var_0_0.ActivityId.Dungeon,
	var_0_0.ActivityId.BossRush,
	var_0_0.ActivityId.RoleStory1,
	var_0_0.ActivityId.RoleStory2,
	var_0_0.ActivityId.Season,
	var_0_0.ActivityId.Lucy,
	var_0_0.ActivityId.KaKaNia
}
var_0_0.ActId2ShowReplayBtnDict = {
	[var_0_0.ActivityId.Dungeon] = true,
	[var_0_0.ActivityId.BossRush] = false,
	[var_0_0.ActivityId.RoleStory1] = false,
	[var_0_0.ActivityId.RoleStory2] = false,
	[var_0_0.ActivityId.Season] = false,
	[var_0_0.ActivityId.Lucy] = false,
	[var_0_0.ActivityId.KaKaNia] = false,
	[var_0_0.ActivityId.Rouge] = false,
	[var_0_0.ActivityId.Explore3] = false
}
var_0_0.AchievementBtnType = {
	Type1 = "#btn_achievementpreview",
	Type2 = "#btn_achievementpreview_rouge"
}
var_0_0.ActId2ShowAchievementBtnDict = {
	[var_0_0.ActivityId.Dungeon] = var_0_0.AchievementBtnType.Type1,
	[var_0_0.ActivityId.BossRush] = var_0_0.AchievementBtnType.Type1,
	[var_0_0.ActivityId.RoleStory1] = var_0_0.AchievementBtnType.Type1,
	[var_0_0.ActivityId.RoleStory2] = var_0_0.AchievementBtnType.Type1,
	[var_0_0.ActivityId.Season] = var_0_0.AchievementBtnType.Type1,
	[var_0_0.ActivityId.Lucy] = var_0_0.AchievementBtnType.Type1,
	[var_0_0.ActivityId.KaKaNia] = var_0_0.AchievementBtnType.Type1,
	[var_0_0.ActivityId.Rouge] = var_0_0.AchievementBtnType.Type2,
	[var_0_0.ActivityId.Explore3] = var_0_0.AchievementBtnType.Type1
}
var_0_0.ActId2ShowRemainTimeDict = {
	[var_0_0.ActivityId.Dungeon] = false,
	[var_0_0.ActivityId.BossRush] = false,
	[var_0_0.ActivityId.RoleStory1] = true,
	[var_0_0.ActivityId.RoleStory2] = true,
	[var_0_0.ActivityId.Season] = false,
	[var_0_0.ActivityId.Lucy] = true,
	[var_0_0.ActivityId.KaKaNia] = true,
	[var_0_0.ActivityId.Rouge] = false,
	[var_0_0.ActivityId.Explore3] = false
}
var_0_0.ActivityNameColor = {
	Select = Color(1, 1, 1, 1),
	UnSelect = Color(0.5529411764705883, 0.5529411764705883, 0.5529411764705883, 1)
}
var_0_0.ActivityNameFontSize = {
	Select = 42,
	UnSelect = 38
}
var_0_0.ActivityNameEnFontSize = {
	Select = 14,
	UnSelect = 12
}
var_0_0.ActId2UnSelectImgPath = {
	[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleunselected.png",
	[var_0_0.ActivityId.Rouge] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleunselected2.png"
}
var_0_0.ActId2SelectImgPath = {
	[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleselected.png",
	[var_0_0.ActivityId.Rouge] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleselected2.png"
}
var_0_0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
var_0_0.ScrollTabTopPadding = 16
var_0_0.RedDotOffsetY = 56
var_0_0.EnterAnimVideoPath = "videos/1_9_enter.mp4"

return var_0_0
