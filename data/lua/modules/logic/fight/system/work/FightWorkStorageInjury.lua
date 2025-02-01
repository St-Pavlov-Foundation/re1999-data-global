module("modules.logic.fight.system.work.FightWorkStorageInjury", package.seeall)

slot0 = class("FightWorkStorageInjury", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0._actEffectMO.targetId) and slot0._actEffectMO.buff and FightEntityModel.instance:getById(slot1.id) then
		slot3:updateBuff(slot2)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
