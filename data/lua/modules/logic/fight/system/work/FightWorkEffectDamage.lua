module("modules.logic.fight.system.work.FightWorkEffectDamage", package.seeall)

slot0 = class("FightWorkEffectDamage", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0._actEffectMO.targetId) and slot0._actEffectMO.effectNum > 0 then
		FightFloatMgr.instance:float(slot1.id, slot0:getFloatType(), slot1:isMySide() and -slot2 or slot2)

		if slot1.nameUI then
			slot1.nameUI:addHp(-slot2)
		end

		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, -slot2)
	end

	slot0:onDone(true)
end

function slot0.getFloatType(slot0)
	if FightHelper.isRestrain(slot0._fightStepMO.fromId, slot0._actEffectMO.targetId) then
		if slot0._actEffectMO.effectType == FightEnum.EffectType.DAMAGE then
			return FightEnum.FloatType.restrain
		elseif slot0._actEffectMO.effectType == FightEnum.EffectType.CRIT then
			return FightEnum.FloatType.crit_restrain
		end
	elseif slot0._actEffectMO.effectType == FightEnum.EffectType.DAMAGE then
		return FightEnum.FloatType.damage
	elseif slot0._actEffectMO.effectType == FightEnum.EffectType.CRIT then
		return FightEnum.FloatType.crit_damage
	end

	return FightEnum.FloatType.damage
end

return slot0
