module("modules.logic.main.controller.work.ShortenAct_PanelViewPatFaceWork", package.seeall)

slot0 = class("ShortenAct_PanelViewPatFaceWork", PatFaceWorkBase)

function slot0._viewName(slot0)
	return PatFaceConfig.instance:getPatFaceViewName(slot0._patFaceId)
end

function slot0._actId(slot0)
	return PatFaceConfig.instance:getPatFaceActivityId(slot0._patFaceId)
end

function slot0.checkCanPat(slot0)
	return ActivityHelper.getActivityStatus(slot0:_actId(), true) == ActivityEnum.ActivityStatus.Normal
end

function slot0.startPat(slot0)
	slot0:_startBlock()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189InfoReply, slot0._onReceiveGetAct189InfoReply, slot0)
	Activity189Controller.instance:sendGetAct189InfoRequest(slot0:_actId())
end

function slot0.clearWork(slot0)
	slot0:_endBlock()
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189InfoReply, slot0._onReceiveGetAct189InfoReply, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 ~= slot0:_viewName() then
		return
	end

	slot0:_endBlock()
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 ~= slot0:_viewName() then
		return
	end

	if ViewMgr.instance:isOpen(slot2) then
		return
	end

	slot0:patComplete()
end

function slot0._onReceiveGetAct189InfoReply(slot0)
	slot1 = slot0:_viewName()

	if not slot0:_isClaimable() then
		slot0:patComplete()

		return
	end

	ViewMgr.instance:openView(slot1)
end

function slot0._endBlock(slot0)
	if not slot0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function slot0._startBlock(slot0)
	if slot0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function slot0._isBlock(slot0)
	return UIBlockMgr.instance:isBlock() and true or false
end

function slot0._isClaimable(slot0)
	return ShortenActModel.instance:isClaimable()
end

return slot0
