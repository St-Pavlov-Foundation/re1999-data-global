-- chunkname: @modules/logic/versionactivity3_5/puzzle/controller/V3a5PuzzleController.lua

module("modules.logic.versionactivity3_5.puzzle.controller.V3a5PuzzleController", package.seeall)

local V3a5PuzzleController = class("V3a5PuzzleController", BaseController)

function V3a5PuzzleController:onInit()
	return
end

function V3a5PuzzleController:onInitFinish()
	return
end

function V3a5PuzzleController:addConstEvents()
	return
end

function V3a5PuzzleController:reInit()
	return
end

function V3a5PuzzleController:checkOpenPuzzleView(storyId)
	if not self._preStoryId then
		self._preStoryId = V3a5PuzzleConfig.instance:getConstValue(V3a5PuzzleEnum.ConstId.PreStoryId)
	end

	if self._preStoryId == storyId then
		ViewMgr.instance:openView(ViewName.V3a5PuzzleView, {
			storyId = storyId
		})

		return true
	end

	return false
end

function V3a5PuzzleController:playNextStory(cb, cbObj)
	if not self._nextStoryId then
		self._nextStoryId = V3a5PuzzleConfig.instance:getConstValue(V3a5PuzzleEnum.ConstId.NextStoryId)
	end

	local function _cb()
		DungeonRpc.instance:sendEndDungeonRequest(false)

		if cb then
			cb(cbObj)
		end
	end

	StoryController.instance:playStory(self._nextStoryId, nil, _cb)
end

V3a5PuzzleController.instance = V3a5PuzzleController.New()

return V3a5PuzzleController
