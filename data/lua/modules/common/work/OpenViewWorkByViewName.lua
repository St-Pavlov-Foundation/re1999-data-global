module("modules.common.work.OpenViewWorkByViewName", package.seeall)

slot0 = class("OpenViewWorkByViewName", BaseWork)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.viewName = slot1
	slot0.viewParam = slot2
	slot0.eventName = slot3 or ViewEvent.OnOpenView
end

function slot0.onStart(slot0)
	ViewMgr.instance:registerCallback(slot0.eventName, slot0.onEventFinish, slot0)
	ViewMgr.instance:openView(slot0.viewName, slot0.viewParam)
end

function slot0.onEventFinish(slot0)
	ViewMgr.instance:unregisterCallback(slot0.eventName, slot0.onEventFinish, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(slot0.eventName, slot0.onEventFinish, slot0)
end

return slot0
