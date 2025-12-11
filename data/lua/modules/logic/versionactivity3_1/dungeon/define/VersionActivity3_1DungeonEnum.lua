module("modules.logic.versionactivity3_1.dungeon.define.VersionActivity3_1DungeonEnum", package.seeall)

local var_0_0 = _M

var_0_0.DungeonChapterId = {
	ElementFight = 31102,
	Story = 31101,
	Hard = 31201,
	Story1 = 31101,
	Story2 = 31301,
	Story3 = 31401
}
var_0_0.EpisodeStarType = {
	[var_0_0.DungeonChapterId.Story1] = {
		empty = "v3a1_dungeon_star_1_locked",
		light = "v3a1_dungeon_star_1"
	},
	[var_0_0.DungeonChapterId.Story2] = {
		empty = "v3a1_dungeon_star_2_locked",
		light = "v3a1_dungeon_star_2"
	},
	[var_0_0.DungeonChapterId.Story3] = {
		empty = "v3a1_dungeon_star_3_locked",
		light = "v3a1_dungeon_star_3"
	},
	[var_0_0.DungeonChapterId.Hard] = {
		empty = "v3a1_dungeon_star_3_locked",
		light = "v3a1_dungeon_star_3"
	}
}
var_0_0.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity3_1_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity3_1_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity3_1_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity3_1_TaskItemGetReward",
	OpenTaskView = "VersionActivity3_1_OpenTaskView",
	FocusNewElement = "VersionActivity3_1_FocusNewElement"
}
var_0_0.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
var_0_0.SceneRootName = "VersionActivity3_1DungeonMapScene"
var_0_0.EpisodeItemMinWidth = 250
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
var_0_0.LevelAnim = {
	loop = "loop",
	right_close = "right_close",
	right_open = "right_open",
	left_close = "left_close",
	left_open = "left_open"
}
var_0_0.LevelAnimDelayTime = 0.1

return var_0_0
