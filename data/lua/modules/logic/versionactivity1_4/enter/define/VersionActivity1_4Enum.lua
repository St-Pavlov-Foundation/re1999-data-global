module("modules.logic.versionactivity1_4.enter.define.VersionActivity1_4Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
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
var_0_0.EnterViewActIdList = {
	var_0_0.ActivityId.ShipRepair,
	var_0_0.ActivityId.Role37,
	var_0_0.ActivityId.BossRush,
	var_0_0.ActivityId.Task,
	var_0_0.ActivityId.DungeonStore,
	var_0_0.ActivityId.Dungeon,
	var_0_0.ActivityId.BossRush,
	var_0_0.ActivityId.Season,
	var_0_0.ActivityId.DustyRecords,
	var_0_0.ActivityId.Role6,
	var_0_0.ActivityId.DungeonStore,
	var_0_0.ActivityId.Dungeon
}
var_0_0.TabEnum = {
	Second = 2,
	First = 1
}
var_0_0.TabActivityList = {
	[var_0_0.TabEnum.First] = {
		1,
		2,
		3,
		4,
		5,
		6
	},
	[var_0_0.TabEnum.Second] = {
		7,
		8,
		9,
		10,
		11,
		12
	}
}

return var_0_0
