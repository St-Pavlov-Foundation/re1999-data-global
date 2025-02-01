module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenFinishView", package.seeall)

slot0 = class("WaitGuideActionOpenFinishView", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot0._viewName = slot2[1]
	slot3 = #slot2 >= 2 and tonumber(slot2[2])

	if ViewMgr.instance:isOpenFinish(slot0._viewName) then
		slot0:onDone(true)

		return
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
	end

	if slot3 and slot3 > 0 then
		TaskDispatcher.runDelay(slot0._delayDone, slot0, slot3)
	end
end

function slot0._delayDone(slot0)
	if slot0:checkGuideLock() then
		return
	end

	slot0:onDone(true)
end

function slot0._checkOpenView(slot0, slot1, slot2)
	if slot0._viewName == slot1 then
		if slot0:checkGuideLock() then
			return
		end

		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
end

return slot0
