module("modules.logic.chessgame.game.step.ChessStepStory", package.seeall)

slot0 = class("ChessStepStory", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.cancelTask(slot0.onDoneTrue, slot0)

	if ChessConfig.instance:getTipsCo(ChessModel.instance:getActId(), slot0.originData.storyId) ~= nil then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameToastUpdate, slot1)
		TaskDispatcher.runDelay(slot0.onDoneTrue, slot0, 1)

		return
	end

	if slot1 then
		slot0._initMaskActive = PostProcessingMgr.instance:getUIPPValue("LocalMaskActive")
		slot0._initDistortStrength = PostProcessingMgr.instance:getUIPPValue("LocalDistortStrength")

		PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", false)
		PostProcessingMgr.instance:setUIPPValue("localDistortStrength", 0)
		PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", 0)
		StoryController.instance:playStory(slot4, {
			blur = true,
			hideStartAndEndDark = true,
			mark = true,
			isReplay = false
		}, slot0.afterPlayStory, slot0)
		ChessGameModel.instance:setPlayingStory(true)
	else
		slot0:onDone(true)
	end
end

function slot0.onDoneTrue(slot0)
	slot0:onDone(true)
end

function slot0.afterPlayStory(slot0)
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", slot0._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", slot0._initDistortStrength)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.PlayStoryonDone)
	ChessGameModel.instance:setPlayingStory(false)
	TaskDispatcher.runDelay(slot0.onDoneTrue, slot0, 0.3)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0.onDoneTrue, slot0)
end

return slot0
