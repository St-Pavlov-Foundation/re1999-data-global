module("modules.logic.sp01.assassin2.define.VersionActivity2_9DungeonEnum", package.seeall)

local var_0_0 = _M

var_0_0.DungeonChapterId = {
	ElementFight = 305101,
	Story = 305101,
	Hard = 305101,
	Story1 = 305101,
	Story2 = 305301,
	Story3 = 305401
}
var_0_0.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_9_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_9_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_9_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_9_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_9_OpenTaskView",
	FocusNewElement = "VersionActivity2_9_FocusNewElement"
}
var_0_0.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode"
}
var_0_0.SceneRootName = "VersionActivity2_9DungeonMapScene"
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
var_0_0.SpaceSceneEpisodeIndexs = {
	18,
	19
}
var_0_0.SceneLoadObj = "ui/viewres/versionactivity_2_7/v2a7_enter/v2a7_m_s08_hddt.prefab"
var_0_0.SceneLoadAnim = "explore/camera_anim/hddt_camer.controller"
var_0_0.GotoSpaceAnimName = "switch1"
var_0_0.returnAnimName = "switch2"
var_0_0.DragEndAnimTime = 1.2
var_0_0.DragSpeed = 1
var_0_0.SceneAnimType = {
	Normal = 3,
	ReturnEarth = 2,
	GotoSpace = 1
}
var_0_0.EpisodeMode2Icon = {
	[VersionActivityDungeonBaseEnum.DungeonMode.Story] = "v2a9_dungeonmap_icon_1",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story2] = "v2a9_dungeonmap_icon_2",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story3] = "v2a9_dungeonmap_icon_3"
}
var_0_0.EpisodeMode2Bg = {
	[VersionActivityDungeonBaseEnum.DungeonMode.Story] = "v2a9_dungeon_progress2_1",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story2] = "v2a9_dungeon_progress2_2",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story3] = "v2a9_dungeon_progress2_3"
}
var_0_0.LittleGameType = {
	Point = 3,
	Eye = 1,
	Line = 2
}
var_0_0.LittleGameType2EpisdoeConstId = {
	[var_0_0.LittleGameType.Eye] = AssassinEnum.ConstId.EpisodeId_EyeGame,
	[var_0_0.LittleGameType.Line] = AssassinEnum.ConstId.EpisodeId_LineGame,
	[var_0_0.LittleGameType.Point] = AssassinEnum.ConstId.EpisodeId_PointGame
}
var_0_0.LittleGameType2AfterStoryConstId = {
	[var_0_0.LittleGameType.Eye] = AssassinEnum.ConstId.AfterStoryId_EyeGame,
	[var_0_0.LittleGameType.Line] = AssassinEnum.ConstId.AfterStoryId_LineGame,
	[var_0_0.LittleGameType.Point] = AssassinEnum.ConstId.AfterStoryId_PointGame
}
var_0_0.LoadWorkType = {
	Layout = 2,
	Scene = 1
}
var_0_0.FightGoalItemResUrl = "ui/viewres/sp01/assassin2/v2a9_fightgoalitem.prefab"
var_0_0.EpisodeMaxProgress = 1
var_0_0.EpisodeSelectDuration = 0.5
var_0_0.Map_Visible_Tween_Time = 0.2
var_0_0.Map_Hide_Root_PosY = -20
var_0_0.TWEEN_TIME = 0.2
var_0_0.MapTweenStopLerp = 0.1
var_0_0.MapStopVelocityRate = 0.3
var_0_0.MapScrollOffsetRate = 0.8
var_0_0.Time_FocuysNewEpisode = 0.8
var_0_0.MapBgAudioName = "s01_bg"
var_0_0.MapMaxPosXRange = 162.3
var_0_0.MapFocusScale = 2.3
var_0_0.PixelPerUnit = 100
var_0_0.MapStartWorldPos = Vector3(0, 0, 0)
var_0_0.DNANodeClickSize = Vector2(2, 5)
