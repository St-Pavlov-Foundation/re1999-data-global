-- chunkname: @modules/logic/versionactivity3_5/puzzle/define/V3a5PuzzleEnum.lua

module("modules.logic.versionactivity3_5.puzzle.define.V3a5PuzzleEnum", package.seeall)

local V3a5PuzzleEnum = _M

V3a5PuzzleEnum.ConstId = {
	PreStoryId = 3,
	CorrectIconIndex = 2,
	ClickErrorTimes = 1,
	V3a6_PreStoryId = 202,
	V3a6_NextStoryId = 203,
	V3a6_InputChar = 201,
	NextStoryId = 4
}
V3a5PuzzleEnum.IconCount = 20
V3a5PuzzleEnum.StoryView = {
	[V3a5PuzzleEnum.ConstId.PreStoryId] = ViewName.V3a5PuzzleView,
	[V3a5PuzzleEnum.ConstId.V3a6_PreStoryId] = ViewName.V3a6PuzzleView
}
V3a5PuzzleEnum.NextStoryView = {
	[ViewName.V3a5PuzzleView] = V3a5PuzzleEnum.ConstId.NextStoryId,
	[ViewName.V3a6PuzzleView] = V3a5PuzzleEnum.ConstId.V3a6_NextStoryId
}

return V3a5PuzzleEnum
