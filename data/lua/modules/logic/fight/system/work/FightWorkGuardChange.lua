module("modules.logic.fight.system.work.FightWorkGuardChange", package.seeall)

slot0 = class("FightWorkGuardChange", FightEffectBase)

function slot0.onStart(slot0)
	if FightDataHelper.entityMgr:getById(slot0._actEffectMO.targetId) then
		FightController.instance:dispatchEvent(FightEvent.EntityGuardChange, slot2.id, slot0._actEffectMO.effectNum, slot2.guard)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
