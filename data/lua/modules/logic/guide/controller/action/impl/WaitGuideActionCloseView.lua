module("modules.logic.guide.controller.action.impl.WaitGuideActionCloseView", package.seeall)

slot0 = class("WaitGuideActionCloseView", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._viewName = slot0.actionParam

	if ViewMgr.instance:isOpen(slot0._viewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._onCloseViewFinish(slot0, slot1, slot2)
	if slot0._viewName == slot1 then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

return slot0
