module("modules.logic.fight.system.work.FightWorkSummonedDelete", package.seeall)

slot0 = class("FightWorkSummonedDelete", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0._actEffectMO.targetId
	slot0._uid = slot0._actEffectMO.reserveId
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._entityId)
	slot1 = slot0._entityMO and slot0._entityMO:getSummonedInfo()
	slot0._oldValue = slot1 and slot1:getData(slot0._uid)
end

function slot0.onStart(slot0)
	if not slot0._oldValue then
		slot0:onDone(true)

		return
	end

	if FightConfig.instance:getSummonedConfig(slot0._oldValue.summonedId, slot0._oldValue.level) then
		slot0:com_registTimer(slot0._delayDone, slot1.closeTime / 1000 / FightModel.instance:getSpeed())
		FightController.instance:dispatchEvent(FightEvent.PlayRemoveSummoned, slot0._entityId, slot0._uid)

		return
	end

	logError("挂件表找不到id:" .. slot0._oldValue.summonedId .. "  等级:" .. slot0._oldValue.level)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:dispatchEvent(FightEvent.SummonedDelete, slot0._entityId, slot0._uid)
end

return slot0
