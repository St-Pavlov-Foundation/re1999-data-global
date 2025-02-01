module("modules.logic.guide.controller.GuideStepController", package.seeall)

slot0 = class("GuideStepController", BaseController)

function slot0.onInit(slot0)
	slot0._guideId = nil
	slot0._stepId = nil
	slot0._againGuideId = nil
	slot0._actionFlow = nil
	slot0._actionFlowsParallel = {}
	slot0._actionBuilder = GuideActionBuilder.New()
	slot0._startTime = 0
end

function slot0.reInit(slot0)
	slot0:clearStep()
end

function slot0.execStep(slot0, slot1, slot2, slot3)
	GuideAudioPreloadController.instance:preload(slot1)

	slot0._guideId = slot1
	slot0._stepId = slot2
	slot0._againGuideId = slot3

	if GuideConfig.instance:getGuideCO(slot1).parallel == 1 or slot0._actionFlow == nil then
		slot0:_reallyStartGuide({})

		if not GuideModel.instance:isStepFinish(slot1, slot2) then
			GuideExceptionController.instance:checkStep(slot0._againGuideId > 0 and slot0._againGuideId or slot0._guideId, slot2)
		end
	end
end

function slot0.clearFlow(slot0, slot1)
	GuideExceptionController.instance:stopCheck()

	if slot0._actionFlowsParallel[slot1] then
		slot0._actionFlowsParallel[slot1]:destroy()

		slot0._actionFlowsParallel[slot1] = nil
	elseif slot0._actionFlow and slot0._actionFlow.guideId == slot1 then
		slot0._actionFlow = nil

		slot0._actionFlow:destroy()
	end
end

function slot0.clearStep(slot0)
	GuideExceptionController.instance:stopCheck()

	if slot0._actionFlow then
		slot0._actionFlow = nil

		slot0._actionFlow:destroy()
	end

	for slot4, slot5 in pairs(slot0._actionFlowsParallel) do
		slot5:destroy()
	end

	slot0._actionFlowsParallel = {}
end

function slot0._reallyStartGuide(slot0, slot1)
	if GuideConfig.instance:getGuideCO(slot0._guideId).parallel and slot0._actionFlowsParallel[slot0._guideId] or not slot2.parallel and slot0._actionFlow then
		return
	end

	if slot0._actionBuilder:buildActionFlow(slot0._guideId, slot0._stepId, slot0._againGuideId) then
		if slot2.parallel == 1 then
			slot0._actionFlowsParallel[slot0._guideId] = slot3
		else
			slot0._actionFlow = slot3
		end

		GuideController.instance:dispatchEvent(GuideEvent.StartGuideStep, slot0._againGuideId > 0 and slot0._againGuideId or slot0._guideId, slot0._stepId)
		slot3:start(slot1)
	else
		logNormal(string.format("<color=#FFA500>guide_%d_%d</color> has no action", slot0._guideId, slot0._stepId))
	end
end

function slot0.getActionBuilder(slot0)
	return slot0._actionBuilder
end

function slot0.getActionFlow(slot0, slot1)
	if GuideConfig.instance:getGuideCO(slot1) and slot2.parallel == 1 then
		return slot0._actionFlowsParallel[slot1]
	else
		return slot0._actionFlow
	end
end

slot0.instance = slot0.New()

return slot0
