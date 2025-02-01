module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepNextRound", package.seeall)

slot0 = class("Va3ChessStepNextRound", Va3ChessStepBase)

function slot0.start(slot0)
	slot0:finish()
end

function slot0.finish(slot0)
	Va3ChessGameModel.instance:setRound(slot0.originData.currentRound)
	Va3ChessGameController.instance:tryResumeSelectObj()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.CurrentRoundUpdate)

	if Va3ChessGameController.instance.event then
		slot1:setCurEvent(nil)
	end

	Va3ChessGameController.instance:forceRefreshObjSelectedView()
	uv0.super.finish(slot0)
end

return slot0
