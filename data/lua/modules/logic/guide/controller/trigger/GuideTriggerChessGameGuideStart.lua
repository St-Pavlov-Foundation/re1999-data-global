module("modules.logic.guide.controller.trigger.GuideTriggerChessGameGuideStart", package.seeall)

slot0 = class("GuideTriggerChessGameGuideStart", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	ChessGameController.instance:registerCallback(ChessGameEvent.GuideStart, slot0._onGuideStart, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot1 == slot2
end

function slot0._onGuideStart(slot0, slot1)
	slot0:checkStartGuide(slot1)
end

return slot0
