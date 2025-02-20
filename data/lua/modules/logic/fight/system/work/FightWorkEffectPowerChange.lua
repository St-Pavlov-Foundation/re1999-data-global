module("modules.logic.fight.system.work.FightWorkEffectPowerChange", package.seeall)

slot0 = class("FightWorkEffectPowerChange", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0._actEffectMO.targetId
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._entityId)
	slot0._powerId = slot0._actEffectMO.configEffect
	slot0._powerData = slot0._entityMO and slot0._entityMO:getPowerInfo(slot0._powerId)
	slot0._oldValue = slot0._powerData and slot0._powerData.num
end

function slot0.onStart(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	if not slot0._entityMO then
		slot0:onDone(true)

		return
	end

	slot0._powerData = slot0._entityMO and slot0._entityMO:getPowerInfo(slot0._powerId)

	if not slot0._powerData then
		logError(string.format("找不到灵光数据,灵光id:%s, 角色或怪物id:%s, 步骤类型:%s, actId:%s", slot0._powerId, slot0._entityMO.modelId, slot0._fightStepMO.actType, slot0._fightStepMO.actId))
		slot0:onDone(true)

		return
	end

	slot0._newValue = slot0._powerData and slot0._powerData.num

	if slot0._oldValue ~= slot0._newValue then
		FightController.instance:dispatchEvent(FightEvent.PowerChange, slot0._actEffectMO.targetId, slot0._powerId, slot0._oldValue, slot0._newValue)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
