module("modules.logic.versionactivity2_0.enter.define.VersionActivity2_0Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	EnterView = 12002,
	DungeonGraffiti = 12005,
	RoleStory1 = 12011,
	BossRush = 12013,
	Season = 12006,
	Joe = 12008,
	Reactivity = 11502,
	Mercuria = 12009,
	RoleStory2 = 12012,
	DungeonStore = 12004,
	Dungeon = 12003,
	SeasonStore = 12007,
	ReactivityStore = 12001
}
var_0_0.EnterViewActSetting = {
	{
		actId = var_0_0.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.DungeonStore
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
		actId = var_0_0.ActivityId.Mercuria,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = var_0_0.ActivityId.Mercuria
	},
	{
		actId = var_0_0.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = var_0_0.ActivityId.Joe,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = var_0_0.ActivityId.Joe
	},
	{
		actId = {
			var_0_0.ActivityId.RoleStory1,
			var_0_0.ActivityId.RoleStory2
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	}
}
var_0_0.EnterViewActIdListWithRedDot = {
	var_0_0.ActivityId.Dungeon,
	var_0_0.ActivityId.BossRush,
	var_0_0.ActivityId.Season
}
var_0_0.TabSetting = {
	select = {
		fontSize = 42,
		enFontSize = 14,
		color = Color(1, 1, 1, 1),
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a0_mainactivity_singlebg/v2a0_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		enFontSize = 14,
		color = Color(0.5529411764705883, 0.5529411764705883, 0.5529411764705883, 1),
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a0_mainactivity_singlebg/v2a0_enterview_itemtitleunselected.png"
		}
	}
}
var_0_0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
var_0_0.RedDotOffsetY = 56
var_0_0.EnterAnimVideoPath = "videos/1_9_enter.mp4"

function var_0_0.JumpNeedCloseView()
	return {
		ViewName.VersionActivity2_0DungeonGraffitiView,
		ViewName.VersionActivity2_0DungeonMapGraffitiEnterView,
		ViewName.VersionActivity2_0DungeonMapView
	}
end

return var_0_0
