module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillMOBase", package.seeall)

local var_0_0 = class("CharacterSkillMOBase")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._skillId = arg_1_1
	arg_1_0._releaseParam = ""
end

function var_0_0.getSkillConfig(arg_2_0)
	return lua_character_skill.configDict[arg_2_0._skillId]
end

function var_0_0.getCost(arg_3_0)
	return arg_3_0:getSkillConfig().cost
end

function var_0_0.getReleaseParam(arg_4_0)
	return arg_4_0._releaseParam
end

function var_0_0.setSkillParam(arg_5_0, ...)
	return
end

function var_0_0.playAction(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 then
		arg_6_1(arg_6_2)
	end
end

function var_0_0.cancelRelease(arg_7_0)
	return
end

function var_0_0.getEffectRound(arg_8_0)
	return EliminateEnum.RoundType.Match3Chess
end

function var_0_0.canRelease(arg_9_0)
	return true
end

return var_0_0
