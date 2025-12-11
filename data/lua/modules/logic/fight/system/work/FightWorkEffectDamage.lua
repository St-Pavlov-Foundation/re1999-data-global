module("modules.logic.fight.system.work.FightWorkEffectDamage", package.seeall)

local var_0_0 = class("FightWorkEffectDamage", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if arg_1_0.actEffectData.custom_nuoDiKaDamageSign then
		arg_1_0:com_sendFightEvent(FightEvent.OnCurrentHpChange, arg_1_0.actEffectData.targetId)
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if var_1_0 then
		local var_1_1 = arg_1_0.actEffectData.effectNum

		if var_1_1 > 0 then
			local var_1_2 = var_1_0:isMySide() and -var_1_1 or var_1_1
			local var_1_3 = arg_1_0:getFloatType()

			if arg_1_0.actEffectData.configEffect == 30006 then
				var_1_3 = FightEnum.FloatType.damage
			end

			FightFloatMgr.instance:float(var_1_0.id, var_1_3, var_1_2, nil, arg_1_0.actEffectData.effectNum1 == 1)

			if var_1_0.nameUI then
				var_1_0.nameUI:addHp(-var_1_1)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_1_0, -var_1_1)
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0.getFloatType(arg_2_0)
	local var_2_0 = FightHelper.isRestrain(arg_2_0.fightStepData.fromId, arg_2_0.actEffectData.targetId)
	local var_2_1 = FightHelper.isOppositeByEntityId(arg_2_0.fightStepData.fromId, arg_2_0.actEffectData.targetId)

	if var_2_0 and var_2_1 then
		if arg_2_0.actEffectData.effectType == FightEnum.EffectType.DAMAGE then
			return FightEnum.FloatType.restrain
		elseif arg_2_0.actEffectData.effectType == FightEnum.EffectType.CRIT then
			return FightEnum.FloatType.crit_restrain
		end
	elseif arg_2_0.actEffectData.effectType == FightEnum.EffectType.DAMAGE then
		return FightEnum.FloatType.damage
	elseif arg_2_0.actEffectData.effectType == FightEnum.EffectType.CRIT then
		return FightEnum.FloatType.crit_damage
	end

	return FightEnum.FloatType.damage
end

return var_0_0
