module("modules.logic.fight.system.work.FightStepEffectWork", package.seeall)

slot0 = class("FightStepEffectWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
	slot0._workFlow = nil
end

function slot0.onStart(slot0)
	if slot0._workFlow then
		return slot0._workFlow:start()
	end
end

function slot0.setFlow(slot0, slot1)
	slot0._workFlow = slot1

	slot1:registFinishCallback(slot0._onFlowDone, slot0)
end

function slot0._onFlowDone(slot0)
	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._workFlow then
		slot0._workFlow:disposeSelf()

		slot0._workFlow = nil
	end
end

return slot0
