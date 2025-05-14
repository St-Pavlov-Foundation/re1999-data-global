module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.define.VersionActivity1_2DungeonEnum", package.seeall)

local var_0_0 = _M

var_0_0.DungeonChapterId = {
	Activity1_2DungeonNormal2 = 12301,
	Activity1_2DungeonHard = 12201,
	Activity1_2DungeonNormal3 = 12401,
	Activity1_2DungeonNormal1 = 12101
}
var_0_0.DungeonMode = {
	Hard = 2,
	Story = 1
}
var_0_0.DungeonChapterId2ViewShowId = {
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal1] = var_0_0.DungeonChapterId.Activity1_2DungeonNormal1,
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal2] = var_0_0.DungeonChapterId.Activity1_2DungeonNormal1,
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal3] = var_0_0.DungeonChapterId.Activity1_2DungeonNormal1
}
var_0_0.DungeonChapterId2UIModel = {
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal1] = 1,
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal2] = 1,
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal3] = 1,
	[var_0_0.DungeonChapterId.Activity1_2DungeonHard] = 2
}
var_0_0.DungeonChapterIdChangeModel = {
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal1] = var_0_0.DungeonChapterId.Activity1_2DungeonHard,
	[var_0_0.DungeonChapterId.Activity1_2DungeonHard] = var_0_0.DungeonChapterId.Activity1_2DungeonNormal1
}
var_0_0.DungeonChapterId2EndChapterId = {
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal1] = var_0_0.DungeonChapterId.Activity1_2DungeonNormal3,
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal2] = var_0_0.DungeonChapterId.Activity1_2DungeonNormal3,
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal3] = var_0_0.DungeonChapterId.Activity1_2DungeonNormal3
}
var_0_0.DungeonChapterId2StartChapterId = {
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal1] = var_0_0.DungeonChapterId.Activity1_2DungeonNormal1,
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal2] = var_0_0.DungeonChapterId.Activity1_2DungeonNormal1,
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal3] = var_0_0.DungeonChapterId.Activity1_2DungeonNormal1
}
var_0_0.DungeonChapterId2ActivityID = {
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal1] = VersionActivity1_2DungeonModel.instance:getCurActivityID(),
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal2] = VersionActivity1_2DungeonModel.instance:getCurActivityID(),
	[var_0_0.DungeonChapterId.Activity1_2DungeonNormal3] = VersionActivity1_2DungeonModel.instance:getCurActivityID(),
	[var_0_0.DungeonChapterId.Activity1_2DungeonHard] = VersionActivity1_2DungeonModel.instance:getCurActivityID()
}

return var_0_0
