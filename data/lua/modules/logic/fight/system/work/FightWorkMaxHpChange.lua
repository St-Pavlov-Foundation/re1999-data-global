module("modules.logic.fight.system.work.FightWorkMaxHpChange", package.seeall)

slot0 = class("FightWorkMaxHpChange", FightEffectBase)

function slot0.onStart(slot0)
	slot0:_startChangeMaxHp()
end

function slot0._startChangeMaxHp(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	if slot2:getMO() then
		slot3.attrMO.hp = slot0._actEffectMO.effectNum

		FightController.instance:dispatchEvent(FightEvent.OnMaxHpChange, slot0._actEffectMO.targetId, slot3.attrMO.hp, slot3.attrMO.hp)
	end

	slot0:_onDone()
end

function slot0._onDone(slot0)
	slot0:clearWork()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
