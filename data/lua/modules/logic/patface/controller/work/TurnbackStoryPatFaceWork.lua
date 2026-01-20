-- chunkname: @modules/logic/patface/controller/work/TurnbackStoryPatFaceWork.lua

module("modules.logic.patface.controller.work.TurnbackStoryPatFaceWork", package.seeall)

local TurnbackStoryPatFaceWork = class("TurnbackStoryPatFaceWork", PatFaceWorkBase)

function TurnbackStoryPatFaceWork:checkCanPat()
	local result = false
	local canShowPop = TurnbackModel.instance:canShowTurnbackPop()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local hasPlayed = TurnbackController.instance:hasPlayedStoryVideo(turnbackId)

	if canShowPop and not hasPlayed then
		result = true
	end

	return result
end

function TurnbackStoryPatFaceWork:startPat()
	local TurnbackMo = TurnbackModel.instance:getCurTurnbackMo()
	local storyId = TurnbackMo and TurnbackMo.config and TurnbackMo.config.startStory

	if storyId then
		StoryController.instance:playStory(storyId, nil, self.onPlayPatStoryFinish, self)
	else
		logError(string.format("TurnbackStoryPatFaceWork:startPat error, storyId is nil", storyId))
		self:onPlayPatStoryFinish()
	end
end

return TurnbackStoryPatFaceWork
