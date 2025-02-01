module("modules.logic.guide.controller.action.impl.WaitGuideActionFightPauseGeneral", package.seeall)

slot0 = class("WaitGuideActionFightPauseGeneral", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot0._pauseName = slot2[1]
	slot0._pauseEvent = FightEvent[slot2[1]]

	FightController.instance:registerCallback(slot0._pauseEvent, slot0._triggerFightPause, slot0)
end

function slot0._triggerFightPause(slot0, slot1)
	slot1[slot0._pauseName] = true

	FightController.instance:unregisterCallback(slot0._pauseEvent, slot0._triggerFightPause, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(slot0._pauseEvent, slot0._triggerFightPause, slot0)
end

return slot0
