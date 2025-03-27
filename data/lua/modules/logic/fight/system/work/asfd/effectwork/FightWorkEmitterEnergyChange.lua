module("modules.logic.fight.system.work.asfd.effectwork.FightWorkEmitterEnergyChange", package.seeall)

slot0 = class("FightWorkEmitterEnergyChange", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0.beforeEnergy = FightDataHelper.ASFDDataMgr:getEmitterEnergy(slot0._actEffectMO.effectNum)
end

function slot0.onStart(slot0)
	slot1 = slot0._actEffectMO.effectNum

	FightController.instance:dispatchEvent(FightEvent.ASFD_EmitterEnergyChange, slot1, slot0.beforeEnergy, FightDataHelper.ASFDDataMgr:getEmitterEnergy(slot1))

	return slot0:onDone(true)
end

return slot0
