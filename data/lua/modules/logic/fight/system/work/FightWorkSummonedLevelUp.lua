module("modules.logic.fight.system.work.FightWorkSummonedLevelUp", package.seeall)

slot0 = class("FightWorkSummonedLevelUp", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0._actEffectMO.targetId
	slot0._uid = slot0._actEffectMO.reserveId
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._entityId)
	slot1 = slot0._entityMO and slot0._entityMO:getSummonedInfo()
	slot0._summonedData = slot1 and slot1:getData(slot0._uid)
	slot0._oldLevel = slot0._summonedData and slot0._summonedData.level
end

function slot0.onStart(slot0)
	if not slot0._summonedData then
		slot0:onDone(true)

		return
	end

	slot0._newLevel = slot0._summonedData.level

	if FightConfig.instance:getSummonedConfig(slot0._summonedData.summonedId, slot0._summonedData.level) then
		slot0:com_registTimer(slot0._delayDone, slot1.enterTime / 1000 / FightModel.instance:getSpeed())
		FightController.instance:dispatchEvent(FightEvent.SummonedLevelChange, slot0._entityId, slot0._uid, slot0._oldLevel, slot0._newLevel)

		return
	end

	logError("挂件表找不到id:" .. slot0._summonedData.summonedId .. "  等级:" .. slot0._summonedData.level)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
