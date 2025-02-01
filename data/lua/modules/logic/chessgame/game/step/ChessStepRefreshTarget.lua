module("modules.logic.chessgame.game.step.ChessStepRefreshTarget", package.seeall)

slot0 = class("ChessStepRefreshTarget", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	ChessGameModel.instance:setCompletedCount(slot0.originData.completedCount)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.CurrentConditionUpdate)
	slot0:onDone(true)
end

return slot0
