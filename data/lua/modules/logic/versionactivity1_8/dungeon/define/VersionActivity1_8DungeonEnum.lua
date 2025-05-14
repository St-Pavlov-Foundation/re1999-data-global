module("modules.logic.versionactivity1_8.dungeon.define.VersionActivity1_8DungeonEnum", package.seeall)

local var_0_0 = _M

var_0_0.DungeonChapterId = {
	ElementFight = 18102,
	Story = 18101,
	Hard = 18201,
	Story1 = 18101,
	Story4 = 18201,
	Story2 = 18301,
	Story3 = 18401
}
var_0_0.EpisodeStarType = {
	[var_0_0.DungeonChapterId.Story] = {
		empty = "v1a8_dungeon_star_1_locked",
		light = "v1a8_dungeon_star_1"
	},
	[var_0_0.DungeonChapterId.Story2] = {
		empty = "v1a8_dungeon_star_2_locked",
		light = "v1a8_dungeon_star_2"
	},
	[var_0_0.DungeonChapterId.Story3] = {
		empty = "v1a8_dungeon_star_3_locked",
		light = "v1a8_dungeon_star_3"
	},
	[var_0_0.DungeonChapterId.Hard] = {
		empty = "v1a8_dungeon_star_3_locked",
		light = "v1a8_dungeon_star_3"
	}
}
var_0_0.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity1_8_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity1_8_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity1_8_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity1_8_TaskItemGetReward",
	OpenTaskView = "VersionActivity1_8_OpenTaskView",
	FocusNewElement = "VersionActivity1_8_FocusNewElement",
	GetComponentRepairReward = "VersionActivity1_8_GetComponentRepairReward"
}
var_0_0.PlayerPrefsKey = {
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	IsPlayedFactoryComponentUnlockANim = "Activity157IsPlayedFactoryComponentUnlockANim_",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	IsPlayedBlueprintAllFinish = "Activity157IsPlayedFactoryComponentUnlockANim",
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	IsPlayedBlueprintUnlockAnim = "Activity157IsPlayedBlueprintUnlockAnim",
	IsPlayedMissionNodeUnlocked = "Activity157IsPlayedUnlockMissionNode_",
	IsPlayedFactoryMapSwitchUnlockAnim = "Activity157IsPlayedFactoryMapSwitchUnlockAnim"
}
var_0_0.SceneRootName = "VersionActivity1_8DungeonMapScene"
var_0_0.DungeonMapCameraSize = 5
var_0_0.MaxHoleNum = 5
var_0_0.HoleHalfWidth = 3.5
var_0_0.HoleHalfHeight = 1.75
var_0_0.HoleAnimDuration = 0.33
var_0_0.HoleAnimMaxZ = 3
var_0_0.HoleAnimMinZ = 0
var_0_0.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
var_0_0.ElementTimeOffsetY = 0.8
var_0_0.MapDir = {
	Top = 3,
	Left = 1,
	Right = 2,
	Bottom = 4
}

return var_0_0
