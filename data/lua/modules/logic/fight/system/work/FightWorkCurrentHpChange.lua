module("modules.logic.fight.system.work.FightWorkCurrentHpChange", package.seeall)

slot0 = class("FightWorkCurrentHpChange", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0._actEffectMO.targetId
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._entityId)
	slot0._oldValue = slot0._entityMO and slot0._entityMO.currentHp
end

function slot0.onStart(slot0)
	if not FightHelper.getEntity(slot0._entityId) then
		slot0:onDone(true)

		return
	end

	if not slot0._entityMO then
		slot0:onDone(true)

		return
	end

	slot0._newValue = slot0._entityMO and slot0._entityMO.currentHp

	FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, slot0._actEffectMO.targetId, slot0._oldValue, slot0._newValue)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
