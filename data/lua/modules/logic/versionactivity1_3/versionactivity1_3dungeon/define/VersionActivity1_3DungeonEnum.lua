module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.define.VersionActivity1_3DungeonEnum", package.seeall)

slot0 = _M
slot0.DungeonMapCameraSize = 5
slot0.DungeonChapterId = {
	LeiMiTeBei4 = 13401,
	LeiMiTeBeiHard = 13201,
	LeiMiTeBei3 = 13301,
	ElementFight = 13102,
	Daily = 13501,
	LeiMiTeBei = 13101
}
slot0.EpisodeStarType = {
	[slot0.DungeonChapterId.LeiMiTeBei] = "v1a3_dungeon_star_2",
	[slot0.DungeonChapterId.LeiMiTeBeiHard] = "v1a3_dungeon_star_4",
	[slot0.DungeonChapterId.LeiMiTeBei3] = "v1a3_dungeon_star_3",
	[slot0.DungeonChapterId.LeiMiTeBei4] = "v1a3_dungeon_star_4"
}
slot0.EpisodeStarEmptyType = {
	[slot0.DungeonChapterId.LeiMiTeBei] = "v1a3_dungeon_star_1",
	[slot0.DungeonChapterId.LeiMiTeBeiHard] = "v1a3_dungeon_star_5",
	[slot0.DungeonChapterId.LeiMiTeBei3] = "v1a3_dungeon_star_1",
	[slot0.DungeonChapterId.LeiMiTeBei4] = "v1a3_dungeon_star_5"
}
slot0.ConstKey = {
	Daily = 2
}
slot0.EpisodeItemMinWidth = 300
slot0.DailyEpisodeId = 1310108
slot0.ExtraEpisodeId = 1310194
slot0.JumpDaily = 10011312

return slot0
