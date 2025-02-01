module("modules.logic.versionactivity1_9.enter.define.VersionActivity1_9Enum", package.seeall)

slot0 = _M
slot0.ActivityId = {
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
slot0.ActLevel = {
	Second = 2,
	First = 1
}
slot0.ActType = {
	Multi = 2,
	Single = 1
}
slot0.EnterViewActIdList = {
	{
		actId = slot0.ActivityId.Dungeon,
		actLevel = slot0.ActLevel.First,
		actType = slot0.ActType.Single,
		storeId = slot0.ActivityId.DungeonStore
	},
	{
		actId = slot0.ActivityId.BossRush,
		actLevel = slot0.ActLevel.Second,
		actType = slot0.ActType.Single
	},
	{
		actId = {
			slot0.ActivityId.RoleStory1,
			slot0.ActivityId.RoleStory2
		},
		actLevel = slot0.ActLevel.Second,
		actType = slot0.ActType.Multi
	},
	{
		actId = slot0.ActivityId.Season,
		actLevel = slot0.ActLevel.Second,
		actType = slot0.ActType.Single,
		storeId = slot0.ActivityId.SeasonStore
	},
	{
		actId = slot0.ActivityId.Lucy,
		actLevel = slot0.ActLevel.Second,
		actType = slot0.ActType.Single,
		redDotUid = slot0.ActivityId.Lucy
	},
	{
		actId = slot0.ActivityId.KaKaNia,
		actLevel = slot0.ActLevel.Second,
		actType = slot0.ActType.Single,
		redDotUid = slot0.ActivityId.KaKaNia
	},
	{
		actId = slot0.ActivityId.Rouge,
		actLevel = slot0.ActLevel.First,
		actType = slot0.ActType.Single
	},
	{
		actId = slot0.ActivityId.Explore3,
		actLevel = slot0.ActLevel.Second,
		actType = slot0.ActType.Single
	}
}
slot0.EnterViewActIdListWithRedDot = {
	slot0.ActivityId.Dungeon,
	slot0.ActivityId.BossRush,
	slot0.ActivityId.RoleStory1,
	slot0.ActivityId.RoleStory2,
	slot0.ActivityId.Season,
	slot0.ActivityId.Lucy,
	slot0.ActivityId.KaKaNia
}
slot0.ActId2ShowReplayBtnDict = {
	[slot0.ActivityId.Dungeon] = true,
	[slot0.ActivityId.BossRush] = false,
	[slot0.ActivityId.RoleStory1] = false,
	[slot0.ActivityId.RoleStory2] = false,
	[slot0.ActivityId.Season] = false,
	[slot0.ActivityId.Lucy] = false,
	[slot0.ActivityId.KaKaNia] = false,
	[slot0.ActivityId.Rouge] = false,
	[slot0.ActivityId.Explore3] = false
}
slot0.AchievementBtnType = {
	Type1 = "#btn_achievementpreview",
	Type2 = "#btn_achievementpreview_rouge"
}
slot0.ActId2ShowAchievementBtnDict = {
	[slot0.ActivityId.Dungeon] = slot0.AchievementBtnType.Type1,
	[slot0.ActivityId.BossRush] = slot0.AchievementBtnType.Type1,
	[slot0.ActivityId.RoleStory1] = slot0.AchievementBtnType.Type1,
	[slot0.ActivityId.RoleStory2] = slot0.AchievementBtnType.Type1,
	[slot0.ActivityId.Season] = slot0.AchievementBtnType.Type1,
	[slot0.ActivityId.Lucy] = slot0.AchievementBtnType.Type1,
	[slot0.ActivityId.KaKaNia] = slot0.AchievementBtnType.Type1,
	[slot0.ActivityId.Rouge] = slot0.AchievementBtnType.Type2,
	[slot0.ActivityId.Explore3] = slot0.AchievementBtnType.Type1
}
slot0.ActId2ShowRemainTimeDict = {
	[slot0.ActivityId.Dungeon] = false,
	[slot0.ActivityId.BossRush] = false,
	[slot0.ActivityId.RoleStory1] = true,
	[slot0.ActivityId.RoleStory2] = true,
	[slot0.ActivityId.Season] = false,
	[slot0.ActivityId.Lucy] = true,
	[slot0.ActivityId.KaKaNia] = true,
	[slot0.ActivityId.Rouge] = false,
	[slot0.ActivityId.Explore3] = false
}
slot0.ActivityNameColor = {
	Select = Color(1, 1, 1, 1),
	UnSelect = Color(0.5529411764705883, 0.5529411764705883, 0.5529411764705883, 1)
}
slot0.ActivityNameFontSize = {
	Select = 42,
	UnSelect = 38
}
slot0.ActivityNameEnFontSize = {
	Select = 14,
	UnSelect = 12
}
slot0.ActId2UnSelectImgPath = {
	[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleunselected.png",
	[slot0.ActivityId.Rouge] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleunselected2.png"
}
slot0.ActId2SelectImgPath = {
	[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleselected.png",
	[slot0.ActivityId.Rouge] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleselected2.png"
}
slot0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
slot0.ScrollTabTopPadding = 16
slot0.RedDotOffsetY = 56
slot0.EnterAnimVideoPath = "videos/1_9_enter.mp4"

return slot0
