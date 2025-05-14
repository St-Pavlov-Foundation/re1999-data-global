module("modules.logic.versionactivity1_2.enter.define.VersionActivity1_2Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	DungeonStore = 11207,
	Dungeon = 11208,
	Season = 11200,
	Trade = 11205,
	Building = 11204,
	DreamTail = 11206,
	JieXiKa = 11202,
	YaXian = 11203,
	EnterView = 11201
}
var_0_0.EnterViewActIdList = {
	var_0_0.ActivityId.Trade,
	var_0_0.ActivityId.JieXiKa,
	var_0_0.ActivityId.Season,
	var_0_0.ActivityId.Dungeon,
	var_0_0.ActivityId.YaXian,
	var_0_0.ActivityId.DreamTail
}

return var_0_0
