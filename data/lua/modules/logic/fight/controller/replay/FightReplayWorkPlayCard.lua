module("modules.logic.fight.controller.replay.FightReplayWorkPlayCard", package.seeall)

slot0 = class("FightReplayWorkPlayCard", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.cardOp = slot1
end

function slot0.onStart(slot0)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onCombineCardEnd, slot0)
	FightController.instance:dispatchEvent(FightEvent.SimulatePlayHandCard, slot0.cardOp.param1, slot0.cardOp.toId, slot0.cardOp.param2)
end

function slot0._onCombineCardEnd(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineCardEnd, slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.01)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineCardEnd, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
