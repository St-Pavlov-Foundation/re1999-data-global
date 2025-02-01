module("modules.logic.versionactivity1_5.enter.define.VersionActivity1_5Enum", package.seeall)

slot0 = _M
slot0.ActivityId = {
	EnterView2 = 11517,
	DungeonExploreTask = 11505,
	DungeonStore = 11503,
	SportsNews = 11510,
	Season = 11500,
	SeasonStore = 11512,
	BossRush = 11516,
	PeaceUlu = 11507,
	DungeonBuilding = 11506,
	Dungeon = 11502,
	Activity142 = 11508,
	AiZiLa = 11509,
	EnterView = 11501
}
slot0.EnterViewActIdListWithGroup = {
	[slot0.ActivityId.EnterView] = {
		slot0.ActivityId.Activity142,
		slot0.ActivityId.BossRush,
		slot0.ActivityId.SportsNews,
		slot0.ActivityId.DungeonStore,
		slot0.ActivityId.Dungeon
	},
	[slot0.ActivityId.EnterView2] = {
		slot0.ActivityId.PeaceUlu,
		slot0.ActivityId.BossRush,
		slot0.ActivityId.Season,
		slot0.ActivityId.AiZiLa,
		slot0.ActivityId.DungeonStore,
		slot0.ActivityId.Dungeon
	}
}
slot0.EnterViewMainActIdList = {
	slot0.ActivityId.EnterView,
	slot0.ActivityId.EnterView2
}
slot0.ActId2Ambient = {
	[slot0.ActivityId.EnterView] = 20150002,
	[slot0.ActivityId.EnterView2] = 20150004
}
slot0.ActId2OpenAudio = {
	[slot0.ActivityId.EnterView] = 20150001,
	[slot0.ActivityId.EnterView2] = 20150003
}

return slot0
