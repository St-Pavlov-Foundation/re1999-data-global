module("modules.logic.main.controller.work.Activity101SignPatFaceWork", package.seeall)

slot0 = class("Activity101SignPatFaceWork", PatFaceWorkBase)

function slot0._viewName(slot0)
	return PatFaceConfig.instance:getPatFaceViewName(slot0._patFaceId)
end

function slot0._actId(slot0)
	return PatFaceConfig.instance:getPatFaceActivityId(slot0._patFaceId)
end

function slot0.checkCanPat(slot0)
	return ActivityType101Model.instance:isOpen(slot0:_actId())
end

function slot0.startPat(slot0)
	slot0:_startBlock()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0._refreshNorSignActivity, slot0)
	Activity101Rpc.instance:sendGet101InfosRequest(slot0:_actId())
end

function slot0.clearWork(slot0)
	slot0:_endBlock()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0._refreshNorSignActivity, slot0)
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

function slot0._refreshNorSignActivity(slot0)
	slot1 = slot0:_actId()
	slot2 = slot0:_viewName()

	if not slot0:isType101RewardCouldGetAnyOne() then
		if ViewMgr.instance:isOpen(slot2) then
			return
		end

		slot0:patComplete()

		return
	end

	ViewMgr.instance:openView(slot2, {
		actId = slot1
	})
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

function slot0.isType101RewardCouldGetAnyOne(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot0:_actId())
end

return slot0
