module("modules.logic.chessgame.game.step.ChessStepTalk", package.seeall)

slot0 = class("ChessStepTalk", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot0:showTalk()
	slot0:onDone(true)
end

function slot0.showToast(slot0)
	GameFacade.showToastString(ChessConfig.instance:getTipsCo(ChessModel.instance:getActId(), slot0.originData.notifyId).content)
end

return slot0
