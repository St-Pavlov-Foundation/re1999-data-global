module("modules.logic.explore.controller.trigger.ExploreTriggerAward", package.seeall)

slot0 = class("ExploreTriggerAward", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	ExploreSimpleModel.instance:setBonusIsGet(ExploreModel.instance:getMapId(), tonumber(slot1) or 0)
	slot0:onDone(true)
end

return slot0
