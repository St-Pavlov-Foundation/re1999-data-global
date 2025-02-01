module("modules.logic.versionactivity1_6.enter.define.VersionActivity1_6Enum", package.seeall)

slot0 = _M
slot0.ActivityId = {
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
slot0.EnterViewActIdList = {
	slot0.ActivityId.Dungeon,
	slot0.ActivityId.Cachot,
	slot0.ActivityId.Reactivity,
	slot0.ActivityId.Role1,
	slot0.ActivityId.Role2,
	slot0.ActivityId.BossRush,
	slot0.ActivityId.Season,
	{
		slot0.ActivityId.RoleStory,
		slot0.ActivityId.RoleStory2
	},
	slot0.ActivityId.Explore
}

return slot0
