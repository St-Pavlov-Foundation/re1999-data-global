module("modules.logic.explore.controller.trigger.ExploreTriggerElevator", package.seeall)

slot0 = class("ExploreTriggerElevator", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	if string.splitToNumber(slot1, "#")[1] ~= 0 then
		ExploreMapTriggerController.instance:getMap():getUnit(slot4):movingElevator(slot3[2], slot3[3])
	end

	slot0:onStepDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
