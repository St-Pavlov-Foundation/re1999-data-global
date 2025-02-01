module("modules.logic.versionactivity2_0.enter.define.VersionActivity2_0Enum", package.seeall)

slot0 = _M
slot0.ActivityId = {
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
slot0.EnterViewActSetting = {
	{
		actId = slot0.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = slot0.ActivityId.DungeonStore
	},
	{
		actId = slot0.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = slot0.ActivityId.SeasonStore
	},
	{
		actId = slot0.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = slot0.ActivityId.ReactivityStore
	},
	{
		actId = slot0.ActivityId.Mercuria,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = slot0.ActivityId.Mercuria
	},
	{
		actId = slot0.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = slot0.ActivityId.Joe,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = slot0.ActivityId.Joe
	},
	{
		actId = {
			slot0.ActivityId.RoleStory1,
			slot0.ActivityId.RoleStory2
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	}
}
slot0.EnterViewActIdListWithRedDot = {
	slot0.ActivityId.Dungeon,
	slot0.ActivityId.BossRush,
	slot0.ActivityId.Season
}
slot0.TabSetting = {
	select = {
		fontSize = 42,
		enFontSize = 14,
		color = Color(1, 1, 1, 1),
		act2TabImg = {
			[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a0_mainactivity_singlebg/v2a0_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		enFontSize = 14,
		color = Color(0.5529411764705883, 0.5529411764705883, 0.5529411764705883, 1),
		act2TabImg = {
			[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a0_mainactivity_singlebg/v2a0_enterview_itemtitleunselected.png"
		}
	}
}
slot0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
slot0.RedDotOffsetY = 56
slot0.EnterAnimVideoPath = "videos/1_9_enter.mp4"

function slot0.JumpNeedCloseView()
	return {
		ViewName.VersionActivity2_0DungeonGraffitiView,
		ViewName.VersionActivity2_0DungeonMapGraffitiEnterView,
		ViewName.VersionActivity2_0DungeonMapView
	}
end

return slot0
