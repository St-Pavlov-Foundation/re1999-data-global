-- chunkname: @modules/logic/versionactivity1_4/puzzle/view/Role37PuzzleRecordViewContainer.lua

module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleRecordViewContainer", package.seeall)

local Role37PuzzleRecordViewContainer = class("Role37PuzzleRecordViewContainer", BaseViewContainer)

function Role37PuzzleRecordViewContainer:buildViews()
	local views = {}

	table.insert(views, Role37PuzzleRecordView.New())

	return views
end

return Role37PuzzleRecordViewContainer
