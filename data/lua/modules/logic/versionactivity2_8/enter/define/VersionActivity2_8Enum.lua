module("modules.logic.versionactivity2_8.enter.define.VersionActivity2_8Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	MoLiDeEr = 12811,
	Survival = 12806,
	RoleStory1 = 12805,
	Dungeon = 12802,
	Season = 12618,
	NuoDiKa = 12810,
	DungeonBoss = 12812,
	DungeonStore = 12803,
	AutoChess = 12807,
	BossRush = 12617,
	Challenge = 12813,
	EnterView = 12801,
	ActivityDrop = 12804
}
var_0_0.EnterViewActSetting = {
	{
		actId = var_0_0.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.DungeonStore
	},
	{
		actId = var_0_0.ActivityId.Survival,
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
		actId = var_0_0.ActivityId.MoLiDeEr,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.NuoDiKa,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.AutoChess,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.Challenge,
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
	var_0_0.ActivityId.Dungeon
}
var_0_0.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a8_mainactivity_singlebg/v2a8_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#AAB1B9",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a8_mainactivity_singlebg/v2a8_enterview_itemtitleselected.png"
		}
	}
}
var_0_0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
var_0_0.RedDotOffsetY = 56

return var_0_0
