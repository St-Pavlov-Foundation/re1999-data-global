module("modules.logic.versionactivity1_5.enter.define.VersionActivity1_5Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
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
var_0_0.EnterViewActIdListWithGroup = {
	[var_0_0.ActivityId.EnterView] = {
		var_0_0.ActivityId.Activity142,
		var_0_0.ActivityId.BossRush,
		var_0_0.ActivityId.SportsNews,
		var_0_0.ActivityId.DungeonStore,
		var_0_0.ActivityId.Dungeon
	},
	[var_0_0.ActivityId.EnterView2] = {
		var_0_0.ActivityId.PeaceUlu,
		var_0_0.ActivityId.BossRush,
		var_0_0.ActivityId.Season,
		var_0_0.ActivityId.AiZiLa,
		var_0_0.ActivityId.DungeonStore,
		var_0_0.ActivityId.Dungeon
	}
}
var_0_0.EnterViewMainActIdList = {
	var_0_0.ActivityId.EnterView,
	var_0_0.ActivityId.EnterView2
}
var_0_0.ActId2Ambient = {
	[var_0_0.ActivityId.EnterView] = 20150002,
	[var_0_0.ActivityId.EnterView2] = 20150004
}
var_0_0.ActId2OpenAudio = {
	[var_0_0.ActivityId.EnterView] = 20150001,
	[var_0_0.ActivityId.EnterView2] = 20150003
}

return var_0_0
