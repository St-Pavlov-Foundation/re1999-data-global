module("modules.logic.versionactivity1_7.enter.define.VersionActivity1_7Enum", package.seeall)

slot0 = _M
slot0.ActivityId = {
	Warmup = 11720,
	BossRush = 11704,
	RoleStory1 = 11715,
	DoubleDrop = 11714,
	Season = 11700,
	Marcus = 11707,
	Reactivity = 11208,
	ReactivityStore = 11713,
	RoleStory2 = 11716,
	Isolde = 11706,
	DungeonStore = 11703,
	Dungeon = 11702,
	SeasonStore = 11705,
	EnterView = 11701
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
		actId = slot0.ActivityId.Isolde,
		actLevel = slot0.ActLevel.Second,
		actType = slot0.ActType.Single,
		redDotUid = slot0.ActivityId.Isolde
	},
	{
		actId = slot0.ActivityId.Marcus,
		actLevel = slot0.ActLevel.Second,
		actType = slot0.ActType.Single,
		redDotUid = slot0.ActivityId.Marcus
	},
	{
		actId = slot0.ActivityId.BossRush,
		actLevel = slot0.ActLevel.Second,
		actType = slot0.ActType.Single
	},
	{
		actId = slot0.ActivityId.Reactivity,
		actLevel = slot0.ActLevel.Second,
		actType = slot0.ActType.Single,
		storeId = slot0.ActivityId.ReactivityStore
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
	}
}
slot0.EnterViewActIdListWithRedDot = {
	slot0.ActivityId.Dungeon,
	slot0.ActivityId.Isolde,
	slot0.ActivityId.Marcus,
	slot0.ActivityId.BossRush,
	slot0.ActivityId.Reactivity,
	slot0.ActivityId.RoleStory1,
	slot0.ActivityId.RoleStory2,
	slot0.ActivityId.Season
}
slot0.ActId2ShowReplayBtnDict = {
	[slot0.ActivityId.Dungeon] = true,
	[slot0.ActivityId.Isolde] = false,
	[slot0.ActivityId.Marcus] = false,
	[slot0.ActivityId.BossRush] = false,
	[slot0.ActivityId.Reactivity] = false,
	[slot0.ActivityId.RoleStory1] = false,
	[slot0.ActivityId.RoleStory2] = false,
	[slot0.ActivityId.Season] = false
}
slot0.ActId2ShowAchievementBtnDict = {
	[slot0.ActivityId.Dungeon] = true,
	[slot0.ActivityId.Isolde] = true,
	[slot0.ActivityId.Marcus] = true,
	[slot0.ActivityId.BossRush] = true,
	[slot0.ActivityId.Reactivity] = false,
	[slot0.ActivityId.RoleStory1] = true,
	[slot0.ActivityId.RoleStory2] = true,
	[slot0.ActivityId.Season] = true
}
slot0.ActId2ShowRemainTimeDict = {
	[slot0.ActivityId.Dungeon] = false,
	[slot0.ActivityId.Isolde] = true,
	[slot0.ActivityId.Marcus] = true,
	[slot0.ActivityId.BossRush] = false,
	[slot0.ActivityId.Reactivity] = false,
	[slot0.ActivityId.RoleStory1] = true,
	[slot0.ActivityId.RoleStory2] = true,
	[slot0.ActivityId.Season] = false
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
	[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a7_mainactivity_singlebg/v1a7_enterview_itemtitleunselected.png"
}
slot0.ActId2SelectImgPath = {
	[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a7_mainactivity_singlebg/v1a7_enterview_itemtitleselected.png"
}
slot0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
slot0.ScrollTabTopPadding = 16
slot0.RedDotOffsetY = 56

return slot0
