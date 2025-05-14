module("modules.logic.versionactivity2_0.dungeon.define.VersionActivity2_0DungeonEnum", package.seeall)

local var_0_0 = _M

var_0_0.DungeonChapterId = {
	ElementFight = 20102,
	Story = 20101,
	Hard = 20201,
	Story1 = 20101,
	Story2 = 20301,
	Story3 = 20401
}
var_0_0.EpisodeStarType = {
	[var_0_0.DungeonChapterId.Story1] = {
		empty = "v2a0_dungeon_star_1_locked",
		light = "v2a0_dungeon_star_1"
	},
	[var_0_0.DungeonChapterId.Story2] = {
		empty = "v2a0_dungeon_star_2_locked",
		light = "v2a0_dungeon_star_2"
	},
	[var_0_0.DungeonChapterId.Story3] = {
		empty = "v2a0_dungeon_star_3_locked",
		light = "v2a0_dungeon_star_3"
	},
	[var_0_0.DungeonChapterId.Hard] = {
		empty = "v2a0_dungeon_star_3_locked",
		light = "v2a0_dungeon_star_3"
	}
}
var_0_0.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_0_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_0_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_0_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_0_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_0_OpenTaskView",
	FocusNewElement = "VersionActivity2_0_FocusNewElement"
}
var_0_0.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	DungeonLastSelectEpisode = "DungeonLastSelectEpisode"
}
var_0_0.SceneRootName = "VersionActivity2_0DungeonMapScene"
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
var_0_0.restaurantElement = 2013001
var_0_0.restaurantChapterMap = 2010102

return var_0_0
