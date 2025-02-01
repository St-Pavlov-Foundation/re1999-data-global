module("modules.logic.chessgame.game.step.ChessStepShowToast", package.seeall)

slot0 = class("ChessStepShowToast", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot0:showToast()
	slot0:onDone(true)
end

function slot0.showToast(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameToastUpdate, ChessConfig.instance:getTipsCo(ChessModel.instance:getActId(), slot0.originData.notifyId))
end

return slot0
