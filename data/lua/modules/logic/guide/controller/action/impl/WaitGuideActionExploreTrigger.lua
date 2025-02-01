module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreTrigger", package.seeall)

slot0 = class("WaitGuideActionExploreTrigger", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	ExploreController.instance:registerCallback(ExploreEvent.ExploreTriggerGuide, slot0._onTriggerGuide, slot0)
end

function slot0._onTriggerGuide(slot0, slot1)
	if slot0.guideId == slot1 then
		ExploreController.instance:unregisterCallback(ExploreEvent.ExploreTriggerGuide, slot0._onTriggerGuide, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.ExploreTriggerGuide, slot0._onTriggerGuide, slot0)
end

return slot0
