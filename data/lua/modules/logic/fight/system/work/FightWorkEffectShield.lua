module("modules.logic.fight.system.work.FightWorkEffectShield", package.seeall)

local var_0_0 = class("FightWorkEffectShield", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.targetId
	arg_1_0._entityMO = FightDataHelper.entityMgr:getById(arg_1_0._entityId)
	arg_1_0._oldValue = arg_1_0._entityMO and arg_1_0._entityMO.shieldValue or 0
end

function var_0_0.onStart(arg_2_0)
	if arg_2_0.actEffectData.custom_nuoDiKaDamageSign then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._newValue = arg_2_0._entityMO and arg_2_0._entityMO.shieldValue or 0

	local var_2_0 = FightHelper.getEntity(arg_2_0._entityId)

	if var_2_0 and var_2_0.nameUI then
		var_2_0.nameUI:setShield(arg_2_0.actEffectData.effectNum)

		local var_2_1 = arg_2_0.actEffectData.effectNum - arg_2_0._oldValue

		if var_2_1 < 0 then
			local var_2_2 = var_2_0:isMySide() and var_2_1 or -var_2_1
			local var_2_3 = arg_2_0:_getOriginFloatType() or FightEnum.FloatType.damage

			FightFloatMgr.instance:float(var_2_0.id, var_2_3, var_2_2, nil, arg_2_0.actEffectData.buffActId == 1)
		end

		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, var_2_0, var_2_1)
		arg_2_0:com_sendFightEvent(FightEvent.ChangeShield, var_2_0.id)
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

		if var_3_1 and var_3_1.targetId == arg_3_0.actEffectData.targetId then
			if var_3_1.effectType == FightEnum.EffectType.ORIGINDAMAGE then
				return FightEnum.FloatType.damage_origin
			elseif var_3_1.effectType == FightEnum.EffectType.ORIGINCRIT then
				return FightEnum.FloatType.crit_damage_origin
			elseif var_3_1.effectType == FightEnum.EffectType.ADDITIONALDAMAGE then
				return FightEnum.FloatType.additional_damage
			elseif var_3_1.effectType == FightEnum.EffectType.ADDITIONALDAMAGECRIT then
				return FightEnum.FloatType.crit_additional_damage
			elseif var_3_1.effectType == FightEnum.EffectType.DAMAGE then
				local var_3_2 = FightHelper.isRestrain(arg_3_0.fightStepData.fromId, arg_3_0.actEffectData.targetId)
				local var_3_3 = FightHelper.isOppositeByEntityId(arg_3_0.fightStepData.fromId, arg_3_0.actEffectData.targetId)

				return var_3_2 and var_3_3 and FightEnum.FloatType.restrain or FightEnum.FloatType.damage
			elseif var_3_1.effectType == FightEnum.EffectType.CRIT then
				local var_3_4 = FightHelper.isRestrain(arg_3_0.fightStepData.fromId, arg_3_0.actEffectData.targetId)
				local var_3_5 = FightHelper.isOppositeByEntityId(arg_3_0.fightStepData.fromId, arg_3_0.actEffectData.targetId)

				return var_3_4 and var_3_5 and FightEnum.FloatType.crit_restrain or FightEnum.FloatType.crit_damage
			elseif var_3_1.effectType == FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE then
				return FightEnum.FloatType.damage_origin
			elseif var_3_1.effectType == FightEnum.EffectType.DEADLYPOISONORIGINCRIT then
				return FightEnum.FloatType.crit_damage_origin
			end
		end
	end
end

return var_0_0
