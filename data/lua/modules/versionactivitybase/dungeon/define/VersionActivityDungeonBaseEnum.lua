module("modules.versionactivitybase.dungeon.define.VersionActivityDungeonBaseEnum", package.seeall)

local var_0_0 = _M

var_0_0.ModeSelectColor = Color.white
var_0_0.ModeDisSelectColor = Color(0.4, 0.4, 0.4, 1)
var_0_0.DungeonMode = {
	Story3 = 3,
	Story = 1,
	Hard = 4,
	Story1 = 1,
	Story2 = 2,
	None = 0
}
var_0_0.DungeonMode2ChapterIdKey = {
	[var_0_0.DungeonMode.Story] = "story1ChapterId",
	[var_0_0.DungeonMode.Story1] = "story1ChapterId",
	[var_0_0.DungeonMode.Story2] = "story2ChapterId",
	[var_0_0.DungeonMode.Story3] = "story3ChapterId",
	[var_0_0.DungeonMode.Hard] = "hardChapterId"
}
var_0_0.ChapterModeNameKey = {
	[var_0_0.DungeonMode.Story] = "p_versionactivitydungeonmaplevelview_type1",
	[var_0_0.DungeonMode.Story1] = "p_versionactivitydungeonmaplevelview_type1",
	[var_0_0.DungeonMode.Story2] = "p_versionactivitydungeonmaplevelview_type2",
	[var_0_0.DungeonMode.Story3] = "p_versionactivitydungeonmaplevelview_type3",
	[var_0_0.DungeonMode.Hard] = "p_versionactivitydungeonmaplevelview_type4"
}

return var_0_0
