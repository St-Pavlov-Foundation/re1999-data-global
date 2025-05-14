module("modules.logic.versionactivity2_5.dungeon.define.VersionActivity2_5DungeonEnum", package.seeall)

local var_0_0 = _M

var_0_0.DungeonChapterId = {
	ElementFight = 25102,
	Story = 25101,
	Hard = 25201,
	Story1 = 25101,
	Story2 = 25301,
	Story3 = 25401
}
var_0_0.EpisodeStarType = {
	[var_0_0.DungeonChapterId.Story1] = {
		empty = "v2a3_dungeon_star_1_locked",
		light = "v2a3_dungeon_star_1"
	},
	[var_0_0.DungeonChapterId.Story2] = {
		empty = "v2a3_dungeon_star_2_locked",
		light = "v2a3_dungeon_star_2"
	},
	[var_0_0.DungeonChapterId.Story3] = {
		empty = "v2a3_dungeon_star_3_locked",
		light = "v2a3_dungeon_star_3"
	},
	[var_0_0.DungeonChapterId.Hard] = {
		empty = "v2a3_dungeon_star_3_locked",
		light = "v2a3_dungeon_star_3"
	}
}
var_0_0.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_5_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_5_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_5_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_5_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_5_OpenTaskView",
	FocusNewElement = "VersionActivity2_5_FocusNewElement"
}
var_0_0.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode"
}
var_0_0.SceneRootName = "VersionActivity2_5DungeonMapScene"
var_0_0.EpisodeItemMinWidth = 300
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
var_0_0.GuideAct165ElementId = 2110201
var_0_0.GuideAct165ElementStepId = 21401

return var_0_0
