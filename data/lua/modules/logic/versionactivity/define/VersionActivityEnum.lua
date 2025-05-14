module("modules.logic.versionactivity.define.VersionActivityEnum", package.seeall)

local var_0_0 = _M

var_0_0.DungeonMapCameraSize = 6.75
var_0_0.PuzzleColorEnum = {
	MatchErrorColor = "#725f5a",
	MatchCorrectColor = "#833d00"
}
var_0_0.ActivityId = {
	Act111 = 11113,
	Act108 = 11102,
	SeasonStore = 11115,
	Act104 = 11100,
	Act106 = 11111,
	Act112 = 11114,
	Act121 = 11209,
	Act109 = 11103,
	Act113 = 11104,
	Act105 = 11101,
	Act107 = 11112
}
var_0_0.EnterViewActIdList = {
	var_0_0.ActivityId.Act113,
	var_0_0.ActivityId.Act104,
	var_0_0.ActivityId.Act112,
	var_0_0.ActivityId.Act109,
	var_0_0.ActivityId.Act111,
	var_0_0.ActivityId.Act108
}
var_0_0.DungeonChapterId = {
	LeiMiTeBei4 = 11401,
	LeiMiTeBeiHard = 11201,
	LeiMiTeBei3 = 11301,
	ElementFight = 11102,
	LeiMiTeBei = 11101
}
var_0_0.ZeroEpisodeId = {
	Hard = 1120100,
	Story = 1110100
}
var_0_0.EpisodeItemMinWidth = 300
var_0_0.FirstVersionActivityPuzzleElementId = 11101061
var_0_0.EnterViewNormalAnimationPath = {
	[var_0_0.ActivityId.Act113] = "normal",
	[var_0_0.ActivityId.Act104] = "normal/changeColorContainer"
}

return var_0_0
