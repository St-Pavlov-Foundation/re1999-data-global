module("modules.logic.versionactivity2_4.dungeon.define.VersionActivity2_4DungeonEnum", package.seeall)

slot0 = _M
slot0.DungeonChapterId = {
	ElementFight = 24102,
	Story = 24101,
	Hard = 24201,
	Story1 = 24101,
	Story2 = 24301,
	Story3 = 24401
}
slot0.EpisodeStarType = {
	[slot0.DungeonChapterId.Story1] = {
		empty = "v2a4_dungeon_star_1_locked",
		light = "v2a4_dungeon_star_1"
	},
	[slot0.DungeonChapterId.Story2] = {
		empty = "v2a4_dungeon_star_2_locked",
		light = "v2a4_dungeon_star_2"
	},
	[slot0.DungeonChapterId.Story3] = {
		empty = "v2a4_dungeon_star_3_locked",
		light = "v2a4_dungeon_star_3"
	},
	[slot0.DungeonChapterId.Hard] = {
		empty = "v2a4_dungeon_star_3_locked",
		light = "v2a4_dungeon_star_3"
	}
}
slot0.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_4_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_4_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_4_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_4_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_4_OpenTaskView",
	FocusNewElement = "VersionActivity2_4_FocusNewElement"
}
slot0.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode"
}
slot0.SceneRootName = "VersionActivity2_4DungeonMapScene"
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

return slot0
