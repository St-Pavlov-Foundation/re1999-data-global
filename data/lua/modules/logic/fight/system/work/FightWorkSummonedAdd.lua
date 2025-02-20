module("modules.logic.fight.system.work.FightWorkSummonedAdd", package.seeall)

slot0 = class("FightWorkSummonedAdd", FightEffectBase)

function slot0.onStart(slot0)
	slot0._targetId = slot0._actEffectMO.targetId

	if FightDataHelper.entityMgr:getById(slot0._targetId) and slot0._actEffectMO.summoned then
		slot3 = slot1:getSummonedInfo():getData(slot0._actEffectMO.summoned.uid)

		if FightConfig.instance:getSummonedConfig(slot3.summonedId, slot3.level) then
			slot0:com_registTimer(slot0._delayDone, slot4.enterTime / 1000 / FightModel.instance:getSpeed())
			FightController.instance:dispatchEvent(FightEvent.SummonedAdd, slot0._targetId, slot3)

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
