module("modules.logic.signin.controller.work.ActivityDoubleFestivalSignWork_1_3", package.seeall)

slot0 = class("ActivityDoubleFestivalSignWork_1_3", BaseWork)
slot1 = ActivityEnum.Activity.DoubleFestivalSign_1_3

function slot0.onStart(slot0)
	if not ActivityModel.instance:isActOnLine(uv0) then
		slot0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0._refreshNorSignActivity, slot0)
	Activity101Rpc.instance:sendGet101InfosRequest(uv0)
end

function slot0._refreshNorSignActivity(slot0)
	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(uv0) then
		slot0:onDone(true)

		return
	end

	ViewMgr.instance:openView(ViewName.ActivityDoubleFestivalSignPaiLianView_1_3)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.ActivityDoubleFestivalSignPaiLianView_1_3 then
		slot0:onDone(true)
	end
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 ~= ViewName.ActivityDoubleFestivalSignPaiLianView_1_3 then
		return
	end

	slot0:_endBlock()
end

function slot0.clearWork(slot0)
	slot0:_endBlock()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0._refreshNorSignActivity, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
end

function slot0._endBlock(slot0)
	if not slot0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function slot0._isBlock(slot0)
	return UIBlockMgr.instance:isBlock() and true or false
end

return slot0
