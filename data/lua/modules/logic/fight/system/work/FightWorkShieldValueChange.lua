module("modules.logic.fight.system.work.FightWorkShieldValueChange", package.seeall)

slot0 = class("FightWorkShieldValueChange", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0._actEffectMO.targetId
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._entityId)
	slot0._oldValue = slot0._entityMO and slot0._entityMO.shieldValue
end

function slot0.onStart(slot0)
	if not slot0._entityMO then
		slot0:onDone(true)

		return
	end

	if FightHelper.getEntity(slot0._entityId) and slot1.nameUI then
		slot1.nameUI:setShield(slot0._actEffectMO.effectNum)

		if slot0._actEffectMO.effectNum - slot0._oldValue < 0 then
			FightFloatMgr.instance:float(slot1.id, slot0:_getOriginFloatType() or FightEnum.FloatType.damage, slot1:isMySide() and slot2 or -slot2)
		end

		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, slot1, slot2)
	end

	slot0:onDone(true)
end

function slot0._getOriginFloatType(slot0)
	if tabletool.indexOf(slot0._fightStepMO.actEffectMOs, slot0._actEffectMO) then
		if slot0._fightStepMO.actEffectMOs[slot1 + 1] and slot2.effectType == FightEnum.EffectType.SHIELDBROCKEN then
			slot2 = slot0._fightStepMO.actEffectMOs[slot1 + 2]
		end

		if slot2 and slot2.targetId == slot0._entityId then
			if slot2.effectType == FightEnum.EffectType.ORIGINDAMAGE then
				return FightEnum.FloatType.damage_origin
			elseif slot2.effectType == FightEnum.EffectType.ORIGINCRIT then
				return FightEnum.FloatType.crit_damage_origin
			elseif slot2.effectType == FightEnum.EffectType.ADDITIONALDAMAGE then
				return FightEnum.FloatType.additional_damage
			elseif slot2.effectType == FightEnum.EffectType.ADDITIONALDAMAGECRIT then
				return FightEnum.FloatType.crit_additional_damage
			end
		end
	end
end

return slot0
