module("modules.logic.explore.controller.steps.ExploreTransferStep", package.seeall)

slot0 = class("ExploreTransferStep", ExploreStepBase)

function slot0.onStart(slot0)
	ExploreMapModel.instance:updatHeroPos(slot0._data.x, slot0._data.y, 0)
	ExploreHeroTeleportFlow.instance:begin(slot0._data)
	slot0:onDone()
end

return slot0
