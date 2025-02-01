module("modules.common.work.OpenViewAndWaitCloseWork", package.seeall)

slot0 = class("OpenViewAndWaitCloseWork", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0.viewName = slot1
	slot0.viewParam = slot2
end

function slot0.onStart(slot0)
	ViewMgr.instance:openView(slot0.viewName, slot0.viewParam)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot0.viewName == slot1 then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

return slot0
