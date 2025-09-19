module("modules.logic.versionactivity3_1.enter.define.VersionActivity3_1Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	YeShuMei = 13117,
	TowerDeep = 13112,
	DouQuQu3Store = 13115,
	NationalGift = 13122,
	Survival = 13106,
	RoleStory = 13107,
	DouQuQu3 = 13105,
	BpOperAct = 13123,
	GaoSiNiao = 13118,
	DungeonStore = 13104,
	BossRush = 13113,
	Dungeon = 13103,
	ReactivityStore = 13114,
	EnterView = 13102,
	SurvivalOperAct = 13111,
	Reactivity = VersionActivity2_4Enum.ActivityId.Dungeon
}
var_0_0.EnterViewActSetting = {
	{
		actId = var_0_0.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.DungeonStore
	},
	{
		actId = var_0_0.ActivityId.DouQuQu3,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.Survival,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.RoleStory,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.YeShuMei,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.ReactivityStore
	},
	{
		actId = var_0_0.ActivityId.GaoSiNiao,
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
		fontSize = 28,
		cnColor = "#F4FDF8",
		enFontSize = 16,
		enColor = "#C90F0D",
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v3a1_mainactivity_singlebg/v3a1_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 28,
		cnColor = "#76877E",
		enFontSize = 16,
		enColor = "#FFFFFF",
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v3a1_mainactivity_singlebg/v3a1_enterview_itemtitleunselected.png"
		}
	}
}
var_0_0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
var_0_0.RedDotOffsetY = 56

return var_0_0
