module("modules.logic.fight.system.work.FightWorkDamageExtra", package.seeall)

slot0 = class("FightWorkDamageExtra", FightEffectBase)

function slot0.onStart(slot0)
	slot0._flow = FlowParallel.New()

	slot0._flow:addWork(FunctionWork.New(slot0._resignDone, slot0))
	slot0._flow:addWork(FightWork2Work.New(FightWorkEffectDamage, slot0._fightStepMO, slot0._actEffectMO))
	slot0._flow:addWork(FunctionWork.New(slot0._resignDone, slot0))
	slot0._flow:addWork(FightWork2Work.New(FightBuffTriggerEffect, slot0._fightStepMO, slot0._actEffectMO))
	slot0._flow:registerDoneListener(slot0._onFlowDone, slot0)
	slot0._flow:start()
end

function slot0._resignDone(slot0)
	slot0._actEffectMO:revertDone()
end

function slot0._onFlowDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._onFlowDone, slot0)
		slot0._flow:stop()

		slot0._flow = nil
	end
end

return slot0
