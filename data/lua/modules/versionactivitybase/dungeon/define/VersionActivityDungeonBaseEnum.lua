module("modules.versionactivitybase.dungeon.define.VersionActivityDungeonBaseEnum", package.seeall)

slot0 = _M
slot0.ModeSelectColor = Color.white
slot0.ModeDisSelectColor = Color(0.4, 0.4, 0.4, 1)
slot0.DungeonMode = {
	Story3 = 3,
	Story = 1,
	Hard = 4,
	Story1 = 1,
	Story2 = 2,
	None = 0
}
slot0.DungeonMode2ChapterIdKey = {
	[slot0.DungeonMode.Story] = "story1ChapterId",
	[slot0.DungeonMode.Story1] = "story1ChapterId",
	[slot0.DungeonMode.Story2] = "story2ChapterId",
	[slot0.DungeonMode.Story3] = "story3ChapterId",
	[slot0.DungeonMode.Hard] = "hardChapterId"
}
slot0.ChapterModeNameKey = {
	[slot0.DungeonMode.Story] = "p_versionactivitydungeonmaplevelview_type1",
	[slot0.DungeonMode.Story1] = "p_versionactivitydungeonmaplevelview_type1",
	[slot0.DungeonMode.Story2] = "p_versionactivitydungeonmaplevelview_type2",
	[slot0.DungeonMode.Story3] = "p_versionactivitydungeonmaplevelview_type3",
	[slot0.DungeonMode.Hard] = "p_versionactivitydungeonmaplevelview_type4"
}

return slot0
