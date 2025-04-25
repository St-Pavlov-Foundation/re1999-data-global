module("modules.logic.fight.system.work.FightWorkSaveFightRecordUpdate", package.seeall)

slot0 = class("FightWorkSaveFightRecordUpdate", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot1 = slot0._actEffectMO.entityMO and slot0._actEffectMO.entityMO.uid
	slot2 = slot1 and FightHelper.getEntity(slot1)
	slot3 = slot2 and slot2:getMO()
	slot0.beforeHp = slot3 and slot3.currentHp or 0
end

function slot0.onStart(slot0)
	slot1 = slot0._actEffectMO.entityMO and slot0._actEffectMO.entityMO.uid

	if not (slot1 and FightHelper.getEntity(slot1)) then
		return
	end

	if slot2.nameUI then
		slot2.nameUI:resetHp()
	end

	slot3 = slot2 and slot2:getMO()

	FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot2, (slot3 and slot3.currentHp or 0) - slot0.beforeHp)

	return slot0:onDone(true)
end

return slot0
