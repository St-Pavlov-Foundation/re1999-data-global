module("modules.logic.fight.system.work.asfd.FightWorkASFDEffectFlow", package.seeall)

slot0 = class("FightWorkASFDEffectFlow", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.stepMo = slot1
	slot0._fightStepMO = slot1
end

function slot0.onStart(slot0)
	slot0.stepWork = FightStepBuilder._buildEffectWorks(slot0.stepMo) and slot1[1]

	if not slot0.stepWork then
		return slot0:onDone(true)
	end

	slot0.stepWork:registerDoneListener(slot0.onEffectWorkDone, slot0)
	slot0.stepWork:onStartInternal()
end

function slot0.onEffectWorkDone(slot0)
	return slot0:onDone(true)
end

return slot0
