module("modules.logic.chessgame.game.step.ChessStepTransport", package.seeall)

slot0 = class("ChessStepTransport", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot0:_transPortMap()
end

function slot0._transPortMap(slot0)
	if slot0.originData.newMapId + 1 ~= ChessGameModel.instance:getNowMapIndex() then
		ChessGameController.instance:deleteInteractObj(slot0.originData.interact.id)
	else
		ChessGameController.instance:addInteractObj(slot1)
	end

	slot0:onDone(true)
end

return slot0
