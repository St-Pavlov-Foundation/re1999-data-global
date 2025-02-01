module("modules.logic.explore.controller.trigger.ExploreTriggerCatchUnit", package.seeall)

slot0 = class("ExploreTriggerCatchUnit", ExploreTriggerBase)
slot1 = ExploreEnum.TriggerEvent.CatchUnit .. "#1"
slot2 = ExploreEnum.TriggerEvent.CatchUnit .. "#0"

function slot0.handle(slot0, slot1, slot2)
	if ExploreModel.instance:hasUseItemOrUnit() then
		slot0:onDone(false)
		logError("catchUnit fail inusing id:" .. ExploreModel.instance:getUseItemUid())

		return
	end

	slot0:sendTriggerRequest(uv0)
end

function slot0.cancel(slot0, slot1, slot2)
	slot4 = ExploreController.instance:getMap():getHero()
	slot5 = ExploreHelper.dirToXY(slot4.dir)
	slot6 = slot4.nodePos

	slot0:sendTriggerRequest(uv0 .. "#" .. slot6.x + slot5.x .. "#" .. slot6.y + slot5.y)
end

function slot0.onReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot5 = 0

		if string.splitToNumber(slot3.params, "#")[2] == 1 then
			slot5 = slot0.unitId
		end

		ExploreModel.instance:setUseItemUid(slot5)
		slot0:onStepDone(true)
	else
		slot0:onDone(false)
	end
end

return slot0
