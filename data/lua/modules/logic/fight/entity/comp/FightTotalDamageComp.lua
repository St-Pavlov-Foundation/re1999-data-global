module("modules.logic.fight.entity.comp.FightTotalDamageComp", package.seeall)

local var_0_0 = class("FightTotalDamageComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._damageDict = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	FightController.instance:registerCallback(FightEvent.OnDamageTotal, arg_2_0._onDamageTotal, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnDamageTotal, arg_3_0._onDamageTotal, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._showTotalFloat, arg_3_0)
end

function var_0_0._onDamageTotal(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_2 == arg_4_0.entity and arg_4_3 and arg_4_3 > 0 then
		arg_4_0._damageDict[arg_4_1] = arg_4_0._damageDict[arg_4_1] or {}

		table.insert(arg_4_0._damageDict[arg_4_1], arg_4_3)

		if arg_4_4 then
			arg_4_0._damageDict[arg_4_1].showTotal = true
			arg_4_0._damageDict[arg_4_1].fromId = arg_4_1.fromId

			TaskDispatcher.runDelay(arg_4_0._showTotalFloat, arg_4_0, 0.6)
		end
	end
end

function var_0_0._onSkillPlayFinish(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 ~= arg_5_0.entity and arg_5_3.actType == FightEnum.ActType.SKILL then
		TaskDispatcher.cancelTask(arg_5_0._showTotalFloat, arg_5_0)

		if arg_5_0._damageDict[arg_5_3] then
			arg_5_0._damageDict[arg_5_3].showTotal = true
			arg_5_0._damageDict[arg_5_3].fromId = arg_5_3.fromId
		end

		arg_5_0:_showTotalFloat()
	end
end

local var_0_1 = {
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.ORIGINDAMAGE] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGE] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true
}
local var_0_2 = {
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true
}

function var_0_0._showTotalFloat(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._damageDict) do
		if iter_6_1.showTotal and #iter_6_1 > 1 then
			local var_6_0 = false
			local var_6_1 = 0

			for iter_6_2, iter_6_3 in ipairs(iter_6_0.actEffect) do
				if iter_6_3.targetId == arg_6_0.entity.id then
					local var_6_2 = iter_6_3.effectType

					if FightTLEventDefHit.originHitEffectType[var_6_2] then
						var_6_0 = true
					end
				end
			end

			for iter_6_4, iter_6_5 in ipairs(iter_6_0.actEffect) do
				if iter_6_5.targetId == arg_6_0.entity.id then
					local var_6_3 = iter_6_5.effectType

					if var_0_1[var_6_3] then
						var_6_1 = var_6_1 + iter_6_5.effectNum
					elseif var_0_2[var_6_3] then
						var_6_1 = 0

						for iter_6_6, iter_6_7 in ipairs(iter_6_1) do
							var_6_1 = var_6_1 + iter_6_7
						end

						break
					end
				end
			end

			if var_6_1 > 0 then
				local var_6_4 = {
					fromId = iter_6_1.fromId,
					defenderId = arg_6_0.entity.id
				}

				if arg_6_0._fixedPos then
					var_6_4.pos_x = arg_6_0._fixedPos[1]
					var_6_4.pos_y = arg_6_0._fixedPos[2]
				end

				local var_6_5 = var_6_0 and FightEnum.FloatType.total_origin or FightEnum.FloatType.total

				FightFloatMgr.instance:float(arg_6_0.entity.id, var_6_5, var_6_1, var_6_4)
			end
		end

		if iter_6_1.showTotal then
			arg_6_0._damageDict[iter_6_0] = nil
		end
	end
end

return var_0_0
