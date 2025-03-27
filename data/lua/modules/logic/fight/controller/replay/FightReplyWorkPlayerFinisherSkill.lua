module("modules.logic.fight.controller.replay.FightReplyWorkPlayerFinisherSkill", package.seeall)

slot0 = class("FightReplyWorkPlayerFinisherSkill", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._beginRoundOp = slot1
end

function slot0.onStart(slot0, slot1)
	if FightCardModel.instance:isCardOpEnd() then
		slot0:onDone(true)

		return
	end

	if not slot0._beginRoundOp then
		return slot0:onDone(true)
	end

	FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, slot0._beginRoundOp.toId)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 3)

	slot2 = FightCardModel.instance:playPlayerFinisherSkill(slot0._beginRoundOp.param1, slot0._beginRoundOp.toId)

	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, slot2)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, slot2)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, slot2)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
