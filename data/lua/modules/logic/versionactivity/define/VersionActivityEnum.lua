module("modules.logic.versionactivity.define.VersionActivityEnum", package.seeall)

slot0 = _M
slot0.DungeonMapCameraSize = 6.75
slot0.PuzzleColorEnum = {
	MatchErrorColor = "#725f5a",
	MatchCorrectColor = "#833d00"
}
slot0.ActivityId = {
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
slot0.EnterViewActIdList = {
	slot0.ActivityId.Act113,
	slot0.ActivityId.Act104,
	slot0.ActivityId.Act112,
	slot0.ActivityId.Act109,
	slot0.ActivityId.Act111,
	slot0.ActivityId.Act108
}
slot0.DungeonChapterId = {
	LeiMiTeBei4 = 11401,
	LeiMiTeBeiHard = 11201,
	LeiMiTeBei3 = 11301,
	ElementFight = 11102,
	LeiMiTeBei = 11101
}
slot0.ZeroEpisodeId = {
	Hard = 1120100,
	Story = 1110100
}
slot0.EpisodeItemMinWidth = 300
slot0.FirstVersionActivityPuzzleElementId = 11101061
slot0.EnterViewNormalAnimationPath = {
	[slot0.ActivityId.Act113] = "normal",
	[slot0.ActivityId.Act104] = "normal/changeColorContainer"
}

return slot0
