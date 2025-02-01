module("modules.logic.fight.system.work.FightWorkNotifyUpgradeHero", package.seeall)

slot0 = class("FightWorkNotifyUpgradeHero", FightEffectBase)

function slot0.onStart(slot0)
	if FightEntityModel.instance:getById(slot0._actEffectMO.targetId) then
		slot1.canUpgradeIds[slot0._actEffectMO.effectNum] = slot0._actEffectMO.effectNum
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
