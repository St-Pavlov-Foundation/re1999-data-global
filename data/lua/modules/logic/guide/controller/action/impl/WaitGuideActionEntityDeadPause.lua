module("modules.logic.guide.controller.action.impl.WaitGuideActionEntityDeadPause", package.seeall)

slot0 = class("WaitGuideActionEntityDeadPause", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnGuideEntityDeadPause, slot0._onGuideEntityDeadPause, slot0)

	slot0._side = tonumber(slot0.actionParam)
end

function slot0._onGuideEntityDeadPause(slot0, slot1, slot2)
	if slot2.side == slot0._side then
		slot1.OnGuideEntityDeadPause = true

		FightController.instance:unregisterCallback(FightEvent.OnGuideEntityDeadPause, slot0._onGuideEntityDeadPause, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnGuideEntityDeadPause, slot0._onGuideEntityDeadPause, slot0)
end

return slot0
