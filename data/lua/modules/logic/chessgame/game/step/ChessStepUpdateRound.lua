module("modules.logic.chessgame.game.step.ChessStepUpdateRound", package.seeall)

slot0 = class("ChessStepUpdateRound", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot0:finish()
end

function slot0.finish(slot0)
	slot1 = ChessGameController.instance.eventMgr

	ChessGameModel.instance:setRound(slot0.originData.currRound)

	if not ChessGameModel.instance:isTalking() then
		ChessGameController.instance:tryResumeSelectObj()
	end

	ChessGameController.instance:dispatchEvent(ChessGameEvent.CurrentRoundUpdate)

	if slot1 then
		slot1:setCurEvent(nil)
	end

	ChessGameController.instance:forceRefreshObjSelectedView()
	slot0:onDone(true)
end

return slot0
