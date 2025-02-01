module("modules.logic.explore.controller.trigger.ExploreTriggerItem", package.seeall)

slot0 = class("ExploreTriggerItem", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	ExploreRpc.instance:sendExploreItemInteractRequest(slot2.id, slot1, slot0.onRequestCallBack, slot0)
end

function slot0.onReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:onDone(true)
	end
end

return slot0
