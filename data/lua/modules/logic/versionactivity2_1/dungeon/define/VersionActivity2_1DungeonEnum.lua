module("modules.logic.versionactivity2_1.dungeon.define.VersionActivity2_1DungeonEnum", package.seeall)

slot0 = _M
slot0.DungeonChapterId = {
	ElementFight = 21102,
	Story = 21101,
	Hard = 21201,
	Story1 = 21101,
	Story2 = 21301,
	Story3 = 21401
}
slot0.EpisodeStarType = {
	[slot0.DungeonChapterId.Story1] = {
		empty = "v2a1_dungeon_star_1_locked",
		light = "v2a1_dungeon_star_1"
	},
	[slot0.DungeonChapterId.Story2] = {
		empty = "v2a1_dungeon_star_2_locked",
		light = "v2a1_dungeon_star_2"
	},
	[slot0.DungeonChapterId.Story3] = {
		empty = "v2a1_dungeon_star_3_locked",
		light = "v2a1_dungeon_star_3"
	},
	[slot0.DungeonChapterId.Hard] = {
		empty = "v2a1_dungeon_star_3_locked",
		light = "v2a1_dungeon_star_3"
	}
}
slot0.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_1_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_1_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_1_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_1_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_1_OpenTaskView",
	FocusNewElement = "VersionActivity2_1_FocusNewElement"
}
slot0.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode"
}
slot0.SceneRootName = "VersionActivity2_1DungeonMapScene"
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
slot0.GuideAct165ElementId = 2110201
slot0.GuideAct165ElementStepId = 21401

return slot0
