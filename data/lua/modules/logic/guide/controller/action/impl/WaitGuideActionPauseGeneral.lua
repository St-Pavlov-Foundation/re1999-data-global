module("modules.logic.guide.controller.action.impl.WaitGuideActionPauseGeneral", package.seeall)

slot0 = class("WaitGuideActionPauseGeneral", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot3 = string.split(slot0.actionParam, "#")[1]
	slot0._pauseName = slot3
	slot0._pauseEvent = GuideEvent[slot3]

	GuideController.instance:registerCallback(slot0._pauseEvent, slot0._triggerPause, slot0)
end

function slot0._triggerPause(slot0, slot1)
	slot1[slot0._pauseName] = true

	GuideController.instance:unregisterCallback(slot0._pauseEvent, slot0._triggerPause, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	GuideController.instance:unregisterCallback(slot0._pauseEvent, slot0._triggerPause, slot0)
end

return slot0
