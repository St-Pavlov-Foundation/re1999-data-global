module("modules.logic.battlepass.flow.BpOpenAndWaitCloseWork", package.seeall)

slot0 = class("BpOpenAndWaitCloseWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._viewName = slot1
end

function slot0.onStart(slot0)
	UIBlockMgr.instance:endBlock("BpChargeFlow")
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:openView(slot0._viewName)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == slot0._viewName then
		UIBlockMgr.instance:startBlock("BpChargeFlow")
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

return slot0
