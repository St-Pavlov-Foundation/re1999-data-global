module("modules.logic.fight.system.work.FightWorkOriginDamage", package.seeall)

slot0 = class("FightWorkOriginDamage", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0._actEffectMO.targetId) and slot0._actEffectMO.effectNum > 0 then
		FightFloatMgr.instance:float(slot1.id, FightEnum.FloatType.damage_origin, slot1:isMySide() and -slot2 or slot2)
		slot1.nameUI:addHp(-slot2)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, -slot2)
	end

	slot0:onDone(true)
end

return slot0
