module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.define.VersionActivity1_2DungeonEnum", package.seeall)

slot0 = _M
slot0.DungeonChapterId = {
	Activity1_2DungeonNormal2 = 12301,
	Activity1_2DungeonHard = 12201,
	Activity1_2DungeonNormal3 = 12401,
	Activity1_2DungeonNormal1 = 12101
}
slot0.DungeonMode = {
	Hard = 2,
	Story = 1
}
slot0.DungeonChapterId2ViewShowId = {
	[slot0.DungeonChapterId.Activity1_2DungeonNormal1] = slot0.DungeonChapterId.Activity1_2DungeonNormal1,
	[slot0.DungeonChapterId.Activity1_2DungeonNormal2] = slot0.DungeonChapterId.Activity1_2DungeonNormal1,
	[slot0.DungeonChapterId.Activity1_2DungeonNormal3] = slot0.DungeonChapterId.Activity1_2DungeonNormal1
}
slot0.DungeonChapterId2UIModel = {
	[slot0.DungeonChapterId.Activity1_2DungeonNormal1] = 1,
	[slot0.DungeonChapterId.Activity1_2DungeonNormal2] = 1,
	[slot0.DungeonChapterId.Activity1_2DungeonNormal3] = 1,
	[slot0.DungeonChapterId.Activity1_2DungeonHard] = 2
}
slot0.DungeonChapterIdChangeModel = {
	[slot0.DungeonChapterId.Activity1_2DungeonNormal1] = slot0.DungeonChapterId.Activity1_2DungeonHard,
	[slot0.DungeonChapterId.Activity1_2DungeonHard] = slot0.DungeonChapterId.Activity1_2DungeonNormal1
}
slot0.DungeonChapterId2EndChapterId = {
	[slot0.DungeonChapterId.Activity1_2DungeonNormal1] = slot0.DungeonChapterId.Activity1_2DungeonNormal3,
	[slot0.DungeonChapterId.Activity1_2DungeonNormal2] = slot0.DungeonChapterId.Activity1_2DungeonNormal3,
	[slot0.DungeonChapterId.Activity1_2DungeonNormal3] = slot0.DungeonChapterId.Activity1_2DungeonNormal3
}
slot0.DungeonChapterId2StartChapterId = {
	[slot0.DungeonChapterId.Activity1_2DungeonNormal1] = slot0.DungeonChapterId.Activity1_2DungeonNormal1,
	[slot0.DungeonChapterId.Activity1_2DungeonNormal2] = slot0.DungeonChapterId.Activity1_2DungeonNormal1,
	[slot0.DungeonChapterId.Activity1_2DungeonNormal3] = slot0.DungeonChapterId.Activity1_2DungeonNormal1
}
slot0.DungeonChapterId2ActivityID = {
	[slot0.DungeonChapterId.Activity1_2DungeonNormal1] = VersionActivity1_2DungeonModel.instance:getCurActivityID(),
	[slot0.DungeonChapterId.Activity1_2DungeonNormal2] = VersionActivity1_2DungeonModel.instance:getCurActivityID(),
	[slot0.DungeonChapterId.Activity1_2DungeonNormal3] = VersionActivity1_2DungeonModel.instance:getCurActivityID(),
	[slot0.DungeonChapterId.Activity1_2DungeonHard] = VersionActivity1_2DungeonModel.instance:getCurActivityID()
}

return slot0
