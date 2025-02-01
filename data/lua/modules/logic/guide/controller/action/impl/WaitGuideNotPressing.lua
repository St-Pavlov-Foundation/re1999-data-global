module("modules.logic.guide.controller.action.impl.WaitGuideNotPressing", package.seeall)

slot0 = class("WaitGuideNotPressing", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if GamepadController.instance:isOpen() then
		slot0:onDone(true)
	elseif slot0:_notPressing() then
		slot0:onDone(true)
	else
		TaskDispatcher.runRepeat(slot0._onFrame, slot0, 0.01)
	end
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
end

function slot0._onFrame(slot0)
	if slot0:_notPressing() then
		slot0:onDone(true)
	end
end

function slot0._notPressing(slot0)
	return not (UnityEngine.Input.touchCount > 0)
end

return slot0
