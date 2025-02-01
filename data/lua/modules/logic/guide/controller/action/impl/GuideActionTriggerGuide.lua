module("modules.logic.guide.controller.action.impl.GuideActionTriggerGuide", package.seeall)

slot0 = class("GuideActionTriggerGuide", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot0._triggerGuideId = not string.nilorempty(slot3) and tonumber(slot3)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	slot0:onDone(true)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)

	if slot0._triggerGuideId then
		if GuideModel.instance:getById(slot0._triggerGuideId) and not slot1.isFinish then
			GuideController.instance:execNextStep(slot0._triggerGuideId)
		else
			GuideController.instance:dispatchEvent(GuideEvent.TriggerGuide, slot0._triggerGuideId)
		end
	elseif GuideModel.instance:getDoingGuideId() then
		GuideController.instance:execNextStep(slot1)
	else
		GuideController.instance:dispatchEvent(GuideEvent.TriggerGuide)
	end
end

return slot0
