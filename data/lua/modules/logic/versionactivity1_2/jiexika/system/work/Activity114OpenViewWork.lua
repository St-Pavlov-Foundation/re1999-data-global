module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenViewWork", package.seeall)

slot0 = class("Activity114OpenViewWork", Activity114BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._viewName = slot1

	uv0.super.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:openView(slot0._viewName, slot1)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == slot0._viewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
	uv0.super.clearWork(slot0)
end

return slot0
