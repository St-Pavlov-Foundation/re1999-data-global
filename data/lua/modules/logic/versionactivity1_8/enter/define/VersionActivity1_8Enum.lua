module("modules.logic.versionactivity1_8.enter.define.VersionActivity1_8Enum", package.seeall)

slot0 = _M
slot0.ActivityId = {
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
slot0.EnterViewActSetting = {
	{
		actId = slot0.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = slot0.ActivityId.DungeonStore
	},
	{
		actId = slot0.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = slot0.ActivityId.ReactivityStore
	},
	{
		actId = slot0.ActivityId.Weila,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = slot0.ActivityId.Weila
	},
	{
		actId = slot0.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			slot0.ActivityId.RoleStory1,
			slot0.ActivityId.RoleStory2
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	},
	{
		actId = slot0.ActivityId.WindSong,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = slot0.ActivityId.WindSong
	},
	{
		actId = slot0.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = slot0.ActivityId.SeasonStore
	}
}
slot0.EnterViewActIdListWithRedDot = {
	slot0.ActivityId.Dungeon,
	slot0.ActivityId.Weila,
	slot0.ActivityId.BossRush,
	slot0.ActivityId.WindSong
}
slot0.TabSetting = {
	select = {
		fontSize = 42,
		enFontSize = 14,
		color = Color(1, 1, 1, 1),
		act2TabImg = {
			[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a8_mainactivity_singlebg/v1a8_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		enFontSize = 14,
		color = Color(0.5529411764705883, 0.5529411764705883, 0.5529411764705883, 1),
		act2TabImg = {
			[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v1a8_mainactivity_singlebg/v1a8_enterview_itemtitleunselected.png"
		}
	}
}
slot0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
slot0.RedDotOffsetY = 56
slot0.EnterAnimVideoPath = "videos/1_8_enter.mp4"

return slot0
