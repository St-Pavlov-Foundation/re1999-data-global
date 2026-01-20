-- chunkname: @modules/logic/versionactivity2_6/enter/define/VersionActivity2_6Enum.lua

module("modules.logic.versionactivity2_6.enter.define.VersionActivity2_6Enum", package.seeall)

local VersionActivity2_6Enum = _M

VersionActivity2_6Enum.ActivityId = {
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
VersionActivity2_6Enum.EnterViewActSetting = {
	{
		actId = VersionActivity2_6Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_6Enum.ActivityId.ReactivityStore
	},
	{
		actId = VersionActivity2_6Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_6Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity2_6Enum.ActivityId.DiceHero,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_6Enum.ActivityId.Xugouji,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_6Enum.ActivityId.Xugouji
	},
	{
		actId = VersionActivity2_6Enum.ActivityId.Rouge,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_6Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			VersionActivity2_6Enum.ActivityId.RoleStory1
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	},
	{
		actId = VersionActivity2_6Enum.ActivityId.Season,
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
VersionActivity2_6Enum.EnterViewActIdListWithRedDot = {
	VersionActivity2_6Enum.ActivityId.Dungeon,
	VersionActivity2_6Enum.ActivityId.Xugouji
}
VersionActivity2_6Enum.TabSetting = {
	select = {
		fontSize = 36,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[VersionActivity2_6Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a6_mainactivity_singlebg/v2a6_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 34,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[VersionActivity2_6Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a6_mainactivity_singlebg/v2a6_enterview_itemtitleunselected.png"
		}
	}
}
VersionActivity2_6Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity2_6Enum.RedDotOffsetY = 56

return VersionActivity2_6Enum
