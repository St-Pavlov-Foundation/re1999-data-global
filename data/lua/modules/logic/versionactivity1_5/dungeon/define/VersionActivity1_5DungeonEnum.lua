module("modules.logic.versionactivity1_5.dungeon.define.VersionActivity1_5DungeonEnum", package.seeall)

slot0 = _M
slot0.DungeonMapCameraSize = 5
slot0.DungeonChapterId = {
	ElementFight = 15102,
	Story = 15101,
	Hard = 15201,
	Story1 = 15101,
	Story4 = 15201,
	Story2 = 15301,
	Story3 = 15401
}
slot0.SceneRootName = "VersionActivity1_5DungeonMapScene"
slot0.EpisodeItemMinWidth = 300
slot0.EpisodeStarType = {
	[slot0.DungeonChapterId.Story1] = "v1a5_dungeon_star_2",
	[slot0.DungeonChapterId.Story2] = "v1a5_dungeon_star_3",
	[slot0.DungeonChapterId.Story3] = "v1a5_dungeon_star_5",
	[slot0.DungeonChapterId.Story4] = "v1a5_dungeon_star_5"
}
slot0.EpisodeStarEmptyType = {
	[slot0.DungeonChapterId.Story1] = "v1a5_dungeon_star_1",
	[slot0.DungeonChapterId.Story2] = "v1a5_dungeon_star_1",
	[slot0.DungeonChapterId.Story3] = "v1a5_dungeon_star_4",
	[slot0.DungeonChapterId.Story4] = "v1a5_dungeon_star_4"
}
slot0.SceneEffect = {
	DayTime = "scenes/v1a5_m_s14_hddt_hd/scenes_prefab/hddt_fog_a.prefab",
	Night = "scenes/v1a5_m_s14_hddt_hd/scenes_prefab/hddt_fog_b.prefab"
}
slot0.MapId2Light = {
	[1510101.0] = true,
	[1510108.0] = true,
	[1510115.0] = true,
	[1510107.0] = true,
	[1510114.0] = false,
	[1510106.0] = true,
	[1510113.0] = false,
	[1510105.0] = true,
	[1510112.0] = false,
	[1510104.0] = false,
	[1510111.0] = false,
	[1510103.0] = true,
	[1510110.0] = true,
	[1510102.0] = true,
	[1510109.0] = true
}
slot0.ElementTimeOffsetY = 0.8
slot0.HardModeUnlockAnimDuration = 1.33
slot0.MapDir = {
	Top = 3,
	Left = 1,
	Right = 2,
	Bottom = 4
}
slot0.MapDirCenterViewPortPos = Vector2(0.5, 0.5)
slot0.MapRateEqualRange = 0.001
slot0.MapHeroItemAnchorYOffset = 10
slot0.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
slot0.MaxHoleNum = 5
slot0.HoleHalfWidth = 3.5
slot0.HoleHalfHeight = 1.75
slot0.HoleAnimDuration = 0.33
slot0.HoleAnimMaxZ = 3
slot0.HoleAnimMinZ = 0
slot0.AreaItemOffsetY = 36
slot0.DispatchStatus = {
	Finished = 3,
	NotDispatch = 1,
	Dispatching = 2
}
slot0.ExploreTaskId = 0
slot0.ExploreTaskLineCount = 20
slot0.ExploreTipOffsetX = 55
slot0.ExploreTipAnchorY = {
	Max = 180,
	Min = -220
}
slot0.ExploreTabImageSelect = "v1a5_revival_btn_hotspot1"
slot0.ExploreTabImageNotSelect = "v1a5_revival_btn_hotspot1_1"
slot0.ExploreProgressPointLight = "v1a5_revival_img_point1_2"
slot0.ExploreProgressPointDark = "v1a5_revival_img_point1_1"
slot0.ExploreTaskUnLockType = {
	FinishAnyOneElement = 4,
	FinishEpisodeAndAnyOneElement = 5,
	FinishElement = 1,
	FinishEpisode = 2,
	FinishElementAndEpisode = 3
}
slot0.ExploreTaskType = {
	Fight = 2,
	Dispatch = 1
}
slot0.ExploreTaskStatus = {
	GainedReward = 5,
	Running = 3,
	Finished = 4,
	Lock = 1,
	Normal = 2
}
slot0.SubHeroTaskStatus = {
	Finished = 3,
	GainedReward = 4,
	Lock = 1,
	Normal = 2
}
slot0.DispatchShortedType = {
	Career = 1,
	HeroId = 2
}
slot0.SubHeroTaskUnLockType = {
	FinishElementAndEpisode = 4,
	FinishSubHeroTask = 3,
	FinishElement = 1,
	FinishEpisode = 2,
	FinishSubHeroTaskAndEpisode = 5
}
slot0.HeroTaskDescShowCount = 90
slot0.Suffix = string.rep(".", 3)
slot0.HeroTaskRedDotAnchor = {
	Lock = Vector2(-100, 88),
	Normal = Vector2(-124, 95)
}
slot0.BuildType = {
	First = 1,
	Second = 2,
	None = 0
}
slot0.BuildType2SmallImage = {
	[slot0.BuildType.First] = "v1a5_building_smallicon_1",
	[slot0.BuildType.Second] = "v1a5_building_smallicon_2",
	[slot0.BuildType.None] = "v1a5_building_smallicon_3"
}
slot0.BuildType2Image = {
	[slot0.BuildType.First] = "v1a5_building_icon_1",
	[slot0.BuildType.Second] = "v1a5_building_icon_2",
	[slot0.BuildType.None] = "v1a5_building_icon_3"
}
slot0.BuildType2TitleBgImage = {
	[slot0.BuildType.None] = "v1a5_building_buffbg_1",
	[slot0.BuildType.First] = "v1a5_building_buffbg_3",
	[slot0.BuildType.Second] = "v1a5_building_buffbg_2"
}
slot0.BuildType2TextColor = {
	[slot0.BuildType.None] = "#FFFAF3",
	[slot0.BuildType.First] = "#36AE8B",
	[slot0.BuildType.Second] = "#FFDC97"
}
slot0.BuildCount = 3
slot0.BuildMaxScale = 1.3
slot0.BuildFocusAnimTime = 0.5
slot0.SliderAnimTime = 1

return slot0
