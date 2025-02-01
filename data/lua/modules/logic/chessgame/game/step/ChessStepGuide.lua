module("modules.logic.chessgame.game.step.ChessStepGuide", package.seeall)

slot0 = class("ChessStepGuide", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	if GuideController.instance:isForbidGuides() then
		slot0:onDone(true)

		return
	end

	slot0._guideId = tonumber(slot0.originData.guideId)

	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, slot0._onGuideFinish, slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GuideStart, tostring(slot0._guideId))
end

function slot0._onGuideFinish(slot0, slot1)
	if slot0._guideId ~= slot1 then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, slot0._onGuideFinish, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, slot0._onGuideFinish, slot0)
end

return slot0
