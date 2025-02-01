module("modules.logic.guide.controller.trigger.GuideTriggerEnterExplore", package.seeall)

slot0 = class("GuideTriggerEnterExplore", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	ExploreController.instance:registerCallback(ExploreEvent.EnterExplore, slot0._onEnterExplore, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot1 == tonumber(slot2)
end

function slot0._onEnterExplore(slot0, slot1)
	slot0:checkStartGuide(slot1)
end

return slot0
