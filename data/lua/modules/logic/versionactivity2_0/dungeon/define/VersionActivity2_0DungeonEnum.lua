module("modules.logic.versionactivity2_0.dungeon.define.VersionActivity2_0DungeonEnum", package.seeall)

slot0 = _M
slot0.DungeonChapterId = {
	ElementFight = 20102,
	Story = 20101,
	Hard = 20201,
	Story1 = 20101,
	Story2 = 20301,
	Story3 = 20401
}
slot0.EpisodeStarType = {
	[slot0.DungeonChapterId.Story1] = {
		empty = "v2a0_dungeon_star_1_locked",
		light = "v2a0_dungeon_star_1"
	},
	[slot0.DungeonChapterId.Story2] = {
		empty = "v2a0_dungeon_star_2_locked",
		light = "v2a0_dungeon_star_2"
	},
	[slot0.DungeonChapterId.Story3] = {
		empty = "v2a0_dungeon_star_3_locked",
		light = "v2a0_dungeon_star_3"
	},
	[slot0.DungeonChapterId.Hard] = {
		empty = "v2a0_dungeon_star_3_locked",
		light = "v2a0_dungeon_star_3"
	}
}
slot0.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_0_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_0_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_0_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_0_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_0_OpenTaskView",
	FocusNewElement = "VersionActivity2_0_FocusNewElement"
}
slot0.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	DungeonLastSelectEpisode = "DungeonLastSelectEpisode"
}
slot0.SceneRootName = "VersionActivity2_0DungeonMapScene"
slot0.EpisodeItemMinWidth = 300
slot0.DungeonMapCameraSize = 5
slot0.MaxHoleNum = 5
slot0.HoleHalfWidth = 3.5
slot0.HoleHalfHeight = 1.75
slot0.HoleAnimDuration = 0.33
slot0.HoleAnimMaxZ = 3
slot0.HoleAnimMinZ = 0
slot0.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
slot0.restaurantElement = 2013001
slot0.restaurantChapterMap = 2010102

return slot0
