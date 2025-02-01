module("modules.logic.fight.system.work.FightWorkSummonedDelete", package.seeall)

slot0 = class("FightWorkSummonedDelete", FightEffectBase)

function slot0.onStart(slot0)
	slot0._targetId = slot0._actEffectMO.targetId
	slot0._uid = slot0._actEffectMO.reserveId

	if FightEntityModel.instance:getById(slot0._targetId) and slot1:getSummonedInfo():getData(slot0._uid) then
		slot2:removeData(slot0._uid)

		if FightConfig.instance:getSummonedConfig(slot3.summonedId, slot3.level) then
			slot0:com_registTimer(slot0._delayDone, slot4.closeTime / 1000 / FightModel.instance:getSpeed())
			FightController.instance:dispatchEvent(FightEvent.PlayRemoveSummoned, slot0._targetId, slot0._uid)

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
	FightController.instance:dispatchEvent(FightEvent.SummonedDelete, slot0._targetId, slot0._uid)
end

return slot0
