module("modules.logic.versionactivity1_6.enter.define.VersionActivity1_6Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	Role1 = 11605,
	BossRush = 11604,
	DungeonBossRush = 11609,
	Cachot = 11610,
	Season = 11600,
	Reactivity = 11104,
	Role2 = 11606,
	RoleStory = 11612,
	DungeonSkillTree = 11608,
	DungeonStore = 11603,
	Explore = 11617,
	Dungeon = 11602,
	RoleStory2 = 11620,
	SeasonStore = 11607,
	EnterView = 11601,
	ReactivityStore = 11611
}
var_0_0.EnterViewActIdList = {
	var_0_0.ActivityId.Dungeon,
	var_0_0.ActivityId.Cachot,
	var_0_0.ActivityId.Reactivity,
	var_0_0.ActivityId.Role1,
	var_0_0.ActivityId.Role2,
	var_0_0.ActivityId.BossRush,
	var_0_0.ActivityId.Season,
	{
		var_0_0.ActivityId.RoleStory,
		var_0_0.ActivityId.RoleStory2
	},
	var_0_0.ActivityId.Explore
}

return var_0_0
