module("modules.logic.guide.controller.action.impl.WaitGuideActionBreakFightResultClose", package.seeall)

slot0 = class("WaitGuideActionBreakFightResultClose", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnBreakResultViewClose, slot0._onBreakResultViewClose, slot0)
end

function slot0._onBreakResultViewClose(slot0, slot1)
	slot1.isBreak = true

	FightController.instance:unregisterCallback(FightEvent.OnBreakResultViewClose, slot0._onBreakResultViewClose, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnBreakResultViewClose, slot0._onBreakResultViewClose, slot0)
end

return slot0
