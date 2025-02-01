module("modules.logic.explore.controller.trigger.ExploreTriggerNormal", package.seeall)

slot0 = class("ExploreTriggerNormal", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	slot0:sendTriggerRequest()
end

function slot0.onReply(slot0, slot1, slot2, slot3)
	slot0:onDone(true)
end

return slot0
