module("modules.logic.versionactivity2_3.enter.define.VersionActivity2_3Enum", package.seeall)

slot0 = _M
slot0.ActivityId = {
	Dungeon = 12302,
	Act174Store = 12319,
	ZhiXinQuanEr = 12306,
	RoleStory1 = 12307,
	Season = 12315,
	SeasonStore = 12316,
	Act174 = 12304,
	Tower = 12320,
	DungeonStore = 12303,
	BossRush = 12313,
	DuDuGu = 12305,
	EnterView = 12301
}
slot0.EnterViewActSetting = {
	{
		actId = slot0.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = slot0.ActivityId.DungeonStore
	},
	{
		actId = slot0.ActivityId.Act174,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = slot0.ActivityId.DuDuGu,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = slot0.ActivityId.DuDuGu
	},
	{
		actId = slot0.ActivityId.ZhiXinQuanEr,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = slot0.ActivityId.ZhiXinQuanEr
	},
	{
		actId = slot0.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = slot0.ActivityId.SeasonStore
	},
	{
		actId = slot0.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			slot0.ActivityId.RoleStory1
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
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
slot0.EnterViewActIdListWithRedDot = {
	slot0.ActivityId.Dungeon,
	slot0.ActivityId.Season
}
slot0.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a3_mainactivity_singlebg/v2a3_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a3_mainactivity_singlebg/v2a3_enterview_itemtitleunselected.png"
		}
	}
}
slot0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
slot0.RedDotOffsetY = 56

return slot0
