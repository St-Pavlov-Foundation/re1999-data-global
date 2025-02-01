module("modules.logic.explore.controller.steps.ExploreUseItemStep", package.seeall)

slot0 = class("ExploreUseItemStep", ExploreStepBase)

function slot0.onStart(slot0)
	ExploreModel.instance:setUseItemUid(tostring(slot0._data.itemUid))
	ExploreController.instance:getMap():checkAllRuneTrigger()
	slot0:onDone()
end

return slot0
