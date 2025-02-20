module("modules.logic.fight.system.work.FightWorkMultiHpChange", package.seeall)

slot0 = class("FightWorkMultiHpChange", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0._actEffectMO.targetId
	slot0._oldEntityMO = FightDataHelper.entityMgr:getOldEntityMO(slot0._entityId)
end

function slot0.onStart(slot0)
	slot0._newEntityMO = FightDataHelper.entityMgr:getById(slot0._entityId)

	if not FightHelper.getEntity(slot0._entityId) or not slot0._oldEntityMO then
		slot0:onDone(true)

		return
	end

	slot2 = slot0:com_registWorkDoneFlowSequence()

	if slot0._newEntityMO then
		FightHelper.buildMonsterA2B(slot1, slot0._oldEntityMO, slot2, FightWorkFunction.New(slot0._afterMonsterA2B, slot0, slot0._newEntityMO))
	end

	slot2:start()
end

function slot0._afterMonsterA2B(slot0, slot1)
	slot0:com_sendFightEvent(FightEvent.MultiHpChange, slot1.id)
end

function slot0.clearWork(slot0)
end

return slot0
