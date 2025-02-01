module("modules.logic.versionactivity2_1.enter.define.VersionActivity2_1Enum", package.seeall)

slot0 = _M
slot0.ActivityId = {
	BossRush = 12113,
	DungeonStore = 12103,
	RoleStory1 = 12106,
	RoleStory2 = 12107,
	Season = 12115,
	StoryDeduction = 12104,
	Aergusi = 12105,
	RougeDlc1 = 12117,
	Dungeon = 12102,
	SeasonStore = 12116,
	EnterView = 12101,
	LanShouPa = 12114
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
		actId = slot0.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = slot0.ActivityId.LanShouPa,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = slot0.ActivityId.LanShouPa
	},
	{
		actId = slot0.ActivityId.Aergusi,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = slot0.ActivityId.Aergusi
	},
	{
		actId = slot0.ActivityId.RougeDlc1,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = slot0.ActivityId.RougeDlc1
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
		actId = VersionActivity2_0Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_0Enum.ActivityId.ReactivityStore
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
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a1_mainactivity_singlebg/v2a1_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a1_mainactivity_singlebg/v2a1_enterview_itemtitleunselected.png"
		}
	}
}
slot0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
slot0.RedDotOffsetY = 56

return slot0
