module("modules.logic.versionactivity1_7.enter.define.VersionActivity1_7Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
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
		actId = var_0_0.ActivityId.Isolde,
		actLevel = var_0_0.ActLevel.Second,
		actType = var_0_0.ActType.Single,
		redDotUid = var_0_0.ActivityId.Isolde
	},
	{
		actId = var_0_0.ActivityId.Marcus,
		actLevel = var_0_0.ActLevel.Second,
		actType = var_0_0.ActType.Single,
		redDotUid = var_0_0.ActivityId.Marcus
	},
	{
		actId = var_0_0.ActivityId.BossRush,
		actLevel = var_0_0.ActLevel.Second,
		actType = var_0_0.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.Reactivity,
		actLevel = var_0_0.ActLevel.Second,
		actType = var_0_0.ActType.Single,
		storeId = var_0_0.ActivityId.ReactivityStore
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
	}
}
var_0_0.EnterViewActIdListWithRedDot = {
	var_0_0.ActivityId.Dungeon,
	var_0_0.ActivityId.Isolde,
	var_0_0.ActivityId.Marcus,
	var_0_0.ActivityId.BossRush,
	var_0_0.ActivityId.Reactivity,
	var_0_0.ActivityId.RoleStory1,
	var_0_0.ActivityId.RoleStory2,
	var_0_0.ActivityId.Season
}
var_0_0.ActId2ShowReplayBtnDict = {
	[var_0_0.ActivityId.Dungeon] = true,
	[var_0_0.ActivityId.Isolde] = false,
	[var_0_0.ActivityId.Marcus] = false,
	[var_0_0.ActivityId.BossRush] = false,
	[var_0_0.ActivityId.Reactivity] = false,
	[var_0_0.ActivityId.RoleStory1] = false,
	[var_0_0.ActivityId.RoleStory2] = false,
	[var_0_0.ActivityId.Season] = false
}
var_0_0.ActId2ShowAchievementBtnDict = {
	[var_0_0.ActivityId.Dungeon] = true,
	[var_0_0.ActivityId.Isolde] = true,
	[var_0_0.ActivityId.Marcus] = true,
	[var_0_0.ActivityId.BossRush] = true,
	[var_0_0.ActivityId.Reactivity] = false,
	[var_0_0.ActivityId.RoleStory1] = true,
	[var_0_0.ActivityId.RoleStory2] = true,
	[var_0_0.ActivityId.Season] = true
}
var_0_0.ActId2ShowRemainTimeDict = {
	[var_0_0.ActivityId.Dungeon] = false,
	[var_0_0.ActivityId.Isolde] = true,
	[var_0_0.ActivityId.Marcus] = true,
	[var_0_0.ActivityId.BossRush] = false,
	[var_0_0.ActivityId.Reactivity] = false,
	[var_0_0.ActivityId.RoleStory1] = true,
	[var_0_0.ActivityId.RoleStory2] = true,
	[var_0_0.ActivityId.Season] = false
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
	[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a7_mainactivity_singlebg/v1a7_enterview_itemtitleunselected.png"
}
var_0_0.ActId2SelectImgPath = {
	[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a7_mainactivity_singlebg/v1a7_enterview_itemtitleselected.png"
}
var_0_0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
var_0_0.ScrollTabTopPadding = 16
var_0_0.RedDotOffsetY = 56

return var_0_0
