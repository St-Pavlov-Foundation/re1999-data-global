module("modules.logic.explore.controller.trigger.ExploreTriggerPlayAudio", package.seeall)

slot0 = class("ExploreTriggerPlayAudio", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	if (tonumber(slot1) or 0) > 0 then
		slot4 = ExploreStepController.instance:getStepIndex(ExploreEnum.StepType.ShowArea)

		if ExploreStepController.instance:getStepIndex(ExploreEnum.StepType.CameraMove) >= 0 then
			ExploreStepController.instance:insertClientStep({
				stepType = ExploreEnum.StepType.TriggerAudio,
				id = slot1
			}, slot3 + 1)
		elseif slot4 > 0 then
			ExploreStepController.instance:insertClientStep({
				stepType = ExploreEnum.StepType.TriggerAudio,
				id = slot1
			}, slot4)
		else
			AudioMgr.instance:trigger(slot1)
		end
	end

	slot0:onDone(true)
end

return slot0
