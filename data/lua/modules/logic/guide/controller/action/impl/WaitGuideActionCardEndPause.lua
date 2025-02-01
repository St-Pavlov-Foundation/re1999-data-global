module("modules.logic.guide.controller.action.impl.WaitGuideActionCardEndPause", package.seeall)

slot0 = class("WaitGuideActionCardEndPause", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnGuideCardEndPause, slot0._onGuideCardEndPause, slot0)
end

function slot0._onGuideCardEndPause(slot0, slot1)
	slot1.OnGuideCardEndPause = true

	FightController.instance:unregisterCallback(FightEvent.OnGuideCardEndPause, slot0._onGuideCardEndPause, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnGuideCardEndPause, slot0._onGuideCardEndPause, slot0)
end

return slot0
