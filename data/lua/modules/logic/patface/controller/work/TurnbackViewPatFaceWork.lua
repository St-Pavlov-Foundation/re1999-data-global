module("modules.logic.patface.controller.work.TurnbackViewPatFaceWork", package.seeall)

slot0 = class("TurnbackViewPatFaceWork", PatFaceWorkBase)

function slot0.checkCanPat(slot0)
	return TurnbackModel.instance:canShowTurnbackPop() and TurnbackModel.instance:isInOpenTime()
end

function slot0.startPat(slot0)
	uv0.super.startPat(slot0)

	slot0.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRpc.instance:sendTurnbackFirstShowRequest(slot0.turnbackId)
end

function slot0.onCloseViewFinish(slot0, slot1)
	if string.nilorempty(slot0._patViewName) or slot0._patViewName == slot1 then
		slot0:patComplete()
		TurnbackRpc.instance:sendTurnbackFirstShowRequest(slot0.turnbackId)
	end
end

function slot0.customerClearWork(slot0)
	slot0.turnbackId = nil
end

return slot0
