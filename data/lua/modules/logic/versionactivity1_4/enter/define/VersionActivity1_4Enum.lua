module("modules.logic.versionactivity1_4.enter.define.VersionActivity1_4Enum", package.seeall)

slot0 = _M
slot0.ActivityId = {
	Dungeon = 11407,
	Task = 11408,
	Role6 = 11403,
	Collect = 11409,
	Season = 11400,
	ShipRepair = 11419,
	SecondEnter = 11420,
	DustyRecords = 11424,
	BossRush = 11414,
	DungeonStore = 11406,
	Role37 = 11402,
	SeasonStore = 11410,
	EnterView = 11401,
	LimitFirstFall = 11421
}
slot0.EnterViewActIdList = {
	slot0.ActivityId.ShipRepair,
	slot0.ActivityId.Role37,
	slot0.ActivityId.BossRush,
	slot0.ActivityId.Task,
	slot0.ActivityId.DungeonStore,
	slot0.ActivityId.Dungeon,
	slot0.ActivityId.BossRush,
	slot0.ActivityId.Season,
	slot0.ActivityId.DustyRecords,
	slot0.ActivityId.Role6,
	slot0.ActivityId.DungeonStore,
	slot0.ActivityId.Dungeon
}
slot0.TabEnum = {
	Second = 2,
	First = 1
}
slot0.TabActivityList = {
	[slot0.TabEnum.First] = {
		1,
		2,
		3,
		4,
		5,
		6
	},
	[slot0.TabEnum.Second] = {
		7,
		8,
		9,
		10,
		11,
		12
	}
}

return slot0
