module("modules.logic.explore.controller.steps.ExploreRotateStep", package.seeall)

slot0 = class("ExploreRotateStep", ExploreStepBase)

function slot0.onStart(slot0)
	if not ExploreController.instance:getMap():getCompByType(ExploreEnum.MapStatus.RotateUnit) then
		slot0:onDone()

		return
	end

	slot1:rotateByServer(slot0._data.interactId, slot0._data.newDir, slot0.onDone, slot0)
end

return slot0
