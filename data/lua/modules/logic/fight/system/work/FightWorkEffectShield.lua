module("modules.logic.fight.system.work.FightWorkEffectShield", package.seeall)

slot0 = class("FightWorkEffectShield", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0._actEffectMO.targetId) and slot1.nameUI then
		slot1.nameUI:setShield(slot0._actEffectMO.effectNum)

		if slot0._actEffectMO.effectNum - slot1:getMO().shieldValue < 0 then
			FightFloatMgr.instance:float(slot1.id, slot0:_getOriginFloatType() or FightEnum.FloatType.damage, slot1:isMySide() and slot3 or -slot3)
		end

		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, slot1, slot3)
	end

	slot0:onDone(true)
end

function slot0._getOriginFloatType(slot0)
	if tabletool.indexOf(slot0._fightStepMO.actEffectMOs, slot0._actEffectMO) then
		if slot0._fightStepMO.actEffectMOs[slot1 + 1] and slot2.effectType == FightEnum.EffectType.SHIELDBROCKEN then
			slot2 = slot0._fightStepMO.actEffectMOs[slot1 + 2]
		end

		if slot2 and slot2.targetId == slot0._actEffectMO.targetId then
			if slot2.effectType == FightEnum.EffectType.ORIGINDAMAGE then
				return FightEnum.FloatType.damage_origin
			elseif slot2.effectType == FightEnum.EffectType.ORIGINCRIT then
				return FightEnum.FloatType.crit_damage_origin
			end
		end
	end
end

return slot0
