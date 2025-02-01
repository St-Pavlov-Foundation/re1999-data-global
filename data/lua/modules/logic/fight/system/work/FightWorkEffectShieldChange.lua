module("modules.logic.fight.system.work.FightWorkEffectShieldChange", package.seeall)

slot0 = class("FightWorkEffectShieldChange", FightEffectBase)

function slot0.onStart(slot0)
	slot2 = slot0._actEffectMO.effectNum

	if FightHelper.getEntity(slot0._actEffectMO.targetId) and slot1.nameUI and slot2 > 0 then
		slot1.nameUI:addHp(slot2)
		slot1.nameUI:setShield(0)
		FightFloatMgr.instance:float(slot1.id, FightEnum.FloatType.heal, slot2)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, slot2)
		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, slot1, 0)
	end

	slot0:onDone(true)
end

return slot0
