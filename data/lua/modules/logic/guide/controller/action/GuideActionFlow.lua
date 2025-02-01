module("modules.logic.guide.controller.action.GuideActionFlow", package.seeall)

slot0 = class("GuideActionFlow", FlowSequence)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.guideId = slot1
	slot0.stepId = slot2
	slot0.againGuideId = slot3

	uv0.super.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot1)
	GuideController.instance:startStep(slot0.guideId, slot0.stepId, slot0.againGuideId)
end

function slot0.onDone(slot0, slot1)
	uv0.super.onDone(slot0, slot1)
	GuideController.instance:finishStep(slot0.guideId, slot0.stepId, false, false, slot0.againGuideId)
end

return slot0
