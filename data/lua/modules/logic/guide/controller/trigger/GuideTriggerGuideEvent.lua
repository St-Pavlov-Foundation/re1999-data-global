module("modules.logic.guide.controller.trigger.GuideTriggerGuideEvent", package.seeall)

slot0 = class("GuideTriggerGuideEvent", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	GuideController.instance:registerCallback(GuideEvent.TriggerActive, slot0._onTriggerActive, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot1 == GuideEnum.EventTrigger[slot2]
end

function slot0._onTriggerActive(slot0, slot1)
	slot0:checkStartGuide(slot1)
end

return slot0
