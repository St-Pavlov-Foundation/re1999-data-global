module("modules.logic.fight.controller.replay.FightReplayWorkMoveCard", package.seeall)

slot0 = class("FightReplayWorkMoveCard", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.cardOp = slot1
end

function slot0.onStart(slot0)
	slot0._index = slot0.cardOp.param1
	slot0._sign = slot0.cardOp.param1 < slot0.cardOp.param2 and 1 or -1
	slot0._endIndex = slot0.cardOp.param2 + slot0._sign

	TaskDispatcher.runRepeat(slot0._delaySimulateDrag, slot0, 0.1 / Mathf.Clamp(FightModel.instance:getUISpeed(), 0.01, 100), slot0.cardOp.param2 - slot0.cardOp.param1 + 1)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onCombineCardEnd, slot0)
	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardBegin, slot0.cardOp.param1)
end

function slot0._delaySimulateDrag(slot0)
	slot0._index = slot0._index + slot0._sign

	if slot0._index ~= slot0._endIndex then
		FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCard, slot0.cardOp.param1, slot0._index)
	else
		TaskDispatcher.cancelTask(slot0._delaySimulateDrag, slot0)
		TaskDispatcher.runDelay(slot0._delaySimulateDragEnd, slot0, 0.2 / Mathf.Clamp(FightModel.instance:getUISpeed(), 0.01, 100))
	end
end

function slot0._delaySimulateDragEnd(slot0)
	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardEnd, slot0.cardOp.param1, slot0.cardOp.param2)
end

function slot0._onCombineCardEnd(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.01)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineCardEnd, slot0)
	TaskDispatcher.cancelTask(slot0._delaySimulateDrag, slot0)
	TaskDispatcher.cancelTask(slot0._delaySimulateDragEnd, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
