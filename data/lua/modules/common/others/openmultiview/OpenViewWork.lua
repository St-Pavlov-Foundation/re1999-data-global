module("modules.common.others.openmultiview.OpenViewWork", package.seeall)

slot0 = class("OpenViewWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._openFunction = slot1.openFunction
	slot0._openFunctionObj = slot1.openFunctionObj
	slot0._waitOpenViewName = slot1.waitOpenViewName
end

function slot0.onStart(slot0, slot1)
	if not slot0._openFunction then
		slot0:onDone(true)

		return
	end

	if not slot0._waitOpenViewName then
		slot0._openFunction(slot0._openFunctionObj)
		slot0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, slot0._onOpenFinish, slot0)
	TaskDispatcher.runDelay(slot0._overtime, slot0, 5)
	slot0._openFunction(slot0._openFunctionObj)
end

function slot0._overtime(slot0)
	TaskDispatcher.cancelTask(slot0._overtime, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, slot0._onOpenFinish, slot0)
	slot0:onDone(true)
end

function slot0._onOpenFinish(slot0, slot1)
	if slot1 == slot0._waitOpenViewName then
		TaskDispatcher.cancelTask(slot0._overtime, slot0)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenFinish, slot0)
		ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, slot0._onOpenFinish, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._overtime, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, slot0._onOpenFinish, slot0)
end

return slot0
