module("modules.logic.versionactivity1_5.dungeon.define.VersionActivity1_5DungeonEnum", package.seeall)

local var_0_0 = _M

var_0_0.DungeonMapCameraSize = 5
var_0_0.DungeonChapterId = {
	ElementFight = 15102,
	Story = 15101,
	Hard = 15201,
	Story1 = 15101,
	Story4 = 15201,
	Story2 = 15301,
	Story3 = 15401
}
var_0_0.SceneRootName = "VersionActivity1_5DungeonMapScene"
var_0_0.EpisodeItemMinWidth = 300
var_0_0.EpisodeStarType = {
	[var_0_0.DungeonChapterId.Story1] = "v1a5_dungeon_star_2",
	[var_0_0.DungeonChapterId.Story2] = "v1a5_dungeon_star_3",
	[var_0_0.DungeonChapterId.Story3] = "v1a5_dungeon_star_5",
	[var_0_0.DungeonChapterId.Story4] = "v1a5_dungeon_star_5"
}
var_0_0.EpisodeStarEmptyType = {
	[var_0_0.DungeonChapterId.Story1] = "v1a5_dungeon_star_1",
	[var_0_0.DungeonChapterId.Story2] = "v1a5_dungeon_star_1",
	[var_0_0.DungeonChapterId.Story3] = "v1a5_dungeon_star_4",
	[var_0_0.DungeonChapterId.Story4] = "v1a5_dungeon_star_4"
}
var_0_0.SceneEffect = {
	DayTime = "scenes/v1a5_m_s14_hddt_hd/scenes_prefab/hddt_fog_a.prefab",
	Night = "scenes/v1a5_m_s14_hddt_hd/scenes_prefab/hddt_fog_b.prefab"
}
var_0_0.MapId2Light = {
	[1510101] = true,
	[1510108] = true,
	[1510115] = true,
	[1510107] = true,
	[1510114] = false,
	[1510106] = true,
	[1510113] = false,
	[1510105] = true,
	[1510112] = false,
	[1510104] = false,
	[1510111] = false,
	[1510103] = true,
	[1510110] = true,
	[1510102] = true,
	[1510109] = true
}
var_0_0.ElementTimeOffsetY = 0.8
var_0_0.HardModeUnlockAnimDuration = 1.33
var_0_0.MapDir = {
	Top = 3,
	Left = 1,
	Right = 2,
	Bottom = 4
}
var_0_0.MapDirCenterViewPortPos = Vector2(0.5, 0.5)
var_0_0.MapRateEqualRange = 0.001
var_0_0.MapHeroItemAnchorYOffset = 10
var_0_0.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
var_0_0.MaxHoleNum = 5
var_0_0.HoleHalfWidth = 3.5
var_0_0.HoleHalfHeight = 1.75
var_0_0.HoleAnimDuration = 0.33
var_0_0.HoleAnimMaxZ = 3
var_0_0.HoleAnimMinZ = 0
var_0_0.AreaItemOffsetY = 36
var_0_0.DispatchStatus = {
	Finished = 3,
	NotDispatch = 1,
	Dispatching = 2
}
var_0_0.ExploreTaskId = 0
var_0_0.ExploreTaskLineCount = 20
var_0_0.ExploreTipOffsetX = 55
var_0_0.ExploreTipAnchorY = {
	Max = 180,
	Min = -220
}
var_0_0.ExploreTabImageSelect = "v1a5_revival_btn_hotspot1"
var_0_0.ExploreTabImageNotSelect = "v1a5_revival_btn_hotspot1_1"
var_0_0.ExploreProgressPointLight = "v1a5_revival_img_point1_2"
var_0_0.ExploreProgressPointDark = "v1a5_revival_img_point1_1"
var_0_0.ExploreTaskUnLockType = {
	FinishAnyOneElement = 4,
	FinishEpisodeAndAnyOneElement = 5,
	FinishElement = 1,
	FinishEpisode = 2,
	FinishElementAndEpisode = 3
}
var_0_0.ExploreTaskType = {
	Fight = 2,
	Dispatch = 1
}
var_0_0.ExploreTaskStatus = {
	GainedReward = 5,
	Running = 3,
	Finished = 4,
	Lock = 1,
	Normal = 2
}
var_0_0.SubHeroTaskStatus = {
	Finished = 3,
	GainedReward = 4,
	Lock = 1,
	Normal = 2
}
var_0_0.DispatchShortedType = {
	Career = 1,
	HeroId = 2
}
var_0_0.SubHeroTaskUnLockType = {
	FinishElementAndEpisode = 4,
	FinishSubHeroTask = 3,
	FinishElement = 1,
	FinishEpisode = 2,
	FinishSubHeroTaskAndEpisode = 5
}
var_0_0.HeroTaskDescShowCount = 90
var_0_0.Suffix = string.rep(".", 3)
var_0_0.HeroTaskRedDotAnchor = {
	Lock = Vector2(-100, 88),
	Normal = Vector2(-124, 95)
}
var_0_0.BuildType = {
	First = 1,
	Second = 2,
	None = 0
}
var_0_0.BuildType2SmallImage = {
	[var_0_0.BuildType.First] = "v1a5_building_smallicon_1",
	[var_0_0.BuildType.Second] = "v1a5_building_smallicon_2",
	[var_0_0.BuildType.None] = "v1a5_building_smallicon_3"
}
var_0_0.BuildType2Image = {
	[var_0_0.BuildType.First] = "v1a5_building_icon_1",
	[var_0_0.BuildType.Second] = "v1a5_building_icon_2",
	[var_0_0.BuildType.None] = "v1a5_building_icon_3"
}
var_0_0.BuildType2TitleBgImage = {
	[var_0_0.BuildType.None] = "v1a5_building_buffbg_1",
	[var_0_0.BuildType.First] = "v1a5_building_buffbg_3",
	[var_0_0.BuildType.Second] = "v1a5_building_buffbg_2"
}
var_0_0.BuildType2TextColor = {
	[var_0_0.BuildType.None] = "#FFFAF3",
	[var_0_0.BuildType.First] = "#36AE8B",
	[var_0_0.BuildType.Second] = "#FFDC97"
}
var_0_0.BuildCount = 3
var_0_0.BuildMaxScale = 1.3
var_0_0.BuildFocusAnimTime = 0.5
var_0_0.SliderAnimTime = 1

return var_0_0
