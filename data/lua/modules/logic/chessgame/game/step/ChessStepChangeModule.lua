module("modules.logic.chessgame.game.step.ChessStepChangeModule", package.seeall)

slot0 = class("ChessStepChangeModule", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot1 = slot0.originData.interactId

	if ChessGameInteractModel.instance:getInteractById(slot1) and slot4:isInCurrentMap() then
		ChessGameController.instance.interactsMgr:get(slot1):changeModule(slot0.originData.path)
	end

	slot0:onDone(true)
end

return slot0
