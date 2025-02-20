module("modules.logic.fight.view.work.FightAutoPlayAssistBossCardWork", package.seeall)

slot0 = class("FightAutoPlayAssistBossCardWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._beginRoundOp = slot1
end

function slot0.onStart(slot0, slot1)
	if slot0._beginRoundOp then
		FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, slot0._beginRoundOp.toId)
	end

	if not slot0._beginRoundOp then
		return slot0:onDone(true)
	end

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 3)

	slot2 = FightCardModel.instance:playAssistBossHandCardOp(slot0._beginRoundOp.param1, slot0._beginRoundOp.toId)

	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, slot2)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, slot2)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, slot2)
	FightDataHelper.paTaMgr:playAssistBossSkillBySkillId(slot2.param1)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossPowerChange)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	logError("自动战斗打协助boss牌超时")
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
