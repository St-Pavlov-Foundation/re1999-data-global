module("modules.logic.explore.controller.trigger.ExploreTriggerCameraCO", package.seeall)

slot0 = class("ExploreTriggerCameraCO", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	slot0.cameraId = tonumber(slot1)

	ExploreController.instance:dispatchEvent(ExploreEvent.OnChangeCameraCO, slot0.cameraId)
	slot0:onStepDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
