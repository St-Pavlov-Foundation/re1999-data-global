module("modules.logic.fight.system.work.asfd.effectwork.FightWorkTeamEnergyChange", package.seeall)

slot0 = class("FightWorkTeamEnergyChange", FightEffectBase)

function slot0.onConstructor(slot0)
	slot0.SAFETIME = 1
end

function slot0.beforePlayEffectData(slot0)
	slot0.beforeEnergy = FightDataHelper.ASFDDataMgr:getEnergy(slot0._actEffectMO.effectNum) or 0
end

slot0.WaitTime = 0.6

function slot0.onStart(slot0)
	slot1 = slot0._actEffectMO.effectNum

	FightController.instance:dispatchEvent(FightEvent.ASFD_TeamEnergyChange, slot1, slot0.beforeEnergy, FightDataHelper.ASFDDataMgr:getEnergy(slot1))
	slot0:com_registTimer(slot0._delayDone, uv0.WaitTime / FightModel.instance:getSpeed())
end

return slot0
