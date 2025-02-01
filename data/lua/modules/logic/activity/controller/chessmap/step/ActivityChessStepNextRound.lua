module("modules.logic.activity.controller.chessmap.step.ActivityChessStepNextRound", package.seeall)

slot0 = class("ActivityChessStepNextRound", ActivityChessStepBase)

function slot0.start(slot0)
	slot0:finish()
end

function slot0.finish(slot0)
	if ActivityChessGameController.instance.event then
		slot1:setCurEvent(nil)
	end

	ActivityChessGameModel.instance:setRound(slot0.originData.currentRound)
	ActivityChessGameController.instance:tryResumeSelectObj()
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.CurrentRoundUpdate)
	uv0.super.finish(slot0)
end

return slot0
