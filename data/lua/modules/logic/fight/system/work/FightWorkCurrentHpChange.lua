module("modules.logic.fight.system.work.FightWorkCurrentHpChange", package.seeall)

slot0 = class("FightWorkCurrentHpChange", FightEffectBase)

function slot0.onStart(slot0)
	slot0:_startChangeCurrentHp()
end

function slot0._startChangeCurrentHp(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		logError("change CURRENTHPCHANGE fail, entity not exist: " .. slot1)
		slot0:onDone(true)

		return
	end

	slot3 = slot2:getMO()
	slot3.currentHp = slot0._actEffectMO.effectNum

	FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, slot0._actEffectMO.targetId, slot3.currentHp, slot3.currentHp)
	slot0:_onDone()
end

function slot0._onDone(slot0)
	slot0:clearWork()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
