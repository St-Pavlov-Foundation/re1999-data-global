module("modules.logic.fight.system.work.FightWorkExSkillPointChange", package.seeall)

slot0 = class("FightWorkExSkillPointChange", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0._actEffectMO.targetId
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._entityId)
	slot0._oldValue = slot0._entityMO and slot0._entityMO:getUniqueSkillPoint()
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

	slot0._newValue = slot0._entityMO and slot0._entityMO:getUniqueSkillPoint()

	if slot0._oldValue ~= slot0._newValue then
		FightController.instance:dispatchEvent(FightEvent.OnExSkillPointChange, slot0._actEffectMO.targetId, slot0._oldValue, slot0._newValue)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
