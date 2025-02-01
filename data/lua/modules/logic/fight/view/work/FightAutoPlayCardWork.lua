module("modules.logic.fight.view.work.FightAutoPlayCardWork", package.seeall)

slot0 = class("FightAutoPlayCardWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._beginRoundOp = slot1
end

function slot0.onStart(slot0, slot1)
	if slot0._beginRoundOp then
		FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, slot0._beginRoundOp.toId)
	end

	FightController.instance:registerCallback(FightEvent.PlayCardOver, slot0._onPlayCardOver, slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 10)

	if slot0._beginRoundOp then
		FightController.instance:dispatchEvent(FightEvent.PlayHandCard, FightCardModel.instance:getHandCards()[slot0._beginRoundOp.param1] and slot2 or 1, slot0._beginRoundOp.toId, slot0._beginRoundOp.param2)
	end
end

function slot0._delayDone(slot0)
	logError("自动战斗打牌超时")
	FightController.instance:dispatchEvent(FightEvent.ForceEndAutoCardFlow)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.PlayCardOver, slot0._onPlayCardOver, slot0)
end

function slot0._onPlayCardOver(slot0)
	slot0:onDone(true)
end

return slot0
