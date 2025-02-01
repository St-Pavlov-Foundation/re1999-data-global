module("modules.logic.guide.controller.trigger.GuideTriggerOpenView", package.seeall)

slot0 = class("GuideTriggerOpenView", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot1 == slot2
end

function slot0._onOpenView(slot0, slot1, slot2)
	slot0:checkStartGuide(slot1)
end

return slot0
