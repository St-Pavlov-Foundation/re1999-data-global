module("modules.logic.chessgame.game.step.ChessStepCompleted", package.seeall)

slot0 = class("ChessStepCompleted", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	if ChessGameInteractModel.instance:getInteractById(slot0.originData.interactId) then
		slot1.isFinish = true

		ChessGameController.instance.interactsMgr:getMainPlayer():getHandler():calCanWalkArea()
		ChessGameInteractModel.instance:setInteractFinishMap()
	end

	slot0:onDone(true)
end

return slot0
