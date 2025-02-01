module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepStory", package.seeall)

slot0 = class("Va3ChessStepStory", Va3ChessStepBase)

function slot0.start(slot0)
	TaskDispatcher.cancelTask(slot0.finish, slot0)

	if Va3ChessConfig.instance:getTipsCfg(Va3ChessModel.instance:getActId(), slot0.originData.storyId) ~= nil then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameToastUpdate, slot1)
		TaskDispatcher.runDelay(slot0.finish, slot0, 1)

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
		Va3ChessGameModel.instance:setPlayingStory(true)
	else
		slot0:finish()
	end
end

function slot0.afterPlayStory(slot0)
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", slot0._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", slot0._initDistortStrength)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.PlayStoryFinish)
	Va3ChessGameModel.instance:setPlayingStory(false)
	TaskDispatcher.runDelay(slot0.finish, slot0, 0.3)
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.finish, slot0)
	uv0.super.dispose(slot0)
end

return slot0
