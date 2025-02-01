module("modules.logic.explore.controller.trigger.ExploreTriggerRotate", package.seeall)

slot0 = class("ExploreTriggerRotate", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetRotateUnit, slot2)
	slot0:onDone(false)
end

return slot0
