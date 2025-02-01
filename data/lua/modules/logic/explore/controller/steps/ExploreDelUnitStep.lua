module("modules.logic.explore.controller.steps.ExploreDelUnitStep", package.seeall)

slot0 = class("ExploreDelUnitStep", ExploreStepBase)
slot1 = {
	[ExploreEnum.ItemType.Rock] = true
}

function slot0.onStart(slot0)
	if ExploreController.instance:getMap():getUnit(slot0._data.interact.id, true) then
		ExploreController.instance:removeUnit(slot1.id)

		if not ExploreModel.instance.isReseting and uv0[slot2:getUnitType()] then
			slot2:setExitCallback(slot0.onDone, slot0)
		else
			slot0:onDone()
		end
	else
		slot0:onDone()
	end
end

return slot0
