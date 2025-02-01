module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEvent", package.seeall)

slot0 = class("WaitGuideActionFightEvent", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._eventName = FightEvent[slot0.actionParam]

	if not slot0._eventName then
		logError("WaitGuideActionFightEvent param error:" .. tostring(slot0.actionParam))

		return
	end

	FightController.instance:registerCallback(slot0._eventName, slot0._onReceiveFightEvent, slot0)
end

function slot0._onReceiveFightEvent(slot0)
	FightController.instance:unregisterCallback(slot0._eventName, slot0._onReceiveFightEvent, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(slot0._eventName, slot0._onReceiveFightEvent, slot0)
end

return slot0
