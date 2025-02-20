module("modules.logic.fight.system.work.FightWorkEffectExpointMaxAdd", package.seeall)

slot0 = class("FightWorkEffectExpointMaxAdd", FightEffectBase)

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnExpointMaxAdd, slot0._actEffectMO.targetId, slot0._actEffectMO.effectNum)
	slot0:onDone(true)
end

function slot0._startAddExpointMax(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	if not slot2:getMO() then
		slot0:onDone(true)

		return
	end

	if slot3:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		slot0:onDone(true)

		return
	end

	slot3:changeExpointMaxAdd(slot0._actEffectMO.effectNum)
	FightController.instance:dispatchEvent(FightEvent.OnExpointMaxAdd, slot1, slot0._actEffectMO.effectNum)
	slot0:_onDone()
end

function slot0._onDone(slot0)
	slot0:clearWork()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
