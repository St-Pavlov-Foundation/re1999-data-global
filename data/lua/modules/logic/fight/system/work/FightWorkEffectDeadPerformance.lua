module("modules.logic.fight.system.work.FightWorkEffectDeadPerformance", package.seeall)

slot0 = class("FightWorkEffectDeadPerformance", FightEffectBase)

function slot0.onAwake(slot0, slot1, slot2, slot3)
	slot0._fightStepMO = slot1
	slot0._actEffectMO = slot2
	slot0._waitForLastHit = slot3
end

function slot0.onStart(slot0)
	slot0:com_registWorkDoneFlowSequence():addWork(Work2FightWork.New(FightWorkEffectDeadNew, slot0._fightStepMO, slot0._actEffectMO, slot0._waitForLastHit))

	if FightModel.instance:getVersion() < 1 and slot0._actEffectMO and slot0._actEffectMO.targetId then
		slot1:addWork(Work2FightWork.New(FightWorkDissolveCardForDeadVersion0, slot0._actEffectMO))
	end

	slot1:start()
end

function slot0.clearWork(slot0)
end

return slot0
