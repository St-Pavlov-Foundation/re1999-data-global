module("modules.logic.explore.controller.steps.ExploreElevatorStep", package.seeall)

slot0 = class("ExploreElevatorStep", ExploreStepBase)

function slot0.onStart(slot0)
	if ExploreModel.instance:getInteractInfo(slot0._data.interactId) then
		slot1.statusInfo.height = slot0._data.height
	end

	slot0:onDone()
end

return slot0
