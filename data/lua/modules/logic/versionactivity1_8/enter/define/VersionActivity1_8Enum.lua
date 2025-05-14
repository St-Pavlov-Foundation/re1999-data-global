module("modules.logic.versionactivity1_8.enter.define.VersionActivity1_8Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	ReactivityStore = 11802,
	DungeonReturnToWork = 11815,
	RoleStory1 = 11813,
	WindSong = 11807,
	Season = 11811,
	BossRush = 11812,
	Reactivity = 11302,
	Weila = 11806,
	RoleStory2 = 11814,
	DungeonStore = 11805,
	JustReport = 11810,
	Dungeon = 11804,
	SeasonStore = 11816,
	EnterView = 11803
}
var_0_0.EnterViewActSetting = {
	{
		actId = var_0_0.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.DungeonStore
	},
	{
		actId = var_0_0.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.ReactivityStore
	},
	{
		actId = var_0_0.ActivityId.Weila,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = var_0_0.ActivityId.Weila
	},
	{
		actId = var_0_0.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			var_0_0.ActivityId.RoleStory1,
			var_0_0.ActivityId.RoleStory2
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	},
	{
		actId = var_0_0.ActivityId.WindSong,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = var_0_0.ActivityId.WindSong
	},
	{
		actId = var_0_0.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = var_0_0.ActivityId.SeasonStore
	}
}
var_0_0.EnterViewActIdListWithRedDot = {
	var_0_0.ActivityId.Dungeon,
	var_0_0.ActivityId.Weila,
	var_0_0.ActivityId.BossRush,
	var_0_0.ActivityId.WindSong
}
var_0_0.TabSetting = {
	select = {
		fontSize = 42,
		enFontSize = 14,
		color = Color(1, 1, 1, 1),
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a8_mainactivity_singlebg/v1a8_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		enFontSize = 14,
		color = Color(0.5529411764705883, 0.5529411764705883, 0.5529411764705883, 1),
		act2TabImg = {
			[var_0_0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a8_mainactivity_singlebg/v1a8_enterview_itemtitleunselected.png"
		}
	}
}
var_0_0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
var_0_0.RedDotOffsetY = 56
var_0_0.EnterAnimVideoPath = "videos/1_8_enter.mp4"

return var_0_0
