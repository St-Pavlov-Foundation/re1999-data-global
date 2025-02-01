module("modules.logic.chessgame.game.step.ChessStepPass", package.seeall)

slot0 = class("ChessStepPass", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot0:processSelectObj()
	slot0:onWin()
end

function slot0.processSelectObj(slot0)
	ChessGameController.instance:setSelectObj(nil)
end

function slot0.onWin(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.OnVictory)
	ChessGameController.instance:gameWin()
	slot0:onDone(true)
end

return slot0
