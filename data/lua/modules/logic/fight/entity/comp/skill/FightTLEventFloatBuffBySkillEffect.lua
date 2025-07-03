module("modules.logic.fight.entity.comp.skill.FightTLEventFloatBuffBySkillEffect", package.seeall)

local var_0_0 = class("FightTLEventFloatBuffBySkillEffect", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.buffId = FightTLHelper.getNumberParam(arg_1_3[1])

	local var_1_0 = arg_1_1.actId
	local var_1_1 = var_1_0 and lua_skill.configDict[var_1_0]
	local var_1_2 = var_1_1 and lua_skill_effect.configDict[var_1_1.skillEffect]

	if not var_1_2 then
		return
	end

	local var_1_3 = 0

	for iter_1_0 = 1, FightEnum.MaxBehavior do
		local var_1_4 = var_1_2["behavior" .. iter_1_0]

		if string.nilorempty(var_1_4) then
			break
		end

		local var_1_5 = FightStrUtil.instance:getSplitToNumberCache(var_1_4, "#")
		local var_1_6 = lua_skill_behavior.configDict[var_1_5[1]]
		local var_1_7 = var_1_6 and var_1_6.type
		local var_1_8 = arg_1_0:getHandle(var_1_7)

		if var_1_8 then
			var_1_3 = var_1_8(arg_1_0, var_1_5)

			break
		end
	end

	if var_1_3 < 1 then
		return
	end

	arg_1_0:floatBuff(var_1_3)
end

function var_0_0.getHandle(arg_2_0, arg_2_1)
	if not var_0_0.SkillEffectHandleDict then
		var_0_0.SkillEffectHandleDict = {
			AddBuff = arg_2_0.getAddBuffFloatCount
		}
	end

	return arg_2_1 and var_0_0.SkillEffectHandleDict[arg_2_1]
end

function var_0_0.floatBuff(arg_3_0, arg_3_1)
	local var_3_0 = FightEnum.EffectType.BUFFADD
	local var_3_1 = arg_3_0.fightStepData.toId
	local var_3_2 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.fightStepData.actEffect) do
		if not iter_3_1:isDone() and var_3_1 == iter_3_1.targetId and iter_3_1.effectType == var_3_0 and iter_3_1.effectNum == arg_3_0.buffId then
			var_3_2 = var_3_2 + 1

			FightSkillBuffMgr.instance:playSkillBuff(arg_3_0.fightStepData, iter_3_1)
			FightDataHelper.playEffectData(iter_3_1)

			if arg_3_1 <= var_3_2 then
				return
			end
		end
	end
end

function var_0_0.getAddBuffFloatCount(arg_4_0, arg_4_1)
	return arg_4_1 and arg_4_1[3] or 1
end

function var_0_0.onTrackEnd(arg_5_0)
	return
end

function var_0_0.onDestructor(arg_6_0)
	return
end

return var_0_0
