module("modules.logic.fight.system.work.FightWorkDistributeCard", package.seeall)

slot0 = class("FightWorkDistributeCard", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	if not FightModel.instance:getCurRoundMO() then
		slot0:onDone(false)

		return
	end

	FightController.instance:setCurStage(FightEnum.Stage.Distribute)

	slot3 = slot1.teamACards1

	if #slot1.beforeCards1 > 0 or #slot3 > 0 then
		FightCardModel.instance:clearDistributeQueue()
		FightCardModel.instance:enqueueDistribute(slot2, slot3)
	end

	FightController.instance:GuideFlowPauseAndContinue("OnGuideDistributePause", FightEvent.OnGuideDistributePause, FightEvent.OnGuideDistributeContinue, slot0._distrubute, slot0)
end

function slot0._distrubute(slot0)
	FightViewPartVisible.set(false, true, false, false, false)
	FightController.instance:registerCallback(FightEvent.OnDistributeCards, slot0._done, slot0)
	FightController.instance:dispatchEvent(FightEvent.DistributeCards)
end

function slot0._done(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, slot0._done, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, slot0._done, slot0)
end

return slot0
