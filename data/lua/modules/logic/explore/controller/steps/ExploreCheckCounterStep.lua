module("modules.logic.explore.controller.steps.ExploreCheckCounterStep", package.seeall)

slot0 = class("ExploreCheckCounterStep", ExploreStepBase)

function slot0.onStart(slot0)
	ExploreController.instance:getMap():getUnit(slot0._data.id).mo:checkActiveCount()
	slot0:onDone()
end

return slot0
