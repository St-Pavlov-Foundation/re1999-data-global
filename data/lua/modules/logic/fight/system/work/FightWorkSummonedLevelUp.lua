module("modules.logic.fight.system.work.FightWorkSummonedLevelUp", package.seeall)

slot0 = class("FightWorkSummonedLevelUp", FightEffectBase)

function slot0.onStart(slot0)
	slot0._targetId = slot0._actEffectMO.targetId
	slot0._uid = slot0._actEffectMO.reserveId

	if FightEntityModel.instance:getById(slot0._targetId) and slot1:getSummonedInfo():getData(slot0._uid) then
		slot3.level = slot3.level + slot0._actEffectMO.effectNum

		if FightConfig.instance:getSummonedConfig(slot3.summonedId, slot3.level) then
			slot0:com_registTimer(slot0._delayDone, slot6.enterTime / 1000 / FightModel.instance:getSpeed())
			FightController.instance:dispatchEvent(FightEvent.SummonedLevelChange, slot0._targetId, slot0._uid, slot3.level, slot5)

			return
		end

		logError("挂件表找不到id:" .. slot3.summonedId .. "  等级:" .. slot3.level)
	end

	slot0:_delayDone()
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
