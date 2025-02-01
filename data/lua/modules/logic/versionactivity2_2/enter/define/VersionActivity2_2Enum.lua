module("modules.logic.versionactivity2_2.enter.define.VersionActivity2_2Enum", package.seeall)

slot0 = _M
slot0.ActivityId = {
	BossRush = 12209,
	TurnBackInvitation = 12222,
	RoleStory1 = 12207,
	Lopera = 12204,
	Season = 12210,
	BPSP = 12243,
	Eliminate = 12211,
	Dungeon = 12202,
	RoleStory2 = 12208,
	DungeonStore = 12205,
	RoomCritter = 12212,
	TianShiNaNa = 12203,
	LimitDecorate = 12236,
	EnterView = 12201
}
slot0.EnterViewActSetting = {
	{
		actId = slot0.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = slot0.ActivityId.DungeonStore
	},
	{
		actId = slot0.ActivityId.TianShiNaNa,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = slot0.ActivityId.TianShiNaNa
	},
	{
		actId = slot0.ActivityId.Eliminate,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = slot0.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
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
		actId = slot0.ActivityId.Lopera,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = slot0.ActivityId.Lopera
	},
	{
		actId = slot0.ActivityId.RoomCritter,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	}
}
slot0.EnterViewActIdListWithRedDot = {
	slot0.ActivityId.Dungeon,
	slot0.ActivityId.BossRush,
	slot0.ActivityId.Season,
	slot0.ActivityId.TurnBackInvitation
}
slot0.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a2_mainactivity_singlebg/v2a2_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[slot0.ActivityId.Dungeon] = "singlebg_lang/txt_v2a2_mainactivity_singlebg/v2a2_enterview_itemtitleselected.png"
		}
	}
}
slot0.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
slot0.RedDotOffsetY = 56

return slot0
