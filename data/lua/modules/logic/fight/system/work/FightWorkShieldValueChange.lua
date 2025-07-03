module("modules.logic.fight.system.work.FightWorkShieldValueChange", package.seeall)

local var_0_0 = class("FightWorkShieldValueChange", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.targetId
	arg_1_0._entityMO = FightDataHelper.entityMgr:getById(arg_1_0._entityId)
	arg_1_0._oldValue = arg_1_0._entityMO and arg_1_0._entityMO.shieldValue
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0._entityMO then
		arg_2_0:onDone(true)

		return
	end

	local var_2_0 = FightHelper.getEntity(arg_2_0._entityId)

	if var_2_0 and var_2_0.nameUI then
		var_2_0.nameUI:setShield(arg_2_0.actEffectData.effectNum)

		local var_2_1 = arg_2_0.actEffectData.effectNum - arg_2_0._oldValue

		if var_2_1 < 0 then
			local var_2_2 = var_2_0:isMySide() and var_2_1 or -var_2_1
			local var_2_3 = arg_2_0:_getOriginFloatType() or FightEnum.FloatType.damage

			FightFloatMgr.instance:float(var_2_0.id, var_2_3, var_2_2)
		end

		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, var_2_0, var_2_1)
	end

	arg_2_0:onDone(true)
end

function var_0_0._getOriginFloatType(arg_3_0)
	local var_3_0 = tabletool.indexOf(arg_3_0.fightStepData.actEffect, arg_3_0.actEffectData)

	if var_3_0 then
		local var_3_1 = arg_3_0.fightStepData.actEffect[var_3_0 + 1]

		if var_3_1 and var_3_1.effectType == FightEnum.EffectType.SHIELDBROCKEN then
			var_3_1 = arg_3_0.fightStepData.actEffect[var_3_0 + 2]
		end

		if var_3_1 and var_3_1.targetId == arg_3_0._entityId then
			if var_3_1.effectType == FightEnum.EffectType.ORIGINDAMAGE then
				return FightEnum.FloatType.damage_origin
			elseif var_3_1.effectType == FightEnum.EffectType.ORIGINCRIT then
				return FightEnum.FloatType.crit_damage_origin
			elseif var_3_1.effectType == FightEnum.EffectType.ADDITIONALDAMAGE then
				return FightEnum.FloatType.additional_damage
			elseif var_3_1.effectType == FightEnum.EffectType.ADDITIONALDAMAGECRIT then
				return FightEnum.FloatType.crit_additional_damage
			end
		end
	end
end

return var_0_0
