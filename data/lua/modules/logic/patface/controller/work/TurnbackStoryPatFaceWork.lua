module("modules.logic.patface.controller.work.TurnbackStoryPatFaceWork", package.seeall)

slot0 = class("TurnbackStoryPatFaceWork", PatFaceWorkBase)

function slot0.checkCanPat(slot0)
	slot1 = false

	if TurnbackModel.instance:canShowTurnbackPop() and not TurnbackController.instance:hasPlayedStoryVideo(TurnbackModel.instance:getCurTurnbackId()) then
		slot1 = true
	end

	return slot1
end

function slot0.startPat(slot0)
	if TurnbackModel.instance:getCurTurnbackMo() and slot1.config and slot1.config.startStory then
		StoryController.instance:playStory(slot2, nil, slot0.onPlayPatStoryFinish, slot0)
	else
		logError(string.format("TurnbackStoryPatFaceWork:startPat error, storyId is nil", slot2))
		slot0:onPlayPatStoryFinish()
	end
end

return slot0
