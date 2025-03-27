module("modules.logic.patface.controller.work.TurnbackViewPatFaceWork", package.seeall)

slot0 = class("TurnbackViewPatFaceWork", PatFaceWorkBase)

function slot0.checkCanPat(slot0)
	return TurnbackModel.instance:canShowTurnbackPop() and TurnbackModel.instance:isInOpenTime()
end

function slot0.startPat(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)

	slot0.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	slot0:_openView()
	TurnbackRpc.instance:sendTurnbackFirstShowRequest(slot0.turnbackId)
end

function slot0._openView(slot0)
	if TurnbackModel.instance:isNewType() then
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView)
	else
		ViewMgr.instance:openView(slot0._patViewName)
	end
end

function slot0.onCloseViewFinish(slot0, slot1)
	if string.nilorempty(slot0._patViewName) or slot0._patViewName == slot1 or slot1 == ViewName.TurnbackNewLatterView then
		slot0:patComplete()
		TurnbackRpc.instance:sendTurnbackFirstShowRequest(slot0.turnbackId)
	end
end

function slot0.customerClearWork(slot0)
	slot0.turnbackId = nil
end

return slot0
