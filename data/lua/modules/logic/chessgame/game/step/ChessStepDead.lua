module("modules.logic.chessgame.game.step.ChessStepDead", package.seeall)

slot0 = class("ChessStepDead", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot0:_onFail()
end

function slot0._onFail(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.OnFail)
	ChessGameController.instance:gameOver()
	slot0:onDone(true)
end

return slot0
