module("modules.logic.fight.system.work.FightWorkDamageShareHp", package.seeall)

slot0 = class("FightWorkDamageShareHp", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0._actEffectMO.targetId) and slot0._actEffectMO.effectNum > 0 then
		slot3 = slot1:isMySide() and -slot2 or slot2

		if slot1.nameUI then
			slot1.nameUI:addHp(-slot2)
		end

		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, -slot2)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
