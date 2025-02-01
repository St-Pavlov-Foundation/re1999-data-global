module("modules.logic.chessgame.game.step.ChessStepShowInteract", package.seeall)

slot0 = class("ChessStepShowInteract", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot0:appearInteract()
	slot0:onDone(true)
end

function slot0.appearInteract(slot0)
	slot1 = slot0.originData.interact
	slot1.mapIndex = slot1.mapIndex + 1

	if slot1.mapIndex == ChessGameModel.instance:getNowMapIndex() then
		ChessGameController.instance:addInteractObj(slot1)
	end
end

return slot0
