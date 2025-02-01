module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEndPause_sp", package.seeall)

slot0 = class("WaitGuideActionFightEndPause_sp", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnGuideFightEndPause_sp, slot0._onGuideFightEndPause, slot0)
end

function slot0._onGuideFightEndPause(slot0, slot1)
	slot1.OnGuideFightEndPause_sp = true

	FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause_sp, slot0._onGuideFightEndPause, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause_sp, slot0._onGuideFightEndPause, slot0)
end

return slot0
