module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.define.VersionActivity1_3DungeonEnum", package.seeall)

local var_0_0 = _M

var_0_0.DungeonMapCameraSize = 5
var_0_0.DungeonChapterId = {
	LeiMiTeBei4 = 13401,
	LeiMiTeBeiHard = 13201,
	LeiMiTeBei3 = 13301,
	ElementFight = 13102,
	Daily = 13501,
	LeiMiTeBei = 13101
}
var_0_0.EpisodeStarType = {
	[var_0_0.DungeonChapterId.LeiMiTeBei] = "v1a3_dungeon_star_2",
	[var_0_0.DungeonChapterId.LeiMiTeBeiHard] = "v1a3_dungeon_star_4",
	[var_0_0.DungeonChapterId.LeiMiTeBei3] = "v1a3_dungeon_star_3",
	[var_0_0.DungeonChapterId.LeiMiTeBei4] = "v1a3_dungeon_star_4"
}
var_0_0.EpisodeStarEmptyType = {
	[var_0_0.DungeonChapterId.LeiMiTeBei] = "v1a3_dungeon_star_1",
	[var_0_0.DungeonChapterId.LeiMiTeBeiHard] = "v1a3_dungeon_star_5",
	[var_0_0.DungeonChapterId.LeiMiTeBei3] = "v1a3_dungeon_star_1",
	[var_0_0.DungeonChapterId.LeiMiTeBei4] = "v1a3_dungeon_star_5"
}
var_0_0.ConstKey = {
	Daily = 2
}
var_0_0.EpisodeItemMinWidth = 300
var_0_0.DailyEpisodeId = 1310108
var_0_0.ExtraEpisodeId = 1310194
var_0_0.JumpDaily = 10011312

return var_0_0
