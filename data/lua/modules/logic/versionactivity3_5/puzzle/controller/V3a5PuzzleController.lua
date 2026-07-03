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

function V3a5PuzzleController:_initStoryViewInfo()
	self._storyViewInfos = {}

	for const, viewName in pairs(V3a5PuzzleEnum.StoryView) do
		local storyId = V3a5PuzzleConfig.instance:getConstValue(const)

		self._storyViewInfos[storyId] = viewName
	end
end

function V3a5PuzzleController:checkOpenPuzzleView(storyId)
	if not self._storyViewInfos then
		self:_initStoryViewInfo()
	end

	for _storyId, viewName in pairs(self._storyViewInfos) do
		if _storyId == storyId then
			ViewMgr.instance:openView(viewName, {
				storyId = storyId
			})

			return true
		end
	end

	return false
end

function V3a5PuzzleController:playNextStory(viewName, cb, cbObj)
	local nextStory = V3a5PuzzleEnum.NextStoryView[viewName]

	if not nextStory then
		return
	end

	local nextStoryId = V3a5PuzzleConfig.instance:getConstValue(nextStory)

	local function _cb()
		DungeonRpc.instance:sendEndDungeonRequest(false)

		if cb then
			cb(cbObj)
		end
	end

	StoryController.instance:playStory(nextStoryId, nil, _cb)
end

V3a5PuzzleController.instance = V3a5PuzzleController.New()

return V3a5PuzzleController
