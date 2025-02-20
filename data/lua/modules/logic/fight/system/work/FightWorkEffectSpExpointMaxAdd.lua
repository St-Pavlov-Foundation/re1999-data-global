module("modules.logic.fight.system.work.FightWorkEffectSpExpointMaxAdd", package.seeall)

slot0 = class("FightWorkEffectSpExpointMaxAdd", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0._actEffectMO.targetId
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._entityId)
	slot0._oldValue = slot0._entityMO and slot0._entityMO:getUniqueSkillPoint()
end

function slot0.onStart(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	if not slot2:getMO() then
		slot0:onDone(true)

		return
	end

	if not slot3:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		slot0:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.OnExpointMaxAdd, slot1, slot0._actEffectMO.effectNum)

	slot0._newValue = slot3:getUniqueSkillPoint()

	FightController.instance:dispatchEvent(FightEvent.OnExSkillPointChange, slot1, slot0._oldValue, slot0._newValue)
	slot0:onDone(true)
end

return slot0
