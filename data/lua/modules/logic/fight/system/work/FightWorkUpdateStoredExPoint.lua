module("modules.logic.fight.system.work.FightWorkUpdateStoredExPoint", package.seeall)

slot0 = class("FightWorkUpdateStoredExPoint", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0._actEffectMO.targetId
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._entityId)
	slot0._oldValue = slot0._entityMO and slot0._entityMO:getStoredExPoint()
end

function slot0.onStart(slot0)
	if not FightDataHelper.entityMgr:getById(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	slot0._newValue = slot0._entityMO and slot0._entityMO:getStoredExPoint()

	FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, slot0._entityId, slot0._oldValue)
	slot0:onDone(true)
end

return slot0
