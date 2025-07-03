module("modules.logic.versionactivity2_7.dungeon.define.VersionActivity2_7DungeonEnum", package.seeall)

local var_0_0 = _M

var_0_0.DungeonChapterId = {
	ElementFight = 27102,
	Story = 27101,
	Hard = 27201,
	Story1 = 27101,
	Story2 = 27301,
	Story3 = 27401
}
var_0_0.EpisodeStarType = {
	[var_0_0.DungeonChapterId.Story1] = {
		empty = "v2a7_dungeon_star_1_locked",
		light = "v2a7_dungeon_star_1"
	},
	[var_0_0.DungeonChapterId.Story2] = {
		empty = "v2a7_dungeon_star_2_locked",
		light = "v2a7_dungeon_star_2"
	},
	[var_0_0.DungeonChapterId.Story3] = {
		empty = "v2a7_dungeon_star_3_locked",
		light = "v2a7_dungeon_star_3"
	},
	[var_0_0.DungeonChapterId.Hard] = {
		empty = "v2a7_dungeon_star_3_locked",
		light = "v2a7_dungeon_star_3"
	}
}
var_0_0.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_7_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_7_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_7_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_7_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_7_OpenTaskView",
	FocusNewElement = "VersionActivity2_7_FocusNewElement"
}
var_0_0.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
var_0_0.SceneRootName = "VersionActivity2_7DungeonMapScene"
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
var_0_0.SpaceSceneEpisodeIndexs = {
	18,
	19
}
var_0_0.SceneLoadObj = "ui/viewres/versionactivity_2_7/v2a7_enter/v2a7_m_s08_hddt.prefab"
var_0_0.SceneLoadAnim = "explore/camera_anim/hddt_camer.controller"
var_0_0.SpaceScene = "scenes/v2a7_m_s08_hddt/scenes_prefab/v2a7_m_s08_hddt_002_p.prefab"
var_0_0.GotoSpaceAnimName = "switch1"
var_0_0.returnAnimName = "switch2"
var_0_0.DragEndAnimTime = 1.2
var_0_0.DragSpeed = 1
var_0_0.SceneAnimType = {
	Normal = 3,
	ReturnEarth = 2,
	GotoSpace = 1
}

return var_0_0
