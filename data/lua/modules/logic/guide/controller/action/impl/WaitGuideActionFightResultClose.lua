module("modules.logic.guide.controller.action.impl.WaitGuideActionFightResultClose", package.seeall)

slot0 = class("WaitGuideActionFightResultClose", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnResultViewClose, slot0._onResultViewClose, slot0)
end

function slot0._onResultViewClose(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnResultViewClose, slot0._onResultViewClose, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnResultViewClose, slot0._onResultViewClose, slot0)
end

return slot0
