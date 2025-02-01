module("modules.logic.guide.controller.trigger.GuideTriggerEnterActivity109Chess", package.seeall)

slot0 = class("GuideTriggerEnterActivity109Chess", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	Activity109ChessController.instance:registerCallback(ActivityChessEvent.GuideOnEnterMap, slot0._onEnterMap, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot1 == slot2
end

function slot0._onEnterMap(slot0, slot1)
	slot0:checkStartGuide(slot1)
end

return slot0
