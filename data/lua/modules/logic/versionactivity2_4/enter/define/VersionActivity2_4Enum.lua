module("modules.logic.versionactivity2_4.enter.define.VersionActivity2_4Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	WuErLiXi = 12406,
	Pinball = 12404,
	RoleStory1 = 12407,
	MusicGame = 12405,
	Season = 12400,
	ReactivityStore = 12408,
	BossRush = 12410,
	Tower = 12320,
	DungeonStore = 12403,
	Dungeon = 12402,
	EnterView = 12401,
	Rouge = 12409,
	Reactivity = VersionActivity1_8Enum.ActivityId.Dungeon,
	ReactivityFactory = VersionActivity1_8Enum.ActivityId.DungeonReturnToWork
}
var_0_0.EnterViewActSetting = {
	{
		actId = var_0_0.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.DungeonStore
	},
	{
		actId = var_0_0.ActivityId.Pinball,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.MusicGame,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = var_0_0.ActivityId.MusicGame
	},
	{
		actId = var_0_0.ActivityId.WuErLiXi,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = var_0_0.ActivityId.WuErLiXi
	},
	{
		actId = var_0_0.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.ReactivityStore
	},
	{
		actId = var_0_0.ActivityId.Rouge,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = var_0_0.ActivityId.Rouge
	},
	{
		actId = var_0_0.ActivityId.Season,
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
		actId = var_0_0.ActivityId.BossRush,
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
	}
}
var_0_0.EnterViewActIdListWithRedDot = {}
var_0_0.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a4_mainactivity_singlebg/v2a4_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {}
	}
}
var_0_0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
var_0_0.RedDotOffsetY = 56
var_0_0.SudokuEpisodeId = 2410103

return var_0_0
