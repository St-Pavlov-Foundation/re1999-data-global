module("modules.logic.versionactivity3_0.enter.define.VersionActivity3_0Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	BossRush = 13016,
	ReactivityStore = 130508,
	RoleStory1 = 13004,
	MaLiAnNa = 13011,
	Season = 13000,
	KaRong = 13015,
	DungeonStore = 13008,
	Dungeon = 13007,
	SeasonStore = 13003,
	EnterView = 13006,
	ActivityDrop = 13009,
	Reactivity = VersionActivity2_3Enum.ActivityId.Dungeon,
	StoryDeduction = VersionActivity2_1Enum.ActivityId.StoryDeduction
}
var_0_0.EnterViewActSetting = {
	{
		actId = var_0_0.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.DungeonStore
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
		actId = var_0_0.ActivityId.MaLiAnNa,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.KaRong,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = var_0_0.ActivityId.KaRong
	},
	{
		actId = var_0_0.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.SeasonStore
	},
	{
		actId = var_0_0.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.ReactivityStore
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
	var_0_0.ActivityId.Dungeon
}
var_0_0.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#FFFFFF99",
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v3a0_mainactivity_singlebg/v3a0_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#FFFFFF24",
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v3a0_mainactivity_singlebg/v3a0_enterview_itemtitleunselected.png"
		}
	}
}
var_0_0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
var_0_0.RedDotOffsetY = 56
var_0_0.RedDotOffsetX = 10
var_0_0.EnterLoopVideoName = "3_0_loop"
var_0_0.EnterAnimVideoName = "3_0_enter"
var_0_0.EnterVideoDayKey = "v3a0_EnterVideoDayKey"

return var_0_0
