module("modules.logic.versionactivity2_6.enter.define.VersionActivity2_6Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	ReactivityStore = 12408,
	DiceHero = 12606,
	RoleStory1 = 12615,
	Rouge = 12614,
	Season = 12618,
	Xugouji = 12605,
	BossRush = 12617,
	DungeonStore = 12603,
	Dungeon = 12602,
	EnterView = 12601,
	ActivityDrop = 12604,
	Reactivity = VersionActivity1_8Enum.ActivityId.Dungeon,
	ReactivityFactory = VersionActivity1_8Enum.ActivityId.DungeonReturnToWork
}
var_0_0.EnterViewActSetting = {
	{
		actId = var_0_0.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.ReactivityStore
	},
	{
		actId = var_0_0.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.DungeonStore
	},
	{
		actId = var_0_0.ActivityId.DiceHero,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.Xugouji,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = var_0_0.ActivityId.Xugouji
	},
	{
		actId = var_0_0.ActivityId.Rouge,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			var_0_0.ActivityId.RoleStory1
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	},
	{
		actId = var_0_0.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = ActivityEnum.Activity.WeekWalkDeepShow,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = ActivityEnum.Activity.WeekWalkDeepShow
	},
	{
		actId = ActivityEnum.Activity.Tower,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = ActivityEnum.Activity.WeekWalkHeartShow,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = ActivityEnum.Activity.WeekWalkHeartShow
	}
}
var_0_0.EnterViewActIdListWithRedDot = {
	var_0_0.ActivityId.Dungeon,
	var_0_0.ActivityId.Xugouji
}
var_0_0.TabSetting = {
	select = {
		fontSize = 36,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a6_mainactivity_singlebg/v2a6_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 34,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a6_mainactivity_singlebg/v2a6_enterview_itemtitleunselected.png"
		}
	}
}
var_0_0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
var_0_0.RedDotOffsetY = 56

return var_0_0
