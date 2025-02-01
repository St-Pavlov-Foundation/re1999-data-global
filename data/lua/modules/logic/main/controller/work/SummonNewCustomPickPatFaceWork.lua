module("modules.logic.main.controller.work.SummonNewCustomPickPatFaceWork", package.seeall)

slot0 = class("SummonNewCustomPickPatFaceWork", PatFaceWorkBase)

function slot0._viewName(slot0)
	return PatFaceConfig.instance:getPatFaceViewName(slot0._patFaceId)
end

function slot0._actId(slot0)
	return PatFaceConfig.instance:getPatFaceActivityId(slot0._patFaceId)
end

function slot0.checkCanPat(slot0)
	slot1 = slot0:_actId()

	return SummonNewCustomPickViewModel.instance:isActivityOpen(slot1) and SummonNewCustomPickViewModel.instance:getHaveFirstDayLogin(slot1)
end

function slot0.startPat(slot0)
	slot0:_startBlock()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	SummonNewCustomPickViewController.instance:registerCallback(SummonNewCustomPickEvent.OnGetServerInfoReply, slot0._refreshSummonCustomPickActivity, slot0)
	SummonNewCustomPickViewController.instance:registerCallback(SummonNewCustomPickEvent.OnSummonCustomGet, slot0._revertOpenState, slot0)
	SummonNewCustomPickViewRpc.instance:sendGet169InfoRequest(slot0:_actId())
end

function slot0.clearWork(slot0)
	slot0:_endBlock()

	slot0._needRevert = false

	SummonNewCustomPickViewController.instance:unregisterCallback(SummonNewCustomPickEvent.OnGetServerInfoReply, slot0._refreshSummonCustomPickActivity, slot0)
	SummonNewCustomPickViewController.instance:unregisterCallback(SummonNewCustomPickEvent.OnSummonCustomGet, slot0._revertOpenState, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.OnGetReward, slot0)
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

	if slot0._needRevert then
		slot0._needRevert = false

		return
	end

	slot0:patComplete()
end

function slot0._refreshSummonCustomPickActivity(slot0)
	slot1 = slot0:_actId()
	slot2 = slot0:_viewName()

	if slot0:isActivityRewardGet() then
		if ViewMgr.instance:isOpen(slot2) then
			return
		end

		slot0:patComplete()

		return
	end

	ViewMgr.instance:openView(slot2, {
		refreshData = false,
		actId = slot1
	})
	SummonNewCustomPickViewModel.instance:setHaveFirstDayLogin(slot1)
	SummonNewCustomPickViewController.instance:registerCallback(SummonNewCustomPickEvent.OnSummonCustomGet, slot0._revertOpenState, slot0)
end

function slot0._revertOpenState(slot0)
	slot0._needRevert = true
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

function slot0.isActivityRewardGet(slot0)
	return SummonNewCustomPickViewModel.instance:isGetReward(slot0:_actId())
end

return slot0
