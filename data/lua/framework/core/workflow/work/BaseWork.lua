module("framework.core.workflow.work.BaseWork", package.seeall)

slot0 = class("BaseWork")
slot1 = "done"

function slot0.initInternal(slot0)
	slot0.context = nil
	slot0.root = nil
	slot0.parent = nil
	slot0.isSuccess = false
	slot0.status = WorkStatus.Init
	slot0.flowName = nil
end

function slot0.setRootInternal(slot0, slot1)
	slot0.root = slot1
end

function slot0.setParentInternal(slot0, slot1)
	slot0.parent = slot1
end

function slot0.onStartInternal(slot0, slot1)
	slot0.context = slot1
	slot0.status = WorkStatus.Running

	return slot0:onStart(slot1)
end

function slot0.onStopInternal(slot0)
	slot0.status = WorkStatus.Stopped

	slot0:onStop()
end

function slot0.onResumeInternal(slot0)
	slot0.status = WorkStatus.Running

	slot0:onResume()
end

function slot0.onResetInternal(slot0)
	slot0.status = WorkStatus.Init

	slot0:onReset()
end

function slot0.onDestroyInternal(slot0)
	slot0:onDestroy()

	slot0.context = nil
	slot0.parent = nil
end

function slot0.onDone(slot0, slot1)
	slot0.isSuccess = slot1
	slot0.status = WorkStatus.Done

	if slot0.beforeClearWork then
		slot0:beforeClearWork()
	end

	slot0:clearWork()

	if slot0.parent then
		if slot0._dispatcher then
			slot0.parent:onWorkDone(slot0)
		else
			return slot0.parent:onWorkDone(slot0)
		end
	end

	if slot0._dispatcher then
		slot0._dispatcher:dispatchEvent(uv0, slot1)
	end
end

function slot0.registerDoneListener(slot0, slot1, slot2)
	if not slot0._dispatcher then
		slot0._dispatcher = {}

		LuaEventSystem.addEventMechanism(slot0._dispatcher)
	end

	slot0._dispatcher:registerCallback(uv0, slot1, slot2)
end

function slot0.unregisterDoneListener(slot0, slot1, slot2)
	if slot0._dispatcher then
		slot0._dispatcher:unregisterCallback(uv0, slot1, slot2)
	end
end

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
end

function slot0.onStop(slot0)
	if slot0.beforeClearWork then
		slot0:beforeClearWork()
	end

	slot0:clearWork()
end

function slot0.onResume(slot0)
end

function slot0.onReset(slot0)
	if slot0.beforeClearWork then
		slot0:beforeClearWork()
	end

	slot0:clearWork()
end

function slot0.onDestroy(slot0)
	if slot0.beforeClearWork then
		slot0:beforeClearWork()
	end

	slot0:clearWork()
end

function slot0.clearWork(slot0)
end

return slot0
