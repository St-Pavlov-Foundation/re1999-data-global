module("modules.logic.chessgame.game.step.ChessStepInteractDelete", package.seeall)

slot0 = class("ChessStepInteractDelete", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot0:deleteInteractObj()
end

function slot0.deleteInteractObj(slot0)
	if ChessGameInteractModel.instance:getInteractById(slot0.originData.id) and slot2:isInCurrentMap() then
		ChessGameController.instance.interactsMgr:get(slot1):getHandler():showDestoryAni(slot0._deleteAnimCallback, slot0)
	else
		slot0:_deleteAnimCallback()
	end
end

function slot0._deleteAnimCallback(slot0)
	ChessGameController.instance:deleteInteractObj(slot0.originData.id)
	slot0:onDone(true)
end

return slot0
