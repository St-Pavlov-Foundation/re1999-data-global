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
var_0_0.MapPosYCurve = "0#-8.5#2.76496#2.76496#0.3333333#0.656047#0|0.03777844#-7.94#3.482616#1.415188#0.3367729#0.7432456#0|0.0655567#-6.42#0#0#0.3333333#0.3333333#0|0.08444592#-7.75#-3.62449#-3.62449#0.3333333#0.3333333#0|0.1044463#-8.58#0#0#0.3333333#0.3333333#0|0.1411136#-6.4#0#0#0.3333333#0.3333333#0|0.1722252#-7.634314#0.2758631#0.2758631#0.3333333#0.3333333#0|0.2088925#-6.02#0#0#0.3333333#0.3333333#0|0.2333374#-8.47#-0.1949237#-0.1949237#0.3333333#0.3333333#0|0.2600045#-9#-0.07125419#-0.07125419#0.3333333#0.3333333#0|0.2855605#-8.52#10.09796#20.4183#0.4271546#0.419604#0|0.3122277#-6.94#2.673388#1.519595#0.7576337#0.6651042#0|0.3466727#-7.59#-5.603214#-5.603214#0.3333333#0.1916098#0|0.4000069#-9.13#0#0#0.3333333#0.3333333#0|0.4600081#-5.59#0#0#0.3333333#0.3333333#0|0.4922308#-4.373166#1.333835#1.212006#0.330912#0.503273#0|0.5088978#-4.56#-1.799999#-1.799999#0.3333333#0.3333333#0|0.5433428#-6.1#0#0#0.3333333#0.3333333#0|0.571121#-6.47#-3.770264#-9.771672#0.6531861#0.6132083#0|0.5988994#-8.02#0#0#0.3333333#0.3333333#0|0.630011#-7.08#6.344685#6.846338#0.3333333#0.6881484#0|0.6511225#-4.17#9.294105#8.964173#0.5438113#0.4798033#0|0.6989012#-2.6#0#0#0.3333333#0.3333333#0|0.7411241#-2.61#-0.165588#-0.165588#0.3333333#0.3333333#0|0.7744579#-6.25#-0.02874248#-0.02874248#0.3333333#0.3333333#0|0.7977916#-3.79#8.127873#6.775735#0.3852142#0.1632368#0|0.817792#-1.73#4.399997#4.399997#0.3333333#0.3333333#0|0.8377924#-1.15#3.740168#3.740168#0.3333333#0.3333333#0|0.8611261#-1.93#-1.817647#-1.817647#0.3333333#0.3333333#0|0.8911266#-5.23#-0.5498232#-2.850125#0.4229248#0.8295949#0|0.9233494#-6.21#-2.467897#-2.467897#0.3333333#0.3333333#0|0.9489055#-7.3#-5.032031#-9.561578#0.4408937#0.3177358#0|0.9811282#-9.53#0#0#0.3333333#0.3333333#0|1#-7.68#12.2004#12.2004#0.45608#0.3333333#0"
var_0_0.MapPosZCurve = "0#-10.5#0#0#0.3333333#0.3333333#0|0.03445813#-11.98#0#0#0.3333333#0.3333333#0|0.1289401#-11.08#16.44658#16.44658#0.3333333#0.3333333#0|0.1767369#-9.64#36.75134#36.75134#0.3333333#0.3333333#0|0.285669#-3.24#30.71951#30.71951#0.3333333#0.3333333#0|0.3134578#-2.19#2.290535#2.290535#0.3333333#0.04893222#0|0.4057168#11.34232#2.491357#2.491357#0.5067036#0.3333333#0|0.5190951#10.14488#3.790189#3.790189#0.3333333#1#0|0.581342#14.13447#3.164289#3.164289#0.3333333#0.3333333#0|0.6602623#14.55#3.763344#3.763344#0.3333333#0.3333333#0|0.7714176#24.86#1.736434#1.736434#0.3333333#0.3333333#0|0.8558956#23.7#0#0#0.3333333#0.3333333#0|1#34.15#0#0#0.3333333#0.3333333#0"
var_0_0.MapMaxPosXRange = 162.3
var_0_0.MapFocusScale = 2.3
var_0_0.PixelPerUnit = 100
var_0_0.MapStartWorldPos = Vector3(0, 0, 0)
var_0_0.DNANodeClickSize = Vector2(2, 5)
